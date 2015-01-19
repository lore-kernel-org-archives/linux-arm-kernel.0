From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 19 Jan 2015 20:39:15 +0100
Subject: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
In-Reply-To: <20150119191210.GE26493@n2100.arm.linux.org.uk>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
 <20150119191210.GE26493@n2100.arm.linux.org.uk>
Message-ID: <20150119193915.GA9969@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 07:12:10PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 19, 2015 at 07:55:56PM +0100, Wolfram Sang wrote:
> > Back in the days, sysfs seemed to have refcounting issues and subsystems
> > needed a completion to be safe. This is not the case anymore, so I2C can
> > get rid of this code. There is noone else besides I2C doing something
> > like this currently (checked with the attached coccinelle script which
> > checks if a release function exists and if it contains a completion).
> 
> Have you validated this with DEBUG_KOBJECT_RELEASE enabled?

You saved me, thank you a lot for this pointer! Patch discarded.

I assume other subsystems also moved away from 'struct device_type' for
the release function as well; but this is just a guess for now and I'll
call it a day for today.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/fd943b8a/attachment.sig>
