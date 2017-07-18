From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jul 2017 16:39:03 +0200
Subject: [PATCH v2 8/8] staging: fsl-mc: allow the driver compile
 multi-arch
In-Reply-To: <596E1CD7.1050909@nxp.com>
References: <20170718133723.12709-1-laurentiu.tudor@nxp.com>
 <20170718133723.12709-9-laurentiu.tudor@nxp.com>
 <CAK8P3a0WvNgk5eXQoPpXiLwOS_wB1NdfCyPtiKMys3qqEwHjDw@mail.gmail.com>
 <596E1CD7.1050909@nxp.com>
Message-ID: <CAK8P3a2E64O6tgAdGck9ce1a=1yeQfzc9tNex7H+i1K0uKaOHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 4:36 PM, Laurentiu Tudor
<laurentiu.tudor@nxp.com> wrote:

> Good point, I'll take care of it. But don't you mean COMPILE_TEST be
> added on the actual MC_BUS config, like so:
>
>   config FSL_MC_BUS
>         bool "QorIQ DPAA2 fsl-mc bus driver"
> -       depends on OF && ARCH_LAYERSCAPE
> +       depends on OF && (ARCH_LAYERSCAPE || COMPILE_TEST)
>         select GENERIC_MSI_IRQ_DOMAIN
> ?
>
> The other drivers that depend on the MC_BUS won't compile on other
> architectures.

I was thinking of adding it to all three, but you are right we only needed
it for the bus.

        Arnd
