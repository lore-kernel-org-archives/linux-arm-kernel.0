Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E148C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:21:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704AD217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jbN1sAvb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ihSsC6Gw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nTijeqdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704AD217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=suu6sfSQRY08UYLdX06N3guQ27ftXyWzNyT4gCwMODQ=; b=jbN1sAvb3QwsfA
	e06yjVGng9XS0uKvvYfThkVX3s3RIwl6QpEL+Lqs8+noltaUqVvtCKMC500eLDeMRZDcCVmb1y/uK
	lRbHOMCPT8ovXJ4M3S5PBBqi/4j4U7WHG0vFvMgZH7xGOpPMs5H8SBpqQ57o+yqhJFHzsca8Ylv8T
	8sB9tRPj5tS6INndEBPpJCp3dFp92KsS9BgeXH7ruGyg8NMYwces2Z7yrKY+tC5N5564UQjNXPcX3
	9RKxAT44pdHc93xyN0N1Bwl6Dz6niRcliq/ZQ0KjWQ0z6PaHxh2Nn5FsMFeKpjMytv7aXm+c8+cMx
	FDfX/QyfWTqoHHGQtzrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvoTN-00006v-Jj; Mon, 18 Feb 2019 19:21:01 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvoTG-0008Q4-Ss; Mon, 18 Feb 2019 19:20:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 2F28760779; Mon, 18 Feb 2019 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1550517654;
 bh=FKs9GoTuE0katQgvbT+nWqLQ4yWk3UAeV0eWR/RsQRQ=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=ihSsC6Gw0QxMI5MpEEPc3Fm+jrMexlJKuu+Rjvpti/zORD5dlywrZ2YFVTW06zU8P
 DzkMU+GpGJF+6ljuhdFy5oO9CZ3KwY0gzutAtlHG4NJbBdswRRB/e7smkQr7mr+Gtl
 4//JtBFkaGTgC0Igxztk8wkND3uv4cvHkYMg63jU=
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi
 [88.114.240.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: kvalo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E555660740;
 Mon, 18 Feb 2019 19:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1550517653;
 bh=FKs9GoTuE0katQgvbT+nWqLQ4yWk3UAeV0eWR/RsQRQ=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=nTijeqdYPmkWKycQKI7SpkbO40N1gXlG+5P5p8TBmsz4+Zmc3muGbFYtY4/iAHRnd
 nHBgcKUiBaTLhYaZvgnRBN5wqIJQFpceyTbFcsV7ZajQXNf/dpL4um7o/au5uBCvLq
 WqZrecKhhmUAx0/SRj1ugtt2mWPTSb9cQKaTg9BE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E555660740
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/2] wireless: mt76: call hweight8() instead of
 __sw_hweight8()
References: <1550469571-25933-1-git-send-email-yamada.masahiro@socionext.com>
 <1550469571-25933-2-git-send-email-yamada.masahiro@socionext.com>
 <877edxt1f1.fsf@kamboji.qca.qualcomm.com>
 <87tvh0syq2.fsf@kamboji.qca.qualcomm.com>
Date: Mon, 18 Feb 2019 21:20:46 +0200
In-Reply-To: <87tvh0syq2.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
 of "Mon, 18 Feb 2019 21:06:29 +0200")
Message-ID: <87pnrosy29.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_112055_390142_7C301266 
X-CRM114-Status: GOOD (  16.34  )
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
Cc: netdev@vger.kernel.org, x86@kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
 linux-mediatek@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Kalle Valo <kvalo@codeaurora.org> writes:
>
>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>
>>> __sw_hweight8() is just internal implementation.
>>>
>>> Drivers should use the common API, hweight8().
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>> Acked-by: Kalle Valo <kvalo@codeaurora.org>
>>
>>> This patch should go to x86 tree along with 2/2.
>>>
>>> Otherwise, all{yes,mod}config of x86 would be broken.
>>>
>>> This patch is trivial enough.
>>> I want ACK from the net/wireless maintainer
>>> so that this can go in via x86 tree.
>>
>> Sounds good to me, feel free to push via the x86 tree.
>
> Actually, can you wait a bit? Felix just reminded me that we have a
> similar patch pending from Ben Hutchings:
>
> https://patchwork.kernel.org/patch/10808203/
>
> And it seems there are two instances of __sw_hweight8, at least in my
> wireless-drivers-next tree:
>
> drivers/net/wireless/mediatek/mt76/mac80211.c: int i, nstream =
> __sw_hweight8(dev->antenna_mask);
> drivers/net/wireless/mediatek/mt76/mac80211.c: int n_chains =
> __sw_hweight8(dev->antenna_mask);
>
> So we need to think what to do.

I think the best would be that Felix applies Ben's patch to the wireless
tree and I'll push it to Linus during the next merge window (via
net-next). Simpler and less conflicts that way.

So Masahiro, could you hold your x86 patch for a while until the mt76
patch will be in Linus' tree? That should not take more than two weeks,
I think.

-- 
Kalle Valo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
