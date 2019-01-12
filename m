Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD168C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:41:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD7320881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LDOpuyOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD7320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yOZjQ7pLAR8dtvy52crDqsUaDVUEdnz9Ur0FGO35msA=; b=LDOpuyOCHpP1rE
	cGvWODJO4AZiHejHwz+xZ5ZKzlp/h/AZ4jNKHI2T3yEmSreohx8upEzQcpGXvnhAtBhzhxGUK6d6+
	KTki8fGN+fH/RVWSqr28UeWjFRSzNf7RvHec+9oaGIz3gz+mQK1pwNtXU4gSVNSPgtMK1yMlwno6e
	TYC++K3NlFi5kI/lq4sJZMTOl3BAugl6ZVihKDERFbq+jYtxEPjkhX/thEydvsN10A1AVoMtsSGnX
	+EkBuoiVhutys+hbhiRN4nSnwiAwKi7Z+o+xOhCXhQRkxVEheI01oCN3jyOknyihDeoaRoXrKugG5
	VF9n1ojE7plAXF3NUiZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giGjH-0001d4-Am; Sat, 12 Jan 2019 10:41:27 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giGjD-0001cc-Me
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 10:41:25 +0000
Received: from oxbsltgw60.schlund.de ([212.227.220.198]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MDQRy-1gb9SS2V78-00AYP6; Sat, 12 Jan 2019 11:41:10 +0100
Date: Sat, 12 Jan 2019 11:41:09 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
Message-ID: <2056332188.370448.1547289669205@email.ionos.de>
In-Reply-To: <20190109235544.2992426-4-jeremy.linton@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-4-jeremy.linton@arm.com>
Subject: Re: [PATCH v3 3/7] arm64: kpti: move check for non-vulnerable CPUs
 to a function
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:NkEVyuRhBB3+Giz5nx3RkR/JlGYzKYoBEsS86FgMRln2tnLFED9
 ryTHdaWRzzjpLkawm96TGiKfPb+AQPYj6wN9HLmuT7QjBHnAOBkELdEfIZabbb/lr4ZEysH
 ne7dqRne1/XIIotwjSawTQng41mD07ZJylw8gYwrYMXf2n1JbpEcwboB91eA5SYjm8E0OYe
 9vqGFaKviCNvvO6Fy06IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ixru4GyGl/A=:Ks82qJrtapA+IE17xD8+Kr
 A9aF0bJMYKMl5es+pQJD1jVhAEVvT7RvUUcmr1pDNq9ELhzjHoqYNttDm4pQVs72UyeSq6cuX
 My7gj23KxHXcYw6yZVTVSqoGRdb4mIMbkkRP3QZl9EaO15ojNeLan/PjDIKaHl8bjCcs/GJvO
 PicVVR51UgI+1mxBHekUA0r6N6B7t0AmCX/FJEJTkR5V0e1bR8J8Ot2eFcomfCgRl98Vq+sn5
 q78gHWouNn5OtpSEjzzicyux1ZBtz7+U2ML5kqceomU1QyIu4BhFHue+LeoKl2OOCLahq7OBt
 Srxy7Q917PSLOM9861fj6srqGoMv4wUKXmAj8xUkt8fJKHQN9JIppxC1IvjKuK0U36n8xNALj
 UVmtHxBoy+kZDtjE7PxFT2KwB9L1JqnKKepAYVfBuz8ayihAqrLB0rkucyoR5ZK0CfTe4b8a/
 /9Fz82ODDIVuoyCFL+E292/eLZ82riBAO6lp1AtZ5hPAbkWNe/A9wdZ2M8VplEMfyhvyWmwse
 lW5wHVdipP8D6NjB2EujPUYt8QhTtoldbGc8csgFtcIr3koijYs3z/F44Wyx/ep/nwHDeQrXh
 +bgc5oFRbE55R6brSLspFsy9eSQAtuD525tLp8c7tZfRrl3tH0XtMY1QzmBHZ1+nDLmvaP2hk
 C7WMYobMZ3O8MB14S79hsThXW/1avWdTxPCqMlq6aZtdBmOA93M1QtRpa15bBvD5rdmCXEAd0
 Rh1Iujm/83k50cfMhVgl9gHmWgT0PJGksFqC83KZokY9aRbyxYU5MeHSDds=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_024124_038508_47F82D93 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
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
Cc: mlangsdo@redhat.com, julien.thierry@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, steven.price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jeremy,

> Jeremy Linton <jeremy.linton@arm.com> hat am 10. Januar 2019 um 00:55 geschrieben:
> 
> 
> From: Mian Yousaf Kaukab <ykaukab@suse.de>
> 
> Add is_meltdown_safe() which is a whitelist of known safe cores.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> [Moved location of function]
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

i only want to inform you that this patch doesn't cleanly apply against linux-next on Friday.

Best regards
Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
