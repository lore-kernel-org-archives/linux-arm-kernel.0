From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 13 Jan 2015 12:42:37 +0100
Subject: [PATCH v5] i2c: rk3x: fix bug that cause measured high_ns
 doesn't meet I2C specification
In-Reply-To: <1418295760-19639-1-git-send-email-addy.ke@rock-chips.com>
References: <1418277650-25215-1-git-send-email-addy.ke@rock-chips.com>
 <1418295760-19639-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20150113114237.GC7660@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 07:02:40PM +0800, Addy Ke wrote:
> The number of clock cycles to be written into the CLKDIV register
> that determines the I2C clk high phase includes the rise time.
> So to meet the timing requirements defined in the I2C specification
> which defines the minimal time SCL has to be high, the rise time
> has to taken into account. The same applies to the low phase with
> falling time.
> 
> In my test on RK3288-Pink2 board, which is not an upstream board yet,
> if external pull-up resistor is 4.7K, rise_ns is about 700ns.
> So the measured high_ns is about 3900ns, which is less than 4000ns
> (the minimum high_ns in I2C specification for Standard-mode).
> 
> To fix this bug min_low_ns should include fall time and min_high_ns
> should include rise time.
> 
> This patch merged the patch from chromium project which can get the
> rise and fall times for signals from the device tree. This allows us
> to more accurately calculate timings. see:
> https://chromium-review.googlesource.com/#/c/232774/
> 
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>

Applied to for-next, thanks!

I fixed the typo Doug mentioned.

Please send new patches as seperate threads, not as a reply to the old
patch.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/ee0cb775/attachment.sig>
