Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9FFC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:43:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F12B217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lzMhkAvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F12B217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/KWKO4NUgYZhxt7uN7fes6kUsqZwiLeEa4O7TIK47es=; b=lzMhkAvl47VNGv
	BOizO+oSDrzM2yr6m7ra6kH5D+la73YGPTXW/Gay0cbBJITSXpvcuo0LqvX+cZtgtyJLSXSw8KaiP
	010d6M8GC+AnUSxqTutE4F/b3L4wpmuJgBHS+fkE/dfEFEFwxU4dDbEhrdyLPTv/1kwz2OcoqsjBs
	uBfqtXsz/dfA5CettLyk7x8jtf/DLokdu87K50QKe19sI3PfoYTez+ZiE1TwW6nq14e3agW5wXHM9
	9WjaS3/0b2FFDAe+sSv5enhWlyX2fP+wPLUAc8Bnv6m8V0LK16E2WLN7ovNIDIVYziKEnpIid/49p
	J4TJYLyBjUIyVGnsgINA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3SB-0003sS-24; Mon, 28 Jan 2019 09:43:43 +0000
Received: from mail-vs1-f67.google.com ([209.85.217.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3S5-0003rX-Vl
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:43:40 +0000
Received: by mail-vs1-f67.google.com with SMTP id x28so9336535vsh.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 01:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I7v2CVhzSApSnN73x2sP5/c9efgR0kyTQcHVcX3dt8I=;
 b=FpKPnb5csxDfxlr+7GRXoyGthV2dHXNy9U5H9MhTH6kv+5VmJWFRFz6bzrCHkQqd0t
 rcxJd5N7ispxH+Ii6NU7swY53CyQTjJlvrgQ6t6B+wDHIx/nF6QLSzYGUSN6sCQ8D0+x
 5I1kS5zkZVH5KuaKQJSnJmBFJwdbNSuaEUN6dE9i/suIcfTcCLgzYKzezKY4fE5L2oah
 gvadONYIAzTdYaVV2E6Cto7CRsWl4f0HNLlbHvk6hl9KGshu5GO46RvRtKGqGaz8Xpg/
 hNlBO8n1opVFZfGkHYd3oQDbw3v7wkgLxGnG5F/9VFEj4lassYsjplYASmyp599VB49C
 0NzQ==
X-Gm-Message-State: AJcUukdkmwMwr5U8NFdueWLKvSdiYZ/jBjL5TvFsrMA6caW74W7EnSXB
 en5JpS4jdpXgSI3/jSySz9r498oOcBozn8VZLvU=
X-Google-Smtp-Source: ALg8bN762N4hfLRHQtO9IsXp0QGWHGsVqfaF50zLAbLpKMuStIzjLEcZvyXnYM8xWjxpj+QEIGLDs/D7L8pc0VRBDvk=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr8815146vsm.152.1548668616811; 
 Mon, 28 Jan 2019 01:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
In-Reply-To: <20181211202406.27721-1-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Jan 2019 10:43:25 +0100
Message-ID: <CAMuHMdUdGvBUX7EsOrwJM4_LzR_Pe2exJ1Pfo48Vt5_scrdy0w@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_014338_016911_A4DD822F 
X-CRM114-Status: GOOD (  13.84  )
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

On Tue, Dec 11, 2018 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
> This adds the build infrastructure for checking DT binding schema
> documents and validating dts files using the binding schema.
>
> Check DT binding schema documents:
> make dt_binding_check
>
> Build dts files and check using DT binding schema:
> make dtbs_check
>
> Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> use for validation. This makes it easier to find and fix errors
> generated by a specific schema.
>
> Currently, the validation targets are separate from a normal build to
> avoid a hard dependency on the external DT schema project and because
> there are lots of warnings generated.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-doc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

BTW, what are the CONFIG dependencies for this to work?
E.g. defconfig on x86_64 fails, even after enabling CONFIG_OF:

$ make dt_binding_check
  SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
  CHKDT   Documentation/devicetree/bindings/arm/primecell.yaml
  ...
  CHKDT   Documentation/devicetree/bindings/trivial-devices.yaml
make[1]: *** No rule to make target
'Documentation/devicetree/bindings/arm/primecell.example.dtb', needed
by '__build'.  Stop.

Obviously it does work for arm/arm64.

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
