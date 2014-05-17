From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 May 2014 11:26:38 +0100
Subject: [PATCH] ARM: remove ARM710 specific assembler code
In-Reply-To: <9DBC3527-1961-40DD-8CBA-9A1B5D3003C9@arm.com>
References: <1364507176.1345.45.camel@x61.thuisdomein>
 <8309592.drxAj71PnZ@wuerfel> <1400059550.31197.12.camel@x220>
 <4305975.PvMXZQ020k@wuerfel> <1400232598.20342.16.camel@x220>
 <20140516125545.GO3693@n2100.arm.linux.org.uk>
 <20140517092337.GA67711@MacBook-Pro.local>
 <20140517094636.GP3693@n2100.arm.linux.org.uk>
 <9DBC3527-1961-40DD-8CBA-9A1B5D3003C9@arm.com>
Message-ID: <20140517102638.GQ3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 17, 2014 at 10:56:02AM +0100, Catalin Marinas wrote:
> > The difference between what you're proposing and what happened to ARMv3
> > is that ARMv3 was broken for quite some time (we read from some of the
> > CP15 registers which are read-only in ARMv3) and no one ever raised a
> > problem with that.  So, after a sufficient period of time, it got removed
> > - and no one batted an eyelid.  That's the correct way to do it - allow
> > code to age, and if no one notices it's been broken, then it can be
> > removed.
> 
> I?m more for pro-actively ?breaking? it with a DEPRECATED
> dependency. For example, if you suspect that some code like ARM710T is
> no longer in use, we mark it and see if anyone complains about this over
> a two years period. If not, it gets removed.
> 
> Waiting for code to get broken is another way but it?s less
> predictable.

When code being used gets broken, it's nice to think that we'll get
bug reports which will tell us if it's still being used.  The problem
with DEPRECATED is that it will get lost amongst all the thousands
of other config options and won't be noticed.  Just like EXPERIMENTAL
or any of the other similar options we've had.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
