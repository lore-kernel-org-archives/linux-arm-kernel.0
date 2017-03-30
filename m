From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Mar 2017 15:50:24 +0200
Subject: [PATCH v9 04/12] soc: samsung: add exynos chipid driver support
In-Reply-To: <1490879826-16754-5-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20170330131427epcas5p4c3d238022dc75694ad3baa8a1018ea04@epcas5p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-5-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAK8P3a0dq-Ve2N3yFbpZ7LHzZJ=w6-pLRTSZJZ2=rnk2gWphJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 3:16 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
>
> +config EXYNOS_CHIPID
> +       bool "Exynos Chipid controller driver" if COMPILE_TEST
> +       depends on ARCH_EXYNOS || COMPILE_TEST
> +       select SOC_BUS

This lets you disable the driver when COMPILE_TEST is set on exynos,
which is probably not what you wanted.

I'd do

         bool "Exynos Chipid controller driver" if COMPILE_TEST && !ARCHEXYNOS
         default ARCH_EXYNOS

     Arnd
