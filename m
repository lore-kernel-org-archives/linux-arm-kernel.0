From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 30 Mar 2016 09:45:21 -0300
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <20160330120644.GM20367@ibawizard.net>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <20160330120644.GM20367@ibawizard.net>
Message-ID: <CAOMZO5DK-K19bHhEpyGoVak5Y7bT-xzA9GjtBSiO6Z+yfeEdgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 9:06 AM, Petr ?tetiar <ynezz@true.cz> wrote:

> I'm really puzzled by this :-) With your patch applied I get following on
> Toradex Apalis modules:
>
>  DTS:         reset-gpio = <&gpio1 28 GPIO_ACTIVE_LOW>;
>  dmesg:       imx6q-pcie 1ffc000.pcie: phy link never came up
>  gpio:        gpio-28  (                    |reset               ) out hi
>  pin voltage: 0V
>
>  DTS:         reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>  dmesg:       ath9k 0000:01:00.0: enabling device (0140 -> 0142)
>  gpio:        gpio-28  (                    |reset               ) out lo
>  pin voltage: 3V3
>
> So Toradex Apalis is actually active-high? Thanks.

Yes, exactly. That's why you need to introduce a new property to
handle the active-high case, so that old dtb's are not broken.
