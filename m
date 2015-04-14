From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 14 Apr 2015 23:09:46 +0200
Subject: [PATCH v3 2/3] firmware: qcom: scm: Add support for ARM64 SoCs
In-Reply-To: <1429041520-6720-3-git-send-email-galak@codeaurora.org>
References: <1429041520-6720-1-git-send-email-galak@codeaurora.org>
 <1429041520-6720-3-git-send-email-galak@codeaurora.org>
Message-ID: <1429045786.27492.51.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-04-14 at 14:58 -0500, Kumar Gala wrote:
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile

> +ifdef CONFIG_64BIT
> +obj-$(CONFIG_QCOM_SCM)		+= qcom_scm-64.o
> +else
>  obj-$(CONFIG_QCOM_SCM)		+= qcom_scm-32.o
> +endif

I don't think arm and arm64 set BITS. If they did 
    obj-$(CONFIG_QCOM_SCM)		+= qcom_scm-$(BITS).o

might have worked here.


Paul Bolle
