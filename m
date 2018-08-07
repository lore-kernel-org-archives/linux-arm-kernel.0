From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 7 Aug 2018 13:45:27 +0800
Subject: [PATCH v3 05/19] arm64: dts: allwinner: a64: Orange Pi Win:
 Enable USB OTG socket
In-Reply-To: <CAGb2v658e-L98z=Xd7V5NToWUKTr4V+3T6vseFRJ0C=0UJ=BkQ@mail.gmail.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
 <20180730123137.923-6-andre.przywara@arm.com>
 <CAGb2v658e-L98z=Xd7V5NToWUKTr4V+3T6vseFRJ0C=0UJ=BkQ@mail.gmail.com>
Message-ID: <CAGb2v66k7Og8L=x9_wwO55xjhxusSA4TkenWF-iLFgAsLNKc2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2018 at 1:04 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Mon, Jul 30, 2018 at 8:31 PM, Andre Przywara <andre.przywara@arm.com> wrote:
>> From: Samuel Holland <samuel@sholland.org>
>>
>> The Orange Pi Win has a micro USB-B socket, connected to the SoC's
>> USB-OTG port. Its power is supplied by the AXP PMIC, and the ID pin is
>> connected to GPIO PH9. It can serve both as a host or a client port.
>>
>> Add the respective DT node to enable it.
>
> This patch is missing vbus detection and vbus-supply for usb0.
>
> The former uses the PMIC's own VBUS detection.
>
> The latter, according to the schematics, is a separate fixed regulator
> controlled by the PMIC's N_VBUSEN pin, so it would correspond to the
> PMIC's drive_vbus regulator node. Also the commit description is wrong.

Applied with ehci0 and ohci0 also enabled, since the A64 has a dual
routed USB0. Also added vbus-supply supply. The patch (and others) will
appear in

    https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git/log/?h=sunxi/dt64-for-4.20

once the mirror completely syncs up. I'm not using the sunxi repo to
ease rebasing when the next -rc1 comes out. I.e. I will queue up
patches in a separate place so Maxime can rebase the ones he queued
up without having to fix up committer info on the ones I did.

ChenYu
