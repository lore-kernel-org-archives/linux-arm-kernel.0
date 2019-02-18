Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7934C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:06:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D82217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rTl0O5+7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K/mNl1s4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K/mNl1s4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D82217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5u6ecAWEVswXTq+vIShZECHut9AXqzMvXLISHa4eqbw=; b=rTl0O5+75YA5gS
	Zu3IS3h1gu+f9A39lpgToHqHoUEKTvr4mY0BA4HsmLjHLwos1IfAoVm71CeJEbwvx6gbZguta93YF
	u8e7nYuCz2GXlKKLBnh5D19zyFhBl7rIoXPms6dICYxqjC+e5V6gU2Kdnv+cpPM8ffOoIXhZaZTDW
	nBsH5pxmQ/4YL6Y8yGMK7xVHUYvc7Q2sTqHfaJJi3qMa94Zbhm/53zU+cW9RndOwUSqMQV7qm+hLW
	Xb79UGfQXM1WKrKemOHo7sxZ5LHofb8VPPySLjcS8uMjc0NvUsZ7YNZk0aehy2zuSPFjpPOLRvoGt
	6FT0bXzTy3ZTyRfGEeVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvoFU-0003PQ-8R; Mon, 18 Feb 2019 19:06:40 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvoFQ-0003Oz-Cr; Mon, 18 Feb 2019 19:06:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id DBA4260779; Mon, 18 Feb 2019 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1550516795;
 bh=esPdABJBpGSqp931ZQiOXnlVd6J4TnHzDy08pTMrC9A=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=K/mNl1s4LJP6VfOQwStdcLZfeXVFuB8vMkIAyRaRXUEL2vmspI5JL6+Lwef9AjK6L
 4XZ83VCR+Y+aVqhi36Jc/X/yml7HrNs8eXD0zmwtGyQscJwG26FdVI0CgWIglMoHXd
 1vcdrH3sr5bA0AkaoFpouVqVpLlxdjs8dgjLMYHk=
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi
 [88.114.240.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: kvalo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B4CB260740;
 Mon, 18 Feb 2019 19:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1550516795;
 bh=esPdABJBpGSqp931ZQiOXnlVd6J4TnHzDy08pTMrC9A=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=K/mNl1s4LJP6VfOQwStdcLZfeXVFuB8vMkIAyRaRXUEL2vmspI5JL6+Lwef9AjK6L
 4XZ83VCR+Y+aVqhi36Jc/X/yml7HrNs8eXD0zmwtGyQscJwG26FdVI0CgWIglMoHXd
 1vcdrH3sr5bA0AkaoFpouVqVpLlxdjs8dgjLMYHk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4CB260740
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
Date: Mon, 18 Feb 2019 21:06:29 +0200
In-Reply-To: <877edxt1f1.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
 of "Mon, 18 Feb 2019 20:08:18 +0200")
Message-ID: <87tvh0syq2.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_110636_474882_8E45053C 
X-CRM114-Status: GOOD (  14.15  )
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

> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>
>> __sw_hweight8() is just internal implementation.
>>
>> Drivers should use the common API, hweight8().
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Acked-by: Kalle Valo <kvalo@codeaurora.org>
>
>> This patch should go to x86 tree along with 2/2.
>>
>> Otherwise, all{yes,mod}config of x86 would be broken.
>>
>> This patch is trivial enough.
>> I want ACK from the net/wireless maintainer
>> so that this can go in via x86 tree.
>
> Sounds good to me, feel free to push via the x86 tree.

Actually, can you wait a bit? Felix just reminded me that we have a
similar patch pending from Ben Hutchings:

https://patchwork.kernel.org/patch/10808203/

And it seems there are two instances of __sw_hweight8, at least in my
wireless-drivers-next tree:

drivers/net/wireless/mediatek/mt76/mac80211.c:  int i, nstream = __sw_hweight8(dev->antenna_mask);
drivers/net/wireless/mediatek/mt76/mac80211.c:  int n_chains = __sw_hweight8(dev->antenna_mask);

So we need to think what to do.

-- 
Kalle Valo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
