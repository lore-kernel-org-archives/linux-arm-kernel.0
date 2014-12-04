From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Dec 2014 19:28:28 +0100
Subject: [PATCH v3 2/5] i2c: davinci: generate STP always when NACK is
 received
In-Reply-To: <1417448047-15236-3-git-send-email-grygorii.strashko@ti.com>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-3-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20141204182828.GG7944@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 05:34:04PM +0200, Grygorii Strashko wrote:
> According to I2C specification the NACK should be handled as follows:
> "When SDA remains HIGH during this ninth clock pulse, this is defined as the Not
> Acknowledge signal. The master can then generate either a STOP condition to
> abort the transfer, or a repeated START condition to start a new transfer."
> [I2C spec Rev. 6, 3.1.6: http://www.nxp.com/documents/user_manual/UM10204.pdf]
> 
> Currently the Davinci i2c driver interrupts the transfer on receipt of a
> NACK but fails to send a STOP in some situations and so makes the bus
> stuck until next I2C IP reset (idle/enable).
> 
> For example, the issue will happen during SMBus read transfer which
> consists from two i2c messages write command/address and read data:
> 
> S Slave Address Wr A Command Code A Sr Slave Address Rd A D1..Dn A P

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/780d400f/attachment.sig>
