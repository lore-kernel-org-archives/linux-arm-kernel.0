From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 27 Oct 2012 16:32:24 +0200
Subject: [PATCH 7/8] i2c: add 'transferred' field to struct i2c_msg
In-Reply-To: <20121025141800.GI28061@n2100.arm.linux.org.uk>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1350899218-13624-8-git-send-email-balbi@ti.com>
 <20121025145748.760c218b@endymion.delvare>
 <20121025131459.GG28061@n2100.arm.linux.org.uk>
 <20121025154202.41f3cbba@endymion.delvare>
 <20121025134609.GH28061@n2100.arm.linux.org.uk>
 <20121025155633.609c5554@endymion.delvare>
 <20121025141800.GI28061@n2100.arm.linux.org.uk>
Message-ID: <20121027163224.67d57aef@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2012 15:18:00 +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 25, 2012 at 03:56:33PM +0200, Jean Delvare wrote:
> > The original idea of using the hole in the i2c_msg structure is from
> > David Brownell, who was apparently familiar with such practice, so I
> > assumed it was OK. Actually I still assume it is, until someone comes
> > with an supported architecture where it is not.
> 
> According to Al Viro, that would be m68k.

OK... So to make things clear, let me ask Al directly about it. Al, can
you please tell us if:

--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
 struct i2c_msg {
 	__u16 addr;		/* slave address			*/
 	__u16 flags;
 	__u16 len;		/* msg length				*/
+	__u16 transferred;	/* actual bytes transferred             */
 	__u8 *buf;		/* pointer to msg data			*/
 };
 
would break binary compatibility on m68k or any other architecture you
are familiar with? Note that struct i2c_msg isn't declared with
attribute packed, so my assumption was that pointer "buf" was align on
at least 4 bytes, leaving a hole between len and buf. Am I wrong?

Thanks,
-- 
Jean Delvare
