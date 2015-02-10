From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 10 Feb 2015 14:55:16 +0300
Subject: [PATCH 1/1] ARM: dts: Use more descriptive names for Exynos5420
 PDs
In-Reply-To: <CAJKOXPepTJYYs6gR6NLQzsJndeRLgF+KHRpH9qt9noUgRBs2Dw@mail.gmail.com>
References: <1423244258-24314-1-git-send-email-javier.martinez@collabora.co.uk>	<54D51170.10903@cogentembedded.com>	<54D52905.6040100@collabora.co.uk>
 <CAJKOXPepTJYYs6gR6NLQzsJndeRLgF+KHRpH9qt9noUgRBs2Dw@mail.gmail.com>
Message-ID: <54D9F1A4.1000908@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 2/10/2015 2:46 PM, Krzysztof Kozlowski wrote:

>>>> All the device nodes for the Exynos5420 power-domains have a quite
>>>> generic "power-domain" name.

>>>      And this is in conformance to the ePAPR standard.

>> True, I forgot that the ePAPR recommends that the node names should be
>> somewhat generic but OTOH this is the only Exynos DTSI file that follows
>> the standard for the power domain device nodes. All other Exynos DTSI
>> use a prefix to differentiate between each power domain.

>>>> So in case of an error, the Exynos PD
>>>> driver shows the following (not very useful) message:

>>>> "Power domain power-domain disable failed"

>>>      Why not fix the message instead to use the full device name?

>> Well, the full node name is also not very useful IMHO since you have
>> to check the DTSI or SoC manual to map the device node unit-address to
>> the corresponding power domain.

>> I used $subject when debugging an HDMI issue and instead of dropping
>> it, I just posted it in case someone considered useful. I don't really
>> mind if the patch is nacked / not picked.

> Additionally (on Arndale Octa):

> $ cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>      domain                      status         slaves
>             /device                                      runtime status
> ----------------------------------------------------------------------
> power-domain                    on
>      /devices/platform/amba/3880000.adma                 suspended
> power-domain                    off
> power-domain                    off
> power-domain                    off
> power-domain                    off
> power-domain                    off

> This really is not helpful. From the power domain debugfs code it is
> complicated to extract of_node of power domain.

    You shouldn't need it.

> It is easier to print
> the name of power domain. But wait... all names are the same! :) So
> why do we have the name in the first place?

    I'm not sure why the full platform device names aren't printed -- they 
should all be different.

WBR, Sergei
