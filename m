Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32F4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:26:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8227620873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iFl3e9Cn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZ6aG/Ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8227620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ev2U0HPhFn9FUK8yZg1o/2kukktIdFOGUgnGc/BFjK0=; b=iFl3e9CnhKd40y
	KO8ZlxqLIJOkV/YTzjYNNM2+3yb3ng/lAztq4nLY4NmYe7/AcgDFY+saC61wuNcZx1R0ZC7Y/BJdQ
	asA5i1aeypQcQ34owR2A1tmMgVGBtdlwZmK07wxzqqIMwDA0JEqWOdh1MFzKnRdmOc89Ry34RhpVI
	rD72SbvxfF4lx1WPvyqzQScEU/sRuaXDV3QOcvS9Tij/Pjs8lVGXihvi1vTNmLowC1gKmKFULI6fe
	HDWh65iBIll94EkHwtWiqu1ILIxNW3yR7bE39zhHU0k5lDbvF+y1mpLhMefDommgQAG/Duepo80aY
	TEP05vDcFeEINIruRmSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gizRu-0002HL-UH; Mon, 14 Jan 2019 10:26:30 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gizRr-0002Ga-QS
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 10:26:29 +0000
Received: by mail-pg1-x544.google.com with SMTP id g189so9276334pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 02:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=CzcCJxnbl0LzIdopm5qsKPZ2eNi80mOCKExFL5bi0I4=;
 b=RZ6aG/UeMLc3x/q1qXUBTiBXPAG9jUV8ZsjANH7ne9PfWJm7eymoitG4SLWwykixmv
 nxLvDlwa1no0v2S/OkZmEuBqoaUoMWsBR+otVwZPPAMNYPDnHTwLh700Xw91pV0Usc6y
 Fu0e4uOJFyUXzbD83A5/+LZM7p1XrhIIgNVM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=CzcCJxnbl0LzIdopm5qsKPZ2eNi80mOCKExFL5bi0I4=;
 b=sgP6OZmWmoqkKODlLfmdrSKt47ER0N7IYALYdobA/MvEt3imbVerBL/F+juaPBcjLJ
 nPOBo1CuYAHJggGXemKmz9iLIwIE0ebRq5LodvVcik0Wy2N9KUZrRHbf3Qvwdtlifj+Z
 4fTy70SE6C3oTbcEPFviLznrgrn834xnKc6z+bOcx9jnHLgVbdAqOCHmvQjauYTjJgYx
 VGN36We7RhKBq5A3/uo1IRn+OJCRt+cO//R6hxsq3l6Q5QhY+eRox99Rp7P0j1XY9uQZ
 zgTg+ww0py4z28+gzIGtHMlmB82fGbMPh6mEzc/Lc9RKONMsKPXWywi3mnbutVH5QAQk
 JENg==
X-Gm-Message-State: AJcUukcXGDXNVOzrypKPZaYzOsww2zy/AK99ciWfaZti9aUhGpFrFmhE
 bWlXn50hYGEeIy54iZUw78+L
X-Google-Smtp-Source: ALg8bN5E/GLwEsy8uAR2BAL7TYdCum31eDVFue3S1vnmVsc49NhDEiiFgLqKF2MzXd1Yh1KAwuN/sQ==
X-Received: by 2002:a62:5fc4:: with SMTP id t187mr24930399pfb.66.1547461586717; 
 Mon, 14 Jan 2019 02:26:26 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
 by smtp.gmail.com with ESMTPSA id l185sm114470pfl.54.2019.01.14.02.26.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 02:26:26 -0800 (PST)
Date: Mon, 14 Jan 2019 15:56:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: afaerber@suse.de
Subject: Re: [PATCH v2 10/34] dt-bindings: arm: Convert Actions Semi bindings
 to jsonschema
Message-ID: <20190114102614.GC13162@Mani-XPS-13-9360>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-11-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-11-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_022627_866559_6EB63A05 
X-CRM114-Status: GOOD (  14.99  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Grant Likely <grant.likely@arm.com>, Frank Rowand <frowand.list@gmail.com>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 03:31:59PM -0600, Rob Herring wrote:
> Convert Actions Semi SoC bindings to DT schema format using json-schema.
> =


Andreas,

Shall I just apply this patch to Actions sub-tree?

Thanks,
Mani

> Cc: "Andreas F=E4rber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/actions.txt       | 56 -------------------
>  .../devicetree/bindings/arm/actions.yaml      | 38 +++++++++++++
>  2 files changed, 38 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml
> =

> diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Document=
ation/devicetree/bindings/arm/actions.txt
> deleted file mode 100644
> index d54f33c4e0da..000000000000
> --- a/Documentation/devicetree/bindings/arm/actions.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -Actions Semi platforms device tree bindings
> --------------------------------------------
> -
> -
> -S500 SoC
> -=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Required root node properties:
> -
> - - compatible :  must contain "actions,s500"
> -
> -
> -Modules:
> -
> -Root node property compatible must contain, depending on module:
> -
> - - LeMaker Guitar: "lemaker,guitar"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - Allo.com Sparky: "allo,sparky"
> - - Cubietech CubieBoard6: "cubietech,cubieboard6"
> - - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker=
,guitar"
> -
> -
> -S700 SoC
> -=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Required root node properties:
> -
> -- compatible :  must contain "actions,s700"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - Cubietech CubieBoard7: "cubietech,cubieboard7"
> -
> -
> -S900 SoC
> -=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Required root node properties:
> -
> -- compatible :  must contain "actions,s900"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - uCRobotics Bubblegum-96: "ucrobotics,bubblegum-96"
> diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documen=
tation/devicetree/bindings/arm/actions.yaml
> new file mode 100644
> index 000000000000..60abd371e474
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/actions.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/actions.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi platforms device tree bindings
> +
> +maintainers:
> +  - Andreas F=E4rber <afaerber@suse.de>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      # The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC.
> +      - items:
> +          - enum:
> +              - allo,sparky # Allo.com Sparky
> +              - cubietech,cubieboard6 # Cubietech CubieBoard6
> +          - const: actions,s500
> +      - items:
> +          - enum:
> +              - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board rev.=
 B
> +          - const: lemaker,guitar
> +          - const: actions,s500
> +
> +      # The Actions Semi S700 is a quad-core ARM Cortex-A53 SoC.
> +      - items:
> +          - enum:
> +              - cubietech,cubieboard7 # Cubietech CubieBoard7
> +          - const: actions,s700
> +
> +      # The Actions Semi S900 is a quad-core ARM Cortex-A53 SoC.
> +      - items:
> +          - enum:
> +              - ucrobotics,bubblegum-96 # uCRobotics Bubblegum-96
> +          - const: actions,s900
> -- =

> 2.19.1
> =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
