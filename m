From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 10 Feb 2015 13:46:12 +0100
Subject: [PATCH 1/1] ARM: dts: Use more descriptive names for Exynos5420
 PDs
In-Reply-To: <1423571438.6241.4.camel@AMDC1943>
References: <1423244258-24314-1-git-send-email-javier.martinez@collabora.co.uk>
 <54D51170.10903@cogentembedded.com> <54D52905.6040100@collabora.co.uk>
 <CAJKOXPepTJYYs6gR6NLQzsJndeRLgF+KHRpH9qt9noUgRBs2Dw@mail.gmail.com>
 <54D9F1A4.1000908@cogentembedded.com> <1423570670.6241.2.camel@AMDC1943>
 <54D9F7B1.3030106@cogentembedded.com> <1423571438.6241.4.camel@AMDC1943>
Message-ID: <54D9FD94.9000102@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 02/10/2015 01:30 PM, Krzysztof Kozlowski wrote:
> On wto, 2015-02-10 at 15:21 +0300, Sergei Shtylyov wrote:
>> On 2/10/2015 3:17 PM, Krzysztof Kozlowski wrote:
>> 
>> >>> Additionally (on Arndale Octa):
>> 
>> >>> $ cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>> >>>       domain                      status         slaves
>> >>>              /device                                      runtime status
>> >>> ----------------------------------------------------------------------
>> >>> power-domain                    on
>> >>>       /devices/platform/amba/3880000.adma                 suspended
>> >>> power-domain                    off
>> >>> power-domain                    off
>> >>> power-domain                    off
>> >>> power-domain                    off
>> >>> power-domain                    off
>> 
>> >>> This really is not helpful. From the power domain debugfs code it is
>> >>> complicated to extract of_node of power domain.
>>

Not very useful indeed.
 
>> >>      You shouldn't need it.
>> 
>> >>> It is easier to print
>> >>> the name of power domain. But wait... all names are the same! :) So
>> >>> why do we have the name in the first place?
>> 
>> >>      I'm not sure why the full platform device names aren't printed -- they
>> >> should all be different.
>> 

Yes, but like I said in a previous email the fact that are different doesn't
necessarily mean that they will be helpful for debugging purposes.

>> > This debugfs code iterates over list of generic_pm_domains (gpd_list). I
>> > cannot find function for translating from genpd to its platform device
>> > so only genpd->name can be printed.
>> 
>>     Then why power domains aren't just named with the platform device names?
> 
> Right, the mach-exynos/pm_domains.c set the name equal to OF node name.
> I'll send a patch extending the name.
>

IIRC the OF core uses the device node unit address and node name to create
the platform device names so you will have something like 10044000.power-domain.

Same if using the node full_name since it will /power-domain at 10044000. In both
cases the DTS should have to be checked to know which power domain really is
unless someone knows by heart the power domains addresses.

But if using generic names for the power domains as suggested by ePAPR is so
important then we should change all the other Exynos DTS files which don't do.
 
> Best regards,
> Krzysztof
> 
> 

Best regards,
Javier
