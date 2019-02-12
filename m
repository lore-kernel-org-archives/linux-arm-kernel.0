Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2DEC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:15:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9BF222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q4gjnkul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9BF222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bioOEObP4KjL9vJ/MsccizSTXtPZ6hIy44OPurLDu+Q=; b=q4gjnkulaGYyibWjvpEuZcGSi
	fB5FwkSUAkK/MvqpxGoP2BfLPJIWGXm6b+tuLWQ2LgokMd7/fPSdxuzKuk0Q8c/P6aUJ56UHsV1dO
	WJvpV82+rPoRx06wMIrzwtAbj8fBT8eJUAqUhesnM+iQrz0YwdzYahKyENStO0wTmwyEx2yLti5xy
	EeFDtkq2Gf57l9RaIy6kQ4f44NpcKkKqkWCGJV2dWPoKQmIqr6RsJGedRUPChkf6zxKbIdTDa8FLm
	n3dq7UHoZ4C1oSKpx3uVP7AOoyCgBeJZS5HGAWkLPhY53moD85V2mzy9lJwMvbJx1X8KjxN/AzF2f
	QPRYwT0cA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtcaZ-0000wB-D1; Tue, 12 Feb 2019 18:15:23 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtcaU-0000vk-Ow
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 18:15:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 672EBA78;
 Tue, 12 Feb 2019 10:15:17 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FE8A3F575;
 Tue, 12 Feb 2019 10:15:14 -0800 (PST)
Subject: Re: [PATCH v3 4/7] of: address: Add support for the parent DMA bus
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Chen-Yu Tsai <wens@csie.org>
References: <cover.f2e5fbb4d21384168973fa32377a33d627768146.1549897336.git-series.maxime.ripard@bootlin.com>
 <fc76568f10be15b0dfc7515d6affecb20de3e479.1549897336.git-series.maxime.ripard@bootlin.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <25d076ef-60a9-b424-878b-d8066e907b35@arm.com>
Date: Tue, 12 Feb 2019 18:15:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fc76568f10be15b0dfc7515d6affecb20de3e479.1549897336.git-series.maxime.ripard@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_101519_552020_0A4770A8 
X-CRM114-Status: GOOD (  25.58  )
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
Cc: devicetree@vger.kernel.org, Yong Deng <yong.deng@magewell.com>,
 Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
 Dave Martin <dave.martin@arm.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Georgi Djakov <georgi.djakov@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/02/2019 15:02, Maxime Ripard wrote:
> Some SoCs have devices that are using a separate bus from the main bus to
> perform DMA.
> 
> These buses might have some restrictions and/or different mapping than from
> the CPU side, so we'd need to express those using the usual dma-ranges, but
> using a different DT node than the node's parent.
> 
> Now that the generic interconnect bindings are available, we can model an
> interconnect with the reserved name "dma" for those use-cases.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>   drivers/of/address.c | 34 +++++++++++++++++++++++++++++++---
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 4c5dc21c71ca..0e9d87a664f5 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -583,8 +583,8 @@ static u64 __of_translate_address(struct device_node *dev,
>   	/* Increase refcount at current level */
>   	of_node_get(dev);
>   
> +	*host = NULL;
>   	if (!parent) {
> -		*host = NULL;
>   		/* Get parent & match bus type */
>   		parent = of_get_parent(dev);
>   		if (parent == NULL)
> @@ -678,12 +678,34 @@ u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
>   }
>   EXPORT_SYMBOL(of_translate_address);
>   
> +static struct device_node *__of_get_dma_parent(struct device_node *np)
> +{
> +	struct of_phandle_args args;
> +	unsigned int index;
> +	int ret;
> +
> +	ret = of_property_match_string(np, "interconnect-names", "dma");
> +	if (ret < 0)
> +		return of_get_parent(np);

Don't you need to propagate ret to index here?

Robin.

> +
> +	ret = of_parse_phandle_with_args(np, "interconnects",
> +					 "#interconnect-cells",
> +					 index, &args);
> +	if (ret < 0)
> +		return of_get_parent(np);
> +
> +	return of_node_get(args.np);
> +}
> +
>   u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
>   {
> +	struct device_node *parent;
>   	struct device_node *host;
>   	u64 ret;
>   
> -	ret = __of_translate_address(dev, NULL, in_addr, "dma-ranges", &host);
> +	parent = __of_get_dma_parent(dev);
> +	ret = __of_translate_address(dev, parent, in_addr, "dma-ranges", &host);
> +	of_node_put(parent);
>   
>   	if (host) {
>   		of_node_put(host);
> @@ -911,9 +933,15 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
>   		return -EINVAL;
>   
>   	while (1) {
> +		struct device_node *parent;
> +
>   		naddr = of_n_addr_cells(node);
>   		nsize = of_n_size_cells(node);
> -		node = of_get_next_parent(node);
> +
> +		parent = __of_get_dma_parent(node);
> +		of_node_put(node);
> +
> +		node = parent;
>   		if (!node)
>   			break;
>   
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
