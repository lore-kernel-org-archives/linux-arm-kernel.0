From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 04 Aug 2014 19:31:12 +0200
Subject: [PATCH v6 10/10] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <CAD=FV=WFP53bZAks7t9xybUxpna89Nz=KG+PQwAcxFEH0D+3mw@mail.gmail.com>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>	<1406940750-15880-11-git-send-email-afaerber@suse.de>
 <CAD=FV=WFP53bZAks7t9xybUxpna89Nz=KG+PQwAcxFEH0D+3mw@mail.gmail.com>
Message-ID: <53DFC360.9080304@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 08/04/2014 05:22 PM, Doug Anderson wrote:
>> +
>> +&pinctrl_0 {
>> +       s5m8767_dvs: s5m8767-dvs {
>> +               samsung,pins = "gpd1-0", "gpd1-1", "gpd1-2";
>> +               samsung,pin-function = <0>;
>> +               samsung,pin-pud = <1>;
>> +               samsung,pin-drv = <0>;
>> +       };
>> +
>> +       dp_hpd_gpio: dp-hpd-gpio {
>> +               samsung,pins = "gpc3-0";
>> +               samsung,pin-function = <0>;
>> +               samsung,pin-pud = <3>;
>> +               samsung,pin-drv = <0>;
>> +       };
>> +
>> +       power_key_irq: power-key-irq {
>> +               samsung,pins = "gpx1-3";
>> +               samsung,pin-function = <0>;
>> +               samsung,pin-pud = <0>;
>> +               samsung,pin-drv = <0>;
>> +       };
> 
> The fact that snow is missing the pinctrl lines for power and lid is a
> bug on snow.  Perhaps Javier would be interested in submitting a patch
> to fix that?
> 
> 

Sure, added on my TODO list to not only add these missing pin control lines for
lid and power and reference them on gpio-keys but also to double check if there
is anything else missing in the mainline Snow DTS that is on the downstream
Chrome OS one.

I'll wait for Andreas series to be picked by Kukjin before submit a patch though
to avoid any unnecessary churn.

Best regards,
Javier
