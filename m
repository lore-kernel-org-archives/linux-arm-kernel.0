From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 1 Feb 2015 14:53:33 +0100
Subject: [PATCH v3 01/10] clk: sunxi: Move USB clocks to separate file
In-Reply-To: <1422388455-25923-2-git-send-email-wens@csie.org>
References: <1422388455-25923-1-git-send-email-wens@csie.org>
 <1422388455-25923-2-git-send-email-wens@csie.org>
Message-ID: <20150201135332.GB4827@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 03:54:06AM +0800, Chen-Yu Tsai wrote:
> The USB clocks originally shared code with the gates clocks, but had
> additional reset controllers. Move these to a separate file. This will
> allow us to add new support for slightly different USB clocks, such as
> on the A80, without affecting gates clocks, and also facilitate the
> migration of gates clocks to a generic solution.
> 
> This also cleans up the USB clocks code slightly, such as adding
> newlines, getting rid of the unused clkdev call, using a simple
> u32 instead of BITMAP for the clock masks, using BIT() macro to
> declare the clock bitmasks, and using of_io_request_and_map() to
> get the I/O address.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150201/2b6e8bc9/attachment.sig>
