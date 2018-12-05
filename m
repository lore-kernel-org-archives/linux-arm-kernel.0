Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C95C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:45:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D979B20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AuM0rpLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D979B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H/LNXf6Z2WT3O/OT3nIOPa80fzN675KfipL+f6nm4cw=; b=AuM0rpLjHRn8+S
	B2Wy8CIiTmgnDO1XdvcD/qcr7RC/Z7jGHrJ+RAFPt+noQhFdF/a1JTNgXt+4i0R+blnc/Zk90FtXX
	kBHdjgFW4lZjDl7qKqCl73Vzk4u9i8mqQS9z9Axdd332n5MkRIOjDqitxCHuHsjeB1o3vUMv43wkb
	sp/YxNUt9kTghNOwrv5OcGqPkhO11aWa9ZVr60JO7TdEjUdIZXp1TDGY6VKjQBp6065qXZ5cfRnGm
	SLQSTXNutQgZRt2Cr+FvXGvzw+GGJdhj2HZWHXi7UAliOcvAwp2KmcOySuz647uMC2UbmZgFqcswy
	pFqiu3UNSJFyDF6lQUrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUTka-00034E-NG; Wed, 05 Dec 2018 09:45:48 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUTkV-000316-PQ
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:45:45 +0000
Received: by mail-ed1-f68.google.com with SMTP id b3so16466829ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 01:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TV1XO0Uved8LFFNzA4LL71DcJa0tScM4mubEOFV4mR0=;
 b=WiKDfml7vsEi8kH/BthJFcLOKb+lBOd+hBc/JGtBU5xBnVoDXG5gJO/yYL+BtIwraF
 YjR9zQFCzjSgiqLRy7JQuCkMgyGQnEB2cg/wt7SpA5rieSDNyF3fag7D/WnGGPNgwhGp
 1QuSDIXyvRVgZDqYlACuaaDacW+qp0GIJ5n2WAoyxEnGeMCyeqc7gxVszyP1bh9u20Jc
 ImoGJu8h8B5t2a8jbf6O0wlHDGBI65Ig1TZmu4Hm7L1TQFqq9jFykchiHCaGX57kqME/
 Wx3HUFwI/RcWqb59VCnnPDGsmC7sRQa+nMCsl4CeWps9oMqXMLHTpQ/m9t4dr/pCcntl
 1f0A==
X-Gm-Message-State: AA+aEWYPxQJuYNEcQd0W3H2PC7G0vhF9FFlQXbSWhAMTlrmu/gHcgOsx
 QeP+GkItPHZ5dzpKiKE4YRlUwf74cH0=
X-Google-Smtp-Source: AFSGD/VEhlt5UXkxz6y1GRaQsQGc3m1MOnUX8ILEFlmmFjFB7ssRKwVF8NRa0zjyMEaE2r2ExjlOUw==
X-Received: by 2002:a17:906:6a11:: with SMTP id
 o17-v6mr17494813ejr.99.1544003131025; 
 Wed, 05 Dec 2018 01:45:31 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44])
 by smtp.gmail.com with ESMTPSA id t9sm5286238edd.25.2018.12.05.01.45.30
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 01:45:30 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id z18so12527991wmc.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 01:45:30 -0800 (PST)
X-Received: by 2002:a1c:c008:: with SMTP id q8mr13866947wmf.99.1544003130312; 
 Wed, 05 Dec 2018 01:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20181205092444.29497-1-paul.kocialkowski@bootlin.com>
 <20181205092444.29497-8-paul.kocialkowski@bootlin.com>
In-Reply-To: <20181205092444.29497-8-paul.kocialkowski@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 5 Dec 2018 17:45:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v66JwZ_RkEdk6sz-0Z7EJx7ieG3zBT6yr-95X6guxUkKTg@mail.gmail.com>
Message-ID: <CAGb2v66JwZ_RkEdk6sz-0Z7EJx7ieG3zBT6yr-95X6guxUkKTg@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] arm64: dts: allwinner: h5: Add system-control
 node with SRAM C1
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_014543_820154_2CFD42B2 
X-CRM114-Status: GOOD (  18.61  )
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
Cc: devel@driverdev.osuosl.org, devicetree <devicetree@vger.kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 5:25 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Add the H5-specific system control node description to its device-tree
> with support for the SRAM C1 section, that will be used by the video
> codec node later on.
>
> The CPU-side SRAM address was obtained empirically while the size was
> taken from the documentation. They may not be entirely accurate.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 22 ++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> index b41dc1aab67d..42bfb560b367 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> @@ -94,6 +94,28 @@
>         };
>
>         soc {
> +               system-control@1c00000 {
> +                       compatible = "allwinner,sun50i-h5-system-control";
> +                       reg = <0x01c00000 0x1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       sram_c1: sram@1d00000 {
> +                               compatible = "mmio-sram";
> +                               reg = <0x00018000 0x1c000>;

0x1d00000 or 0x18000?

> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               ranges = <0 0x00018000 0x1c000>;

Same here.

> +
> +                               ve_sram: sram-section@0 {
> +                                       compatible = "allwinner,sun50i-h5-sram-c1",
> +                                                    "allwinner,sun4i-a10-sram-c1";
> +                                       reg = <0x000000 0x1c000>;
> +                               };
> +                       };
> +               };
> +
>                 mali: gpu@1e80000 {
>                         compatible = "allwinner,sun50i-h5-mali", "arm,mali-450";
>                         reg = <0x01e80000 0x30000>;
> --
> 2.19.2
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
