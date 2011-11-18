From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Nov 2011 17:52:03 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <20111117183726.GE3044@localhost.localdomain>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
 <20111117160536.GU9581@n2100.arm.linux.org.uk>
 <20111117183726.GE3044@localhost.localdomain>
Message-ID: <20111118175203.GI9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 06:37:26PM +0000, Dave Martin wrote:
> On Thu, Nov 17, 2011 at 04:05:37PM +0000, Russell King - ARM Linux wrote:
> > You do understand that system_rev is for the system _revision_ not for
> > some kind of system ID.  For example, it's to identify whether we're on
> > a revision 4, 5 or 6 system.
> > 
> > However, with DT the differences in system revision should be encoded
> > into the DT itself, and the kernel should not be making choices about
> > the hardware off this.
> 
> I can't comment on whether this is an abuse of system_rev, since I'm
> not too familiar with that.
> 
> I feel that Whether the value of the V2M_SYS_ID register should be put
> in the DT is more doubtful though: the DT must describe the hardware
> which cannot be probed.

That is exactly my point - but we don't want V2M_SYS_ID controlling what
hardware is there because then you'll end up having _drivers_ having to
be aware of the system revision.

Instead, the differences in device IP - when they're not discoverable
from the device itself - should be encoded in DT to allow the device IP
to be reused on different platforms which may not even have a V2M_SYS_ID
register.

That's what my objection is about: nothing should be using the overall
system revision to determine anything about it.
