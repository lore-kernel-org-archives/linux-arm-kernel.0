From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 05 Jul 2014 20:43:26 +0200
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <FFC4CCB1-115D-4A20-A79D-78200D02D90F@arm.com>
References: <20140701234800.GA23577@sirena.org.uk>
 <20140705164348.GM14896@sirena.org.uk>
 <FFC4CCB1-115D-4A20-A79D-78200D02D90F@arm.com>
Message-ID: <4473002.jGohFvPsvi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 July 2014 18:06:29 Catalin Marinas wrote:
> On 5 Jul 2014, at 17:43, Mark Brown <broonie@kernel.org> wrote:
> > On Sat, Jul 05, 2014 at 12:14:07PM +0100, Catalin Marinas wrote:
> > 
> >> The timeline I propose would be:
> >> 
> >> 1. Architecture feature deprecation (still present, no way to disable)
> >>   - In Linux we need to find ways and push for alternatives to be
> >>     adopted by user space (like we did with kuser helpers)
> > 
> > Is it worth adding a non-default option to either disable and emulate or
> > just completely disable during this phase rather than at step 2 (perhaps
> > with a sysctl)?  That would help people who want to test that what they
> > are doing is going to work going forwards.  The work is going to have to
> > happen anyway.
> 
> The problem is that when the feature is deprecated, we may not always
> get the option to disable it (it?s more of an advance warning to think
> about it, that?s why I added emulation at step 2). For example SWP has
> been deprecated in ARMv6 but no way to disable it until ARMv7 MP. If we
> get the option (and we should probably recommend this to the
> architects), I agree, you can start the emulation work at step 1 but
> defaulting to native deprecated feature rather than emulation.

I think if a there is no way to turn off a feature, we can't really
treat it as "deprecated", since we are lacking the most important tool
to help users migrate away from it. Do you know why the architecture
folks believe it makes sense to have distinct steps 1 and 2?

Another problem that I see with the way that features are phased out
on ARM is how the hypervisor architecture makes it really hard to
run a guest in an older architecture version. For instance on s390,
you can basically emulate any prior machine from the past 50 years
by selectively trapping some of the instructions from the guest
into the hypervisor, at least for any instruction that has had
a different behavior in the past.

	Arnd
