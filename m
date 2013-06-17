From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 18:08:51 +0200
Subject: [PATCH 01/11] pinctrl: single: adopt pinctrl sleep mode management
In-Reply-To: <20130617120340.GE10305@atomide.com>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
 <1369995191-20855-2-git-send-email-gururaja.hebbar@ti.com>
 <CACRpkdZjvW6M1Q+K3OD1x_Jkz91AofdOdBThyJLGJ+Wx-BDTNw@mail.gmail.com>
 <20130617120340.GE10305@atomide.com>
Message-ID: <CACRpkdZGV7v2=rrKfiLXF7k3JG-1BEDr5=dC+E96gvpnPCCRcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 2:03 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Linus Walleij <linus.walleij@linaro.org> [130617 04:38]:
>> On Fri, May 31, 2013 at 12:13 PM, Hebbar Gururaja
>> <gururaja.hebbar@ti.com> wrote:
>>
>> > Make pinctrl-single able to handle suspend/resume events and change
>> > hogged pins states accordingly.
>> >
>> > Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
>> > Cc: Linus Walleij <linus.walleij@linaro.org>
>>
>> Noone said anything about this patch, but it looks very straight-forward
>> to me and seems sound so I have applied it.
>>
>> If Tony or Haojian has strong feelings about it I will dequeue it.
>
> I don't like the hogged pins at all as they prevent me from unloading
> pinctrl-single.. But the patch seems fine to me:

Hm? I think the hogged pins are the *only* pins we can
reliably release when unloading the driver, look:

void pinctrl_unregister(struct pinctrl_dev *pctldev)
{
(...)
        if (!IS_ERR(pctldev->p))
                pinctrl_put(pctldev->p);

That releases all hogged pinctrl handles when unloading
a pinctrl driver.

Yours,
Linus Walleij
