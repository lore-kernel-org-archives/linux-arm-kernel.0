From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Feb 2011 16:38:52 +0000
Subject: [PATCH] ARM: errata: pl310 cache sync operation may be faulty
In-Reply-To: <1297768683-30273-1-git-send-email-srinidhi.kasagar@stericsson.com>
References: <1297768683-30273-1-git-send-email-srinidhi.kasagar@stericsson.com>
Message-ID: <AANLkTikPGwcm-_j-NzW2UixaEx_ekJMjJcrTO1SUy7Ao@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 February 2011 11:18, srinidhi kasagar
<srinidhi.kasagar@stericsson.com> wrote:
> +config ARM_ERRATA_753970
> + ? ? ? bool "ARM errata: cache sync operation may be faulty"
> + ? ? ? depends on CACHE_PL310
> + ? ? ? help
> + ? ? ? ? This option enables the workaround for the 753970 PL310 erratum.

Is this number correct? I couldn't find it in ARM's internal database.

> + ? ? ? ? Under some condition the effect of cache sync operation on
> + ? ? ? ? the store buffer still remains when the operation completes.
> + ? ? ? ? This means that the store buffer is always asked to drain and
> + ? ? ? ? this prevents it from merging any further writes. The workaround
> + ? ? ? ? is to replace the normal offset of cache sync operation (0x730)
> + ? ? ? ? by another offset targeting an unmapped PL310 register 0x740.
> + ? ? ? ? This has the same effect as the cache sync operation: store buffer
> + ? ? ? ? drain and waiting for all buffers empty.

You may want to specify the revision number this applies to so that
people to enable it if not needed.

-- 
Catalin
