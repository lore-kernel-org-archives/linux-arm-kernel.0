From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 Feb 2015 12:46:06 +0100
Subject: [PATCH 1/1] ARM: dts: Use more descriptive names for Exynos5420
 PDs
In-Reply-To: <54D52905.6040100@collabora.co.uk>
References: <1423244258-24314-1-git-send-email-javier.martinez@collabora.co.uk>
 <54D51170.10903@cogentembedded.com>
 <54D52905.6040100@collabora.co.uk>
Message-ID: <CAJKOXPepTJYYs6gR6NLQzsJndeRLgF+KHRpH9qt9noUgRBs2Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-06 21:50 GMT+01:00 Javier Martinez Canillas
<javier.martinez@collabora.co.uk>:
> Hello Sergei,
>
> Thanks a lot for your feedback.
>
> On 02/06/2015 08:09 PM, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 02/06/2015 08:37 PM, Javier Martinez Canillas wrote:
>>
>>> All the device nodes for the Exynos5420 power-domains have a quite
>>> generic "power-domain" name.
>>
>>     And this is in conformance to the ePAPR standard.
>>
>
> True, I forgot that the ePAPR recommends that the node names should be
> somewhat generic but OTOH this is the only Exynos DTSI file that follows
> the standard for the power domain device nodes. All other Exynos DTSI
> use a prefix to differentiate between each power domain.
>
>>> So in case of an error, the Exynos PD
>>> driver shows the following (not very useful) message:
>>
>>> "Power domain power-domain disable failed"
>>
>>     Why not fix the message instead to use the full device name?
>>
>
> Well, the full node name is also not very useful IMHO since you have
> to check the DTSI or SoC manual to map the device node unit-address to
> the corresponding power domain.
>
> I used $subject when debugging an HDMI issue and instead of dropping
> it, I just posted it in case someone considered useful. I don't really
> mind if the patch is nacked / not picked.

Additionally (on Arndale Octa):

$ cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
    domain                      status         slaves
           /device                                      runtime status
----------------------------------------------------------------------
power-domain                    on
    /devices/platform/amba/3880000.adma                 suspended
power-domain                    off
power-domain                    off
power-domain                    off
power-domain                    off
power-domain                    off

This really is not helpful. From the power domain debugfs code it is
complicated to extract of_node of power domain. It is easier to print
the name of power domain. But wait... all names are the same! :) So
why do we have the name in the first place?
