From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 28 Apr 2018 14:38:38 +0200
Subject: [PATCH v2] i2c: at91: Read all available bytes at once
In-Reply-To: <20180426095314.12758-1-david.engraf@sysgo.com>
References: <20180426082558.GX13305@rfolt0960.corp.atmel.com>
 <20180426095314.12758-1-david.engraf@sysgo.com>
Message-ID: <20180428123838.abxiht7k4egv7iel@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 11:53:14AM +0200, David Engraf wrote:
> With FIFO enabled it is possible to read multiple bytes
> at once in the interrupt handler as long as RXRDY is
> set. This may also reduce the number of interrupts.
> 
> This patch polls RXRDY and reads all available bytes at
> once.
> 
> Signed-off-by: David Engraf <david.engraf@sysgo.com>

checkpatch said twice:

WARNING: line over 80 characters

While I am not super-strict with this limit, it makes sense here IMO.
The comment stays readable, and we don't even lose a line.

Fixed it this time for you.

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180428/2eee6e2b/attachment.sig>
