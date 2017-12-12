From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Dec 2017 19:54:35 +0000
Subject: WARNING: suspicious RCU usage
In-Reply-To: <CAOMZO5Brd7pZtF5e8RLu63MpUo1Sc01vWC1WeccEMTkGBL0Rqw@mail.gmail.com>
References: <20171210120012.GM10595@n2100.armlinux.org.uk>
 <20171210190727.GJ7829@linux.vnet.ibm.com>
 <20171210193438.GP10595@n2100.armlinux.org.uk>
 <20171210213930.GL7829@linux.vnet.ibm.com>
 <20171212164900.GA6673@linux.vnet.ibm.com>
 <CAOMZO5AftAWz339Sy+oxQ8K9Dr04Jyf8SV0R0JGrcPaL-VQLMQ@mail.gmail.com>
 <20171212173450.GD10595@n2100.armlinux.org.uk>
 <CAOMZO5DBMpCHfgmNND6=qJD+sxOLMPFqEsyz+GiBVhMzN3H+Zg@mail.gmail.com>
 <20171212193638.GH7829@linux.vnet.ibm.com>
 <CAOMZO5Brd7pZtF5e8RLu63MpUo1Sc01vWC1WeccEMTkGBL0Rqw@mail.gmail.com>
Message-ID: <20171212195435.GF10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 05:44:07PM -0200, Fabio Estevam wrote:
> Hi Paul,
> 
> On Tue, Dec 12, 2017 at 5:36 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> 
> >> Ok, just tested with CONFIG_BL_SWITCHER=y on a imx6q-cubox-i:
> >
> > Just to confirm, your dmesg below is illustrating the hang, correct?
> 
> Sorry for not being clear. Let me clarify my tests.
> 
> If I run a mainline kernel on a imx6q I do see the exact same RCU
> warning as reported by Peng Fan in this thread.
> 
> This is 100% reproducible: the first time I do a suspend/resume after
> boot the RCU warning is present. Subsequent suspend/resume cycles do
> not show the warning.
> 
> With your patch applied I don't see the RCU warning anymore.
> 
> I originally tested the standard imx_v6_v7_defconfig and also a kernel
> with CONFIG_BL_SWITCHER=y as suggested by Russell.
> 
> In my tests even with CONFIG_BL_SWITCHER=y suspend/resume works fine
> and no more RCU warnings were seen.
> 
> The dmesg I shared shows the normal output without the RCU warning.

Which is exactly what I would expect with imx6.  Just because it
works for imx6 does not mean it works for everyone.

I need to get Will Deacon's permission before I can send an email
containing our discussion on the points here from 2013, and that
probably won't happen until tomorrow - and I'm having to do that
because none of you seem to be listening to what I'm saying wrt
that spinlock.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
