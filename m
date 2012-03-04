From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 04 Mar 2012 11:25:06 +0100
Subject: Status of gpio-pxa driver and dummy clock
In-Reply-To: <CAN1soZwtVm=qBw97AeeysfTXhCQg7XonKkHAE_dn6EYbLHnKBw@mail.gmail.com>
 (Haojian Zhuang's message of "Sun, 4 Mar 2012 09:05:47 +0800")
References: <87eht9tllp.fsf@free.fr>
 <CAN1soZwtVm=qBw97AeeysfTXhCQg7XonKkHAE_dn6EYbLHnKBw@mail.gmail.com>
Message-ID: <87aa3wu0hp.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@gmail.com> writes:

> On Sun, Mar 4, 2012 at 5:34 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Hi Haojian,
>>
>> As you certainly know, Russell reverted the patch "ARM: pxa: add dummy clock for
>> sa1100-rtc", id a55b5adaf403c4d032e0871ad4ee3367782f4db6. As a consequence, the
>> dummy clock for gpio-pxa was removed, causing breakage of gpio-pxa driver.
>>
>> I wonder if you (or somebody through you) sent an update to fix the gpio-pxa by
>> either fixing gpio-pxa or adding back "pxa-gpio" clock. As of today, I see no
>> fix in 3.3-rc free (Linus tree).
>>
>
> This patch is already merged into arm-soc tree for v3.4. I don't have
> a plan to push it into
> v3.3.

Oh, you should push it to 3.3. It's a fix, and the mioa701 board is broken (and
probably many others PXA based boards too) because no GPIO is available (as
probe function of pxa-gpio always fail on clk_get()).

If you don't want to push it to 3.3, I'll have to send a fix to Arnd to fix the
breakage.

Without it, a PXA based kernel (pxa2xx) will hang in its boot phase, on the
first gpio_get_* or gpio_set_*, which is called by many drivers.

Cheers.

-- 
Robert
