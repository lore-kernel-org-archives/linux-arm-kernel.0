Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D115DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:18:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845F72081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CHZt5D6q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xakBUG63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845F72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TTHiSCImSu8m4ORMKe2KhVOLyXrNnSBHguRYY4nWNLM=; b=CHZt5D6qbSElVW
	uq22Rqoy3Bw/2+A3q4uniU5UjeN4TXMfmj5Lk+IXSkzO1lyyAbNX3utLk80aiS4lRe+h3RRKJB/aF
	iMiJxIh2cBhr71j0e7H1X4rq77vuJbcYJsK6RZyGjQLi83DuAXaLgUpCgEWzn9xFhHzuDNvfXRbge
	DWpPjuOk6BWm9tma/I8I39dZpN8EADIdTj+7gKmyT942r2VUoJuxvOjOC5LPWJ05yM/VmhF4YzQxC
	k5lGpmvPm/+Uj/gDHxH1AwZLyMQbWFg1lbz2GXZo0VuT+FdlGIYMdJ2wpE3spgV0NjdkGMls3WMeq
	qe+tJYyXg6iI3Dlm/SDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUOe7-0000sX-42; Wed, 05 Dec 2018 04:18:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUOe3-0000rF-0e; Wed, 05 Dec 2018 04:18:44 +0000
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 755EB208E7;
 Wed,  5 Dec 2018 04:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543983511;
 bh=8hFPeaJ4NZs1xCUFjUmp3nPWEvkuJu8DlebMjLI3KWU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=xakBUG63thzntpcZPytkaVhU7we1d1JUSKnqxD1p9lC0Ff8HH2UkaX/WEyUUlYbyj
 zwb5QjH7q05xXP0+9YpJIk+9uJkelwdCRddFBLuPIZss5EUlYblDC8+uaqk2bbhmoA
 CXGxRIgvPYkrqelzI23iM7Alxr+RPK2nUOwAN3rw=
Received: by mail-qt1-f169.google.com with SMTP id v11so20857231qtc.2;
 Tue, 04 Dec 2018 20:18:31 -0800 (PST)
X-Gm-Message-State: AA+aEWYKssN3VKrMj8GS/NEopt+WpQ6u1hZ78Oe/8u4aIrDiYCAE9VuT
 37SRWgDb/zRXmHYVR4UOuTmRGUcjIqmueeiEFg==
X-Google-Smtp-Source: AFSGD/V01+InEWqTizzIInNBqkSOixfMH8Ewf368Pcckr0vw2Ad0e4cKwmByU2t30xL4CMpc3ghoXkkMCZuA1vWVR8A=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr22291715qtf.26.1543983510705; 
 Tue, 04 Dec 2018 20:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-14-robh@kernel.org>
 <7hr2ewbxd4.fsf@baylibre.com>
In-Reply-To: <7hr2ewbxd4.fsf@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Dec 2018 22:18:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+hZRJZZ1ZcOxZVXtsUs0013cP0fyf3A=_9J15WbzuUhw@mail.gmail.com>
Message-ID: <CAL_Jsq+hZRJZZ1ZcOxZVXtsUs0013cP0fyf3A=_9J15WbzuUhw@mail.gmail.com>
Subject: Re: [PATCH v2 13/34] dt-bindings: arm: amlogic: Move
 'amlogic,meson-gx-ao-secure' binding to its own file
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_201843_190122_06A5DA20 
X-CRM114-Status: GOOD (  13.57  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@arm.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 7:01 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Rob Herring <robh@kernel.org> writes:
>
> > It is best practice to have 1 binding per file, so board level bindings
> > should be separate for various misc SoC bindings.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Carlo Caione <carlo@caione.org>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-amlogic@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/amlogic.txt       | 29 -------------------
> >  .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 ++++++++++++++++++
> >  2 files changed, 28 insertions(+), 29 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
>
> But this isn't really related to the schema series is it?  If you
> prefer, I can just queue this one separately via my tree.

Yes, you can take it.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
