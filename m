Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98914C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:01:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F81821903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B4cEIPfU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnHAFGAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F81821903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T2kVgx8/fbinqcx9d3a4LhTyj8rOksxLsuNvY7+RnYQ=; b=B4cEIPfUqEZ/hI
	EfLp7LgMGzuJlXPhCxCLkKIgmOHrTTZVGbj/N8+rczlpnebO1eTIs071KaCxMJUUEZUQweTK5RW7e
	lcGC485eIYWEjVbtQJdtdOX1T/U5i9UfRba3JVqSS97UJy2QYm5sZyqAtckYc3cw7tl80qlRfd5oX
	FsE2aenMKN1vGdP3IvfsW0wX93xxHiXcUkg6YcVlXBNsaFmwwfXv8mPINw4sy+DguAH60a/aPp/x8
	jJpCBOXtgYRJb6z4bVBqmuEWzvj1tBboJuhhYC/7DAYiI2fiaNXc2EiinIA06t4MBOt2gHKGg5DNL
	o8yX+XxyDWJURuOo/jQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnagW-0001rp-B1; Sun, 27 Jan 2019 03:00:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnagS-0001rM-Tk
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 03:00:34 +0000
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6C0B621925
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548558028;
 bh=VQZ9p5D0SjFbMo7+hJBCYP4JqQfOx1wEolKfSx+wZwI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OnHAFGAZgzXIyZqT+g4jjiJKbgFOMZ5tVZGorAneODvYXAbnF++XmCbdha+HsDAfL
 QG4hvFL6gZ3ryA+6bxYykz9SJ57Z8mdvtnVyx+tnYCQudufzFJA+iNSoV+2n/wfA2e
 eEQNNkcSNRCWK7Y0O0iD2qU+STnoObBx6AYj2qSQ=
Received: by mail-qk1-f171.google.com with SMTP id q1so7617882qkf.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 26 Jan 2019 19:00:28 -0800 (PST)
X-Gm-Message-State: AJcUukdk8kuOMY4AcWrik69w77ZijLMC+Mj5nmKsbNkFmrP5bfi/TleY
 5DBzq5Ww1YUoNX7BOSR189v1bhf71FjUhI0uxQ==
X-Google-Smtp-Source: ALg8bN4jf4q7gzMidj4mMrXVcLr7bxoeZvYw6qytdthD58afqiisLh4HxHLUZEeywpFTlVr/F9bqu62NPHmWrvLDXuA=
X-Received: by 2002:a37:a483:: with SMTP id
 n125mr14681058qke.184.1548558027423; 
 Sat, 26 Jan 2019 19:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
 <CAMuHMdUZHi87Dv=m4USocfQ60s6_uHmny5DvCVm+hZ98+ROvdA@mail.gmail.com>
In-Reply-To: <CAMuHMdUZHi87Dv=m4USocfQ60s6_uHmny5DvCVm+hZ98+ROvdA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Sat, 26 Jan 2019 21:00:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com>
Message-ID: <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_190032_982309_82E2D7C8 
X-CRM114-Status: GOOD (  17.66  )
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

On Wed, Jan 23, 2019 at 9:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Tue, Dec 11, 2018 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
> > This adds the build infrastructure for checking DT binding schema
> > documents and validating dts files using the binding schema.
> >
> > Check DT binding schema documents:
> > make dt_binding_check
> >
> > Build dts files and check using DT binding schema:
> > make dtbs_check
> >
> > Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> > use for validation. This makes it easier to find and fix errors
> > generated by a specific schema.
> >
> > Currently, the validation targets are separate from a normal build to
> > avoid a hard dependency on the external DT schema project and because
> > there are lots of warnings generated.
>
> Thanks, I'm giving this a try, and get errors like:
>
>       DTC     arch/arm/boot/dts/emev2-kzm9d.dt.yaml
>     FATAL ERROR: No markers present in property 'cpu0' value
>
> and
>
>       DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml
>     FATAL ERROR: No markers present in property 'audio_clk_a' value
>
> Do you have a clue?

That's really strange because those aren't even properties. Are other
dts files okay? This is the in tree dtc?

The only time you should be missing markers is if you did a dts -> dts
-> dt.yaml.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
