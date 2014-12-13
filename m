From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 13 Dec 2014 09:21:23 +0000
Subject: [PATCH 0/3] removing of some unused/unsupported dts entries
In-Reply-To: <cover.1418434448.git.silvio.fricke@gmail.com> (Silvio Fricke's
 message of "Sat, 13 Dec 2014 01:46:45 +0000")
References: <cover.1418434448.git.silvio.fricke@gmail.com>
Message-ID: <8761dfgb1o.fsf@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 13 2014 at  1:46:45 am GMT, Silvio Fricke <silvio.fricke@gmail.com> wrote:

Hi Silvio,

> I have found some dts entries which are not evaluated by the drivers. This
> patch remove this entries from the dts files.
> Jason has mentioned I should CC: Thomas, Marc and him self to this
> mails.

As far as I can tell, this looks correct. A few key things though:

- Please write decent commit logs. Indicate *why* you think these
  properties can be removed (hint: not finding corresponding in the
  drivers is not enough a reason, the binding itself matters).

- Spend two minutes looking at the ML archives, and try to find why we
  ended-up with these orphan properties (something like this:
  https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-November/023482.html
  contains useful historical information).

- Cc the relevant platform maintainers. You're changing things that they
  care about, basic courtesy is to keep them in the loop.

All of this will help maintainers to quickly decide on the fate of these
patches.

Thanks,

	M.

> thanks and best regards,
> Silvio
>
>
> Silvio Fricke (3):
>   ARM: mx5: dts: remove unused irq-trigger entry
>   ARM: tegra: dts: remove unused irq-trigger entry
>   ARM: SPEAr: dts: remove unused irq-trigger, id and block entries
>
>  arch/arm/boot/dts/imx53-m53.dtsi      | 1 -
>  arch/arm/boot/dts/spear1310-evb.dts   | 1 -
>  arch/arm/boot/dts/spear1340-evb.dts   | 2 --
>  arch/arm/boot/dts/spear320-hmi.dts    | 3 ---
>  arch/arm/boot/dts/tegra30-apalis.dtsi | 1 -
>  5 files changed, 8 deletions(-)

-- 
Without deviation from the norm, progress is not possible.
