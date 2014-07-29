From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Tue, 29 Jul 2014 14:45:37 +0200
Subject: [PATCH v2 3/4] ARM: dts: exynos5250: Fold common ChromeOS parts
 into Snow
In-Reply-To: <CAD=FV=VK0KJknJ2099S7fEDzBnpPCrpSZ36WPkJB156GpcyEfg@mail.gmail.com>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>	<1405704009-8430-4-git-send-email-afaerber@suse.de>
 <CAD=FV=VK0KJknJ2099S7fEDzBnpPCrpSZ36WPkJB156GpcyEfg@mail.gmail.com>
Message-ID: <53D79771.1020406@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug,

Am 25.07.2014 18:02, schrieb Doug Anderson:
> On Fri, Jul 18, 2014 at 10:20 AM, Andreas F?rber <afaerber@suse.de> wrote:
>> +/*
>> + * On Snow we've got SIP WiFi and so can keep drive strengths low to
>> + * reduce EMI.
>> + */
>> +&mmc_3 {
>> +       status = "okay";
>> +       num-slots = <1>;
>> +       supports-highspeed;
>> +       broken-cd;
>> +       card-detect-delay = <200>;
>> +       samsung,dw-mshc-ciu-div = <3>;
>> +       samsung,dw-mshc-sdr-timing = <2 3>;
>> +       samsung,dw-mshc-ddr-timing = <1 2>;
>> +
>> +       slot at 0 {
>> +               reg = <0>;
>> +               bus-width = <4>;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
> 
> This actually looks like a bug on snow.  I don't think these pinctrl
> statements are taking effect and I think they belong at the mmc level,
> not the slot level.  That's not a new bug introduced by you, though.
> Mind fixing it?  You've already got it right for Spring mmc_1.

I was taught never to mix code movements with functional changes, as it
hides them even if mentioned in the commit message. Would you like me to
fix it pre- or post-move? Post-move would be easiest for me. ;)

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
