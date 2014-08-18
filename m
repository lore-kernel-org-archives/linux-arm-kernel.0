From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Mon, 18 Aug 2014 19:03:04 +0200
Subject: [PATCH v2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <53F2255E.7090208@wwwdotorg.org>
References: <1407957267-3258-1-git-send-email-dgreid@chromium.org>
 <53EF76CF.9050808@suse.de> <53F2255E.7090208@wwwdotorg.org>
Message-ID: <53F231C8.5050309@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 18.08.2014 18:10, schrieb Stephen Warren:
> On 08/16/2014 09:20 AM, Andreas F?rber wrote:
>> Am 13.08.2014 21:14, schrieb Dylan Reid:
>>> +    pinmux: pinmux at 0,70000868 {
>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&pinmux_default>;
>>> +
>>> +        pinmux_default: common {
>>> +            dap_mclk1_pw4 {
>>
>> Any need to have the nodes this way? Shouldn't this rather be
>> dap-mclk1-pw4 as node name by conventions, with a dap_mclk1_pw4 label
>> for referencing if needed? Same below, obviously.
> 
> Underscores are consistent with at least all the other Tegra DTs, so I
> think this is best as is.
> 
>>> +    pwm: pwm at 0,7000a000 {
>>
>> Add the label to the .dtsi where the node is first declared? Then you
>> can override it the safer &pwm { ... }; way. Same for all other nodes
>> being extended/overridden here - that's what your colleagues requested
>> for Spring. It'll help with the 80 char limit further below by reducing
>> indentation.
> 
> We certainly do have the pwm label in *.dtsi for other SoCs, so we
> should probably move the label there.
> 
> Using the &pwm {} syntax would be inconsistent with all the other Tegra
> DTs, and isn't really any safer; the HW isn't going to change, so once
> this is written, it should continue to "just work".

For exactly those consistency reasons I was asked to refactor the whole
set of exynos5250-*.dts files despite having no relation to them -
turning my 1 .dts patch into a large series that still isn't applied...

It's funny and disappointing that every Linux maintainer seems to have
their own conventions, and not even the Google Chrome people can agree
on a common style or live up to what they ask of others.

As for &pwm {}, I understood it's "safer" in that mismatches in the node
name will lead to compilation errors rather than silent runtime misbehavior.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
