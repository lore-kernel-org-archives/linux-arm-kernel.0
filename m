From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Apr 2011 15:49:47 +0300
Subject: [PATCH 2/3] ARM: compressed/misc.c: simplify decompress_kernel()
In-Reply-To: <1303272904-31392-3-git-send-email-nicolas.pitre@linaro.org>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-3-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110421124947.GC15060@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110420 07:12]:
> The return value for decompress_kernel() is no longer used.  Furthermore,
> this was obtained and stored in a variable called output_ptr which is
> a complete misnomer for what is actually the size of the decompressed
> kernel image.  Let's get rid of it.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Works for me:

Tested-by: Tony Lindgren <tony@atomide.com>

> BTW, I've yet to understand why, but this patch makes CONFIG_KERNEL_LZMA
> work for me.

Maybe the compressed image size changes slightly so the compressed
image end no longer goes past the uncompressed kernel end and relocate
works properly? Maybe see if the patch I posted solves your LZMA
issue even without this patch?

Tony
