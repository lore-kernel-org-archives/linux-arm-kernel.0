From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 27 Jul 2015 15:39:24 +0200
Subject: [PATCH V2 00/11] OPP: Add code to support operating-points-v2
 bindings
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Message-ID: <3834037.XRjxlAtlMq@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 27, 2015 10:32:30 AM Viresh Kumar wrote:
> Hi Rafael,
> 
> This is mostly reviewed and its been out on the lists for around one and
> half month. We can get it pushed for 4.3 now. Resending the series
> because of minor updates in few patches, which were also sent as replies
> to earlier version.
> 
> I have tested this on dual-core exynos board with the driver inbuilt as
> well as a module. Tried multiple insertion/removals of the module. Have
> tested cpufreq-dt driver with both old and new bindings.
> 
> ----------x-----------------x-------------
> 
> This adds code to support operating-points-v2 bindings. Not everything
> is supported yet, but most of the basic stuff is.
> 
> Pushed here as well for reference:
> ssh://git at git.linaro.org/people/viresh.kumar/linux.git opp/v2
> 
> V1->V2:
> - 1/11 is a new patch which moves the bindings file into opp specific
>   folder.
> - 'opp-suspend' binding got updated and is part of individual OPPs now,
>   instead of a phandle present in the opp table.
> - Some more minor reformatting as suggested by Bartlomiej and Stephen,
>   they were already posted as reply to earlier patches in V1.
> 
> Viresh Kumar (11):
>   opp: Create a directory for opp bindings
>   opp: Relocate few routines
>   OPP: Create _remove_device_opp() for freeing dev_opp
>   OPP: Allocate dev_opp from _add_device_opp()
>   OPP: Break _opp_add_dynamic() into smaller functions
>   opp: Add support to parse "operating-points-v2" bindings
>   OPP: Add clock-latency-ns support
>   opp: Add OPP sharing information to OPP library
>   OPP: Add support for opp-suspend
>   opp: Add helpers for initializing CPU OPPs
>   cpufreq-dt: Add support for operating-points-v2 bindings
> 
>  .../devicetree/bindings/power/{ => opp}/opp.txt    |    0
>  drivers/base/power/opp.c                           | 1072 +++++++++++++++-----
>  drivers/cpufreq/cpufreq-dt.c                       |   56 +-
>  include/linux/pm_opp.h                             |   29 +
>  4 files changed, 905 insertions(+), 252 deletions(-)
>  rename Documentation/devicetree/bindings/power/{ => opp}/opp.txt (100%)

Looks OK to me overall, but there seem to be some patches in the series that
haven't been reviewed by the OPP people.  I'd prefer these to get some ACKs
before they go in.

Thanks,
Rafael
