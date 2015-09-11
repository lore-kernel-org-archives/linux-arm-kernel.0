From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 11 Sep 2015 16:26:16 -0700
Subject: [Patch v2] firmware: qcom: scm: Add function stubs for ARM64
In-Reply-To: <1442005276-31971-1-git-send-email-agross@codeaurora.org>
References: <1442005276-31971-1-git-send-email-agross@codeaurora.org>
Message-ID: <20150911232616.GE13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 11 Sep 14:01 PDT 2015, Andy Gross wrote:

> This patch adds stubs for the SCM functions exposed in the QCOM SCM API.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>  drivers/firmware/Kconfig       |    8 +++++
>  drivers/firmware/Makefile      |    3 +-
>  drivers/firmware/qcom_scm-64.c |   63 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/qcom_scm-64.c
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 99c69a3..72720eb 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -136,6 +136,14 @@ config QCOM_SCM
>  	bool
>  	depends on ARM || ARM64
>  
> +config QCOM_SCM_32
> +	def_bool y
> +	depends on QCOM_SCM && ARM
> +
> +config QCOM_SCM_64
> +	def_bool y
> +	depends on QCOM_SCM && ARM64
> +

So if QCOM_SCM is selected by a consumer then the dependencies here will
be met and the correct implementation will be chosen, as these aren't
possible to deselect?


I guess that's an okay approach, so:

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
