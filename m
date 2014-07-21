From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 21 Jul 2014 13:35:34 +0200
Subject: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
In-Reply-To: <52019695.n2AjkGEsJ7@wuerfel>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <8387001.GKG5goCh1a@wuerfel>
 <20140721131939.20e81354@free-electrons.com>
 <52019695.n2AjkGEsJ7@wuerfel>
Message-ID: <20140721133534.3415e425@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Mon, 21 Jul 2014 13:30:47 +0200, Arnd Bergmann wrote:

> > > It would be best to have a way to read a property (or multiple
> > > properties) from DT instead, to identify the requirements of the
> > > device individually. However, I guess that would also require
> > > changing the DT representation in an incompatible way, which we
> > > normally don't.
> > 
> > cpuidle is not represented in DT, so besides checking the global
> > compatible string with of_machine_is_compatible(), or passing data
> > through platform_data (as proposed in the patch series), I don't really
> > see how the cpuidle driver could find out which SoC variant is being
> > used.
> 
> One way I think it can be done is by looking up the pmsu node
> and then looking at some of the properties in there.

Which properties do you have in mind? Should we simply use different
compatible strings for the PMSU node, per SoC ? Some other suggestions ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
