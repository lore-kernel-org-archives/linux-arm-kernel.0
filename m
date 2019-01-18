Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E787C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:21:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196E820855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e+Z3tLtV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="oG5OB19K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FhySyZFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196E820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:Date:References:
	MIME-Version:To:From:Message-Id:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ao1UQedKQpe23+Uef6mJeew0vGXRvvMvJ/SIGmRiAn4=; b=e+Z3tLtV8IOsBM
	Wy/eYhWiJxTwwAN3qk7qFuXNeEi+wvAxhrLkehgN26L9mgFdSVYyUE9+d71/0o3deao0oaBrMG2yc
	4vU86tuuUZNcS4UG0RI1F2xLM7RDr4JJIcZXHvNczr2RQooUBNYtFe8aZCZPXfE7GZMMvZfH8N2Ki
	G9tlkwxKdwHin/+mbAUeuAqERkbeB+s0yPzSkhanu7ptA3RUh1vXCl+BCH2YLCX5LdtbjsXm/t1Ih
	CNdZsgsckdZ0ejeW/Mtz0QRdc4NLfZJustrvF4nEEd7ihK0aAkzgTUEQJgrOzJBo+s4Y6d7ltCiJU
	zR+BT9XTJvkw5832xjgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkLen-0004Ua-Vy; Fri, 18 Jan 2019 04:21:25 +0000
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkLek-0004Ts-F2
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 04:21:24 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 2BE4521ADD;
 Thu, 17 Jan 2019 23:21:14 -0500 (EST)
Received: from web6 ([10.202.2.216])
 by compute4.internal (MEProxy); Thu, 17 Jan 2019 23:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 message-id:from:to:cc:mime-version:content-transfer-encoding
 :content-type:references:date:in-reply-to:subject; s=fm1; bh=m9V
 EIlsPUJt00+Jb74/la9I69I7E0UJYRsCp2QNRtBo=; b=oG5OB19KjjwCkg9aVNs
 HVTm2eb8ZbNXU4ZpwzFkrQImrzjRLuj8LO1niVg5ZOy3PGpS7fwFJ+MIwUfXhPhB
 mOwGjugIIppOol35NU6zfUMNKCHOo9ZpYejCb56EoH1KFZReNnaxWKQNxhJTaZSz
 4wTjYaBcqGiCVOARPDi8pD9o4c7no9zgUONmgxryBjf6JbMvdCqj9pLi6sumDV3x
 IQsVf7IrNX5AKSpZSBd/RwC3niykkatbdvZr7wbxMnaxItdYMYGeQX/tVG/HEVRw
 LQ0F9W/pt+y44ykjlaBZ8TSmEY1XnHWFr6FiykpmVXv8WuGoluiQoqMdzKUDrXn3
 avQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=m9VEIlsPUJt00+Jb74/la9I69I7E0UJYRsCp2QNRt
 Bo=; b=FhySyZFw7t7GqpTwHw/DQ5vvJjjtU/tbtSVi9YVZ/og6ELh3be+DjJM6B
 gxmaIP7yOgvvPx/1azZ5eQqKnwZQchefPWhjftWCrsxwjg5yElEUg/0WhhbWKtKp
 S8oTNnRxn64TWJkXGo8EOU1YrUHBk66s5QgssB3mGVEpdg3pyQ2w2i+084on5XFc
 Ir8mp52MNWv/RizXLF2urdyDmiPiV9Pq2yLS8VAosN+Ci2x+SlUoe08rEeeyUUNf
 4QjXn56qY72h/+ZL/QZkqb8eWVdaeX8/xqf7O9ekS/BdZQh43h7MHK78mLvPM3Vl
 tUSJPj16pT8P+yresBRLmbHv+bu8A==
X-ME-Sender: <xms:OVRBXMDcb3mdRnHaga1R2g4qANad2gTgMIg2ETVVgIYH74dN1t44YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrgeelgdeikecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
 tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffhvfgggfgtof
 hfffgjufesthejredtredtjeenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceo
 rghnughrvgifsegrjhdrihgurdgruheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
 gurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:OVRBXK1qoPczqoQGfrGNuKZWw7T_yJOWQKSm4jOlnk2n4QcxCg8lAQ>
 <xmx:OVRBXCXjn_vaA3S3yaqtftWEInbWegOglRUHMp58Dzkx7Rr9l6CPjQ>
 <xmx:OVRBXEmU1h3z0pRYDZmCqcg7ZRjUSJLe0WstK7C8no9wTslOeBjyQA>
 <xmx:OlRBXK-xS45LkojaaSuib_yZKftL2sz9PB6xtTV1DAoTT3TjjEh-lg>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
 id BC8FD429B; Thu, 17 Jan 2019 23:21:12 -0500 (EST)
Message-Id: <1547785272.2051152.1637704704.1926B2B5@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
To: Vijay Khemka <vijaykhemka@fb.com>, Lee Jones <lee.jones@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface - ajax-36e4bfd3
References: <20190117190830.824013-1-vijaykhemka@fb.com>
Date: Fri, 18 Jan 2019 14:51:12 +1030
In-Reply-To: <20190117190830.824013-1-vijaykhemka@fb.com>
Subject: Re: [PATCH] dt-bindings: aspeed-lpc: Make parameter optional
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_202122_645646_55D7996E 
X-CRM114-Status: GOOD (  13.96  )
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
Cc: "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vijay,

On Fri, 18 Jan 2019, at 05:38, Vijay Khemka wrote:
> Memory-region and flash phandle is not a required parameter, it is
> optional to describe in device tree and needed only use basis.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/
> Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index 34dd89087cff..ff0cb28903dd 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -135,6 +135,10 @@ Required properties:
>  - clocks:	contains a phandle to the syscon node describing the clocks.
>  		There should then be one cell representing the clock to use
>  
> +Optional properties:
> +These below properties are optional and required only if one need to use it
> +through ioctl.

I'd just say "Optional properties". Leave the description off, as we probably
shouldn't be talking about ioctls and such in the bindings.

Andrew

> +
>  - memory-region: A phandle to a reserved_memory region to be used for the LPC
>  		to AHB mapping
>  
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
