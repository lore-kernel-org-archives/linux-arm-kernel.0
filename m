Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F200BC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:35:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F4F2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MMR3MTWE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhayHQp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F4F2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QX3TE34Qkx0F0Z2w+/BlMuZj7kjeIDxSMmvAnVGfo9g=; b=MMR3MTWEFVMVJx
	3ZUxR8r5vUpa0qEXoiDXIO1z/vS8WqhvKrHr5n2UybLb/ukeuykjg1oix4S3yKDcURw3pTfGT3LzN
	3wApiKQi2cinVxFZ0lGAkJzaiGSZyQ5A3LIYtqmJ/5RtTyPu0jg5LXHvezHKwvdOI0l/Le56uIAEm
	WvHfkyv8DkGoCEfxqhVfkROAlTIB3ZDDAPLcwjZCass0gaDFavYPtAD2HGD63U9hJBGsHHrOBcymz
	qn11qOMWONi+5+bBC+zY60PW3PDqWIIQBJDmZzd6Kor2fUzVdyMEVP4X9lm7ylfWeax9jXMDwtaco
	mAv7FqKOvnJVvcoMD2lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go8wH-00030S-PI; Mon, 28 Jan 2019 15:35:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go8w9-0002qW-4r
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 15:35:03 +0000
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D4AF12177B
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548689700;
 bh=NZmE/2MZuC2Pg/w/22LZvSE7CCI06iRQKfA1qY1cgu0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=LhayHQp6GYG7uw8Zd5CbicwmBepg9ykEKPLIvCHzl7aD2Qj4WGmPGOukJ1DVG0HRD
 YRb1vyEQz8kVB7eoTVMxP2Rhn4w5kOwkH9g/a6YNTMp0jiygRcaRbVDJCIBMUYxcJ9
 PcJW4pHFFont0kUcymbL9rK4B55h8nKSOKHGpRO4=
Received: by mail-qk1-f180.google.com with SMTP id c21so9592428qkl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 07:34:59 -0800 (PST)
X-Gm-Message-State: AJcUukegPUvTvWk8WfCNFbd1WCFf4pcDQAhayzt8Lca7p4OTfR27aI2M
 BMYOakeD9IZgvaxgalXj3c8nDgjtOMewCplWxg==
X-Google-Smtp-Source: ALg8bN7/6xUWddlpOWTZGyOMvMZN+9ik8FtdIbA1p+CzxDg9H/QULhFgM1PqM4cJaz5SKqu8x4tT/ivAdUkyr38+528=
X-Received: by 2002:a37:a483:: with SMTP id
 n125mr19292602qke.184.1548689698974; 
 Mon, 28 Jan 2019 07:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
 <CAMuHMdUdGvBUX7EsOrwJM4_LzR_Pe2exJ1Pfo48Vt5_scrdy0w@mail.gmail.com>
In-Reply-To: <CAMuHMdUdGvBUX7EsOrwJM4_LzR_Pe2exJ1Pfo48Vt5_scrdy0w@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 28 Jan 2019 09:34:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKG8d+yONY2ikeiCaORYBfWhLe_rAsir11R8zRAD84MmA@mail.gmail.com>
Message-ID: <CAL_JsqKG8d+yONY2ikeiCaORYBfWhLe_rAsir11R8zRAD84MmA@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_073501_577843_95648969 
X-CRM114-Status: GOOD (  18.19  )
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

On Mon, Jan 28, 2019 at 3:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Cc: linux-doc@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kbuild@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> BTW, what are the CONFIG dependencies for this to work?
> E.g. defconfig on x86_64 fails, even after enabling CONFIG_OF:

I generally use allmodconfig which enables building all DTs.

Yes, there's a dependency on CONFIG_DTC which isn't always enabled
with CONFIG_OF. Maybe it should be. The only other solutions I've
thought of are either always build dtc or make the targets conditional
on CONFIG_DTC. The latter would only change the error message.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
