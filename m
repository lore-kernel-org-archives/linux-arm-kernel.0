From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 12 Jun 2014 00:24:44 +0200
Subject: [PATCH v7 0/2] i2c: sunxi: add P2WI controller support
In-Reply-To: <1402478250-7292-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1402478250-7292-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140611222444.GB3109@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 11:17:28AM +0200, Boris BREZILLON wrote:
> Hello,
> 
> This series adds support for the P2WI block used by some Allwinner boards
> to interface with the AXP221 PMIC.
> 
> The P2WI controller looks like an SMBus controller which only supports byte
> data transfers. But, it differs from standard SMBus protocol on several
> aspects:
> - it supports only one slave device, and thus drop the address field
> - it adds a parity bit every 8bits of data
> - only one read access is required to read a byte (instead of a write
>   followed by a read access in standard SMBus protocol)
> - there's no Ack bit after each byte transfer
> 
> This means this bus cannot be used to interface with standard SMBus
> devices (the only known device to support this interface is the AXP221
> PMIC).
> However the P2WI protocol is close enough to SMBus to be integrated in
> the I2C subsystem (see this thread [1] for detailed reasons that led to
> integrating this driver in the I2C subsystem).
> 
> [1] http://www.spinics.net/lists/linux-i2c/msg15066.html

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140612/1b73c7c5/attachment.sig>
