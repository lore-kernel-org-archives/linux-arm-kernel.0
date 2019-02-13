Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA0AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:17:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FC621872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vp4lCn4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FC621872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v6ewoBTrMVAgMmRoBpcBG9Dswvd61OD/6jystUVtHD0=; b=Vp4lCn4lTIHyGA
	XJy2PW9r1Z5N6Ds9C7IidW6S6+nqsxon9BLcG9ZW7lxq+uienJAvticq21bWocalMvqxb867Lpucc
	2F/aCZRt5lozzVY2cOQRzglmVwKLb6t0iXx3FBWI5C/q4TvPMhaoZQ7khUim1DtuOPnShVXq5qG2V
	kfwcq6+V72pyHB4ARKsepjrCyUUiTKE7MuatPzxkQOajLbKvgrUrRAuQ35U2Rj8QUeX6mXy38R3Gj
	ohoz2cjVGVs+BIofpdBJRQ6NMTc3dUeHEc8D8M8Ap3tqw+1kVXYgrkrbERd2G2OXVUh+ntZ8A8Bne
	7CZxDoa8Ltpj3xQ7ouug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2qh-0004OP-V2; Wed, 13 Feb 2019 22:17:47 +0000
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2qd-0004O0-JV
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 22:17:45 +0000
Received: from belgarion ([90.76.35.80]) by mwinf5d43 with ME
 id cNHa1z0061jkVcS03NHanc; Wed, 13 Feb 2019 23:17:38 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 13 Feb 2019 23:17:38 +0100
X-ME-IP: 90.76.35.80
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: arm@kernel.org
Subject: Re: [GIT PULL] pxa for v5.1
References: <87womhub5h.fsf@belgarion.home>
X-URL: http://belgarath.falguerolles.org/
Date: Wed, 13 Feb 2019 23:17:34 +0100
In-Reply-To: <87womhub5h.fsf@belgarion.home> (Robert Jarzmik's message of
 "Sat, 02 Feb 2019 22:35:06 +0100")
Message-ID: <87bm3ftjsx.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_141743_922789_A9D8CA37 
X-CRM114-Status: GOOD (  14.02  )
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
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Hi Arnd, Kevin, and Olof,
>
> This is the pxa pull request for 5.1, totally negative diff stat :)
> Can you please consider pulling ?

Hi,

This is a small reminder for this pull request.

Cheers.

--
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
