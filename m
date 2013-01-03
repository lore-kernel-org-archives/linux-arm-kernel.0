From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Jan 2013 16:23:59 +0000
Subject: [PATCH 2/2] arm: make return_address available for ARM_UNWIND
In-Reply-To: <1357229038.10284.46.camel@gandalf.local.home>
References: <1357207949-3349-1-git-send-email-kpark3469@gmail.com>
 <1357207949-3349-2-git-send-email-kpark3469@gmail.com>
 <20130103103815.GL2631@n2100.arm.linux.org.uk>
 <CA+KhAHbmjD7zTw+wcw84Abg3V1dD=0Ea4kUpYdGENQf1UOWphw@mail.gmail.com>
 <1357220165.10284.30.camel@gandalf.local.home>
 <20130103141301.GQ2631@n2100.arm.linux.org.uk>
 <1357229038.10284.46.camel@gandalf.local.home>
Message-ID: <20130103162359.GR2631@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 11:03:58AM -0500, Steven Rostedt wrote:
> On Thu, 2013-01-03 at 14:13 +0000, Russell King - ARM Linux wrote:
> > In summary, from what I can see in the patch, the reason why the ifdefs
> > are the way they are, and the reason the warning is there has not been
> > addressed; these patches just seem to be aimed just at removing a #warning
> > statement to make the warning go away.
> 
> You're correct that this patch does not solve any of theses issues. Now,
> I'm thinking that ftrace has matured where these issues don't exist, and
> where they do, it will only cause noise in the trace than anything
> serious. But, this needs to be looked deeper to make sure.

Looking back in the archives, it seems that we had a problem with ftrace
and the unwinder polluting the trace information:

http://lists.arm.linux.org.uk/lurker/message/20090604.201745.1c41ee6c.en.html

There's quite a bit of discussion in that thread about this which details
why we came up with what we have today.
