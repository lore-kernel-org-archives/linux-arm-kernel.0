Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C43C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:10:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F212084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ex/4uN+4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lYedVqQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F212084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B2O8J2nihRV57oHf3ppBfA362Z0/BRtuknsSqcY2VtA=; b=Ex/4uN+4JB5t2a
	FU1BgguJMlI0If7NRxlRS4afYzFfPGIw4FZfoDVKP/uEaKzp5pIvWiy0DfhdWt7CjmDyDsdf1qcwS
	p5g1FYi2xDTqInhc4FhLdC9f32IhF/lHOSZvjcEG+b2uzIH3erEKivY057XtKOqaRW6G0xw3quebk
	71aF1nshAXJFY3kHtkFm8Wq8dr7h7CMx3cJwoDfQgzI0mEgfWcdBHd7jZBcEBfIWSFNBMiVlTA8Dp
	Z5TDB07SR3wzyYMowTCMOioTNcILfsFe5fkdd2AfDVzo5LH6kHBK4/yrrkOj3hiwpmZRhwnVar9rw
	7NsarBsc6aNN/2EvJlxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWqE3-0008Ro-Mq; Tue, 11 Dec 2018 22:09:59 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWqDz-0008Qg-6K; Tue, 11 Dec 2018 22:09:56 +0000
Received: by mail-oi1-x241.google.com with SMTP id y23so13379096oia.4;
 Tue, 11 Dec 2018 14:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eI5IGdZLbihoM1JpOCBJmDZFFsM5cSSnLSPPgCxAhxk=;
 b=lYedVqQZ3hqB7908uJavjK0ActWFskQNhfRu/+U8sFPEicionz+F4zXfkoBWB7MTMv
 nrpTV249UI8OByccj+DNfZJ5xnMuEXGYE4F36ZwtOALheYYEtd8ornGZyAwNvsXKw6nB
 OI0ufxjbfmFQ2JDHaFLSAK/hmv7+senKJrKhyeNvWpWXDUKkiGwVzJTxaRz3wdVjD4hp
 NmDDJmKtN2Azl/2TUzYP8vVcdYr2sm4kq5PLlO/n+p+KBi5IIn4sybbYSwuDiUNimUMq
 4W1erBZT5etP3t4ANa42ek3Q6kczPK65Xkl1UxFHoN7f7V6QWiugpOfFGoudCfCkNS82
 WdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eI5IGdZLbihoM1JpOCBJmDZFFsM5cSSnLSPPgCxAhxk=;
 b=HzHJUXIaNvt480AfwXnzt3e5aSVc+HQJjvLNYWayJGLhoFAWnjOzigZx48ZD/496LS
 vv/DRqA1BjIu7VU8erKtfP7g6NNyFVCsnugq3AfZfKKrKaE39vdxMgPFjCDfIe5tP0bS
 4nbpgYfYu6ADGCKSYdgWvQIwZ6e2b13NAnW+/LRBVDunzpU6ze10AjXUDyiQb21pJcEb
 ses2+o2PXTQ7qQRvUH4V1FOrCVJ87ORobOCtEsx0tQGtBBFY81W12q0fpX5iHe7VrywV
 U2nhk/D5QS1FtwFLJsBWhscvwHcltcQKl9obLqQLjyJedKIKXAYdvh1HnCuywWnXEVAF
 WWqw==
X-Gm-Message-State: AA+aEWYVzm/0hNla2KQxtMRZ8wUjibIaeicEros19DBupksGsRDCT5a3
 nrmPkW87uVNp5GmJi7NPPBfvt8je/PNqG/HceO4=
X-Google-Smtp-Source: AFSGD/Wd/Z4vd02AtSBwuc1xmWjmPFLv8kqXsfTFz7+LnpbfgEAjbmcFHJYvFjMlfJ1RZphs6yginarIxzFkIPWxYhY=
X-Received: by 2002:aca:4ace:: with SMTP id x197mr2461612oia.129.1544566181810; 
 Tue, 11 Dec 2018 14:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
 <ba3e4fef-7a18-8c7d-e0ea-05c541b29913@baylibre.com>
In-Reply-To: <ba3e4fef-7a18-8c7d-e0ea-05c541b29913@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 11 Dec 2018 23:09:30 +0100
Message-ID: <CAFBinCBYBAqtKp_edgs6b44MpOhc-iN_FwR425bkU4xirGQKvA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: meson: add the APB/APB2 busses
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_140955_236492_47C30666 
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
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Neil,

On Tue, Dec 11, 2018 at 10:16 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 08/12/2018 17:50, Martin Blumenstingl wrote:
> > This adds the APB bus on Meson8 and Meson8b as well as the APB2 bus on
> > Meson6. This is preparation work for adding the Mali GPU which is
> > located on theses busses.
> >
> > Meson6 seems to have it's APB at 0xc8000000 instead of 0xd0000000. The
> > region at 0xd0000000 is called APB2 or A9_APB and it has a different
> > size (256k) compared to Meson8 and Meson8b (2M).
> >
> > Addresses and sizes are taken from the Amlogic 3.10 kernel sources:
> > - Meson6: [0]
> > - Meson8: [1]
> > - Meson8b: [2]
> >
> >
> > Changes since v1 at [3]:
> > - re-send the patches but this time don't include the old patches
> >   which still had a typo in the patch description (ABP vs APB)
> >
> >
> > [0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson6/include/mach/io.h#L61
> > [1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8/include/mach/io.h#L53
> > [2] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8b/include/mach/io.h#L53
> > [3] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009424.html
> >
> >
> > Martin Blumenstingl (3):
> >   ARM: dts: meson6: add the APB2 bus
> >   ARM: dts: meson8: add the APB bus
> >   ARM: dts: meson8b: add the APB bus
> >
> >  arch/arm/boot/dts/meson6.dtsi  | 8 ++++++++
> >  arch/arm/boot/dts/meson8.dtsi  | 8 ++++++++
> >  arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
> >  3 files changed, 24 insertions(+)
> >
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
thank you for taking the time to review this!

> But frankly I'll squash the meson8/meson8b patches with the mali node patches !
I didn't do this because I realized that there are different busses
between Meson6 and Meson8/Meson8b. so I wanted to have a commit
message which describes this.
if you prefer I can still squash the Meson8 and Meson8b patches into
their corresponding GPU .dts patch but I would like to keep the Meson6
patch (as I'm not planning to add the Mali GPU until someone can
actually test it on that SoC)


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
