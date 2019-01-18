Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4FAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:41:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E822086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yndeounp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z2KUeKQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E822086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+h728ee8aVqYS+qyDuBdWvNI1o+rhjk4Xu//vl1sO8A=; b=Yndeounp8Pdjnj
	pWTCUjLB6YdmvkJHCdbapY6vF3oNhHg6uQrzNOToaXo9VTWFKIBunlFRUKBGxeToXQJzCCVgaeo1h
	zeLnSrG4u5w/rqRMyi15e0Af907Cxo7Fj14uN4PQmCLzq/Nivbfneo/+IBCjjkACH/30SqifxSSbK
	DiJB3G5NxRF9b3lSty7DfGGuCUwBbSH9x+8Qs4NPBniBilZmFEnILfDYQf+yRym0gE9iu9MRNUzzr
	LszU9UR0jFyuW91hFgAjwcBxnfV89ORVAC8FTcrZ8HSa+cYPf+V/RFaFY6nSsDJgufz7z7wE4OAk+
	0/5vcqYBT646wMY9e3Rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkQeP-0003Jm-RV; Fri, 18 Jan 2019 09:41:21 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkQeL-0003If-8S
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 09:41:19 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190118094109euoutp0115bbde57a59117f869199917aa1f9843~65-b68APB0046200462euoutp01G
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:41:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190118094109euoutp0115bbde57a59117f869199917aa1f9843~65-b68APB0046200462euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1547804469;
 bh=RGXq9RGEUurKx6PSdc+PYxtxsJ/5Q+IzJ0gAyNc2HLA=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=Z2KUeKQGapvqQ9Jgr84NjSns7SXRu/51seXMQd140hPdy0V3U7jAXjRyqaU/6bkWt
 0mneQ9zwhIqYCOic7AmO6Ey96sHoB0knm/Ex/djkouwdAjB5/XrQIt7xb4qj7jDmAV
 vTthYxsSqltb03VdQzWo811uFN9gv5Cu4MOyNUS4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190118094109eucas1p1ab05532f8165610dc474362bdee7bbd6~65-blkck73063730637eucas1p10;
 Fri, 18 Jan 2019 09:41:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id EE.48.04294.53F914C5; Fri, 18
 Jan 2019 09:41:09 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190118094108eucas1p183dbb93b33e288b5b6043f4f5bd4bdcb~65-aoCgiY2366223662eucas1p1V;
 Fri, 18 Jan 2019 09:41:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190118094108eusmtrp2b5babbdfd476b5ba54a20f3cc44585d3~65-aX1NnO3211632116eusmtrp29;
 Fri, 18 Jan 2019 09:41:08 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-bc-5c419f35d876
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 84.C9.04128.43F914C5; Fri, 18
 Jan 2019 09:41:08 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190118094107eusmtip2a3234dfbecca364b28e7d316014cb1d2~65-ZyivDv2009320093eusmtip2h;
 Fri, 18 Jan 2019 09:41:07 +0000 (GMT)
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
To: Christoph Hellwig <hch@lst.de>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <f4222474-0515-c0a2-ef5e-523b56869210@samsung.com>
Date: Fri, 18 Jan 2019 10:41:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117172152.GA32292@lst.de>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzHfe+5e+5xOT0O+YymdVtZEmm1nkaGWT1bs/qnraLVxTPk5+5B
 ZNWtVmGGoeJx+bWWXyt1IV0ro+UyHeqWrpI0PyMpFCdTnj2U/16fz/v9+bV9CEzxWuJMRMUl
 Muo4VYwSl4kb2yyd23aVBoRu17xdS1XXPhdRZc0+lPHiVymlG+iRUCa9Fqey7jVIqNZrTxD1
 e3ZRQt3WLYioj+0eVMGEReq/hjb1vMJoXU0GTj+4dYHON1ciuquwHNGP32lwemD+C06PmGZx
 Oru+BtHTOtdDsmMy33AmJiqZUXv5nZRFfr5jFCfkO6aUaAwiDSq1y0TWBJA74eZ8L8pEMkJB
 ViEwT2WJeEFBziDI4ShBmEbQq+kRrVQ8KcyQCkIlgvKGPlwIJhFwMwtLLoKwJ4/Az+H9fIED
 qYShMSPiGSOLMCi4k8AzTnpD5kQmzrOc9IO2648xnsXkJhgf6hDzbRzJULhskgkWO2gvGhTz
 bE16wF1t13LLDfBwQosJ7ATvB0uX97RIwdJyQOAgMPV2SgW2hzFD/TKvhz+PeL9siS8huFrI
 SYUgC0GDtgkXXD7wzPBKwi+EkVugTu8lpANgNLsS49NA2oJ5wk7YwRbyGm8sp+WQfkUhuDcD
 Z7j7b2xL92ssFym5VZdxq67hVl3D/Z9bhsQ1yIlJYmMjGHZHHHPGk1XFsklxEZ5h8bE6tPRp
 HYuGmSakXzjVikgCKW3kufX+oQqJKplNjW1FQGBKB7mOCwhVyMNVqWcZdfwJdVIMw7YiF0Ks
 dJKnWfWHKMgIVSITzTAJjHpFFRHWzhq0T/VW7TvXnO3W31+xxwZGo4u3O1qZw+6ftkqZcTCe
 X+j/JTcHzR2tG2wKCIzMOUe/OR741L3zpetA1Yu9G8fZ6FLjsPJgoqvzbnrMog1JG7P3d+rE
 pr9XoKyBWrm+3qWvumgr6i6RTI0U/viQHTyp/5aXvq55PqQs2ORWfPhThlLMRqq83TE1q/oL
 ED7+omUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xe7om8x1jDG7s57FYufook8WC/dYW
 Z5vesFtsenyN1eLyrjlsFj0btrJaHJq6l9Hi9/d/rBbLNv1hsrh7Usdiytuf7A7cHpevXWT2
 2LSqk81j85J6j8k3ljN6nJ+xkNFj980GNo/Hv16yeTy//J3No2/LKkaPz5vkArii9GyK8ktL
 UhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIerj3LUjBZtGJe
 w3GmBsb5gl2MnBwSAiYSe2d0sncxcnEICSxllNhwfy8bREJG4uS0BlYIW1jiz7UuNoiit4wS
 M479Zexi5OAQFoiQ+PrMHaRGREBJ4umrs4wgNcwCs5klTlxaxgLR0MAk0b11IdhUNgFDia63
 XWA2r4CdxLFpu5lBbBYBVYnXT0+zgNiiAjESs570sUPUCEqcnPkELM4poCOxbs55RhCbWUBd
 4s+8S8wQtrzE9rdzoGxxiVtP5jNNYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgx
 t7g0L10vOT93EyMwlrcd+7llB2PXu+BDjAIcjEo8vC+2OcQIsSaWFVfmHmKU4GBWEuHdNMsx
 Rog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgWkmryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQ
 QHpiSWp2ampBahFMHxMHp1QDo79ZQMaWg9fsDh/uELo99UJayu6vFuft7j9+eX9LUlvX7dUc
 q3cmnmzb//fh7eNOnnZOsmv06rYH7RVQupfie23Gl4cL1hRceXB3tyDD4doLYrc4XGJN2Gcv
 tlgV7p+5/KC7maqm6+rJiwVeveP73qMzcZKStFZbSLriAnX+Wyw6gW+bDyje1VNiKc5INNRi
 LipOBADq0Yzi+wIAAA==
X-CMS-MailID: 20190118094108eucas1p183dbb93b33e288b5b6043f4f5bd4bdcb
X-Msg-Generator: CA
X-RootMTR: 20190111181812epcas2p1eeb68a16701631513eaf297073f7299f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190111181812epcas2p1eeb68a16701631513eaf297073f7299f
References: <20190111181731.11782-1-hch@lst.de>
 <CGME20190111181812epcas2p1eeb68a16701631513eaf297073f7299f@epcas2p1.samsung.com>
 <20190111181731.11782-4-hch@lst.de>
 <6f8892ac-c2aa-10df-c74f-ba032bf75160@samsung.com>
 <20190117172152.GA32292@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_014117_435672_CDA5DA74 
X-CRM114-Status: GOOD (  22.02  )
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
Cc: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Pawel Osciak <pawel@osciak.com>, linux-kernel@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Russell King <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Christoph,

On 2019-01-17 18:21, Christoph Hellwig wrote:
> On Mon, Jan 14, 2019 at 01:42:26PM +0100, Marek Szyprowski wrote:
>> On 2019-01-11 19:17, Christoph Hellwig wrote:
>>> vb2_dc_get_userptr pokes into arm direct mapping details to get the
>>> resemblance of a dma address for a a physical address that does is
>>> not backed by a page struct.  Not only is this not portable to other
>>> architectures with dma direct mapping offsets, but also not to uses
>>> of IOMMUs of any kind.  Switch to the proper dma_map_resource /
>>> dma_unmap_resource interface instead.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> There are checks for IOMMU presence in other places in vb2-dma-contig,
>> so it was used only when no IOMMU is available, but I agree that the
>> hacky code should be replaced by a generic code if possible.
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> V4L2 pipeline works fine on older Exynos-based boards with CMA and IOMMU
>> disabled.
> Do you know if these rely on the offsets?  E.g. would they still work
> with the patch below applied on top.  That would keep the map_resource
> semantics as-is as solve the issue pointed out by Robin for now.

AFAIK that code was only used for sharing buffers between hardware
modules that are a part of the same SoC, usually implemented as platform
devices. AFAIR this never worked for devices on different buses. So far
I wasn't aware on ANY which would require an offset for the DMA access.

The first version of videobuf2-dc code even incorrectly used paddr
instead of dma_addr as a buffer 'address' returned to the client
drivers, because in case of those SoC this was exactly the same (see
commits 472af2b05bdefcaee7e754e22cbf131110017ad6 and
ba7fcb0c954921534707f08ebc4d8beeb2eb17e7).

> If not I can only think of a flag to bypass the offseting for now, but
> that would be pretty ugly.  Or go for the long-term solution of
> discovering the relationship between the two devices, as done by the
> PCIe P2P code..
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 8e0359b04957..25bd19974223 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -359,7 +359,7 @@ EXPORT_SYMBOL(dma_direct_map_sg);
>  dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> -	dma_addr_t dma_addr = phys_to_dma(dev, paddr);
> +	dma_addr_t dma_addr = paddr;
>  
>  	if (unlikely(!dma_direct_possible(dev, dma_addr, size))) {
>  		report_addr(dev, dma_addr, size);
>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
