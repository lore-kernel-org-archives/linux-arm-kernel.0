From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Jan 2015 15:32:36 +0100
Subject: [PATCH 4/4] ARM: dts: Add initial support for Alpine platform
In-Reply-To: <CABM=7kn8CMGZDPECfEru11O9gkbYFOTSkzHJF+Ku-oMJoFg6sQ@mail.gmail.com>
References: <54c53663.0OSd3sO9f1oYd3El%tsahee@annapurnalabs.com>
 <36490364.POE8pPlYQh@wuerfel>
 <CABM=7kn8CMGZDPECfEru11O9gkbYFOTSkzHJF+Ku-oMJoFg6sQ@mail.gmail.com>
Message-ID: <3392216.FHWJaKVrAq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 January 2015 16:14:11 Tsahee Zidenberg wrote:
> On 26 January 2015 at 13:15, Arnd Bergmann <arnd@arndb.de> wrote:> +* CPU
> node:
> 
> > > +
> > > +The Alpine platform includes cortex-a15 cores.
> > > +enable-method: must be "annapurna-labs,alpine-smp" to allow smp  [1]
> >
> > Any reason for not using PSCI on this platform?
> >
> >
> PSCI is in the roadmap, but not supported by current firmware.

As your initial submission is very minimal regarding driver support,
would it be sensible to wait for the firmware to catch up then?

That way you lose SMP support for the moment but could still work
on adding the device drivers while testing in uniprocessor mode and
then we will see if your firmware is ready once there are more
drivers upstream. Once the firmware has PSCI working, it will all
just work without the need for extra devices in DT or the custom
SMP operations.

	Ard
