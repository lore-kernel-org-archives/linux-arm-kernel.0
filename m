From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 27 Mar 2015 16:37:13 +0100
Subject: [PATCH] i2c: cadence: Handling Slave monitor mode
In-Reply-To: <BL2FFO11FD05378650E02EA6549B4DF50E8030@BL2FFO11FD053.protection.gbl>
References: <BL2FFO11FD05378650E02EA6549B4DF50E8030@BL2FFO11FD053.protection.gbl>
Message-ID: <20150327153713.GC27238@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 09:48:15PM +0530, Nava kishore Manne wrote:
> In slave monitor mode, the I2C interface is set up as a master and
> continues to attempt a transfer to a particular slave until the
> slave device responds with an ACK.
> 
> Added this feature for zero length transfers enable the controller
> for slave monitor interrupt and get the status. Disable the slave
> monitor mode feature upon successful handling.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> Acked-by: Harini Katakam <harinik@xilinx.com>

I am not sure this is going to work.

How often is this access tried when there is no device? It should be
tried only once.

Those 0byte messages can be read or write, so transferring one bit, one
could say. I assume this one can only read? (which is not a show-stopper
but the cases should be handled)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150327/d0a9ab91/attachment.sig>
