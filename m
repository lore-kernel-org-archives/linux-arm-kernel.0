From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 5 Aug 2012 20:58:41 +0800
Subject: [PATCH 2/2] GPIO: gpio-pxa: fix devicetree functions
In-Reply-To: <CACRpkdYGPgy8s505_rom2tnKdL8rVwrd3N=rbRUJnRYnDj726A@mail.gmail.com>
References: <1343230539-7196-1-git-send-email-zonque@gmail.com>
 <1343230539-7196-2-git-send-email-zonque@gmail.com>
 <CACRpkdY6zn+aigZituo37iq=Mttf9Bhn06nyH-A4zQ6mhsByow@mail.gmail.com>
 <CAN1soZxzGeJWbG9g_j1L=gG42SE6LUt_W1vJwu61OSMHdcgAbQ@mail.gmail.com>
 <CACRpkdYGPgy8s505_rom2tnKdL8rVwrd3N=rbRUJnRYnDj726A@mail.gmail.com>
Message-ID: <CAN1soZzh+79eczrSyjY9RO0Eec7KvDDJ-s9rckiBGw56b7R-3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 5, 2012 at 5:40 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Aug 5, 2012 at 5:52 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>> On Sun, Aug 5, 2012 at 7:16 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Wed, Jul 25, 2012 at 5:35 PM, Daniel Mack <zonque@gmail.com> wrote:
>>>
>>>> Provide an of_xlate function for the PXA GPIO chips and make it work for
>>>> devicetree environments.
>>>>
>>>> Successfully tested on a PXA3xx board.
>>>>
>>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>>
>>> Could the PXA maintainers pls have a look at this patch, if you're working
>>> on DT support especially...
>>>
>>> BTW: I guess this is not a fix for issues in the current kernel HEAD?
>>> Is it OK to have this for the next (v3.7) cycle?
>>>
>> It's a real fix. Since of_get_named_gpio_flags() needs to get flags of gpio.
>> This function is widely used in mmc/usb/... drivers. So it requires
>> vendor's gpio
>> driver to support parse flags from DT script.
>
> OK I take that as an ACK so I've put it on my fixes branch with
> your Acked-by.
>
Thanks. Let me revert it from pxa git tree.

Regards
Haojian
