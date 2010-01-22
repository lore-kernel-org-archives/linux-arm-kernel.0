From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jan 2010 15:25:08 -0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <201001211342.48751.jpihet@mvista.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<201001211321.44682.jpihet@mvista.com>
	<001a01ca9a96$0f7024a0$2e506de0$@deacon@arm.com>
	<201001211342.48751.jpihet@mvista.com>
Message-ID: <002601ca9b77$14cec870$3e6c5950$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

* Jean Pihet wrote:

> > So, in response to your question, I reckon you should wrap the switch
> > statement with the implementer check, but add a DIDR check in the else
> > block so that cores with a v7 PMU will at least get support for the
> > standard events.
> That makes sense. Are such chipsets already out or planned in the near future?

Well, it's basically for supporting any v7 core that isn't designed by ARM.
I don't know if any such cores are supported by [mainline] Linux yet, but I'm
sure they'll turn up.

> I propose to have the current code working and merged in before supporting the
> generic v7 cores. Doing so requires to add new set of events mappings.
> 
> What do you think?

That makes sense. A8 is probably the most popular v7 core at the moment, so
supporting that should be the priority.

Cheers,

Will
