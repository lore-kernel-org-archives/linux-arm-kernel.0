From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jul 2014 13:30:47 +0200
Subject: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
In-Reply-To: <20140721131939.20e81354@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <8387001.GKG5goCh1a@wuerfel> <20140721131939.20e81354@free-electrons.com>
Message-ID: <52019695.n2AjkGEsJ7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 July 2014 13:19:39 Thomas Petazzoni wrote:
> On Mon, 21 Jul 2014 13:16:22 +0200, Arnd Bergmann wrote:
> 
> > > It isn't possible to do:
> > > 
> > > if (of_machine_is_compatible("marvell,armada-370-xp-pmsu"))
> > >         cpuidle_register(&armadaxp_cpuidle_driver, NULL);
> > > 
> > > ?
> > > 
> > > That will prevent the creation of the new single-declaration header file.
> > 
> > It would be best to have a way to read a property (or multiple
> > properties) from DT instead, to identify the requirements of the
> > device individually. However, I guess that would also require
> > changing the DT representation in an incompatible way, which we
> > normally don't.
> 
> cpuidle is not represented in DT, so besides checking the global
> compatible string with of_machine_is_compatible(), or passing data
> through platform_data (as proposed in the patch series), I don't really
> see how the cpuidle driver could find out which SoC variant is being
> used.

One way I think it can be done is by looking up the pmsu node
and then looking at some of the properties in there.

	Arnd
