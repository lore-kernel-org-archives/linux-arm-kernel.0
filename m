From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Feb 2012 13:22:17 +0000
Subject: [PATCH] ARM: ptrace: fix ptrace_read_user for !CONFIG_MMU
 platforms
In-Reply-To: <20120221113548.GK22562@n2100.arm.linux.org.uk>
References: <1329763029-18220-1-git-send-email-will.deacon@arm.com>
 <20120220194634.GK26840@n2100.arm.linux.org.uk>
 <201202210124.23028.paul@codesourcery.com>
 <20120221083612.GG22562@n2100.arm.linux.org.uk>
 <20120221100041.GA19696@mudshark.cambridge.arm.com>
 <20120221101052.GH22562@n2100.arm.linux.org.uk>
 <20120221105250.GC19696@mudshark.cambridge.arm.com>
 <20120221113548.GK22562@n2100.arm.linux.org.uk>
Message-ID: <20120221132216.GJ19696@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 11:35:48AM +0000, Russell King - ARM Linux wrote:
> The other thing is, as this has been broken right from the start, has
> gdb under uclinux even been tested?

I checked with the tools guys here and they don't yet do !MMU testing,
although I think it's on the list.

> I don't think fixing this in mainline until we know the full story behind
> this is the right thing to be doing.  There's no point fixing a feature
> which no one's using.

Understood. Paul - would you please be able to confirm that:

(a) GDB is currently broken on uclinux? (it certainly looks that way)
(b) My proposed patch fixes the problem?

If you don't have an environment set up, I wonder if there's somebody else
we can poke who's playing with this stuff.

Will
