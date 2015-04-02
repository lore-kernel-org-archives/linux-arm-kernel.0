From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Fri, 3 Apr 2015 01:35:23 +0900
Subject: [PATCH/RFC] ARM: shmobile: r8a7791: Remove MSIOF address from
 device tree
In-Reply-To: <CAMuHMdV201bh8-QrJgsO4KNSMW-d9aVyMczHdyQO0Y_pg4sukw@mail.gmail.com>
References: <1426430633-3867-1-git-send-email-ykaneko0929@gmail.com>
 <CAH1o70JyBbmQ9vDrpamtL=09nq64B9RM1asWOWRXEL0LdgrxMQ@mail.gmail.com>
 <CAMuHMdV201bh8-QrJgsO4KNSMW-d9aVyMczHdyQO0Y_pg4sukw@mail.gmail.com>
Message-ID: <CAH1o70LKe5acCgKd6QwfGAnhLOm9X8iKyX9f6jN=3ZOjGb9aMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert-san,

Thanks for your reply.

It seems that you and Simon concluded that the driver change wasn't
necessary. As I don't have access to the relevant documentation I'm happy
to defer to you two on that matter.

With that in mind I'll refresh this patch as you request.

I'm assuming that the r8a7790 version of this patch is fine as-is.
I'll re-post that one unchanged other than dropping the RFC tag.

Thanks,
Kaneko

2015-03-30 18:23 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Kaneko-san,
>
> On Sun, Mar 29, 2015 at 3:22 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> I'm wondering if you could find a moment to look over this patch.
>
> In light of the discussion thread w.r.t. to the driver changes (I
> don't recall you
> replying, did I miss that?), I think the DTS changes for r8a779[01] are fine.
> However, please also update the example (for r8a7791) in
> Documentation/devicetree/bindings/spi/sh-msiof.txt.
>
> Thanks!
>
>> 2015-03-15 23:43 GMT+09:00 Yoshihiro Kaneko <ykaneko0929@gmail.com>:
>>> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>>>
>>> MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
>>> MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.
>>>
>>> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>>> ---
>>>
>>> This patch is based on devel branch of Simon Horman's renesas tree.
>>>
>>>  arch/arm/boot/dts/r8a7791.dtsi | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
>>> index 4696062..3e9f824 100644
>>> --- a/arch/arm/boot/dts/r8a7791.dtsi
>>> +++ b/arch/arm/boot/dts/r8a7791.dtsi
>>> @@ -1288,7 +1288,7 @@
>>>
>>>         msiof0: spi at e6e20000 {
>>>                 compatible = "renesas,msiof-r8a7791";
>>> -               reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;
>>> +               reg = <0 0xe6e20000 0 0x0064>;
>>>                 interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
>>>                 clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
>>>                 dmas = <&dmac0 0x51>, <&dmac0 0x52>;
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
