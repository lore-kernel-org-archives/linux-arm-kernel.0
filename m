From: eric@eukrea.com (Eric =?UTF-8?B?QsOpbmFyZA==?=)
Date: Wed, 23 Jan 2013 22:14:58 +0100
Subject: [PATCH v2 2/3] arm: mvebu: Enable USB controllers on Armada
 370/XP boards
In-Reply-To: <20130123190352.2d001218@skate>
References: <1358954792-16160-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358954792-16160-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <CALF0-+XJEXJ2B3NLu5DvyxaDuuMNP=zk+z8QUd4GTQULW3BpyA@mail.gmail.com>
 <20130123190352.2d001218@skate>
Message-ID: <20130123221458.6237568b@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Le Wed, 23 Jan 2013 19:03:52 +0100,
Thomas Petazzoni <thomas.petazzoni@free-electrons.com> a ?crit :
> On Wed, 23 Jan 2013 14:04:42 -0300, Ezequiel Garcia wrote:
> 
> > from the OpenBlocks AX3-4 board dts file, since you mentioned this
> > board uses that USB
> > port for a PCIe connector -- if I understood correctly.
> 
> No. The OpenBlocks has a different USB controller that sits on the PCIe
> bus. There is nothing like a PCIe port that uses a USB port, that
> doesn't make sense.
> 
I don't have a AX3-4 but it seems to have a MiniPCIe socket and
not a PCIe one.
MiniPCIe specification includes both PCIe _and_ USB2.0 signals (on pins
36&38) (and also SMBus, SIM and LEDs drivers check the following table
for details http://pinoutsguide.com/Slots/mini_pcie_pinout.shtml ) so
the possibility to have a USB port connected to the MiniPCIe on the
AX3-4 makes sense.

For example most 3G MiniPCIe boards are using the USB2.0 signals and
not the PCIe ones.

Eric
