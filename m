From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 17 Jun 2014 09:05:40 +0800
Subject: PXA2xx and pinctrl
In-Reply-To: <87oaxsd3i4.fsf@free.fr>
References: <87oaxsd3i4.fsf@free.fr>
Message-ID: <CAN1soZy-ZCtS0qtMGjP3CRraiuSrm_=ZYWcB6nbPW92OPJMrWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 4:05 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Hi Haojian, Eric,
>
> In my current work of porting things here and there to device-tree for PXA27x,
> I'm considering mfp-pxa2xx for pinctrl integration.
>
> I'm wondering if you see before hand any blocking point that can't be addressed
> and which prevents pxa2xx to be converted to pinctrl inftrastructure.
>
> And if no blocking point arises, how easy would it be according to your
> knowledge to still offer legacy mfp_* APIs, and replace the functions by
> pinctrl_*() calls ?
>
> Cheers.
>
> --
> Robert

1. GPDRx & GAFRx are used together to configure alternate function on
PXA2xx pins.

2. GPIOx_2 can also work as GPIOx.

If you define two logic pins binds to one real pin, and define pin
tables in DTS, you can
re-use the pinctrl-single driver. Otherwise, you need to write a new
pinctrl driver.

Regards
Haojian
