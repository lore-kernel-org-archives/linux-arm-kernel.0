From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 20 Sep 2014 14:19:05 +0200
Subject: [PATCH v2] i2c: rk3x: fix divisor calculation for SCL frequency
In-Reply-To: <1410147505-5930-1-git-send-email-addy.ke@rock-chips.com>
References: <1409884333-3544-1-git-send-email-addy.ke@rock-chips.com>
 <1410147505-5930-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20140920121904.GB3850@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 11:38:25AM +0800, Addy Ke wrote:
> I2C_CLKDIV register descripted in the previous version of
> RK3x chip manual is incorrect. Plus 1 is required.
> 
> The correct formula:
> - T(SCL_HIGH) = T(PCLK) * (CLKDIVH + 1) * 8
> - T(SCL_LOW) = T(PCLK) * (CLKDIVL + 1) * 8
> - (SCL Divsor) = 8 * ((CLKDIVL + 1) + (CLKDIVH + 1))
> - SCL = PCLK / (CLK Divsor)
> 
> It will be updated to the latest version of chip manual.
> 
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140920/133ac9df/attachment.sig>
