From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:44:15 -0800
Subject: [PATCH] ARM: EXYNOS: enable 4 cores secondary cpu up for
 exynos5440
In-Reply-To: <CAOesGMjCzs6Uh8EEbrNcknGUezyVdbYBJ1M-vXgMYt1jxRPUKQ@mail.gmail.com>
References: <1356980980-3387-1-git-send-email-kgene.kim@samsung.com>
 <CAOesGMjCzs6Uh8EEbrNcknGUezyVdbYBJ1M-vXgMYt1jxRPUKQ@mail.gmail.com>
Message-ID: <042701cde93a$b2671f10$17355d30$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> Hi,
> 
Hi,

[...]

> It seems better to create a helper function here instead and calling
> that, instead of switching to a conditional open-coded block to this
> function.
>
Yes, sounds good. I will.

> > @@ -178,6 +183,8 @@ static void __init exynos_smp_init_cpus(void)
> >
> >         if (soc_is_exynos5250())
> >                 ncores = 2;
> > +       else if (soc_is_exynos5440())
> > +               ncores = 4;
> 
> In the future it would make sense to get the core count from the
> device tree instead.
> 
Agreed.

Thanks.

- Kukjin
