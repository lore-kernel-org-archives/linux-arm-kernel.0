From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 31 Oct 2018 15:21:16 -0700
Subject: [PATCH 0/2] perf tests: Check for ARM [vectors] page
In-Reply-To: <20181025000905.6095-1-f.fainelli@gmail.com>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
Message-ID: <b4fffe21-cc0d-f691-29fe-a9deda2f7ba1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/18 5:09 PM, Florian Fainelli wrote:
> Hi all,
> 
> I just painfully learned that perf would segfault when
> CONFIG_KUSER_HELPERS is disabled because it unconditionally makes use of
> it. This patch series adds an ARM test for that by leveraging the
> existing find_vdso_map() function and making it more generic and capable
> of location any map within /proc/self/maps.

Any feedback on this?

> 
> Florian Fainelli (2):
>   perf tools: Make find_vdso_map() more modular
>   perf tests: Add a test for the ARM 32-bit [vectors] page
> 
>  tools/perf/arch/arm/tests/Build          |  1 +
>  tools/perf/arch/arm/tests/arch-tests.c   |  4 +++
>  tools/perf/arch/arm/tests/vectors-page.c | 20 +++++++++++++++
>  tools/perf/tests/tests.h                 |  5 ++++
>  tools/perf/util/find-map.c               | 31 ++++++++++++++++++++++++
>  tools/perf/util/find-vdso-map.c          | 30 +++--------------------
>  6 files changed, 64 insertions(+), 27 deletions(-)
>  create mode 100644 tools/perf/arch/arm/tests/vectors-page.c
>  create mode 100644 tools/perf/util/find-map.c
> 


-- 
Florian
