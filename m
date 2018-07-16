From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 16 Jul 2018 08:41:35 -0500
Subject: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
In-Reply-To: <be3c7332-3a7d-f8b0-efe4-e2a319273c42@amlogic.com> (Jian Hu's
 message of "Wed, 11 Jul 2018 16:05:54 +0800")
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
 <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
 <be3c7332-3a7d-f8b0-efe4-e2a319273c42@amlogic.com>
Message-ID: <7hbmb7mh68.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jian Hu <jian.hu@amlogic.com> writes:

> On 2018/7/10 5:53, Martin Blumenstingl wrote:
>> On Mon, Jul 9, 2018 at 1:14 PM Jian Hu <jian.hu@amlogic.com> wrote:

[...]

>>> +static const struct of_device_id clkc_match_table[] = {
>>> +       { .compatible = "amlogic,g12a-clkc" },
>> I wonder if that should be "amlogic,meson-g12a-clkc" (I know that AXG
>> and GXBB/GXL/GXM omit the "meson-" prefix, but I am not sure if that's
>> correct - I'll CC Rob Herring on the dt-bindings patch)
>>
> For clock drivers,they omit the "meson-" prefix, But for common
> amlogic drivers use "amlogic.meson-<chip>-<ip>".
> So which type should we choose? .compatible = "amlogic,g12a-clkc or
>
> .compatible = "amlogic,meson-g12a-clkc

Please follow the existing pattern for clock drivers, omitting the
"meson-" prefix.

Kevin
