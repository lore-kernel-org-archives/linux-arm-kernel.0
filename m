From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 26 Oct 2016 09:26:47 -0200
Subject: [PATCH] ARM: imx6: Fix GPC probe error path
In-Reply-To: <39c26009-8e50-d182-dbfd-49f44cb9402a@roeck-us.net>
References: <1477416878-30353-1-git-send-email-linux@roeck-us.net>
 <39c26009-8e50-d182-dbfd-49f44cb9402a@roeck-us.net>
Message-ID: <CAOMZO5C8u84wxC88t_mjAGSjPSbL746FEXPqt6evQO1eA5+r9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Wed, Oct 26, 2016 at 12:35 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Looking into this some more, it turns out that
> of_genpd_add_provider_onecell()
> now returns an error if one of the provided power domains does not exist.
> In this case, the "ARM" power domain does not exist. I don't see where it is
> created, so it may well be that this now fails for all imx6 boards with
> multi_v7_defconfig. Looking into kernelci.org test results, this is
> confirmed
> for at least imx6dl-riotboard. Overall I think it is quite safe to assume
> that all imx6 boards crash with mainline kernels and multi_v7_defconfig.
>
> The change can be tracked down to commit 0159ec67076 ("PM / Domains: Verify
> the PM domain is present when adding a provider"). Adding everyone in the
> commit log for feedback.

Yes, this is the same conclusion I got. Please check:
https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/fixes&id=eef0b282bb586259d35548851cf6a4ce847bb804
