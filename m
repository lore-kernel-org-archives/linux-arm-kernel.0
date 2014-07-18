From: burlaprakash.linuxkernel@gmail.com (Prakash Burla)
Date: Fri, 18 Jul 2014 18:45:01 +0530
Subject: [PATCH v2 4/4] mfd: pm8921: rename pm8921-core driver
In-Reply-To: <1405613855-27572-5-git-send-email-svarbanov@mm-sol.com>
References: <1405613855-27572-1-git-send-email-svarbanov@mm-sol.com>
 <1405613855-27572-5-git-send-email-svarbanov@mm-sol.com>
Message-ID: <CABu_nUQDWbejZcQqFSJMhCokeMJXBcsCpsiJxz4gBsmtKiyivA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 9:47 PM, Stanimir Varbanov <svarbanov@mm-sol.com> wrote:
> The pm8921-core driver presently supports pm8921 and pm8058
> Qualcomm PMICs.  To avoid confusion with new generation PMICs
> (like pm8941) rename the pm8921-core driver to more
> appropriate name pm8xxx-ssbi, which reflects better that
> those chips use SSBI interface.
>
> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> ---
>  drivers/mfd/Kconfig                          |   14 +++++-----
>  drivers/mfd/Makefile                         |    2 +-
>  drivers/mfd/{pm8921-core.c => pm8xxx-ssbi.c} |   38 +++++++++++++-------------
>  3 files changed, 27 insertions(+), 27 deletions(-)
>  rename drivers/mfd/{pm8921-core.c => pm8xxx-ssbi.c} (92%)
 .
 [Nope]
>  MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("PMIC 8921 core driver");
> +MODULE_DESCRIPTION("PMIC PM8XXX SSBI driver");
>  MODULE_VERSION("1.0");
> -MODULE_ALIAS("platform:pm8921-core");
> +MODULE_ALIAS("platform:pm8xxx-ssbi");
 >How about adding the module author as svarbanov at mm-sol.com/qcom?
      MODULE_AUTHOR("SVARBANOV<svarbanov@mm-sol.com>");
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
