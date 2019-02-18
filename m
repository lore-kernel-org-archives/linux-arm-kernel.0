Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66829C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:50:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3791E2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uy9y49os";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lr8Js8ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3791E2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G4cP7mYwjv5uIi6Yw/mn/nemsF0e0VNnNUIuoBSOegg=; b=uy9y49osL9FxBK
	te77rmiMoNiZw0DFdk7bnBabuagA/291p4UifumlrTFK6OT42+KAlLl+zggQ1kj9XJLc1IyoSIkzR
	UXC8zXT7eFAIP26zVRXbn8gxNi2XVlBxjX5l4ZneVU/ayucQ9qeofWr9eVpG3VV3E/LAkJn6AK4ES
	EhNhsxZW5gG+6spNFEJOJZwtdpZemHPqP9CtqGUOmWaiQZEj9t76uHz9TuDz9BLtilN7OKaiv647i
	7u4Vm6tAF6G9Tn2mOajKtUqjyQJKo1vKC/NYiUk31geoE2eALiKmWen0t7vLj+w3ZQBdXTOfPsPfB
	6A1cxWp1pus8TXjJNZSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqnZ-0001Mh-Oa; Mon, 18 Feb 2019 21:50:01 +0000
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqnV-0001Kw-6J; Mon, 18 Feb 2019 21:49:59 +0000
Received: from zn.tnic (p200300EC2BC7C7005C4C67E6EC0FFC5E.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bc7:c700:5c4c:67e6:ec0f:fc5e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C3991EC04F3;
 Mon, 18 Feb 2019 22:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1550526588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=uys+NyVWP2GvLyuFgTpEgdk6WtP+kp1DTy4+1DKVLVQ=;
 b=Lr8Js8ffE5Nze7xsrc3+Z3i07x783BhgCJwyJ+Tyk0D9aVC8l1qku3wnfmuVdj3beR5y4w
 hDEH7xoU3sse257OkNTRHHSc0AP2EkmifyeUEyJYeNYIY2V9cE+4Kg8V+5Ci3K76QMbqc1
 gqUCou8w/VG9eWowESXjI5P3p2WceY0=
Date: Mon, 18 Feb 2019 22:49:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 1/2] wireless: mt76: call hweight8() instead of
 __sw_hweight8()
Message-ID: <20190218214940.GI4265@zn.tnic>
References: <1550469571-25933-1-git-send-email-yamada.masahiro@socionext.com>
 <1550469571-25933-2-git-send-email-yamada.masahiro@socionext.com>
 <877edxt1f1.fsf@kamboji.qca.qualcomm.com>
 <87tvh0syq2.fsf@kamboji.qca.qualcomm.com>
 <87pnrosy29.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87pnrosy29.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_134957_380061_C1A45EB2 
X-CRM114-Status: GOOD (  10.60  )
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
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Ingo Molnar <mingo@redhat.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org, Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 09:20:46PM +0200, Kalle Valo wrote:
> So Masahiro, could you hold your x86 patch for a while until the mt76
> patch will be in Linus' tree? That should not take more than two weeks,
> I think.

No hurry - I won't take it into the x86 now and queue it for 5.1 because
it is not something urgent or fixing a bug or so. It is a cleanup and as
such it can surely wait for 5.2, I'd say. Unless there are other aspects
which I'm not thinking of right now...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
