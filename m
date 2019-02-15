Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB1EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:45:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FD02190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LrLDbuhQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXu37FfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FD02190C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3R7MgDhTV/x0n7H9gH7gYMyDeCHxgkEczqEnIJDLO88=; b=LrLDbuhQRkQ7NZ
	/jq4Pfg0F/pMOj1mELs3+k1c+T3YbPXwAQLco6c2xUto0XeDwgfbYQuveNlZyjqo0VxrFQv8lgYFe
	3z4J5obEz+AJS+83oTxyhskg0ix+2UQ8VusmZQA/ZFEMUtJ2DHguX6OrazU0zX15mA/3pZW4JF5UI
	FAZNBQgZQEmT++nlpZrle4W6BGnCQeBuEhw6s8DGMdVSyrICnBDpraVCiGI5GGnsWMP2JqjoYthYi
	t+D9UGxnxUgfq1qikTg0XNLmVvghFpue972lSzVEbTD3ZESdWCk0Gq9MMl8XB3SfwgL4VX4swNbKQ
	GxWPh4cYpusWOSFCEpWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufg6-0001Tg-PX; Fri, 15 Feb 2019 15:45:26 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guffy-0001La-1m
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:45:22 +0000
Received: by mail-pg1-x541.google.com with SMTP id m2so2716184pgl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j+dGzuY4Ye8v3wi1zo3ZE2vet87YPNALWZYIQz9tmtk=;
 b=mXu37FfBUfTf7s/Qd5AyVbwUIYznmu9QbNaQQ021HZ58O1BLswguOdvjknxD7yXnlk
 CJ7l/hhhD3LGNr1SEDH8iHjyQdfy0MUY6/0rJXmaNEaA59gVygPbiiOglTqYVhxg2niQ
 5wshRT09mk/OtXnH6kaRYIb+ZR1Fe7bhC3OdC+Ez8rDnq/6a4cnrkTQJjafP9sUXRKR0
 cKSAHEI7QBIH+Dk/NWbBPupV8WFf9UJMe0jjahOoDCLzqaMusWdz5c8gP/UqjOO+eAwh
 +o3tdDLi1F+i8sHu1sXtga5AFskd8/P3aO3auwUrZUGCIrDPE7554nfIKUL292VXLPsr
 GqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j+dGzuY4Ye8v3wi1zo3ZE2vet87YPNALWZYIQz9tmtk=;
 b=UOtTfnH9s2+e+XFs8dQaD5US2ZP8XnJKDrOaZ+YLMJWcDBf3CbSCkZKAD40Uce1DFm
 wu+I8FYgurBnvBNCGqTyHX0WxgG4D134pabJKxhTZzx9+R2spWSeRTp0L3tUqmWm8c75
 /njrkPpWU4IikFF23WzzZx4vQTVbc5YYhUjfrT21xodD28mzElzUI4T5F9hCq1MG1nz6
 +rrsrvAr/PbJbKsoxYXKZ7hvR6k9NymjOU/5+9V0hucR3EsfyqO4CVLToiejCbccZ0Ca
 hriKz80v+J7NWRd46dF6LkeLBI5EPY4LWrxidIqeK3GBfaDcjtPHlYFnfos5ZkItfiqL
 HTCg==
X-Gm-Message-State: AHQUAuZQdi7DBQOrHbZIYXHx3jrld08tevque8NCu2HjnPdF8ysIvKut
 yef41c3T6nOe4jy3yBUkmoUYQx7XScqPRRojUhU=
X-Google-Smtp-Source: AHgI3IbTsm0WlrbQO0Xvn51Vfd9lDPn6KFAOvDd8k4euw/MAIMS4Kl5080ppXZvV2xl7PjpX++hUqZl1Fza6Luy1HNg=
X-Received: by 2002:a63:eb0f:: with SMTP id t15mr635082pgh.252.1550245516987; 
 Fri, 15 Feb 2019 07:45:16 -0800 (PST)
MIME-Version: 1.0
References: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
 <1550081533-25000-3-git-send-email-Frank.Li@nxp.com>
 <20190215135834.GA55505@lakrids.cambridge.arm.com>
In-Reply-To: <20190215135834.GA55505@lakrids.cambridge.arm.com>
From: Zhi Li <lznuaa@gmail.com>
Date: Fri, 15 Feb 2019 09:45:04 -0600
Message-ID: <CAHrpEqRGKeO2E15TFjgvBOug-nGc6UO3nkQrmvJL9TKzYp-T_A@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] dt-bindings: perf: imx8-ddr: add imx8qxp ddr
 performance monitor
To: Mark Rutland <mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_074518_226213_C64AE983 
X-CRM114-Status: GOOD (  18.01  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 7:58 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Feb 13, 2019 at 06:12:33PM +0000, Frank Li wrote:
> > Added binding doc for imx8qxp ddr performance monitor
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> As a general thing, please put the DT binding earlier in the series than
> the code and/or DTs using it, as per:
>
>   Documentation/devicetree/bindings/submitting-patches.txt
>
> > ---
> > Change from v2 to v3
> > * ddr_pmu0 -> ddr-pmu
> >
> >  .../devicetree/bindings/perf/fsl-imx-ddr.txt       | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> >
> > diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> > new file mode 100644
> > index 0000000..9d55182
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> > @@ -0,0 +1,22 @@
> > +* Freescale(NXP) IMX8 DDR performance monitor
> > +
> > +Required properties:
> > +
> > +- compatible: (standard compatible string) should be one of:
> > +     "fsl,imx8-ddr-pmu"
> > +     "fsl,imx8m-ddr-pmu"
>
> Please remove the "(standard xxx)" bits, they're just noise.

Okay.

>
> Otherwise, this generally looks OK.
>
> Are the DDR PMU registers part of the DDR controller register block?

Not. It is additional module.

>
> Thanks,
> Mark.
>
> > +
> > +- reg: (standard registers property) physical address and size
> > +
> > +- interrupts: (standard interrupt property) single interrupt
> > +     generated by the control block
> > +
> > +Example:
> > +
> > +     ddr-pmu@5c020000 {
> > +             compatible = "fsl,imx8-ddr-pmu";
> > +             reg = <0x0 0x5c020000 0x0 0x10000>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > --
> > 2.5.2
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
