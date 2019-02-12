Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3499C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:02:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CE52084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g/RMEvZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CE52084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xZ7OitOV/GCNzVi3kkehjA2TAGtYu/TkPb9GOsm+36Q=; b=g/RMEvZtFsHrz8tf3IxKJdNBh
	ZgC4AyxRwDc++UWQ65ebiJAXuOFFy28nbcjWZDP7D6KtVzouAsVk2U5gxVMc8c0CHYfu/4itlWIzr
	B1tOOoolBIYGkkYrn7Syy3I6SRt/I63oDdc+rr7XD0HGb9HzXbieyg/R2iZ5eOn0bO7C6fLVU5WXw
	hGbViw60nnHmrLyI5rAJQI9HXkeG0wui752d5MHXDtRQp35DSd53ILkZXE7EUR3+KuDEZ+La29d/b
	Sw4Fsb4gxq6akMaT3OxTB+bBOcV2c53fYOq7TRLhKNQWeI0CdV1j0u4J6saHIschTPmXBrUgKVu+F
	J/5i2XVAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtcOL-00034n-0r; Tue, 12 Feb 2019 18:02:45 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtcO8-00030F-3O
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 18:02:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F0BBA78;
 Tue, 12 Feb 2019 10:02:31 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EEFF3F774;
 Tue, 12 Feb 2019 10:02:29 -0800 (PST)
Subject: Re: [PATCH v3 3/7] of: address: Add parent pointer to the
 __of_translate_address args
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Chen-Yu Tsai <wens@csie.org>
References: <cover.f2e5fbb4d21384168973fa32377a33d627768146.1549897336.git-series.maxime.ripard@bootlin.com>
 <57fa05909120919f33590fed11bd4041467a09f5.1549897336.git-series.maxime.ripard@bootlin.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fbac5719-5d76-e7f4-5e5e-2d5167783106@arm.com>
Date: Tue, 12 Feb 2019 18:02:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <57fa05909120919f33590fed11bd4041467a09f5.1549897336.git-series.maxime.ripard@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_100232_523453_DE3ADBF9 
X-CRM114-Status: GOOD (  27.77  )
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
> The __of_translate_address function is used to translate the device tree
> addresses to physical addresses using the various ranges property to create
> the offset.
> 
> However, it's shared between the CPU addresses (based on the ranges
> property) and the DMA addresses (based on dma-ranges). Since we're going to
> add support for a DMA parent node that is not the DT parent node, we need
> to change the logic a bit to have an optional parent node that we should
> use.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>   drivers/of/address.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 2270373b30ab..4c5dc21c71ca 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -569,10 +569,10 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>    * relative to that node.
>    */
>   static u64 __of_translate_address(struct device_node *dev,
> +				  struct device_node *parent,
>   				  const __be32 *in_addr, const char *rprop,
>   				  struct device_node **host)
>   {
> -	struct device_node *parent = NULL;
>   	struct of_bus *bus, *pbus;
>   	__be32 addr[OF_MAX_ADDR_CELLS];
>   	int na, ns, pna, pns;
> @@ -583,11 +583,14 @@ static u64 __of_translate_address(struct device_node *dev,
>   	/* Increase refcount at current level */
>   	of_node_get(dev);
>   
> -	*host = NULL;
> -	/* Get parent & match bus type */
> -	parent = of_get_parent(dev);
> -	if (parent == NULL)
> -		goto bail;
> +	if (!parent) {

I would have suggested having the callers make the of_get_parent() call 
themselves, but having pulled up the code for a look at the whole 
function, there's a bigger issue at play. The parent traversal happens 
within the main translation loop as well, and topologies could quite 
feasibly exist where that makes a difference, e.g.:

	icc {
		#interconnect-cells = <0>;
		dma-ranges = <...>;
	};

	subsystem {
		interconnects = <&icc>;
		interconnect-names = "dma";

		intermediate-bus {
			dma-ranges;

			device {
				...
			};
		};
	};

or:

	icc2 {
		#interconnect-cells = <0>;
		dma-ranges = <...>;
	};

	icc1 {
		#interconnect-cells = <0>;
		dma-ranges = <...>;
		interconnects = <&icc2>;
		interconnect-names = "dma";
	};

	device {
		interconnects = <&icc1>;
		interconnect-names = "dma";
		...
	};

So I guess the answer is to switch this over to using a callback and 
have the callers pass of_get_parent/of_get_dma_parent in as appropriate.

Robin.

> +		*host = NULL;
> +		/* Get parent & match bus type */
> +		parent = of_get_parent(dev);
> +		if (parent == NULL)
> +			goto bail;
> +	}
> +
>   	bus = of_match_bus(parent);
>   
>   	/* Count address cells & copy address locally */
> @@ -665,7 +668,7 @@ u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
>   	struct device_node *host;
>   	u64 ret;
>   
> -	ret = __of_translate_address(dev, in_addr, "ranges", &host);
> +	ret = __of_translate_address(dev, NULL, in_addr, "ranges", &host);
>   	if (host) {
>   		of_node_put(host);
>   		return OF_BAD_ADDR;
> @@ -680,7 +683,7 @@ u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
>   	struct device_node *host;
>   	u64 ret;
>   
> -	ret = __of_translate_address(dev, in_addr, "dma-ranges", &host);
> +	ret = __of_translate_address(dev, NULL, in_addr, "dma-ranges", &host);
>   
>   	if (host) {
>   		of_node_put(host);
> @@ -736,7 +739,7 @@ static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
>   	unsigned long port;
>   	struct device_node *host;
>   
> -	taddr = __of_translate_address(dev, in_addr, "ranges", &host);
> +	taddr = __of_translate_address(dev, NULL, in_addr, "ranges", &host);
>   	if (host) {
>   		/* host-specific port access */
>   		port = logic_pio_trans_hwaddr(&host->fwnode, taddr, size);
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
