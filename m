Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA996C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:58:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990472184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XvhX0IyR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MFKQYu7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990472184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1W7r/BSWuygH2iRjZS+jvRd81hgjwp6r2M6mLZLLA+M=; b=XvhX0IyRTiml9u
	oy/+mqaRHxzCQdw16Cy6ITIjGcXu78SbkGiIeNHZs4m9AULT+etsytXyJLIwBPr/scBw2iVP9ma4O
	7wha2QxtOPHctEL5gdgq6F9Y4NRABFHadIdnn+h1k+3GhKlaygY8lePHB0wdNiovKPQK+NjC4J3W7
	sQvqzP+eCqa6C/LMsFbYArcZx43KJUX2xzGrRJ20LVe3gxX1+7Tg8+zb0IINislUyzHxoUeA/FYXR
	4iPA1HdqpJeZcifLZmdvc7DuIYqldg+Keoo0BUaJttONbMeQidoPlllHYmAgrmOAxtgmeNlmFbads
	5gdW4MW7ZwnVQI5W6IAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZC8g-0005aI-A9; Tue, 18 Dec 2018 09:58:10 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZC8a-0005XH-J4; Tue, 18 Dec 2018 09:58:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iHiwr/FMFw5Dm9zasFmVTSZRnXhmdru9eEi/AXWWkTY=; b=MFKQYu7lJ/BehPNauB8d8s6A0
 BkI+YWIQjK+zik026CH/G8bw3sROaM0SZtvrln7+qazrQ/TU1xPwwyq9XjGeHgqO/6zWEiWwV7Qms
 ljKjzrjnOZAOZclTfZIW3kQT9AMvvtSRgSc12Gld5qPmGmqC99mM3ipsdpMj3WbX0vEXw=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:55758)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gZC7t-0005RJ-53; Tue, 18 Dec 2018 09:57:21 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gZC7l-0005fh-Dp; Tue, 18 Dec 2018 09:57:13 +0000
Date: Tue, 18 Dec 2018 09:57:09 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181218095709.GJ26090@n2100.armlinux.org.uk>
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_015804_624357_EF1F500D 
X-CRM114-Status: GOOD (  24.27  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mhocko@suse.com, heiko@sntech.de, linux-rockchip@lists.infradead.org,
 airlied@linux.ie, hjc@rock-chips.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, akpm@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 01:53:34AM +0530, Souptick Joarder wrote:
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index a8db758..8279084 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -221,26 +221,11 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
>  					      struct vm_area_struct *vma)
>  {
>  	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
> -	unsigned int i, count = obj->size >> PAGE_SHIFT;
>  	unsigned long user_count = vma_pages(vma);
> -	unsigned long uaddr = vma->vm_start;
>  	unsigned long offset = vma->vm_pgoff;
> -	unsigned long end = user_count + offset;
> -	int ret;
> -
> -	if (user_count == 0)
> -		return -ENXIO;
> -	if (end > count)
> -		return -ENXIO;
>  
> -	for (i = offset; i < end; i++) {
> -		ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
> -		if (ret)
> -			return ret;
> -		uaddr += PAGE_SIZE;
> -	}
> -
> -	return 0;
> +	return vm_insert_range(vma, vma->vm_start, rk_obj->pages + offset,
> +				user_count - offset);

This looks like a change in behaviour.

If user_count is zero, and offset is zero, then we pass into
vm_insert_range() a page_count of zero, and vm_insert_range() does
nothing and returns zero.

However, as we can see from the above code, the original behaviour
was to return -ENXIO in that case.

The other thing that I'm wondering is that if (eg) count is 8 (the
object is 8 pages), offset is 2, and the user requests mapping 6
pages (user_count = 6), then we call vm_insert_range() with a
pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
end up inserting four pages.

The original code would calculate end = 6 + 2 = 8.  i would iterate
from 2 through 8, inserting six pages.

(I hadn't spotted that second issue until I'd gone through the
calculations manually - which is worrying.)

I don't have patches 5 through 9 to look at, but I'm concerned that
similar issues also exist in those patches.

I'm concerned that this series seems to be introducing subtle bugs,
it seems to be unnecessarily difficult to use this function correctly.
I think your existing proposal for vm_insert_range() provides an
interface that is way too easy to get wrong, and, therefore, is the
wrong interface.

I think it would be way better to have vm_insert_range() take the
object page array without any offset adjustment, and the object
page_count again without any adjustment, and have vm_insert_range()
itself handle the offsetting and VMA size validation.  That would
then give a simple interface and probably give a further reduction
in code at each call site.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
