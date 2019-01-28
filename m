Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F3EC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638412175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HMBaCYr3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wzh4I8U3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638412175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2YOY1YV1GdxwdX/LfhFP+HQmc7B/mketD+6TTr5qE8o=; b=HMBaCYr3QPX0fx
	hi+dyc3v9fIa/7x+bqpjqIg1tF63YrtqhHpT5FvX2jA9pnVR5UEcoEGdvRamG41kjKpwaWReLNAql
	cLPx2pNxLr0YV57oSDjF/ARo15ySz6Nb9JS7R1BxhYkoUrWZSKIK2MypqE1FjfRrPut0I3hIeL1Fo
	ibCsPYxZWQDjo7JRlMJ5YZVZmG7BwwgUqKQqrgSYjV+0/tlbcJwey3ikk4G6qfecHbGN0wTD2RAHe
	k8zOXol3CvnlfjWaPZCLNZktrc+8qviB3PNpmumvjaxJ84JN4P8YcdNRBVC77ZjRrnCyI+oK57/9U
	Gp82kcWDqbwtiteEJRYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9A0-0001Na-74; Mon, 28 Jan 2019 15:49:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go99x-0001NA-AR
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 15:49:18 +0000
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DCB6321848
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548690557;
 bh=zb+nISiRI73A+qDN+B8FR5Vq4TOtoLMt5EaVYuqlw3k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=wzh4I8U3m/doHXMuJs+U+XcvJZn5zi1aPkPRWnb6CY8m95I8YmDIc6Uw7YnK81NYm
 Mfbr3fYfkAfw4k61uN3DmjPVgzP4Tri3fAkSCon1PPU5/oB2DRqsiSnF/2umkD+A4r
 s45+o7+CeYhBM3T85YQBs94xOMyjKEb3UIlybgHo=
Received: by mail-qt1-f172.google.com with SMTP id l11so18757257qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 07:49:16 -0800 (PST)
X-Gm-Message-State: AJcUukdgSZptr/mdMAYzBquk1BKgwukLj5Q7nYNj3abwxQONH2iC1hZO
 hsUYxvqvJGOfTTvZ96LsvDWPA8iKH2WeQXkH1w==
X-Google-Smtp-Source: ALg8bN6aAd3dUU8SPZKh3Ue5xmkf45/Ph2BX3YSHn6GYh7OyqXrJ80LErM0PgHIMouF7sP1yus5diSXLSD4ZYYMcubc=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr21234047qtd.257.1548690556001; 
 Mon, 28 Jan 2019 07:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
 <CAMuHMdUZHi87Dv=m4USocfQ60s6_uHmny5DvCVm+hZ98+ROvdA@mail.gmail.com>
 <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com>
 <CAMuHMdU3Om44R3wB69jeyHFER8syGDeJQsYd-pXqEKHBMZW2ow@mail.gmail.com>
In-Reply-To: <CAMuHMdU3Om44R3wB69jeyHFER8syGDeJQsYd-pXqEKHBMZW2ow@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 28 Jan 2019 09:49:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+5RpZ2WmxnFz-wa=NTGQ2=6MqjdysmXH8PTrRfke8-=A@mail.gmail.com>
Message-ID: <CAL_Jsq+5RpZ2WmxnFz-wa=NTGQ2=6MqjdysmXH8PTrRfke8-=A@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_074917_398238_FC50F40D 
X-CRM114-Status: GOOD (  26.74  )
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
 <devicetree@vger.kernel.org>, Kumar Gala <kumar.gala@linaro.org>,
 arm-soc <arm@kernel.org>, Sean Hudson <darknighte@darknighte.com>,
 Jonathan Corbet <corbet@lwn.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Grant Likely <grant.likely@arm.com>, Michal Marek <michal.lkml@markovi.net>,
 Frank Rowand <frowand.list@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 2:59 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Sun, Jan 27, 2019 at 4:00 AM Rob Herring <robh@kernel.org> wrote:
> > On Wed, Jan 23, 2019 at 9:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Dec 11, 2018 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
> > > > This adds the build infrastructure for checking DT binding schema
> > > > documents and validating dts files using the binding schema.
> > > >
> > > > Check DT binding schema documents:
> > > > make dt_binding_check
> > > >
> > > > Build dts files and check using DT binding schema:
> > > > make dtbs_check
> > > >
> > > > Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> > > > use for validation. This makes it easier to find and fix errors
> > > > generated by a specific schema.
> > > >
> > > > Currently, the validation targets are separate from a normal build to
> > > > avoid a hard dependency on the external DT schema project and because
> > > > there are lots of warnings generated.
> > >
> > > Thanks, I'm giving this a try, and get errors like:
> > >
> > >       DTC     arch/arm/boot/dts/emev2-kzm9d.dt.yaml
> > >     FATAL ERROR: No markers present in property 'cpu0' value
> > >
> > > and
> > >
> > >       DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml
> > >     FATAL ERROR: No markers present in property 'audio_clk_a' value
> > >
> > > Do you have a clue?
> >
> > That's really strange because those aren't even properties. Are other
> > dts files okay? This is the in tree dtc?
> >
> > The only time you should be missing markers is if you did a dts -> dts
> > -> dt.yaml.
>
> Found it: make dtbs_check doesn't play well with my local change to
> add symbols for DT overlays:

Now that makes sense.

>     --- a/scripts/Makefile.lib
>     +++ b/scripts/Makefile.lib
>     @@ -285,6 +285,10 @@ cmd_dt_S_dtb=
>              \
>      $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
>             $(call if_changed,dt_S_dtb)
>
>     +ifeq ($(CONFIG_OF_OVERLAY),y)
>     +DTC_FLAGS += -@
>     +endif
>     +
>      quiet_cmd_dtc = DTC     $@
>      cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>             $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o
> $(dtc-tmp) $< ; \
>
> Do you see a way to handle that better?

We need to have the code that generates these properties to also add
markers. Or we could drop the __symbols__ nodes on YAML output. Or
ignore the option when doing YAML output.

> Apart from a few expected issues, I'm seeing one other strange message:
>
>     arch/arm/boot/dts/sh73a0-kzm9g.dt.yaml: interrupts: [[2, 4], [3,
> 4]] is too long
>
> This is the interrupts property in the adi,adxl345 node in
> arch/arm/boot/dts/sh73a0-kzm9g.dts.
> Apparently the check complains if more than one interrupt is listed here.
> Is this a known issue?

There are lots of warnings... I've gone thru and checked some to make
sure they are valid, but certainly not all. There's probably some
cases that are too strict too.

This one is because this device is listed in trivial-devices.yaml and
you can't have 2 interrupts for a trivial device (because you need to
define the interrupt order). Looks like we have a binding doc for it
too, so we should just remove it from trivial-devices.yaml.

There are lots of '... is too (long|short)' messages because of how
the dts file property values are bracketed. This used to not matter,
but is significant in the YAML output. I have a dtc patch to give
warnings on all these (and dtc will give source location).

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
