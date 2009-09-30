From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 30 Sep 2009 14:36:25 +0200
Subject: 2.6.32-rc1/2, arm and usb
In-Reply-To: <19138.34019.987851.150679@pilspetsen.it.uu.se> (Mikael
	Pettersson's message of "Wed\, 30 Sep 2009 00\:06\:27 +0200")
References: <87ws3i40id.fsf@lechat.rtp-net.org>
	<19138.34019.987851.150679@pilspetsen.it.uu.se>
Message-ID: <87ocos4njq.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson <mikpe@it.uu.se> writes:

Hi,

> Arnaud Patard (Rtp) writes:
>  > I wanted yesterday to check that my iop sanmina support was still fine on
>  > latest -rc kernel and found out that it was not booting anymore and last
>  > thing printed on the serial console is "done. Booting the kernel". After
>  > bisecting, the culprit is commit
>  > db8be50c4307dac2b37305fc59c8dc0f978d09ea (in linus tree). Reverting it
>  > allows to boot so this confirms the git bisect result.
>  > 
>  > The commit does this in drivers/usb/host/pci-quirks.c :
>  > -DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);
>  > +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);
>  > 
>  > Now, before collecting informations to report the problem to usb folks
>  > and trying to debug further, I'm wondering if anyone else got this bug
>  > or if I'm just unlucky and has a hardware-specific issue. Also, if
>  > someone has an idea of what the problem may be or in which direction I
>  > should look at, please share.
>
> My iop n2100 shows the exact same problem with 2.6.32-rc1,
> and reverting the commit mentioned above fixes it.
>
> None of my other machines (including two non-iop arms, x86,
> and ultrasparc) have this problem even though they all have
> PCI usb controllers. So the problem looks iop-specific.

fyi, I've taken a look at linux-usb today and found :
http://marc.info/?l=linux-usb&m=125426642829044&w=2

So this bug is not iop specific. Even if it doesn't look arch specific,
I'm surprised to see that so few machines are affected. I was hoping
that all arm machines with usb host on pci were affected but according
to your tests it's not the case.


Arnaud
