Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD70C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:07:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F79217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tzqSvpIl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pon7C6so";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZXnqq/mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F79217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qx57NOv2igOVeUtTTHcLfkqSsWahol8Bedh7NxSK+gk=; b=tzqSvpIlrSsXpe
	95OUDqP9eYrgcBDjnFLXpgOiPHKkGJK7HMnbQbjf1m8/FSTwM4so8b2xOY7w6pLqojaXnCfOpvXaH
	jEi/zLzTYVTDImUhju+/Iv4bOnW9/9IJV6H+xsD9LFrz9QLi8m+ZMOOddJuGpzBtu1gltjLJ9O+Dk
	GJwLgTFirqmL3kJ6Z1O+9N6yrwEu90lrRmsoy+dE0WwaiJJdQVzXaznQVLq0dZP2t5zUoDLhTLvcE
	t9v4iga1YoS3xsqnUqUh++NIXopt6nzti7Rs6mTO4t91M460xWmdiA0KrMqw3+JwGu+7cPEIAJRst
	OTBm/1WUci+bubsH2SbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvwgU-0004QS-Vd; Tue, 19 Feb 2019 04:07:06 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvwgR-0004Q2-Fd; Tue, 19 Feb 2019 04:07:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 143E0607DD; Tue, 19 Feb 2019 04:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1550549222;
 bh=uGVscGjQWC/OWhL7Z0iOTmLrqP/qoK8+9ZkjZ8C43BM=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=Pon7C6somlLT8MvPhjFlnoGcMVaWSSzK0917xz20W7aIlNxIB1QOe9KZV29+mZlTV
 t1oclUOyWx5h2OoqLLs05Elv12gHi40B3M7O69Efz8byrD0uSkqC7o5YHqtturlNbp
 jyfH9qC7vWBnbuUc/RjFWElI3iPNfCrktm8oF5QU=
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi
 [88.114.240.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: kvalo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F703607DE;
 Tue, 19 Feb 2019 04:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1550549221;
 bh=uGVscGjQWC/OWhL7Z0iOTmLrqP/qoK8+9ZkjZ8C43BM=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=ZXnqq/muos6OXLaGdJKEDSMuxWkMSt5fMt5AiOjzHffWHaINR9QBRRQ9V/cx9OMLz
 pxj7UO2fOgPNA4pO/jWk/7wtmXJ7XiPfQzP8jRnWvzEoEa5w5bHis+TIGXof08T445
 pA8fOkp4+Qwf+Sr3hk8lbntI8nmamfR9JC5VaTV8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F703607DE
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
 <87pnrosy29.fsf@kamboji.qca.qualcomm.com>
 <CAK7LNAQMgFXw=rtpdPNZ=xpLw-SiwKGAgM__Owvqd1EhTCUntQ@mail.gmail.com>
Date: Tue, 19 Feb 2019 06:06:54 +0200
In-Reply-To: <CAK7LNAQMgFXw=rtpdPNZ=xpLw-SiwKGAgM__Owvqd1EhTCUntQ@mail.gmail.com>
 (Masahiro Yamada's message of "Tue, 19 Feb 2019 10:13:27 +0900")
Message-ID: <878sycs9pd.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_200703_560670_6421756C 
X-CRM114-Status: GOOD (  18.63  )
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

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> On Tue, Feb 19, 2019 at 4:38 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Kalle Valo <kvalo@codeaurora.org> writes:
>>
>> > Kalle Valo <kvalo@codeaurora.org> writes:
>> >
>> >> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>> >>
>> >>> __sw_hweight8() is just internal implementation.
>> >>>
>> >>> Drivers should use the common API, hweight8().
>> >>>
>> >>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> >>
>> >> Acked-by: Kalle Valo <kvalo@codeaurora.org>
>> >>
>> >>> This patch should go to x86 tree along with 2/2.
>> >>>
>> >>> Otherwise, all{yes,mod}config of x86 would be broken.
>> >>>
>> >>> This patch is trivial enough.
>> >>> I want ACK from the net/wireless maintainer
>> >>> so that this can go in via x86 tree.
>> >>
>> >> Sounds good to me, feel free to push via the x86 tree.
>> >
>> > Actually, can you wait a bit? Felix just reminded me that we have a
>> > similar patch pending from Ben Hutchings:
>> >
>> > https://patchwork.kernel.org/patch/10808203/
>> >
>> > And it seems there are two instances of __sw_hweight8, at least in my
>> > wireless-drivers-next tree:
>> >
>> > drivers/net/wireless/mediatek/mt76/mac80211.c: int i, nstream =
>> > __sw_hweight8(dev->antenna_mask);
>> > drivers/net/wireless/mediatek/mt76/mac80211.c: int n_chains =
>> > __sw_hweight8(dev->antenna_mask);
>> >
>> > So we need to think what to do.
>>
>> I think the best would be that Felix applies Ben's patch to the wireless
>> tree and I'll push it to Linus during the next merge window (via
>> net-next). Simpler and less conflicts that way.
>>
>> So Masahiro, could you hold your x86 patch for a while until the mt76
>> patch will be in Linus' tree? That should not take more than two weeks,
>> I think.
>
> Sure.
> I will resend 2/2 later.

Great, thanks!

-- 
Kalle Valo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
