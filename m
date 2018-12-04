Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37BEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:53:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7249208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oPH8t2Q9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7249208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free-electrons.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ksMRm2r1mgQiSsXemrXxBMQoxaOIjDY8wfJoyTEJ/mg=; b=oPH8t2Q9JkI1O1
	t0GxXYUH1/a8hRyzBPTLyfQ2T4RRQQkTDb8OtjdJ9mDMQrYFps9BPMphXM/oZSO6VyVX3rgcAGgzw
	NLC+m3nFa3w29KnX6JLX8J+9mw+1ZUKS02wjBa92ezLipwKDLcThCzB+SnuBkL5+ocGcPVQqH0CKa
	VW/gFs9eqvCF2yu0BtDtbmQunZRWNQZ+q/m9x/GMJyJ/TNHPRBxisMuD5RfgCatB7tPJGqail2ACt
	ICRDGWvGbfLe/w1CPxNq6yNB1fnQw9aRyA7ZONX9MIlQnCu89yxCVar8XvlfJ/0sfPqvH+iaw2nmS
	FOgAenNbYTuZM1dYaw3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU5WA-0001Ic-Vc; Tue, 04 Dec 2018 07:53:18 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU5W7-0001HE-6M
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 07:53:17 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id B545A207B0; Tue,  4 Dec 2018 08:53:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 7F9DD20736;
 Tue,  4 Dec 2018 08:53:02 +0100 (CET)
Date: Tue, 4 Dec 2018 08:53:02 +0100
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 11/34] dt-bindings: arm: Convert Alpine board/soc
 bindings to json-schema
Message-ID: <20181204075302.GC3173@kwain>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-12-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-12-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_235315_371244_5710B30D 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message.
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Antoine Tenart <antoine.tenart@free-electrons.com>,
 linux-kernel@vger.kernel.org, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Tsahee Zidenberg <tsahee@annapurnalabs.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

On Mon, Dec 03, 2018 at 03:32:00PM -0600, Rob Herring wrote:
> diff --git a/Documentation/devicetree/bindings/arm/al,alpine.yaml b/Docum=
entation/devicetree/bindings/arm/al,alpine.yaml
> new file mode 100644
> index 000000000000..82e2fafdfece
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/al,alpine.yaml
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/al,alpine.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Annapurna Labs Alpine Platform Device Tree Bindings
> +
> +maintainers:
> +  - Tsahee Zidenberg <tsahee@annapurnalabs.com>

Could you add '- Antoine Tenart <antoine.tenart@bootlin.com>' here?

Thanks!
Antoine

> +description: test
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: al,alpine
> +  model:
> +    items:
> +      - const: "Annapurna Labs Alpine Dev Board"
> +
> +...
> -- =

> 2.19.1
> =


-- =

Antoine T=E9nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
