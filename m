From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 8 Feb 2016 10:30:06 -0800
Subject: [RESEND2 PATCH 1/3] memremap: add MEMREMAP_WC flag
In-Reply-To: <9085d37fa97a762a46b9d58719c085368682c64f.1454950917.git.brian.starkey@arm.com>
References: <cover.1454950917.git.brian.starkey@arm.com>
 <9085d37fa97a762a46b9d58719c085368682c64f.1454950917.git.brian.starkey@arm.com>
Message-ID: <20160208183006.GA8429@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 05:30:50PM +0000, Brian Starkey wrote:
> Add a flag to memremap() for writecombine mappings. Mappings satisfied
> by this flag will not be cached, however writes may be delayed or
> combined into more efficient bursts. This is most suitable for
> buffers written sequentially by the CPU for use by other DMA devices.
> 
> Signed-off-by: Brian Starkey <brian.starkey@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  include/linux/io.h |    1 +
>  kernel/memremap.c  |   15 +++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/io.h b/include/linux/io.h
> index 32403b5..e2c8419 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -135,6 +135,7 @@ enum {
>  	/* See memremap() kernel-doc for usage description... */
>  	MEMREMAP_WB = 1 << 0,
>  	MEMREMAP_WT = 1 << 1,
> +	MEMREMAP_WC = 1 << 2,

You didn't update the documentation :(
