Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130BBC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:07:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D358520839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gvl5CQdy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mzqSbOCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D358520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DFw1ZZz49xGIghKXN2UpckWj+sB8S9MPnvuGvzObMGQ=; b=Gvl5CQdyjVDCUE
	M4KjIDxWixAucVGRMehlRmLI5xSmsMoSSm/bykKAExjg4gtBiyyWMyJQ2a3BSsrktux+9q7PPRog5
	WSB8dfJoM49dzZfyzN+gPaDHnK+ULxXE2wOvjYRTiFLbbBJGFztkJ/Z5yFXYDXKNrcrtRx36Cdqno
	puTIOxy3IC90+jlcY6FK6esphodggx52+ke09Ma0HKnbt/t0pfLSszPVLVwD2sww+WIiIKAvqUEa8
	G+WGEWTnx+3ven9X5e5Y/Sw1G6asZWrP5BkQ44tHE101MaboND4DAgn3O2/NcI1XXcG98KFvkZeqx
	xTk0fMhEmgAhxyEwW6CA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWurM-00082W-NV; Wed, 12 Dec 2018 03:06:52 +0000
Received: from conssluserg-06.nifty.com ([210.131.2.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWurJ-000820-Hm
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 03:06:51 +0000
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id wBC36AJH023775
 for <linux-arm-kernel@lists.infradead.org>; Wed, 12 Dec 2018 12:06:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wBC36AJH023775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544583971;
 bh=6N6RaQ3wOc5su8qLy+bJz8CBzbjrgjGBbfJL+Zs0A8I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mzqSbOCkOEqhbf4OQ0ewjDCoQoQA3IgGMlZn6sN4Ms0Dtjegs8WHUWfW5iVumz7EF
 WsAUNlQ6ZXf5IAqJZMnspq8yfyFQpF8NbOMDzQOEZ1lzjUNs+1Wov7ABnWEXpZQjDl
 F6stobTLy7H/XeLSRlyWCI2TTqqz8I58Ao2/PUvxoHjFRhnPLnCjRoBtSQRItqEILP
 +rrHSmsS5cfrnCPCrksPhcNT/WLjfOCH8qwbWcJW0F+tCgldZ0R29uGUnmJCtFShcX
 G4ADaFBvO9yHdlYyr/kmDxWAqrHYQXQTVl8lLCQ4HEfTzroBErKC3tTzNTu9SBS05g
 8wRKpdiJXrF+w==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id y27so10236648vsi.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 19:06:11 -0800 (PST)
X-Gm-Message-State: AA+aEWZOy+jssu86y+Lte5HIFfmENk8l23f6Q9jeer1NYqmrFGTBAXqq
 g9TAIEcLEzq83CTlxDGuxrp6AYcBtUx0jZnqaEs=
X-Google-Smtp-Source: AFSGD/VERKFbaF0SBtxWKtriGXKkGFdxuiwSlwd3i91soixgKZm5tqCgfSyRuHTxgC3c6MPKZTcle5pStFMzaQADVac=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr8404903vsm.181.1544583970188; 
 Tue, 11 Dec 2018 19:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
In-Reply-To: <20181211202406.27721-1-robh@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 12 Dec 2018 12:05:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkR-V+tuhSytcdEhvBX6wosKQBuWo57Qo7fqdxyGFq_Q@mail.gmail.com>
Message-ID: <CAK7LNAQkR-V+tuhSytcdEhvBX6wosKQBuWo57Qo7fqdxyGFq_Q@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_190649_802036_0D5EAA13 
X-CRM114-Status: GOOD (  14.16  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, arm-soc <arm@kernel.org>,
 darknighte@darknighte.com, Jonathan Corbet <corbet@lwn.net>,
 Frank Rowand <frowand.list@gmail.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Michal Marek <michal.lkml@markovi.net>, grant.likely@arm.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 5:24 AM Rob Herring <robh@kernel.org> wrote:
>
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
> ---
> v4:
> - Rework libyaml check and error message with Masahiro's version
> - Simplify build rules and dependencies
>


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thanks.


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
