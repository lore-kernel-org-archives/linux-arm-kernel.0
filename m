Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05FEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:05:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F58D2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jBx3Z8Nm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV0vsPgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F58D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MJV8QQW4CM6LmXdnnW31PgFj078TWbxUkepl6LxP8t4=; b=jBx3Z8Nmc5uoDO
	/6rALbXuNUmeB91M/ZbwMDpmGy9tRPj266cYgbeL6nSXkej2zHVH05smaecRvhX6LGFgQwD6w6xcr
	0xaI58RzFaO5ru4lH8IirY/CZE2GeG1OYMdtFoDCDEKp+CHVgqKrBqU1nf9wG4zL4Dsm4Kt1QvzRU
	/cKKbKPE48/3AqtQbzd8gByWjEokc6mXLf8yLckHitG1cmaoVLhj+bX1dGhICqfYpm6DK3QnV727/
	joDwKn1Ocoo2l7rhgp9UlNZtM6jTgUm863s/Gc+iTpbMf+W1pKrraXQZne85M0dDEKeLYo2JmxIIi
	KZ5D3OW4U65qLsFDjibw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBKK-0004yH-E8; Tue, 04 Dec 2018 14:05:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBKC-0004RA-3I
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:05:26 +0000
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7314E214DA
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543932306;
 bh=yTr+UbBFW+eS6HM3fzcLbxczAbrxW4SyfnuUXDeA/9o=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GV0vsPguRlbVwUdqPqdotp9D2RX4uJcvLoeZB4aoigLRi8c7ofsrLfJ3hTvEy12nT
 3oDb2slvH5a27cyVmVC2m6BQspIoq8Cfy2ZmpH2LSslhjD9ORiJJdd8STMH9ZsBG+O
 U9Uh+jBysPhtu0bVYSATY+Qpb2tiZwvhrxeihfeg=
Received: by mail-qt1-f171.google.com with SMTP id p17so18082191qtl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 06:05:06 -0800 (PST)
X-Gm-Message-State: AA+aEWblXHVIdxNa0Iut9nxRdsAnUuax+sOlx7iyVkwFG/jaUAbBk/8z
 5rQ8kKVBYeuLWnCQd+L+FAxqvhSGax4FPQoO9Q==
X-Google-Smtp-Source: AFSGD/Wa9LYCKIlO2I4w34Owie/nbFY2YYmEhKbJJCOx75JQlW9JLL4Y1Zli1NJqi2tnJfrE9cHPFZaPN3+nzSMsdBg=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr19809237qts.144.1543932305591; 
 Tue, 04 Dec 2018 06:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-22-robh@kernel.org>
 <be37bd18-a573-307e-3a9e-e879010cfc89@baylibre.com>
In-Reply-To: <be37bd18-a573-307e-3a9e-e879010cfc89@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Dec 2018 08:04:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ3oL4FWSQKVLRtmg5Bma5q6-QgicfATcOEo3nQY-TdPw@mail.gmail.com>
Message-ID: <CAL_JsqJ3oL4FWSQKVLRtmg5Bma5q6-QgicfATcOEo3nQY-TdPw@mail.gmail.com>
Subject: Re: [PATCH v2 21/34] dt-bindings: arm: Convert Oxford Semi board/soc
 bindings to json-schema
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_060520_173893_97767AB0 
X-CRM114-Status: GOOD (  18.78  )
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
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@arm.com>, linux-oxnas@groups.io,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 2:43 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 03/12/2018 22:32, Rob Herring wrote:
> > Convert Oxford Semi SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-oxnas@groups.io
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/oxnas.txt         | 14 -----------
> >  .../devicetree/bindings/arm/oxnas.yaml        | 25 +++++++++++++++++++
> >  2 files changed, 25 insertions(+), 14 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/oxnas.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
> > deleted file mode 100644
> > index ac64e60f99f1..000000000000
> > --- a/Documentation/devicetree/bindings/arm/oxnas.txt
> > +++ /dev/null
> > @@ -1,14 +0,0 @@
> > -Oxford Semiconductor OXNAS SoCs Family device tree bindings
> > --------------------------------------------
> > -
> > -Boards with the OX810SE SoC shall have the following properties:
> > -  Required root node property:
> > -    compatible: "oxsemi,ox810se"
> > -
> > -Boards with the OX820 SoC shall have the following properties:
> > -  Required root node property:
> > -    compatible: "oxsemi,ox820"
> > -
> > -Board compatible values:
> > -  - "wd,mbwe" (OX810SE)
> > -  - "cloudengines,pogoplugv3" (OX820)
> > diff --git a/Documentation/devicetree/bindings/arm/oxnas.yaml b/Documentation/devicetree/bindings/arm/oxnas.yaml
> > new file mode 100644
> > index 000000000000..6ae51ef513be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/oxnas.yaml
> > @@ -0,0 +1,25 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/oxnas.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Oxford Semiconductor OXNAS SoCs Family device tree bindings
> > +
> > +maintainers:
> > +  - Neil Armstrong <narmstrong@baylibre.com>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +        - enum:
> > +            - wd,mbwe
> > +        - const: oxsemi,ox810se
> > +
> > +      - items:
> > +        - enum:
> > +            - cloudengines,pogoplugv3
> > +        - const: oxsemi,ox820
> >
>
> We also loose all the "human friendly" description of board/SoC relationship here,
> and I think it's a shame.

You can have whatever comments or description properties you like, so
how would you like it to look?

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
