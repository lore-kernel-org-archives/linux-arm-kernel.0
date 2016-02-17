From: yu.c.chen@intel.com (Chen, Yu C)
Date: Wed, 17 Feb 2016 02:20:22 +0000
Subject: [PATCH v5 15/15] arm64: hibernate: Prevent resume from a
 different kernel version
In-Reply-To: <20160216201557.GA6526@amd>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
 <1455637767-31561-16-git-send-email-james.morse@arm.com>
 <20160216201557.GA6526@amd>
Message-ID: <36DF59CE26D8EE47B0655C516E9CE640286C4F3C@shsmsx102.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-pm-owner at vger.kernel.org [mailto:linux-pm-
> owner at vger.kernel.org] On Behalf Of Pavel Machek
> Sent: Wednesday, February 17, 2016 4:16 AM
> To: James Morse
> Cc: linux-arm-kernel at lists.infradead.org; Will Deacon; Sudeep Holla; Geoff
> Levand; Catalin Marinas; Lorenzo Pieralisi; Mark Rutland; AKASHI Takahiro;
> Marc Zyngier; Rafael J . Wysocki; linux-pm at vger.kernel.org
> Subject: Re: [PATCH v5 15/15] arm64: hibernate: Prevent resume from a
> different kernel version
> 
> On Tue 2016-02-16 15:49:27, James Morse wrote:
> > Resuming using a different kernel version is fragile, while there are
> > sufficient details in the hibernate arch-header to perform the
> > restore, changes in the boot process can have a long-lasting impact on the
> system.
> > In particular, if the EFI stub causes more memory to be allocated, the
> > amount of memory left for linux is reduced. If we are lucky, this will
> > cause restore to fail with the message:
> 
> Well, this does not close the door completely. 4.6-rc0 is going to be very
> different from 4.6-rc1. Better solution would be to increase version every
> time EFI stub changes, or maybe record ammount of memory reserved for
> EFI.
This reminds me a similar problem I once encountered on x86 : - )
The efi memory layout should be strictly the same before/after hibernation, right?
