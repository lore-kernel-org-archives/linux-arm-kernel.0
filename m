Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D36CC282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:44:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5E421741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C1BdDTic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5E421741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ovtktGu93eGnofxARb3upSagP9rKK6wmSk7vXmrL0gE=; b=C1BdDTicqfY2Sq
	qAWWFNiSal97mCgkryN/sCrAFpIjl/joardhQ3kaG41MkBpKhAaLeN9mEXjGOaGPLKiUBI49B4LU6
	HLwbFZ+wO4HBvula7SEIh++mmx4yrNNkWzwedVmdZ27MTdC4oLX+UZrAxkz5iwg0JdoeeboF8Yorb
	Pb+s1iMGPjZ9MFKM0zwyX3xwNEx3+ghOyW5YN56RdgOrMDZ2p00dxQpql6Q/rjuq8jiHSTkBDRS+I
	pJynoGPkRpxp/QcIhB736QNaAbMA4i319l9d3i8SKp3iIKwAuytltwSAMDyIIz1u1LsGLljAkiiFW
	WR5H1xR6vFhhiDFQwJ6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go94v-0006g1-IS; Mon, 28 Jan 2019 15:44:05 +0000
Received: from mail-vs1-f67.google.com ([209.85.217.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go94r-0006fE-Cz
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 15:44:02 +0000
Received: by mail-vs1-f67.google.com with SMTP id e7so9992602vsc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 07:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x2wa+K5YNPI9+zY5xomP72xSduPXvimTTHXp1XsjO7E=;
 b=HyyHyjedfWZJLN6AvqnMyA5FU/jnfoOp6Ck0MgjMSuT9Vh0lplIJgl2mta8abxGt4F
 Fs3wE5pXeWZbL9vFdFh7f+GPvtORxwjDwaBq7gGomenYZ3A1Jk/DgTcEDQA9Uy6JHOTB
 EtRTaEZGn5tyI35jTyFOuLibBi4Dc+IkBTy13UgJekfHjYTpL5DiilUxslifl+kl6+az
 xG3ENgDt11Uo78tDABlAClOHGXbW8NUILjNn7/848AwWALcMjrlSrvvH3W5p7tsPVJCI
 O2Jtuos7foJpxHXAT3t1rCv9BKN4dObnUf8kXM2k18IM1GcfcJIYSXCDmLv6aRpwN7n5
 JdAg==
X-Gm-Message-State: AHQUAubvRR7ROcv8tVAummjTg9R4G/ufatgDCgTOD4oBP9ewQGRVHXBe
 Fb2IVZbaAEAnOTgwpJFGx+vzjBfu/XjPwYh1TvJh0g==
X-Google-Smtp-Source: AHgI3IaCNqFqxYF5jcFRcCRr3F8u3p45e8vOxEGJ+OqOd1kuIKX0RovOS/tgzMJSBqB2qpmVtJ11sRlLqYSVlIaIAgE=
X-Received: by 2002:a67:c202:: with SMTP id i2mr148070vsj.11.1548690240249;
 Mon, 28 Jan 2019 07:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
 <CAMuHMdUdGvBUX7EsOrwJM4_LzR_Pe2exJ1Pfo48Vt5_scrdy0w@mail.gmail.com>
 <CAL_JsqKG8d+yONY2ikeiCaORYBfWhLe_rAsir11R8zRAD84MmA@mail.gmail.com>
In-Reply-To: <CAL_JsqKG8d+yONY2ikeiCaORYBfWhLe_rAsir11R8zRAD84MmA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Jan 2019 16:43:47 +0100
Message-ID: <CAMuHMdWy2D-keyOuKtgCLe0_76qR74Jk7Aa=_FzxvEG7rfKpCA@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_074401_441824_61A07817 
X-CRM114-Status: GOOD (  17.90  )
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

On Mon, Jan 28, 2019 at 4:35 PM Rob Herring <robh@kernel.org> wrote:
> On Mon, Jan 28, 2019 at 3:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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

> > BTW, what are the CONFIG dependencies for this to work?
> > E.g. defconfig on x86_64 fails, even after enabling CONFIG_OF:
>
> I generally use allmodconfig which enables building all DTs.
>
> Yes, there's a dependency on CONFIG_DTC which isn't always enabled
> with CONFIG_OF. Maybe it should be. The only other solutions I've

Oh, didn't think of CONFIG_DTC.

> thought of are either always build dtc or make the targets conditional
> on CONFIG_DTC. The latter would only change the error message.

Making the target conditional may make it more obvious to the user
what's going on. Cfr. "make modules_install" giving a nice explanation
when CONFIG_MODULES=n.

Thanks.

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
