Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447F7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:39:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128C620989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ev+QmA6x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwWX3CXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128C620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6YYRWFPQcDSb5e/0zf60u2VaAZvb7IceUh8bpEpzDuE=; b=Ev+QmA6xWYSd2d
	rKl21JlNIGm4OMc7HhLJC5mKf4dqGWEK0XPe4I2ELl3UM0aHuNrefWTTya0jqAi+eL4ajQgSZ5DSE
	AvYKAe9cHGJSrsqNWoATw8E7opU+5bbGVOxoABGx1IxOQBYJGkMN3rWMBK85d3A+O3k2AmkmrYVSi
	t0pgXs3rx7pvcH607TKTN5946u4WNTt1w8Sxz1KVD1atgexSK5DpIhwYat6ulyWn/8lDlJS6qqtZH
	o3mGKx5f9zmWxNVs4l4S0v7Nzm/EgwXElPde1zB1OmUBsAf7cqcL4sexuZunmRbOtjDmSJn8gvbfn
	GlZsyIiq3wruw+xVRb8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV2Ia-0004oF-G1; Thu, 06 Dec 2018 22:39:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV2IV-0004nE-Nu
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:39:09 +0000
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C804214C1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 22:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544135937;
 bh=VbcGlGAAJz1C5lG5tVujtKGSK3Bzi9ksK0uLYUy4iTs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qwWX3CXUokZ5RG8Lnane13bLAiRnSZecN5UyfBcgcWUuVM9iMuC3c3kkxeutUE8LB
 /4oIpNkh1WUjpscOzImeHx6nRPLRR4J/4GPWvoYFwGGglepAlD73BPhKakTn57nF9o
 FSZpqCXCfPhshg92VJ1ERjAxrWcrMx3ApwFmFEV0=
Received: by mail-qt1-f178.google.com with SMTP id d18so2439122qto.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 14:38:57 -0800 (PST)
X-Gm-Message-State: AA+aEWY7PHHzgkhnwloCOE5W7Nqv3XYIHXI6sr3Hp1xbKKMTt+5aFzU8
 0q9ahcDFtcW9rxneG7A2HUxmW1UT3Vx2dV/iPw==
X-Google-Smtp-Source: AFSGD/WRcxX6FyCGvj2OcZXNFbrOhz0ZTMGsJJyitoIl5YZ2WGpr7kucAG1ka5etxdncf7t9pJXcHjiB2cB+i17nrWE=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr29359172qvi.90.1544135936338; 
 Thu, 06 Dec 2018 14:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-31-robh@kernel.org>
 <20181204085022.GB25962@ulmo>
In-Reply-To: <20181204085022.GB25962@ulmo>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Dec 2018 16:38:44 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+NWVoFzBCYVwu-YM_90mYUdgmaW4ctJim2LkxfpRbg=Q@mail.gmail.com>
Message-ID: <CAL_Jsq+NWVoFzBCYVwu-YM_90mYUdgmaW4ctJim2LkxfpRbg=Q@mail.gmail.com>
Subject: Re: [PATCH v2 30/34] dt-bindings: arm: Convert Tegra board/soc
 bindings to json-schema
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_143907_808663_32D34CA8 
X-CRM114-Status: GOOD (  20.72  )
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
 Jon Hunter <jonathanh@nvidia.com>, Grant Likely <grant.likely@arm.com>,
 linux-tegra@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 2:50 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Dec 03, 2018 at 03:32:19PM -0600, Rob Herring wrote:
> > Convert Tegra SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-tegra@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/tegra.txt         |  65 -----------
> >  .../devicetree/bindings/arm/tegra.yaml        | 101 ++++++++++++++++++
> >  2 files changed, 101 insertions(+), 65 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/tegra.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
> > deleted file mode 100644
> > index c59b15f64346..000000000000
> > --- a/Documentation/devicetree/bindings/arm/tegra.txt
> > +++ /dev/null
> > @@ -1,65 +0,0 @@
> > -NVIDIA Tegra device tree bindings
> > --------------------------------------------
> > -
> > -SoCs
> > --------------------------------------------
> > -
> > -Each device tree must specify which Tegra SoC it uses, using one of the
> > -following compatible values:
> > -
> > -  nvidia,tegra20
> > -  nvidia,tegra30
> > -  nvidia,tegra114
> > -  nvidia,tegra124
> > -  nvidia,tegra132
> > -  nvidia,tegra210
> > -  nvidia,tegra186
> > -  nvidia,tegra194
> > -
> > -Boards
> > --------------------------------------------
> > -
> > -Each device tree must specify which one or more of the following
> > -board-specific compatible values:
> > -
> > -  ad,medcom-wide
> > -  ad,plutux
> > -  ad,tamonten
> > -  ad,tec
> > -  compal,paz00
> > -  compulab,trimslice
> > -  nvidia,beaver
> > -  nvidia,cardhu
> > -  nvidia,cardhu-a02
> > -  nvidia,cardhu-a04
> > -  nvidia,dalmore
> > -  nvidia,harmony
> > -  nvidia,jetson-tk1
> > -  nvidia,norrin
> > -  nvidia,p2371-0000
> > -  nvidia,p2371-2180
> > -  nvidia,p2571
> > -  nvidia,p2771-0000
> > -  nvidia,p2972-0000
> > -  nvidia,roth
> > -  nvidia,seaboard
> > -  nvidia,tn7
> > -  nvidia,ventana
> > -  toradex,apalis_t30
> > -  toradex,apalis_t30-eval
> > -  toradex,apalis_t30-v1.1
> > -  toradex,apalis_t30-v1.1-eval
> > -  toradex,apalis-tk1
> > -  toradex,apalis-tk1-eval
> > -  toradex,apalis-tk1-v1.2
> > -  toradex,apalis-tk1-v1.2-eval
> > -  toradex,colibri_t20
> > -  toradex,colibri_t20-eval-v3
> > -  toradex,colibri_t20-iris
> > -  toradex,colibri_t30
> > -  toradex,colibri_t30-eval-v3
> > -
> > -Trusted Foundations
> > --------------------------------------------
> > -Tegra supports the Trusted Foundation secure monitor. See the
> > -"tlm,trusted-foundations" binding's documentation for more details.
> > diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
> > new file mode 100644
> > index 000000000000..66493892ffc1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/tegra.yaml
> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/tegra.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>
> Could you explain what these are? They give 404, so I assume they are
> more like placeholders and not actually used?

Please read the documentation in patch 2. They are used, but aren't live URLs.

> > +
> > +title: NVIDIA Tegra device tree bindings
> > +
> > +maintainers:
> > +  - Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > +  - Peter De Schrijver <pdeschrijver@nvidia.com>
>
> Not sure how you got that list, but probably from git history. I think
> it makes sense to replace Marcel and Peter with Jon and myself.

Will do.

> Other than that, looks fine to me. Some of the enumerations below look
> somewhat hard to parse, but I suspect that it will become second nature
> in no time.

We can add descriptions and/or comments if that helps. I didn't add
them if not already there.

> Acked-by: Thierry Reding <treding@nvidia.com>

Thanks.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
