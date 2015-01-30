From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 30 Jan 2015 12:00:16 +0100
Subject: [PATCH] ARM: dts: mvebu: add ethernet to the cm-a510 board
In-Reply-To: <20150130113118.5523ed68@armhf>
References: <E1YH5bU-0005mG-3L@bombadil.infradead.org>
 <54CB5267.5060004@gmail.com> <20150130113118.5523ed68@armhf>
Message-ID: <54CB6440.1010002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.01.2015 11:31, Jean-Francois Moine wrote:
> On Fri, 30 Jan 2015 10:44:07 +0100
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>> I had a closer look on the Compulab website of the SoM [1] and think
>> that we'll have to convert it to dove-cm-a510.dtsi and the baseboard
>> Gabriel is using (maybe SBC-A510 [2]).
>
> I don't understand why the A510 contained in the cm-a510 should be
> different from the one of the other boards (I just noticed a second
> ethernet and a WiFi device - but, is the Compulab document up to date?).

It is not the SoM that is different, but the baseboard it is attached
to. So, the SoM makes a second layer of dtsi around the SoC but is not
sufficient for a board dts.

Regarding the on-SoM WiFi, that will be available on _any_ cm-a510
equipped to _any_ baseboard, so it can be enabled in the som.dtsi.

The second ethernet comes from a PCIe attached NIC, and as you already
said, we simply don't know (yet) if it is actually wired-up on Gabriel's
baseboard. If it is not wired-up on the baseboard, we definitely want
it disabled in DT, too.

> If it is the same, the dove.dtsi should work (and it seems to work for
> Gabriel).

Of course it does work for Gabriel but we don't want to exclusively
mainline Gabriel's setup. In the best case, we want to provide a
dove-cm-a510.dtsi that can be included in any baseboard somebody is
using.

> The only difference with the cm-a510 is the presence or not of the
> connectors. So, all the Dove devices could be enabled in the DT, and,
> if some room is needed in the board, the .config could be adapted
> removing the useless drivers and have a minimal kernel.

Adapting the .config and removing drivers is actually not an option.
IMHO, introducing DT was meant for a single multi-arch kernel that
can be shipped with common Linux distros. Therefore, DT is the place
you enable/disable available resources. You leave most of the SoC (and
SoM) nodes disabled as long as you cannot tell if there is a
corresponding connector available.

Sebastian
