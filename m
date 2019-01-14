Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B07DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:28:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E2C20659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FmqsLJ5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E2C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y8DA3Chq+WQq1LqckT1459/k/dUTqafkpcAOKC1zo9g=; b=FmqsLJ5NX26zb2
	MVLY1LfJpl2znvix4010/Vo1vLKAYTK4aLGICk7wDOVZU/HlQtdXqRK5Y8aiAdoRCc0A6vk2gAyGt
	ik1sezgsZ2WioPa9nHdo3eThpRHmuC3v7azqa7VTlsCIXFP6dcVEJxSxX89x3pFhOjpihGsDiNQ3V
	7+vJsSaMn0prEEQOKYpNFg8zItQ8MLwmj5w+yYcFEgjmF4Tmam/7yi9QSdIjneBaJ/F00ZylJqQd6
	UNwU9AooaNvaj0VOgpNFw7JSL7+ywZHS+N7EDkBWKw8ELdfGHOW05BOk24Bs0QPuJeu0/6IVq53Aj
	M80bBrRcokGA/D2woQGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj8qc-0005oK-Na; Mon, 14 Jan 2019 20:28:38 +0000
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj8qZ-0005nX-6I
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 20:28:37 +0000
Received: from [192.168.0.100] (pC19F5E95.dip0.t-ipconnect.de [193.159.94.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by smtp.math.uni-bielefeld.de (Postfix) with ESMTPSA id 727AE60004;
 Mon, 14 Jan 2019 21:20:05 +0100 (CET)
Subject: Re: [PATCH] Revert "ARM: dma-mapping: Set proper DMA ops in
 arm_iommu_detach_device()"
To: Robin Murphy <robin.murphy@arm.com>, Thierry Reding <treding@nvidia.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
 <20190114132240.12125-1-m.szyprowski@samsung.com>
 <20190114160902.GB9218@ulmo> <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tjakobi@math.uni-bielefeld.de; prefer-encrypt=mutual; keydata=
 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
 24xKzP1yWf7TCvc+DT6gUl4T65RXUQyTeJ0=
Message-ID: <ffad41c0-f314-e404-5bb0-a39d01b69478@math.uni-bielefeld.de>
Date: Mon, 14 Jan 2019 21:20:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.9.1
MIME-Version: 1.0
In-Reply-To: <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_122835_539019_8E54170D 
X-CRM114-Status: GOOD (  16.72  )
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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ben Skeggs <bskeggs@redhat.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello everyone,

first of all thanks to Marek for looking into this.

@Robin: This works for me. The drivers now probe and bind correctly again.

With best wishes,
Tobias

Robin Murphy wrote:
> On 14/01/2019 16:09, Thierry Reding wrote:
>> On Mon, Jan 14, 2019 at 02:22:40PM +0100, Marek Szyprowski wrote:
>>> This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.
>>>
>>> That patch broke IOMMU support for devices, which fails to probe for the
>>> first time and use deferred probe approach. When non-NULL dma_ops is set
>>> in arm_iommu_detach_device(), the given device later ignored by
>>> arch_setup_dma_ops() and stays with non-IOMMU dma_ops.
>>>
>>> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in
>>> arm_iommu_detach_device()"
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>> =A0 arch/arm/mm/dma-mapping.c | 12 ++++++------
>>> =A0 1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> Can you point out exactly what drivers break because of this change? We
>> need to find a solution that works for everyone. Reverting is only
>> marginally useful because somebody will just end up wanting to revert
>> the revert because a different driver is now broken.
> =

> At first glance, it sounds like what we really want is for
> arch_teardown_iommu_ops() to completely clear any ops that arch_setup_dma=
_ops()
> installed - does the below suffice?
> =

> Robin.
> =

> ----->8-----
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f1e2922e447c..1e3e08a1c456 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2390,4 +2390,6 @@ void arch_teardown_dma_ops(struct device *dev)
> =A0=A0=A0=A0=A0=A0=A0=A0 return;
> =

> =A0=A0=A0=A0 arm_teardown_iommu_dma_ops(dev);
> +=A0=A0=A0 /* Let arch_setup_dma_ops() start again from scratch upon re-p=
robe */
> +=A0=A0=A0 set_dma_ops(dev, NULL);
> =A0}


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
