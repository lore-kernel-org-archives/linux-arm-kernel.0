From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Mar 2017 16:03:59 +0200
Subject: [PATCH v9 07/12] ARM: EXYNOS: introduce soc specific pm ops
In-Reply-To: <1490879826-16754-8-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20170330131434epcas1p4e42fe06bae3456c39e0f93a2f8ae4bc0@epcas1p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-8-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAK8P3a3wTa0ckx3Uo37ptDxQCK_24aDK9dmETtog_qU7VrMygA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 3:17 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:

> +               .soc_id = "EXYNOS5250",
> +               .data = &exynos_common_s2r_data
> +       },
> +       {
> +               .soc_id = "EXYNOS5260",
> +               .data = &exynos_common_s2r_data
> +       },
> +       {
> +               .soc_id = "EXYNOS5440",
> +               .data = &exynos_common_s2r_data
> +       },
> +       {
> +               .soc_id = "EXYNOS5410",
> +               .data = &exynos_common_s2r_data
> +       },
> +       {
> +               .soc_id = "EXYNOS5420",
> +               .data = &exynos_common_s2r_data
> +       },
> +       {
> +               .soc_id = "EXYNOS5800",
> +               .data = &exynos_common_s2r_data

If these are all the same, just make that soc_id="EXYNOS5*"
to match them all at once.

> +int __init exynos_s2r_init(void)
> +{
> +       const struct soc_device_attribute *match;
> +
> +       match = soc_device_match(exynos_soc_revision);
> +
> +       if (match)
> +               s2r_data = (const struct exynos_s2r_data *) match->data;
> +
> +       if (!s2r_data)
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +arch_initcall(exynos_s2r_init);
> +

Can you replace the arch_initcall with a direct call from the machine
init function?

        Arnd
