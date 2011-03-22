From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 22 Mar 2011 19:58:57 +0530
Subject: [PATCH v17 12/13] davinci: dm644x: add support for v4l2 video
	display
In-Reply-To: <1300197580-5029-1-git-send-email-manjunath.hadli@ti.com>
References: <1300197580-5029-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C47D8A2@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2011 at 19:29:40, Hadli, Manjunath wrote:
> Create platform devices for various video modules like venc,osd,
> vpbe and v4l2 driver for dm644x.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> ---

> +struct venc_platform_data dm644x_venc_pdata = {
> +	.venc_type	= VPBE_VERSION_1,
> +	.setup_clock	= dm644x_venc_setup_clock,
> +};

Sparse pointed out that this symbol can
be static.

Can you please build the complete series with
C=1 on the command line? This will enable
sparse check on all files being re-compiled.

I also noticed some sparse warnings on vpbe_venc.c

Also, please build with CONFIG_DEBUG_SECTION_MISMATCH=y
on the command line. I noticed some section
mismatches as well with the new code.

Thanks,
Sekhar
