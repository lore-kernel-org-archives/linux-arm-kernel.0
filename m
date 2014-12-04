From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Dec 2014 19:30:15 +0100
Subject: [PATCH v2 2/3] i2c: cadence: Set the hardware time-out register
 to maximum value
In-Reply-To: <1417610126-7957-3-git-send-email-harinik@xilinx.com>
References: <1417610126-7957-1-git-send-email-harinik@xilinx.com>
 <1417610126-7957-3-git-send-email-harinik@xilinx.com>
Message-ID: <20141204183015.GI7944@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 06:05:25PM +0530, Harini Katakam wrote:
> From: Vishnu Motghare <vishnum@xilinx.com>
> 
> Cadence I2C controller has bug wherein it generates invalid read transactions
> after timeout in master receiver mode. This driver does not use the HW
> timeout and this interrupt is disabled but the feature itself cannot be
> disabled. Hence, this patch writes the maximum value (0xFF) to this register.
> This is one of the workarounds to this bug and it will not avoid the issue
> completely but reduces the chances of error.
> 
> Signed-off-by: Vishnu Motghare <vishnum@xilinx.com>
> Signed-off-by: Harini Katakam <harinik@xilinx.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/7509448e/attachment.sig>
