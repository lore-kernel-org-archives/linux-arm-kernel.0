From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 23 Oct 2014 12:33:41 -0200
Subject: [PATCH] usb: ehci/ohci: use SIMPLE_DEV_PM_OPS to support
 hibernation
In-Reply-To: <1414054135-14428-1-git-send-email-wonhong.kwon@lge.com>
References: <1414054135-14428-1-git-send-email-wonhong.kwon@lge.com>
Message-ID: <CAOMZO5CeufsCUFWAnR7SRy5W=y25Pr+iNELLd8Fb25U7omt15Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 6:48 AM, Wonhong Kwon <wonhongkwon@gmail.com> wrote:

> -#else /* !CONFIG_PM */
> +#else /* !CONFIG_PM_SLEEP */
>  #define ehci_platform_suspend  NULL
>  #define ehci_platform_resume   NULL

No need for these NULL defines anymore as you switched to SIMPLE_DEV_PM_OPS.

> -#else /* !CONFIG_PM */
> +#else /* !CONFIG_PM_SLEEP */
>  #define ohci_platform_suspend  NULL
>  #define ohci_platform_resume   NULL

Same here.
