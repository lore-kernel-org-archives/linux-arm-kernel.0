From: db@donbowman.ca (Don Bowman)
Date: Wed, 14 Feb 2018 23:18:15 -0500
Subject: PCI on alpine soc
Message-ID: <CADJev7948TA_FU-3+Z8KNCbQgvApLfe8n6jP-wCbJeU2R4d26w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have a Netgear ReadyNAS 214. Thankfully netgear have provided the
GPL code, and the kernel (4.4) works.

I noticed that there was a set of pull-requests accepted into the
mainline, and there is also the arm-soc repo. Both suggest they
support alpine.

When i compile and run them, things generally work, but the PCI
devices are not discovered.

The code is pretty different from the netgear-provided 4.4 and the
current 4.16rc.

the fdt is passed in the same from the u-boot in both cases 94.4 and 4.16rc)

is it expected that this chip works? Does anyone have any suggestions?

for kicks i 'ported' the 4.4 ALPINE specific bits from the netgear
tree to latest, and then it worked (except for an issue w/ a change in
API for of_... and MSI, so the MSI was not working). But its kind of
hackish.
