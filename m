From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 21 Jul 2014 13:19:39 +0200
Subject: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
In-Reply-To: <8387001.GKG5goCh1a@wuerfel>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404913221-17343-13-git-send-email-thomas.petazzoni@free-electrons.com>
 <53CCF295.6030907@linaro.org> <8387001.GKG5goCh1a@wuerfel>
Message-ID: <20140721131939.20e81354@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Mon, 21 Jul 2014 13:16:22 +0200, Arnd Bergmann wrote:

> > It isn't possible to do:
> > 
> > if (of_machine_is_compatible("marvell,armada-370-xp-pmsu"))
> >         cpuidle_register(&armadaxp_cpuidle_driver, NULL);
> > 
> > ?
> > 
> > That will prevent the creation of the new single-declaration header file.
> 
> It would be best to have a way to read a property (or multiple
> properties) from DT instead, to identify the requirements of the
> device individually. However, I guess that would also require
> changing the DT representation in an incompatible way, which we
> normally don't.

cpuidle is not represented in DT, so besides checking the global
compatible string with of_machine_is_compatible(), or passing data
through platform_data (as proposed in the patch series), I don't really
see how the cpuidle driver could find out which SoC variant is being
used.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
