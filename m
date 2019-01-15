Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB14C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:52:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC4520656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U4dBbhr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC4520656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g2tQkW40kV1PQsxU1bE7wI9ZzDlHO8XRu2g37+wl0Js=; b=U4dBbhr5ycTgmr
	R+JdaW+uKGCzzNNbV4ZNfKKrjWIXQg1VS8fbuezfwveJSBe21HUZxWvxUWQa8LGQa7OR5epRqb98M
	MxA/O41VTKIopjb+dniP/2o1n0Jw5sDNHNkt37pL3qiV3o1MFdulI3qcKae0sxIE2jVmpv0+U6xU4
	Si2OLx2d/lvOnK1qQkG+Ue/ZdOpS9RuHZKSjzheFWFek1wGFf7v28hUUiDYsTWJEw8wYL6J6JuRIk
	fK5MTwzPTh3LLgg8SBN1PVYP+c2SXlSSVgOa8AmAqd/lMtzW0P6DImL0cZY96XqXuXLRlRLhfUjSr
	xsnKjzLa9x3HkLPOYAJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjEq5-0003lZ-S4; Tue, 15 Jan 2019 02:52:29 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjEq2-0003l4-0T
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 02:52:27 +0000
Received: by mail-ed1-f68.google.com with SMTP id a20so1348969edc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 18:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8QYlvmXDylvUtOb39tKDxn82P1fbLoRwSF1u234njv4=;
 b=MhNHmSLocUQ2jiw1Z4aYDv0Djm+KCEZZFNuSWtyMD9b+WCexpXQlZsUf2307pE/RNx
 WPCX6QVCSsEPChi7WInE7flNsvjWOkrf5oGLPoAT6dVD3CYD9XiNcgvGG+54pBA4ugKq
 MgFgfOI83TQky9fSZ1zZjQddRmUMoR7wRTq0vyhqlYgDTG8ZQ0pT/MQUa4ga2lZwiTR9
 ggw3JpbQ5RQ+xDqpQEImSn/PtbQ/NHgaMAYvJrSvDOF3HVyNglrpT3p7nNEZPXn2R60h
 eTe7r5rAhsGva4j6PwakNk2Z4+Jda0wvk7qoCFJH0AFpV42Ra5Vnz26tFyQD6n+Q/iwd
 KT7w==
X-Gm-Message-State: AJcUukcArL6aXeyYrJncr8tb7udOEXdXBnRZpQf1OmJa/mnO8/Ix0bP+
 j3t3cXqLdh6EDWi7vFrYFEFM6OfxAIY=
X-Google-Smtp-Source: ALg8bN4gChkK8o/anI+rQ4u00Gi1DzM2XDo/tI6jnFvPM67yIM+AtA5a0zS9nmNh3Pddv3StMdqtYA==
X-Received: by 2002:a17:906:2313:: with SMTP id
 l19-v6mr1442713eja.204.1547520743579; 
 Mon, 14 Jan 2019 18:52:23 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com.
 [209.85.221.46])
 by smtp.gmail.com with ESMTPSA id q10-v6sm3023433eju.47.2019.01.14.18.52.21
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 18:52:22 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id l9so1189173wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 18:52:21 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr1028067wrv.87.1547520741332; 
 Mon, 14 Jan 2019 18:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20190113021719.46457-1-samuel@sholland.org>
 <9738319a-4154-62be-2325-2873dfb326dc@linaro.org>
In-Reply-To: <9738319a-4154-62be-2325-2873dfb326dc@linaro.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 15 Jan 2019 10:52:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Hmn2QBN++X8h94E_Vwe1uZ67zz5TTGiwUJJe4nCWgXQ@mail.gmail.com>
Message-ID: <CAGb2v66Hmn2QBN++X8h94E_Vwe1uZ67zz5TTGiwUJJe4nCWgXQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Allwinner A64 timer workaround
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_185226_051578_D964EDB1 
X-CRM114-Status: GOOD (  21.95  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 8:57 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/01/2019 03:17, Samuel Holland wrote:
> > This is the third version of a patch series to fix system clock jumps
> > and other timer instability on the Allwinner A64 SoC. It has now been
> > tested for a week, and I've received no reports of date jumps with this
> > version. So this is, as far as I can tell, a complete workaround.
> >
> > See the commit messages for a detailed description of the issue, but the
> > summary is that, when a high counter bit rolls over, indeterminance in
> > the low bits causes CNTPCT/CNTVCT and their respective TVAL registers to
> > jump forward or backward. Backward jumps (or the next read after forward
> > jumps) are sometimes seen by the kernel and interpreted as the timer
> > wrapping around after 2^56 cycles. This causes the system clock to jump
> > forward approximately 91 years.
> >
> > changes since v2;
> > - Reduced workaround threshold from 11 to 10 bits based on reports from
> >   other hardare and the U-Boot version of this workaround
> > - Added TVAL handling based on Marc's suggestion
> > - Added erratum documentation and renamed symbols to match
> > - Added Maxime's Acked-by
> >
> > changes since v1:
> > - Add an iteration limit like most other arch timer workarounds
> > - Added Andre's Tested-by
> >
> > Samuel Holland (2):
> >   arm64: arch_timer: Workaround for Allwinner A64 timer instability
> >   arm64: dts: allwinner: a64: Enable A64 timer workaround
> >
> >  Documentation/arm64/silicon-errata.txt        |  2 +
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  1 +
> >  drivers/clocksource/Kconfig                   | 10 ++++
> >  drivers/clocksource/arm_arch_timer.c          | 55 +++++++++++++++++++
> >  4 files changed, 68 insertions(+)
> >
>
> Applied. Took the opportunity to add the stable@ tag.

Not seeing it in tip just yet. Was it applied for -rc or -next?
Need to know which branch to apply the device tree patch to.

Thanks
ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
