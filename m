From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 1 Aug 2016 14:24:24 +0200
Subject: [PATCH] arm64: fix address fault during mapping fdt region
In-Reply-To: <579F197B.80101@zoho.com>
References: <579F197B.80101@zoho.com>
Message-ID: <20160801122424.GA18162@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2016 at 05:42:19PM +0800, zijun_hu wrote:
> >From 07b9216ec3494515e7a6c41e0333eb8782427db3 Mon Sep 17 00:00:00 2001
> From: zijun_hu <zijun_hu@htc.com>
> Date: Mon, 1 Aug 2016 17:04:59 +0800
> Subject: [PATCH] arm64: fix address fault during mapping fdt region
> 
> fdt_check_header() accesses other fileds of fdt header but
> the first 8 bytes such as version; so accessing unmapped
> address fault happens if fdt region locates below align
> boundary nearly during mapping fdt region, or expressed as
> (offset + sizeof(struct fdt_header)) > SWAPPER_BLOCK_SIZE
> 
> fdt header size at least is mapped in order to avoid the issue
> 
> Signed-off-by: zijun_hu <zijun_hu@htc.com>
> ---
>  arch/arm64/mm/mmu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
