Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B450C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:03:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D9C223C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eq6K6iOY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmmRIXpB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb7c9liU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D9C223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y26FeYPT56fe+KB1TZTB3dHFJtfutayh5kLGtXKJssA=; b=Eq6K6iOYASs7vq
	WJLR8uAE51FACuZYmfIEhP7FU6y7XyastwPBT1q4h9sEDiiKXjqM0Yd2frfNlAvPQWbbFenqeMRzM
	R3cimgxOU4WxUBrb5/QtEexy+yWH3d0u942IZNFsn4Pv50MlbCewMgSJe5DQMCVkBZ3uL37rFO035
	9isHzgHSva4TCzu5dtnELvH8uOoIgjojY+qykw3bTlatbzcBwVMavMTta3ADTkq3D7gQcN9eDrxI1
	V09U+9TYv+Qr40oUxNUVyGJwHJUDSoQVlb+Ib/A0OcYNxRpZZgC6GkoMnBb5/gW4CJblMKvyFa8ej
	H97/knHB9QwhLgk/Jo8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUw76-0006C7-9W; Thu, 06 Dec 2018 16:02:56 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw61-00066R-Kr
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 16:01:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dGsnISE4FIz3KQANOsJodhs5OOKMBBgVf9JyNqy91KY=; b=RmmRIXpBOzf6z0VvG8Owa8EZW
 GD1kY1RCwb9jzOI2JvKEGcvG25+s/Kv7ATtEkjR8iSPPWgL8wBWtGjTbt9vimT7acslw8r03x44Zh
 9Vr0Lzu9Saq/lb7sqxO29asB5//rZty0JRo1LSck+7atOX03WnBt+MHBsP7scy1erYHSvprOJjF6U
 VMt1F3Pv1VnhxtR8yDY0wBRaBYsf8S1LwPjzo28dZ4gwLRmvkdqsQkK9sbkfuNYXi1sEj4TI9Lezs
 r6K6K/MyvzNMjS9N0hnYmGgpm95NZZVK1zhQoNozfwf4b3IovPIJP3i7wvYihvslHPh3QaubXmCWg
 /VoSgDQzQ==;
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw5z-0008WI-7w
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:01:47 +0000
Received: by mail-ot1-x342.google.com with SMTP id 81so876150otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dGsnISE4FIz3KQANOsJodhs5OOKMBBgVf9JyNqy91KY=;
 b=Pb7c9liUJiikpZkKTCPiEfgLwt/PLPzsQunOw8ew3+Lg0nErefYWMfrTyFftv7Soj1
 vnKvRjjpGTXaAPewKbn0rRp8V0WgBTlTWZHB74zIFemgWfXGy2GJQhvLTuTa6mWP/Cfy
 NudE5H/KKO9zujAfmsn0EXV31mg3DUga6A2mQFpIggfYfkGGIuo9tknd4/iV2hQKURHI
 KH0XVFj0ifaBaVmp1bvHVgjQ/MApP8ajWOkoikcbJrxgAnTqyZNOVq2OKz6VOk821LVW
 Dnx8/uPDgdUIu6NaW9yWQ5JwSPyYwuCLJKhsDw/FSpYHjc32MH1qdbsInYtXCczHzNoj
 0QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dGsnISE4FIz3KQANOsJodhs5OOKMBBgVf9JyNqy91KY=;
 b=dWHMMZa9/VSfgUd7L1xcAz4ZJC2j8AJ05oz4U2L64EF03C6bF4ZNC9/zjdFrDHJjYc
 JABa6p0zmgeCdWBh5R0gHRhUv03AzhdSjNaU/KE4fDpCE0rYFxvqMjTzswBeX2m+ZX6R
 BO4c+m8TlNWUlva6GooDUJUt58W4u2wffmLdmu73bejq6LASs3qrkRi48SkPEDGZz9eT
 iY8kQPQ/vLglvQSSazHpEyCZ7NwnglsmTjFlSRe+HGz0qJlBi8S36mR5Of0ZR8fQkxS1
 d4pAr4w81YiFnSvFyHpJBgoI9x4hPo3nMmzj10+bL/wG19mx0gFBjvu0gHLAcd4Wauzv
 AUcA==
X-Gm-Message-State: AA+aEWYaq4dbmdkZQrFfgFgmyfPHYaCi4el6NCAMS+P2CLlkf2GwoSUW
 Rf3xiuV+Fc7WPO4IE1dFg9fv/lyD7ZKDyX1k7zo=
X-Google-Smtp-Source: AFSGD/U2HcJuBLCF0Rzz5fG7dqBs1l/1mPF6ZVMRqidGWc0mp5Dd0H5KvetGCI3cpTmsyUeIizr8pwJ5E6bBb8Z91zY=
X-Received: by 2002:a9d:2c65:: with SMTP id f92mr18615316otb.18.1544112091176; 
 Thu, 06 Dec 2018 08:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20181206115053.7665-1-ganapatrao.kulkarni@cavium.com>
 <20181206123420.GA26473@arm.com>
In-Reply-To: <20181206123420.GA26473@arm.com>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Thu, 6 Dec 2018 21:31:19 +0530
Message-ID: <CAKTKpr6QHWO=G6cMS8WFM8HNpTv4ZMZeieT8QoBSYfZYBiCWqQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] Add ThunderX2 SoC Performance Monitoring Unit
 driver
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_110147_284303_56593DA2 
X-CRM114-Status: GOOD (  14.34  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, "Nair,
 Jayachandran" <Jayachandran.Nair@cavium.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 suzuki.poulose@arm.com, LKML <linux-kernel@vger.kernel.org>,
 Robert Richter <Robert.Richter@cavium.com>, Vadim.Lomovtsev@cavium.com,
 Ganapatrao Kulkarni <Ganapatrao.Kulkarni@cavium.com>, Jan.Glauber@cavium.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 6:04 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ganapat,
>
> On Thu, Dec 06, 2018 at 11:51:24AM +0000, Kulkarni, Ganapatrao wrote:
> > This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
> > The SoC has PMU support in L3 cache controller (L3C) and in the
> > DDR4 Memory Controller (DMC).
> >
> >
> > v11:
> >       Updated Patch 2 with minor comments.
>
> Thanks. I've pushed this out on my perf/updates branch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=perf/updates
>
> but note that I did make some spelling and formatting changes to the
> Documentation patch, as well as removal of the event descriptions (they
> should be part of the perf tool, as is done for the other system PMUs).

Thanks Will.
>
> Will

Thanks,
Ganapat

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
