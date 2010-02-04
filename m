From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu, 04 Feb 2010 20:29:52 +0100
Subject: [RFC PATCH 1/3] [ARM] allow NR_IRQS to be larger than 256
In-Reply-To: <f17812d71002041109u3d7ea08ej201708fa462e087d@mail.gmail.com>
References: <f17812d71002041109u3d7ea08ej201708fa462e087d@mail.gmail.com>
Message-ID: <4B6B2030.3040306@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> -#if NR_IRQS > 256
> +#if NR_IRQS > 512
> +#define HARDIRQ_BITS	10
> +#elif NR_IRQS > 256
>  #define HARDIRQ_BITS	9
>  #else
>  #define HARDIRQ_BITS	8

Would not it be possible to use

#define HARDIRQ_BITS order_base_2(NR_IRQS)

to remove any limitation?

-- 
					    Gilles.
