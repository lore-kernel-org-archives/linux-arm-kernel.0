Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1CBC31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:44:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EBB21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CTz9jHJq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukQfKm8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EBB21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fao04roT1xTKtl+HI9XraI8dcFXLCZGQRwQbmjDJ0p4=; b=CTz9jHJqlXADxD
	d80wY088JIuea/7XukAGG3hsWLD1hAaxNehErtqA8B8RVV0e8WTJQrrG9dFtDvq8HRnxKRI+Vm6Yy
	wfFCKajvBc3QbSH0Hq9ovBLXHNCWpcYvLPa/nyuHI3OLojE/UCrazOZUAw60cw/puSI7MEP2j+KkU
	LGMMbkA5h7JHMmNMEhVlZtgLR0UHhQ3qzh0vOwqveZw1BdxFPX+ZCjgx+nF/7/72mUsl80R3eFHHN
	8QlVNsxU70Hew+KZ7HlLZglqa03nTQCDYMGlQ3IHFebavc5h++X8UAEvwOW4vSHz8N712StKzHQdQ
	spTcgrw8Q04CZKsfwj7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gleZ3-0002ec-UY; Mon, 21 Jan 2019 18:44:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gleYz-0002df-1e; Mon, 21 Jan 2019 18:44:50 +0000
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0572521736;
 Mon, 21 Jan 2019 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548096288;
 bh=WkBPCGNsdmn4jUhxAXGoZLrFy2EOGBTLPTLOWLTc7Nw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ukQfKm8OCoVpXwwuS7QE4vGrQMxA0Q+R+t7u+Cl0gJlmAGeeF3jsIPzsITocDS+gX
 jHRs2poRKOtbXC0TEcXhBGcSnpo1mu6pEaMthQAJ8ptG+hpR+q5cMEAy5dcF1/SwK+
 OLnjuhqlujJKMJN0IWQSqpdLQNoPyiQqgy3E1XDE=
Received: by mail-wr1-f47.google.com with SMTP id v13so24599388wrw.5;
 Mon, 21 Jan 2019 10:44:47 -0800 (PST)
X-Gm-Message-State: AJcUukelIq6C4OC4mn+lwuuXnYSfnkwxT7zOFVNPlM7ycSLt8Jg1u1Ec
 EzSXJCm5NXi+xmgMIjpj8UrLc8ylgbJU8Lms7mc=
X-Google-Smtp-Source: ALg8bN5jhLVM7PhuAyOsnPvXiFgHqX1g/kuXwBtzPZxKMWJHYa11vtn8xHyCLRMHpDn/srbc4qfsdmcu7tYK/jdu2tc=
X-Received: by 2002:adf:b243:: with SMTP id y3mr30303350wra.184.1548096286455; 
 Mon, 21 Jan 2019 10:44:46 -0800 (PST)
MIME-Version: 1.0
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190121171019.GA2903@bogus> <86imyhapl9.fsf@baylibre.com>
In-Reply-To: <86imyhapl9.fsf@baylibre.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 21 Jan 2019 10:44:35 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpgZDEdKFH4ZLqxtO60unxXRJoXNsGugNT=oojHDMp+3g@mail.gmail.com>
Message-ID: <CAGp9LzpgZDEdKFH4ZLqxtO60unxXRJoXNsGugNT=oojHDMp+3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
To: Loys Ollivier <lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_104449_099620_56FB2B2D 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 9:29 AM Loys Ollivier <lollivier@baylibre.com> wrote:
>
>
> On Mon 21 Jan 2019 at 17:10, Rob Herring wrote:
>
> > On Thu, 17 Jan 2019 17:54:32 +0100, Loys Ollivier wrote:
> >> Add binding for Mediatek-based GNSS receivers.
> >>
> >> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> >> ---
> >>
> >> v2:
> >> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> >> Moved current-speed as an optional propertie.
> >> Removed the status line in the example.
> >> Added "mediatek,mt3339" compatible.
> >>
> >>  .../devicetree/bindings/gnss/mediatek.txt          | 39
> >>  ++++++++++++++++++++++
> >>  1 file changed, 39 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> >>
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Thanks Rob,
> If there are no objections by others, I'll stop sending these two patch
> (1/4 and 2/4) and reference any new patch serie for 3 and 4 as depending
> on those two.
>

Hi Loys,

Thanks for adding the first GPS device driver. It's really nice to see
more device drivers added to upstream support.

Do you mind send the series again with Cc linux-mediatek@lists.infradead.org ?

Sean

> --
> -L
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
