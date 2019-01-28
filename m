Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648A4C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:01:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBE8207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NiiolcR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBE8207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1X9FH+ZgiTcRrumzt7s0TB1ciSTF3PQ6HlU/JoTk7ng=; b=NiiolcR3XBpgAK
	DvO61NgL8Cpaac2ZELR6YkKQo0DYdBDpza0IcXTkZTugHazlwr4pn21nlnLqqLcVbpgziviBwZXWW
	fORq+QBfJwL4gUH1Z4eYFTlGlEixXMBuBxso/MRNFpRiybxreFZgX3ihk3DCXNHa2S9KTGyVLGUgV
	DSVxOhANOAQseY7Cly7Xrsf+7hTtLCpaSJlMik5oLhAXK/7BmlQf+OlEW5YJpPgdfrw0kg9Mce0Nz
	4y7nQhU4sT2xneVZSqyru4YILiqP4GSTCRiyKrkFdLOj88EUmZe1pMUD35z5zSNA7gQyP2/csupmI
	Qblc+3im8mJlnPqoZcnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2nG-0007Iu-8M; Mon, 28 Jan 2019 09:01:26 +0000
Received: from mail-ua1-f65.google.com ([209.85.222.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2lO-0004ce-8e
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 08:59:52 +0000
Received: by mail-ua1-f65.google.com with SMTP id p9so5328600uaa.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 00:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MWXadM6v1/BrjCPM0KXC31G3yYpSsxrtCBcUvwcG1D8=;
 b=bdHTkIThIppcB+Y8CRPyXxMF9Wpuw5xn/c11tLzog8XBt4RYrXkAgZOuwi0H4Jy7Nq
 nzbVvSK6W8URpWDBfOC/9vPgw8YySSfnoXSU3uwckQxAzdkf9j+KdvWx0qKKMbNXyjsk
 6GS3hhPtxhmoZBpk6fvREKtqThw7VRwQ830IKzVw2uYZATjgUMHMGsuwyDO1i8JKKIPJ
 AI8JlKePe7xoO/z700EaF21c0fwLbpZX07aIcL90jdsa0h3Hw5XHx37UPYWt2zziTRxj
 3wq0CE2ZaOinSzbUkyRSUMlrH5lKODWZ+pzcIDQ8Gi79lrRshnucYCt3bFBh+FLoj/RY
 c7bg==
X-Gm-Message-State: AJcUukeDIK2qbCbAsAhHPuXWjexu5Ks7ShocySkUpHJ4j/cjk6Qal7e8
 0bEl8Fb58ejtkpLqRpToniua6wQsIr9zlpe4lEQ=
X-Google-Smtp-Source: AHgI3IZCtxnlqEb43WDzFI4/ibLeSYAnaqLRjvAhFCOKh3TgiAmEZ4Zzoj0/nmPt+UCqpb2z7ffEYeRjE4eQi+VGVdo=
X-Received: by 2002:a9f:2726:: with SMTP id a35mr4943200uaa.75.1548665968589; 
 Mon, 28 Jan 2019 00:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
 <CAMuHMdUZHi87Dv=m4USocfQ60s6_uHmny5DvCVm+hZ98+ROvdA@mail.gmail.com>
 <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com>
In-Reply-To: <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Jan 2019 09:59:16 +0100
Message-ID: <CAMuHMdU3Om44R3wB69jeyHFER8syGDeJQsYd-pXqEKHBMZW2ow@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_005930_639166_DD942DBB 
X-CRM114-Status: GOOD (  19.42  )
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

Hi Rob,

On Sun, Jan 27, 2019 at 4:00 AM Rob Herring <robh@kernel.org> wrote:
> On Wed, Jan 23, 2019 at 9:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Dec 11, 2018 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
> > > This adds the build infrastructure for checking DT binding schema
> > > documents and validating dts files using the binding schema.
> > >
> > > Check DT binding schema documents:
> > > make dt_binding_check
> > >
> > > Build dts files and check using DT binding schema:
> > > make dtbs_check
> > >
> > > Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> > > use for validation. This makes it easier to find and fix errors
> > > generated by a specific schema.
> > >
> > > Currently, the validation targets are separate from a normal build to
> > > avoid a hard dependency on the external DT schema project and because
> > > there are lots of warnings generated.
> >
> > Thanks, I'm giving this a try, and get errors like:
> >
> >       DTC     arch/arm/boot/dts/emev2-kzm9d.dt.yaml
> >     FATAL ERROR: No markers present in property 'cpu0' value
> >
> > and
> >
> >       DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml
> >     FATAL ERROR: No markers present in property 'audio_clk_a' value
> >
> > Do you have a clue?
>
> That's really strange because those aren't even properties. Are other
> dts files okay? This is the in tree dtc?
>
> The only time you should be missing markers is if you did a dts -> dts
> -> dt.yaml.

Found it: make dtbs_check doesn't play well with my local change to
add symbols for DT overlays:

    --- a/scripts/Makefile.lib
    +++ b/scripts/Makefile.lib
    @@ -285,6 +285,10 @@ cmd_dt_S_dtb=
             \
     $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
            $(call if_changed,dt_S_dtb)

    +ifeq ($(CONFIG_OF_OVERLAY),y)
    +DTC_FLAGS += -@
    +endif
    +
     quiet_cmd_dtc = DTC     $@
     cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
            $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o
$(dtc-tmp) $< ; \

Do you see a way to handle that better?

Apart from a few expected issues, I'm seeing one other strange message:

    arch/arm/boot/dts/sh73a0-kzm9g.dt.yaml: interrupts: [[2, 4], [3,
4]] is too long

This is the interrupts property in the adi,adxl345 node in
arch/arm/boot/dts/sh73a0-kzm9g.dts.
Apparently the check complains if more than one interrupt is listed here.
Is this a known issue?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
