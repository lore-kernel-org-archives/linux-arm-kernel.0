Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41BFC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:44:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD40D2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ud+Eg9yF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="MIQ8d5j8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD40D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OsNdICabWV0Y7sYab5d/ituzQPrPeGcxZlzv7f/pxmg=; b=Ud+Eg9yF93ayT+
	BZsl3v6A0xdO57ZVeRorcWlOh1JAqzAFlDfGqHk346IH/8OtOiVKWUaw5h06BMS5+Iszzh87/uvSV
	PLlvwoZtq2C1BlDggFAURz61tHHG2DvEobf88K4RdIwXo8zGZdm5v0MMxozQZGQl4LK72X//eyjpi
	vbAtIOxCm0x3nIIeBGGhQy638GMpuPlYy1+6vWEOkHQPEwIY+ZtzxKMUKII51CWUT5LTAuGcZclSV
	cZrAC2niWo+VYzSNwLTvSvJO2ETvTJCC4AnwULWLh/kCqEcTfWl35smvFZPV3bZr9z3AOLfNUbcRs
	y1h8SqCfXzzqhifaAQIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTv5B-0004FM-Cu; Mon, 03 Dec 2018 20:44:45 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTv57-0004Es-Ex
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:44:42 +0000
Received: by mail-it1-x144.google.com with SMTP id h65so10768437ith.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=amibJ2RgkeUa/mIclqlTzMw95d3bOJv6DE0nVJDBvaY=;
 b=MIQ8d5j8eeWr8RKEPwqFqHG/96ma6wIEKBlXYD+X1cU+o9dLaF5t3hbLDdk0WnO37j
 MCM7cLfM3tRyXkajjX3bl/t6rRCn54YiXZSglJg8hZBjtx+d987hDWJ9fWtLrchez3Wm
 p7HeJ+Bmhb7AI4ASTPnTltOQLLx5NbouTQG3i0jGnn66cktzC2HpXG6w8VOVpSBUY+r9
 i+gUVZjgDWWclTm3ZpP4WFb35EmuPeJsO3VS8L9aMrvZphQzg8WKNqgDOek+p+gFUnQL
 smb3vEYatFriZkBxYxoFbOZU/UMD8WvC/HlOR+KIyUy6Wv6siBUW27g6lGL9/73iY/EE
 uedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=amibJ2RgkeUa/mIclqlTzMw95d3bOJv6DE0nVJDBvaY=;
 b=mY75UtMLFpcPUOVtqcngAYt/6MFa2K3ISQN4B5AihYAbNDQkb4uOQA4tYyYE4xCai2
 M9HZBkhNUcs3zQVOJWUMWr4PPaLCFYmI/0Vel/nvd2ikwvc/8drhFb8nKNpa4HfjZN/x
 vadZ0AbZRO5KbQFW6jNaB9rW7WwX8192R3d/o+1wJQcOGsqXDI4iCh93L3dweebEPPtJ
 7tFJ2NrNZz6uMB49G4ZzHPZ/iiZZeNZG1f7olhf+ykHUKfjJKxNb7YUrG0HR8Uj48Nw8
 b6jsydp3ZzfFQSY/4594aPKJ92tHkXZNDUmwqfjMSOtRpKEcAI4s/x0R7XFrNUprtW9c
 JPYg==
X-Gm-Message-State: AA+aEWbiQ2kOP29LdLwPvbhj33pnWog68WavsjbvBHHkLLIaiAx/TFqJ
 0ZtpfiBU6C+9hURMHFidNWHlasWI7MhpNyP64gO0WA==
X-Google-Smtp-Source: AFSGD/VWhPg5DIJX1EOL+YaHa2R3gBPI0r5NsRja+u1IMmhEPdRByrNt5aD5idsaeMcl9p4/F5PNifyx97LTA6wxhBE=
X-Received: by 2002:a24:2104:: with SMTP id e4mr8867805ita.59.1543869869981;
 Mon, 03 Dec 2018 12:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20181203191248.13067-1-robh@kernel.org>
 <CACRpkdZMf+HRu7T4ggzfjV-XktyQpQoKkrEDCmNjz0gxsk8JxQ@mail.gmail.com>
In-Reply-To: <CACRpkdZMf+HRu7T4ggzfjV-XktyQpQoKkrEDCmNjz0gxsk8JxQ@mail.gmail.com>
From: Olof Johansson <olof@lixom.net>
Date: Mon, 3 Dec 2018 12:44:18 -0800
Message-ID: <CAOesGMjtw1Pgd=XcrjoJ1btJrsU2qr+-oFtCqe59COyyOyQ72w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: realview: Fix some more duplicate regulator
 nodes
To: LinusW <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_124441_553908_3B833248 
X-CRM114-Status: GOOD (  12.79  )
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
Cc: Rob Herring <robh@kernel.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 12:39 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Dec 3, 2018 at 8:12 PM Rob Herring <robh@kernel.org> wrote:
>
> > There's a bug in dtc in checking for duplicate node names when there's
> > another section (e.g. "/ { };"). In this case, skeleton.dtsi provides
> > another section. Upon removal of skeleton.dtsi, the dtb fails to build
> > due to a duplicate node 'fixedregulator@0'. As both nodes were pretty
> > much the same 3.3V fixed regulator, it hasn't really mattered. Fix this
> > by renaming the nodes to something unique. In the process, drop the
> > unit-address which shouldn't be present wtihout reg property.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Arm SoC folks: are you applying it directly like with the last
> one?

Yep, just did (but email didn't go out yet, I tend to batch them up).
Revisited and added your Reviewed-by though.


Thanks,

-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
