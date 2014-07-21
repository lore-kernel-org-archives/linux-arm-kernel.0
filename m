From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jul 2014 14:00:22 +0200
Subject: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
In-Reply-To: <20140721133534.3415e425@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <52019695.n2AjkGEsJ7@wuerfel> <20140721133534.3415e425@free-electrons.com>
Message-ID: <5251405.VTrfDi1rj5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 July 2014 13:35:34 Thomas Petazzoni wrote:
> On Mon, 21 Jul 2014 13:30:47 +0200, Arnd Bergmann wrote:
> 
> > > > It would be best to have a way to read a property (or multiple
> > > > properties) from DT instead, to identify the requirements of the
> > > > device individually. However, I guess that would also require
> > > > changing the DT representation in an incompatible way, which we
> > > > normally don't.
> > > 
> > > cpuidle is not represented in DT, so besides checking the global
> > > compatible string with of_machine_is_compatible(), or passing data
> > > through platform_data (as proposed in the patch series), I don't really
> > > see how the cpuidle driver could find out which SoC variant is being
> > > used.
> > 
> > One way I think it can be done is by looking up the pmsu node
> > and then looking at some of the properties in there.
> 
> Which properties do you have in mind? Should we simply use different
> compatible strings for the PMSU node, per SoC ? Some other suggestions ?

I don't know, it really depends on what the differences are between
the SoCs, and I haven't looked at them.

Using the compatible strings would make it work best if you have one
driver per variant, and then share some common code, as opposed to
having one shared driver with a number of exceptions.

If the differences are just a few parameters, it might be better
to encode those parameters in DT properties instead.

	Arnd
