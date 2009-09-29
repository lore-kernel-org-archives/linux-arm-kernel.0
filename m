From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 29 Sep 2009 10:29:30 +0200
Subject: 2.6.32-rc1/2, arm and usb
Message-ID: <87ws3i40id.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


I wanted yesterday to check that my iop sanmina support was still fine on
latest -rc kernel and found out that it was not booting anymore and last
thing printed on the serial console is "done. Booting the kernel". After
bisecting, the culprit is commit
db8be50c4307dac2b37305fc59c8dc0f978d09ea (in linus tree). Reverting it
allows to boot so this confirms the git bisect result.

The commit does this in drivers/usb/host/pci-quirks.c :
-DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);

Now, before collecting informations to report the problem to usb folks
and trying to debug further, I'm wondering if anyone else got this bug
or if I'm just unlucky and has a hardware-specific issue. Also, if
someone has an idea of what the problem may be or in which direction I
should look at, please share.


Thanks,
Arnaud
