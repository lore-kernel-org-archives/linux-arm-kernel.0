From: ta.omasab@gmail.com (Thomas Abraham)
Date: Tue, 13 May 2014 23:59:01 +0530
Subject: [PATCH 0/2] PM / OPP: move cpufreq specific helpers out of OPP
 layer
In-Reply-To: <1399296830-13056-1-git-send-email-nm@ti.com>
References: <1399296830-13056-1-git-send-email-nm@ti.com>
Message-ID: <CAJuA9agOJyQ_2KOoyn=ohVOeO199aVqm_YXtpUVfETQiPk+ZTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 5, 2014 at 7:03 PM, Nishanth Menon <nm@ti.com> wrote:
> CPUFreq usage of OPP should be independent of the ordering of type of
> data storage inside OPP layer. The current operations can equally be
> performed by generic operations.
>
> [RFC]: https://patchwork.kernel.org/patch/4100811/
>
> Series based on: v3.15-rc1
>
> Nishanth Menon (2):
>   PM / OPP: Remove cpufreq wrapper dependency on internal data
>     organization
>   PM / OPP: Move cpufreq specific OPP functions out of generic OPP
>     library
>
>  Documentation/cpu-freq/core.txt |   29 +++++++++++
>  Documentation/power/opp.txt     |   40 ++------------
>  drivers/base/power/opp.c        |   91 --------------------------------
>  drivers/cpufreq/Makefile        |    2 +
>  drivers/cpufreq/cpufreq_opp.c   |  110 +++++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h         |   21 ++++++++
>  include/linux/pm_opp.h          |   20 -------
>  7 files changed, 167 insertions(+), 146 deletions(-)
>  create mode 100644 drivers/cpufreq/cpufreq_opp.c

Works fine on Exynos.
Tested-by: Thomas Abraham <thomas.ab@samsung.com>

>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
