Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A1CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:14:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCCE217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F4omlvUG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mHzPx+VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCCE217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qV8znqT2JGizu0fiJ9W3rOgsSIabXWu9wsAWMsV7uec=; b=F4omlvUGHo2yE1
	HHmhZMYxSrbn4WPUulWJm3QUIB8G7zkhxDNhWrzxdPWihzlMGbsdWSoG5GDzYPXdZGV1yxQRilAD0
	plt6LSB+KgUnUUS2KcTEW9RyId9NecxvJS7k9qAR9S+H5hn5FuoLfOVwtcN4giMG4bD7XT9+KQces
	d4pWAl/0d+JcL7L7K67pcM1esLzSIYfOOcj8VAyMnUgwVVSYkkDG/DRUDEyhBUo3wDWqNa6sbpPCY
	SKQMzki4M/XXSOwM3MLpbgoTlib7pvvddllY/QYK8uE9cH4rqSkA13FeMnM5UCKO7cpk8bXs+rSAf
	0cLCPs75S2TImmR3jmNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvtzV-00071C-9h; Tue, 19 Feb 2019 01:14:33 +0000
Received: from conssluserg-01.nifty.com ([210.131.2.80])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvtzR-00070p-Jj; Tue, 19 Feb 2019 01:14:31 +0000
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x1J1E4uq028091;
 Tue, 19 Feb 2019 10:14:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1J1E4uq028091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550538844;
 bh=12GOMpHSdKq1T0/8pXwHzQ0yf/8DKFAjpoLne8aSI0A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mHzPx+VIf2tFY4/s0Sm+qhugjJTEsxEeUZh/Axra1Z4NUzg+Ao52uwCft1zCuKVtI
 F7Cgo54OA5R2jD2f1ueIAICY+bVX0mvjKozOLsDyO7GG1jb61brtgck+MIvEWeqttE
 IZNrvIPmM91rTMeE5XXo0vLWFVKoKp4Fm139wKOpe8ByUV93xTPSGbM+mUajA85+oI
 KQixEWdcYHzU/NzdpHhNJC8YHCt7510jDtHW4uAYm3H6ZHHea9qSPBk1+GSJ8KTGyp
 BHsPB+erA3qQnKfRUPCHzFVwjvLeiK93gcqzfZb3DyhRr+jnHMMXgH318dy8Ri6dCf
 9DPgnh496TQjw==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id s16so10779793vsk.4;
 Mon, 18 Feb 2019 17:14:04 -0800 (PST)
X-Gm-Message-State: AHQUAuaftnSL+4wS58pbJWTqvYXMuR2Qx9bJkNjhZfYDJznJCUQTZ4al
 nRfQW5fs2L49SobHfLS1ffQn1/U8J2BjfQITSdo=
X-Google-Smtp-Source: AHgI3IYS1xQosfLMLt7IfKYeSFA7qXgC47MIextseXf408cL7JsP6OXTuuKu9KtdSNby9Mke9GzxSDWPItmjzXLIlUs=
X-Received: by 2002:a67:c913:: with SMTP id w19mr13504171vsk.179.1550538843511; 
 Mon, 18 Feb 2019 17:14:03 -0800 (PST)
MIME-Version: 1.0
References: <1550469571-25933-1-git-send-email-yamada.masahiro@socionext.com>
 <1550469571-25933-2-git-send-email-yamada.masahiro@socionext.com>
 <877edxt1f1.fsf@kamboji.qca.qualcomm.com>
 <87tvh0syq2.fsf@kamboji.qca.qualcomm.com>
 <87pnrosy29.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87pnrosy29.fsf@kamboji.qca.qualcomm.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 19 Feb 2019 10:13:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQMgFXw=rtpdPNZ=xpLw-SiwKGAgM__Owvqd1EhTCUntQ@mail.gmail.com>
Message-ID: <CAK7LNAQMgFXw=rtpdPNZ=xpLw-SiwKGAgM__Owvqd1EhTCUntQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] wireless: mt76: call hweight8() instead of
 __sw_hweight8()
To: Kalle Valo <kvalo@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_171429_871931_BD39B3B8 
X-CRM114-Status: GOOD (  17.44  )
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
Cc: Networking <netdev@vger.kernel.org>, X86 ML <x86@kernel.org>,
 linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 4:38 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Kalle Valo <kvalo@codeaurora.org> writes:
>
> > Kalle Valo <kvalo@codeaurora.org> writes:
> >
> >> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> >>
> >>> __sw_hweight8() is just internal implementation.
> >>>
> >>> Drivers should use the common API, hweight8().
> >>>
> >>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >>
> >> Acked-by: Kalle Valo <kvalo@codeaurora.org>
> >>
> >>> This patch should go to x86 tree along with 2/2.
> >>>
> >>> Otherwise, all{yes,mod}config of x86 would be broken.
> >>>
> >>> This patch is trivial enough.
> >>> I want ACK from the net/wireless maintainer
> >>> so that this can go in via x86 tree.
> >>
> >> Sounds good to me, feel free to push via the x86 tree.
> >
> > Actually, can you wait a bit? Felix just reminded me that we have a
> > similar patch pending from Ben Hutchings:
> >
> > https://patchwork.kernel.org/patch/10808203/
> >
> > And it seems there are two instances of __sw_hweight8, at least in my
> > wireless-drivers-next tree:
> >
> > drivers/net/wireless/mediatek/mt76/mac80211.c: int i, nstream =
> > __sw_hweight8(dev->antenna_mask);
> > drivers/net/wireless/mediatek/mt76/mac80211.c: int n_chains =
> > __sw_hweight8(dev->antenna_mask);
> >
> > So we need to think what to do.
>
> I think the best would be that Felix applies Ben's patch to the wireless
> tree and I'll push it to Linus during the next merge window (via
> net-next). Simpler and less conflicts that way.
>
> So Masahiro, could you hold your x86 patch for a while until the mt76
> patch will be in Linus' tree? That should not take more than two weeks,
> I think.

Sure.
I will resend 2/2 later.




-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
