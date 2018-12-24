Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D269C64E79
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:24:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0D42184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KylmLD2l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TATbDOi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0D42184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5CjLaUBkt3gVpf3vppfAAHshFSYTbXulbUTNWIIgXMQ=; b=KylmLD2lu06/vQ
	7z+LZAA5l9nzPXd5M8YUyvVmdHXnO1NwFuwZV4QZdhxKy07cPpQ+CenPw4752bf8ir+Cj2xbaK1Ep
	IgUwi/bt+VI/7ej6lDLsA41N7TtC/F0qURBkXxnxvbi7smdvciContRZt85xvS/ziMLv7b82ChyPi
	Zi0Jxc/+iyHskmHu/1e+G+qcoy+x6ddH65+AwJDQtlN06rcinFtaoyeP3O15auzQxoAnYtvI0lOwL
	Quq6P1Cd/4KXUJfnHZbh9t2jMdsYRP1NzrgDSU/83pg920oCy5U8nvovc41mFC8ufXZh0o9cqDLEZ
	JqCA0gIQ1E46oIR29KRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbS5t-000220-BR; Mon, 24 Dec 2018 15:24:37 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbS5p-0001ss-H0; Mon, 24 Dec 2018 15:24:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MnCBPLk/TWveJ/PPLBS7RWz+axnrCYxLUyWpWEjxPy4=; b=TATbDOi3szvOxUTavPt0X/r70
 vsZj5TZTSx89zhAQEl7pS0fasAu9W4Uive0aLhYKym8rlMr0h3b5qwCBM6UIqLJdkpMS98GpUMDFU
 bc0TulCo/Wa0vECNHHWmPTUklO2uv6AO21/tGIxV+oMKw13XOlxLGMTtHjIrkIyQj253g=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:44267)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gbS2Y-0007zj-3i; Mon, 24 Dec 2018 15:21:10 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gbS2Q-00077T-Hm; Mon, 24 Dec 2018 15:21:02 +0000
Date: Mon, 24 Dec 2018 15:20:59 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH v5 0/9] Use vm_insert_range
Message-ID: <20181224152059.GA26090@n2100.armlinux.org.uk>
References: <20181224131841.GA22017@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181224131841.GA22017@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_072433_563341_F3E15171 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: mhocko@suse.com, heiko@sntech.de, peterz@infradead.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux1394-devel@lists.sourceforge.net,
 m.szyprowski@samsung.com, sfr@canb.auug.org.au,
 oleksandr_andrushchenko@epam.com, joro@8bytes.org,
 iommu@lists.linux-foundation.org, willy@infradead.org, airlied@linux.ie,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 treding@nvidia.com, linux-media@vger.kernel.org, keescook@chromium.org,
 pawel@osciak.com, riel@surriel.com, rppt@linux.vnet.ibm.com,
 boris.ostrovsky@oracle.com, mchehab@kernel.org, iamjoonsoo.kim@lge.com,
 vbabka@suse.cz, jgross@suse.com, hjc@rock-chips.com, xen-devel@lists.xen.org,
 kyungmin.park@samsung.com, stefanr@s5r6.in-berlin.de,
 akpm@linux-foundation.org, robin.murphy@arm.com,
 kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Having discussed with Matthew offlist, I think we've come to the
following conclusion - there's a number of drivers that buggily
ignore vm_pgoff.

So, what I proposed is:

static int __vm_insert_range(struct vm_struct *vma, struct page *pages,
			     size_t num, unsigned long offset)
{
	unsigned long count = vma_pages(vma);
	unsigned long uaddr = vma->vm_start;
	int ret;

	/* Fail if the user requested offset is beyond the end of the object */
	if (offset > num)
		return -ENXIO;

	/* Fail if the user requested size exceeds available object size */
	if (count > num - offset)
		return -ENXIO;

	/* Never exceed the number of pages that the user requested */
	for (i = 0; i < count; i++) {
		ret = vm_insert_page(vma, uaddr, pages[offset + i]);
		if (ret < 0)
			return ret;
		uaddr += PAGE_SIZE;
	}

	return 0;
}

/*
 * Maps an object consisting of `num' `pages', catering for the user's
 * requested vm_pgoff
 */
int vm_insert_range(struct vm_struct *vma, struct page *pages, size_t num)
{
	return __vm_insert_range(vma, pages, num, vma->vm_pgoff);
}

/*
 * Maps a set of pages, always starting at page[0]
 */
int vm_insert_range_buggy(struct vm_struct *vma, struct page *pages, size_t num)
{
	return __vm_insert_range(vma, pages, num, 0);
}

With this, drivers such as iommu/dma-iommu.c can be converted thusly:

 int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma+)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	int ret = -ENXIO;
-
-	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
-		ret = vm_insert_page(vma, uaddr, pages[i]);
-		if (ret)
-			break;
-		uaddr += PAGE_SIZE;
-	}
-	return ret;
+	return vm_insert_range(vma, pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
}

and drivers such as firewire/core-iso.c:

 int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
 			  struct vm_area_struct *vma)
 {
-	unsigned long uaddr;
-	int i, err;
-
-	uaddr = vma->vm_start;
-	for (i = 0; i < buffer->page_count; i++) {
-		err = vm_insert_page(vma, uaddr, buffer->pages[i]);
-		if (err)
-			return err;
-
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_insert_range_buggy(vma, buffer->pages, buffer->page_count);
}

and this gives us something to grep for to find these buggy drivers.

Now, this may not look exactly equivalent, but if you look at
fw_device_op_mmap(), buffer->page_count is basically vma_pages(vma)
at this point, which means this should be equivalent.

We _could_ then at a later date "fix" these drivers to behave according
to the normal vm_pgoff offsetting simply by removing the _buggy suffix
on the function name... and if that causes regressions, it gives us an
easy way to revert (as long as vm_insert_range_buggy() remains
available.)

In the case of firewire/core-iso.c, it currently ignores the mmap offset
entirely, so making the above suggested change would be tantamount to
causing it to return -ENXIO for any non-zero mmap offset.

IMHO, this approach is way simpler, and easier to get it correct at
each call site, rather than the current approach which seems to be
error-prone.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
