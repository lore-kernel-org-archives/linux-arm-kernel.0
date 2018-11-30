Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F69C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:15:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B2920863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u0rxrftf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B2920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dsgDVCE4kDd9fJFov5C0oONsC2gZG8aDLru+W1KKqR4=; b=u0rxrftf1Z8BlQ
	ok3UxpXFUK/3LMngmMvnG7vQZCoQYZO12MvixqbY0HjRzOvVRATwEIIuZIrD8XwQONGpfY4Js8O10
	0JDB6MNiOMwzcM1rbfW2NOv5aWUuhAIMFZPeOX0AsPfuyMPgq+8ZXPm7DpwHRNL+9dOXHPwEdv3x9
	k9jZyfrU7i28tRm8N/44Vx6Jw3sr9VThHZHS76Z93y+CPRq9UfWVlwGJovcZF5AduClxMKPAvjty3
	WfYNsVeyMVL8qEdkj6WdxdiOLD0a2to09+ta7mQ3HwOpeU8V8Auerf1oZP5bl6Bz1XQIB8xD5LJId
	2nkdaGhFuEBB72UiWk/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gShi7-0001tO-5i; Fri, 30 Nov 2018 12:15:55 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gShi3-0001sx-9Q
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 12:15:53 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id CD1D513F8CE;
 Fri, 30 Nov 2018 13:15:21 +0100 (CET)
To: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Unexpected variation in SYS_ID_AA64MMFR0_EL1
Message-ID: <e2130285-6e51-f1c9-7b91-6b0467a15de6@free.fr>
Date: Fri, 30 Nov 2018 13:15:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_041551_481213_CDCB5F51 
X-CRM114-Status: UNSURE (   8.14  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On an APQ8098-based system, for cores 4-7 (little cores?), the kernel prints:

[    0.179055] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1.
Boot CPU: 0x00000000001122, CPU4: 0x00000000101122

TGran16, [23:20]
    Support for 16KB memory translation granule size:
	0x1	Indicates that the 16KB granule is supported.

Since this is a pr_warn, I get the feeling something is not quite right.
Is there something to fix? Is it a problem that the big and little cores
don't support exactly the same granule sizes?

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
