Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC75C61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:30:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92ADB2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HQKf3q4f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMsQHhNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92ADB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NS5h0wEAq1Pf69823BAc6L+Nvqq/MP0kfOqxveH7VeY=; b=HQKf3q4f5B1RYd
	oRPwgFIMYn4x0HLProYYwEVMoKLdy6EmrnhcGF5PZBvEHpmNABzacGPr5n1unKrdQhsCGpsDDMYcB
	uAJAeGa2vss2vX5O8pYXTqobU4WycOoBqNFnvVDTetCiwbMAMGLMXpNwsz3qZTD57rbwhaCcs5g/k
	FEp9fSghxTg+QeGfceA/RxFWWcaeVhmWTdVZJSoceXYn7wL4escbtsOEEecQ0G91pTJrl/quLmws+
	y0CXQljMfiheCjo9T/se+rgzyevxd2FaKTxreE2W+KVFQUojnsUK4co6zbR/IA9W4qlJadGQzpDXx
	aHiac6KNl1pT8wnI1tcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkz8h-0006Zj-BD; Sat, 19 Jan 2019 22:30:55 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkz8e-0006ZN-Cw
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 22:30:53 +0000
Received: by mail-oi1-x243.google.com with SMTP id y1so11782154oie.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 14:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gXdfjLbvWADu2xnhaWD9Ipp8Sac4nR48CwxbLVF68A8=;
 b=uMsQHhNjCBfO+fDgedRKm7N4ZZs5a0mJiirbPfqtCociZZZ3LVD4qWRolyymnog9oR
 YIdH73OFahCgEdbCaDS8ddIKFDrOCnXlGcnaj+HDB5ceJwBxUll/IRcw14GSb4ZZEJSs
 w9GCPadvUE3dUQTmrMQ+fbZrkIzClpH+tRKh/KYWLjO0V50zh/Sutji2xyXrkCEtML9f
 QqtlFu0fZlMlJ1EUlaIvJdp4BUasZwRtj5IprEhEthGlY6P30c2ujvXSIqJHM5/ECGro
 bzEVG2RMcTlzXySgeOjomBNA7AgHQzDOwpM82ng6NvvyBdMAMuu7wqUJx1cYChiClGUf
 NVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gXdfjLbvWADu2xnhaWD9Ipp8Sac4nR48CwxbLVF68A8=;
 b=jTGEcTrSDvY5eN1sKp0Hvt0xoGa8W7Ge07xpqypL3auMmN0/7eTy+zDupa+EPqMoKq
 8oBsQTPRfXSHBuw5je5z/umwRjF6j5IWrT1qdUTqltMsflA22rzWmCuwlQ3P6s/Uw8oL
 gZT0S09G9IJoKmhkd8mmaiVZ76JljITpQwoLf4WUaZ5MDibQoiKPnfdgop/YNnPwnqHj
 5RsbVgQKBCqZS8V6syd0Oy+07B72ollj6SUnJInpoYw26CVWx+hk4DRM2Ppp3K6eDxL/
 KmxY0fR7QP3+EP67wMCDwN52GgRXapVqcWDXsBPcpEovdRRMV3oz2ncZSRRcR35wdPiB
 T/GQ==
X-Gm-Message-State: AJcUukdJT1gHRDQT5oO4QYWZdhkcxj+ytYuX08kRL+XUE+5daD53JXfB
 g6jc6Pc8Jn5pFe/jFDijaFJEe9m6fxNZywm+oYE=
X-Google-Smtp-Source: ALg8bN4vYceMuZXNjubl7hFSWQyHQXOvgR7DZws4qXRBnzYLSdwbLsyAGKgN5/xnBZ1c0LPf3IX6s3g/eMu6E+Kvuj0=
X-Received: by 2002:a05:6808:296:: with SMTP id
 z22mr1938356oic.67.1547937050854; 
 Sat, 19 Jan 2019 14:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20190119211815.25101-1-slongerbeam@gmail.com>
 <20190119211815.25101-3-slongerbeam@gmail.com>
In-Reply-To: <20190119211815.25101-3-slongerbeam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 19 Jan 2019 20:30:42 -0200
Message-ID: <CAOMZO5AMgKra8ZxUyBkvDDR68gWZ+YiOhO-yHS-+adMWGgnEsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx53-smd: Add OV5642 video capture support
To: Steve Longerbeam <slongerbeam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_143052_463400_1FD7FA5F 
X-CRM114-Status: GOOD (  11.66  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Steve,

On Sat, Jan 19, 2019 at 7:19 PM Steve Longerbeam <slongerbeam@gmail.com> wrote:
>
> Add video capture support from the OV5642 to IPU CSI0 on
> the i.MX53 SMD.
>
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>

Looks good, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Only one minor nit below that perhaps Shawn could adjust while applying:

     pmic: dialog@48 {
>                 compatible = "dlg,da9053", "dlg,da9052";
>                 reg = <0x48>;
> +               interrupt-parent = <&gpio7>;
> +               interrupts = <11 IRQ_TYPE_LEVEL_LOW>; /* low-level active IRQ at GPIO7_11 */
> +
> +               regulators {
> +                       ldo7_reg: ldo7 {
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3600000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       ldo9_reg: ldo9 {
> +                               regulator-min-microvolt = <1250000>;
> +                               regulator-max-microvolt = <3650000>;
> +                               regulator-always-on;

regulator-always-on could be removed from the two regulators above
since they are used by the camera.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
