From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat, 18 Jun 2016 18:01:27 -0700
Subject: [PATCH v3 0/5] i.MX L2-cache code cleanups and performance tweaks
In-Reply-To: <1466296268-27099-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466296268-27099-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <CAHQ1cqGmt0GFiyQq9XA-YrqgLrZEDWC=NBM3iVd2dmmJzPvUDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please ignore this version of the patch set, I just realized that I
screwed up patch 3/5. I'll be sending fixed v4 shortly.

Sorry for the noise,
Andrey Smirnov

On Sat, Jun 18, 2016 at 5:31 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Hi everyone,
>
> Here's the second version of i.MX L2-cache related patches. Here's
> what's new from v2:
>
>        - Generic ARM patches were split inot a separte series
>
>        - Typo and whitespace fixes (as per Uwe's suggestions)
>
>        - Re-ordered l2c_aux_val, and l2c_aux_mask are initializers are placed
>          in the order of their declaration
>
> Let me know if any more changes to the series are needed.
>
> Andrey Smirnov
>
> Andrey Smirnov (5):
>   i.MX: system.c: Convert goto to if statement
>   i.MX: system.c: Remove redundant errata 752271 code
>   i.MX: system.c: Replace magic numbers
>   i.MX: system.c: Tweak prefetch settings for performance
>   i.MX: Do not explicitly call l2x0_of_init()
>
>  arch/arm/mach-imx/imx35-dt.c    | 10 +++-------
>  arch/arm/mach-imx/mach-imx6q.c  |  2 ++
>  arch/arm/mach-imx/mach-imx6sl.c |  2 ++
>  arch/arm/mach-imx/mach-imx6sx.c |  2 ++
>  arch/arm/mach-imx/system.c      | 42 ++++++++++++++++-------------------------
>  5 files changed, 25 insertions(+), 33 deletions(-)
>
> --
> 2.5.5
>
