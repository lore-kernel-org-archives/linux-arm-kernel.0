From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Jul 2016 20:43:49 -0300
Subject: bug in error message
In-Reply-To: <CAJz5OpfCWc2=kD8bwthizCEMau2DjMScoNkCER_FGFQkADbhrA@mail.gmail.com>
References: <CAJz5OpfCWc2=kD8bwthizCEMau2DjMScoNkCER_FGFQkADbhrA@mail.gmail.com>
Message-ID: <CAOMZO5CtvFGUK04jP4=Gnar8x9RShiu=9LFDfFt46JRG53PV6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2016 at 6:51 PM, Frank Mori Hess <fmh6jj@gmail.com> wrote:
> There is a bug in arch/arm/mm/dma-mapping.c where it prints a number
> in an error message in hex when it should be decimal:
>
> pr_err("DMA: failed to allocate %zx KiB pool for atomic coherent allocation\n",
>         atomic_pool_size / 1024);
>
> patch (literally one character) here:
>
> https://github.com/fmhess/linux/commit/dce53a26afe31c63b88bc5b5c75b41ec86579291

Your proposed fix is not correct. You should use %zu instead.

Thanks for reporting it anyway. Will submit a patch.
