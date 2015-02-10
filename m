From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 Feb 2015 13:17:50 +0100
Subject: [PATCH 1/1] ARM: dts: Use more descriptive names for Exynos5420
 PDs
In-Reply-To: <54D9F1A4.1000908@cogentembedded.com>
References: <1423244258-24314-1-git-send-email-javier.martinez@collabora.co.uk>
 <54D51170.10903@cogentembedded.com> <54D52905.6040100@collabora.co.uk>
 <CAJKOXPepTJYYs6gR6NLQzsJndeRLgF+KHRpH9qt9noUgRBs2Dw@mail.gmail.com>
 <54D9F1A4.1000908@cogentembedded.com>
Message-ID: <1423570670.6241.2.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2015-02-10 at 14:55 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 2/10/2015 2:46 PM, Krzysztof Kozlowski wrote:
> > Additionally (on Arndale Octa):
> 
> > $ cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> >      domain                      status         slaves
> >             /device                                      runtime status
> > ----------------------------------------------------------------------
> > power-domain                    on
> >      /devices/platform/amba/3880000.adma                 suspended
> > power-domain                    off
> > power-domain                    off
> > power-domain                    off
> > power-domain                    off
> > power-domain                    off
> 
> > This really is not helpful. From the power domain debugfs code it is
> > complicated to extract of_node of power domain.
> 
>     You shouldn't need it.
> 
> > It is easier to print
> > the name of power domain. But wait... all names are the same! :) So
> > why do we have the name in the first place?
> 
>     I'm not sure why the full platform device names aren't printed -- they 
> should all be different.

This debugfs code iterates over list of generic_pm_domains (gpd_list). I
cannot find function for translating from genpd to its platform device
so only genpd->name can be printed.

Best regards,
Krzysztof
