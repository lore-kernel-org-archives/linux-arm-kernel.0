From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2011 09:53:36 +0100
Subject: [PATCH 2/3] ARM: compressed/misc.c: simplify decompress_kernel()
In-Reply-To: <1303272904-31392-3-git-send-email-nicolas.pitre@linaro.org>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-3-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110427085336.GL17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 12:15:03AM -0400, Nicolas Pitre wrote:
> The return value for decompress_kernel() is no longer used.  Furthermore,
> this was obtained and stored in a variable called output_ptr which is
> a complete misnomer for what is actually the size of the decompressed
> kernel image.  Let's get rid of it.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
> 
> BTW, I've yet to understand why, but this patch makes CONFIG_KERNEL_LZMA
> work for me.

Hmm.  I've switched almost entirely to LZMA since it was introduced and it
works for me on all my platforms.  I haven't tested kernels rigorously since
your patches to the decompressor, so maybe there's a regression in there
somewhere.

Can you try LZMA with your various patches over the last four months
reverted?
