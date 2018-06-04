From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Jun 2018 11:45:41 +0100
Subject: [PATCH] ASoC: dapm: delete dapm_kcontrol_data paths entry before
 freeing
In-Reply-To: <20180601225334.19064-1-srinivas.kandagatla@linaro.org>
References: <20180601225334.19064-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180604104541.GB7536@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 11:53:34PM +0100, Srinivas Kandagatla wrote:

> Below is the kernel BUG with SLAB Poisoning

> =============================================================================
> BUG kmalloc-128 (Tainted: G        W        ): Poison overwritten
> -----------------------------------------------------------------------------
> 
> Disabling lock debugging due to kernel taint
> INFO: 0xffff80003cf1c310-0xffff80003cf1c31f. First byte 0x10 instead of 0x6b
> INFO: Allocated in dapm_kcontrol_data_alloc.isra.37+0x34/0x2a8 age=6929 cpu=0 pid=50
>  __slab_alloc.isra.24+0x24/0x38
>  kmem_cache_alloc+0x190/0x1d8

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180604/2726e3d4/attachment.sig>
