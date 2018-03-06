From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2018 17:38:29 +0100
Subject: [PATCH v2 0/6] Arm interconnect PMU driver tidyup
In-Reply-To: <cover.1518717258.git.robin.murphy@arm.com>
References: <cover.1518717258.git.robin.murphy@arm.com>
Message-ID: <CAK8P3a1fSYaAQHoESQc8y3Xn+5bAg6dFtjnz1nayfhrpns+ZGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 7:51 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi arm-soc folks,
>
> PLease consider this series tidying up the Arm interconnect code
> in drivers/bus to separate the PMU parts out into drivers/perf
> where Will and Mark can handle future maintenance more easily.
>
> FWIW, the patches are also available on a branch here:
>
>   git://linux-arm.org/linux-rm.git perf

This is not a signed tag, so I applied the patches manually to the drivers
branch. To add to the bike-shedding, I would have preferred a different
approach over the auxdata array, either exporting a function based
interface, or calling ioremap() on the physical address multiple times,
but each of those has other downsides, so your version seems good
enough.

Thanks,

         Arnd
