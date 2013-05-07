From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 7 May 2013 12:27:11 -0600
Subject: [RESEND][PATCH 1/3] arm: dts: introduce config HAS_BANDGAP
In-Reply-To: <5188FE54.6050200@ti.com>
References: <1367874058-2378-1-git-send-email-eduardo.valentin@ti.com>
 <1367874058-2378-2-git-send-email-eduardo.valentin@ti.com>
 <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
 <20130506223653.GA12089@obsidianresearch.com>
 <51884971.9050508@ti.com>
 <20130507003651.GA26035@obsidianresearch.com>
 <5188FE54.6050200@ti.com>
Message-ID: <20130507182711.GB28628@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 09:15:00AM -0400, Eduardo Valentin wrote:
> > But broadly the direction seems that drivers should have minimal
> > dependencies so, eg, the thermal maintainer compiling for x86 should
> > be able to compile test/static analyze your driver..

> Well, I do not see much of this attempt actually. Do you have some link
> / evidene that shows someone who actually cares about compiling drivers
> for targets that they are not used for? On this specific driver, I
> actually have  had exactly the opposite advice [1]. I am not convinced
> people actually want to do that.

There was a discussion a bit ago, but I can't find a link.. The
context was subsystem maintainers are being asked to look after more
code with the DT transition moving things out of arch/arm and at least
one complained they couldn't even compile test on x86... But again, I
can't find a link and you are right, there are lots and lots of
'depends ARCH..' style things in kConfig already.

Lets just call it something to think about.

> >> Thats the idea behind this config option. It follows the same design as
> >> CONFIG_ARCH_HAS_CPUFREQ, for instance.
> > 
> > That is entirely contained inside arch/arm and doesn't involve
> > drivers.
> 
> It actually goes outside arch/arm.

Hm, must have missed that, seemed like all it did was control
including drivers/cpufreq/Kconfig within the ARM kconfigs.. And
unicore32 copied the name, but did the same thing.

Regards,
Jason
