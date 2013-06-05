From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 5 Jun 2013 23:48:22 +0200
Subject: [PATCH 0/9] Fix Marvell mv63xxx I2C driver
In-Reply-To: <20130516202921.GW18614@n2100.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
Message-ID: <20130605214822.GE2934@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 09:29:21PM +0100, Russell King - ARM Linux wrote:
> This patch series fixes a whole chunk of problems with this driver,
> discovered with the Marvell Armada 510 chip on the Solid-run cubox.
> 
> Most notable of these is the I2C driver aborting a transaction
> because a signal is pending - which might be SIGPIPE or SIGALRM
> for the process.  Meanwhile, the calling driver may be in the
> middle of a critical read-modify-write cycle on a device register,
> causing it to fail.
> 
> Other problems are race conditions in the handling of multi-part
> messages, where we end up sending multiple start conditions -
> sometimes more times than we have i2c_msg's to send.
> 
> Lastly is the rather poor probe error handling, which ranges from
> non-existent to lacking propagating the provided error code.

Applied rest of the series to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130605/32e7753b/attachment.sig>
