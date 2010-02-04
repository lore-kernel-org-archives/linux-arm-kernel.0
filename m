From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Feb 2010 19:14:02 +0000
Subject: [RFC PATCH 1/3] [ARM] allow NR_IRQS to be larger than 256
In-Reply-To: <f17812d71002041109u3d7ea08ej201708fa462e087d@mail.gmail.com>
References: <f17812d71002041109u3d7ea08ej201708fa462e087d@mail.gmail.com>
Message-ID: <20100204191402.GE27344@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2010 at 11:09:22AM -0800, Eric Miao wrote:
> commit fc14e7ca387688ca63eafa16d4aa3012898d096d
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:   Mon Dec 28 11:05:55 2009 +0800
> 
>     [ARM] allow NR_IRQS to be larger than 256

Don't you mean 512 ?

> -#if NR_IRQS > 256
> +#if NR_IRQS > 512
> +#define HARDIRQ_BITS	10
> +#elif NR_IRQS > 256
>  #define HARDIRQ_BITS	9
