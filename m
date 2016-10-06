From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 6 Oct 2016 09:56:25 -0600
Subject: [PATCH 5/8] dt/bindings: Update binding for PM domain idle states
In-Reply-To: <CAMuHMdUKbJ1Mt3viEkbCDmZGHQjGi_E=bxEBSHOB1MMY+qfSYQ@mail.gmail.com>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
 <1475699519-109623-6-git-send-email-lina.iyer@linaro.org>
 <CAMuHMdWxft8o493XN2zg1wj2By7P+qBkrvyQOt7WdBnhPAvSXQ@mail.gmail.com>
 <CAMuHMdUKbJ1Mt3viEkbCDmZGHQjGi_E=bxEBSHOB1MMY+qfSYQ@mail.gmail.com>
Message-ID: <20161006155625.GG28930@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06 2016 at 02:09 -0600, Geert Uytterhoeven wrote:
>On Thu, Oct 6, 2016 at 10:06 AM, Geert Uytterhoeven
><geert@linux-m68k.org> wrote:
>> On Wed, Oct 5, 2016 at 10:31 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>> Update DT bindings to describe idle states of PM domains.
>>>
>>> This patch is based on the original patch by Marc Titinger.
>>>
>>> Cc: <devicetree@vger.kernel.org>
>>> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  .../devicetree/bindings/power/power_domain.txt     | 36 ++++++++++++++++++++++
>>>  1 file changed, 36 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>>> index 025b5e7..a043315 100644
>>> --- a/Documentation/devicetree/bindings/power/power_domain.txt
>>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>>> @@ -29,6 +29,10 @@ Optional properties:
>>>     specified by this binding. More details about power domain specifier are
>>>     available in the next section.
>>>
>>> +- domain-idle-states : A phandle of an idle-state that shall be soaked into a
>>> +                generic domain power state. The idle state definitions are
>>> +                compatible with arm,idle-state specified in [1].
>>> +
>>>  Example:
>>>
>>>         power: power-controller at 12340000 {
>>> @@ -59,6 +63,36 @@ The nodes above define two power controllers: 'parent' and 'child'.
>>>  Domains created by the 'child' power controller are subdomains of '0' power
>>>  domain provided by the 'parent' power controller.
>>>
>>> +Example 3:
>>> +       parent: power-controller at 12340000 {
>>
>> With W=1, this is gonna trigger:
>>
>>     Warning (unit_address_vs_reg): Node foo has a unit name, but no reg property
>>
>> Yes, there are pre-existing users in this file.
>
>Scrap this... switching desktops causes loss of position...
>
>>> +               compatible = "foo,power-controller";
>>> +               reg = <0x12340000 0x1000>;
>>> +               #power-domain-cells = <1>;
>>> +               domain-idle-states = <&DOMAIN_RET, &DOMAIN_PWR_DN>;
>>> +       };
>
>+       DOMAIN_RET: state at 0 {
>+               compatible = "arm,idle-state";
>+               entry-latency-us = <1000>;
>+               exit-latency-us = <2000>;
>+               min-residency-us = <10000>;
>
>This one is gonna trigger
>
>Warning (unit_address_vs_reg): Node foo has a unit name, but no reg property
>
>+       };
>
Its just an example, Will fix the example.

>Gr{oetje,eeting}s,
>
>                        Geert
>
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
>In personal conversations with technical people, I call myself a hacker. But
>when I'm talking to journalists I just say "programmer" or something like that.
>                                -- Linus Torvalds
