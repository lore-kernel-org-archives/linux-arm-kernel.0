Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CC7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:40:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB41520685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MVLc62Lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB41520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qWnZbzFKKL+UMkfRyjsE1hBaQZur8uZAuR/4zNwjgIY=; b=MVLc62Lbdn6lgX
	1ALbI8YG5VO0dImUvqrMX/rtg3cYDr8qm7oe3v/oaNeuGbikMJz0SqfX0Nx1jCPrzKb0CPGiOkIEB
	OzOrXYf2mF7Air/ftHsW7UeNnVooMakZ4KtO/P5oZ2fw14k9riBXDMkOtS+rT2Tz3DHNndgnj9uUG
	uyEvPDIsnZyhBd3JcoYpVCyd4yiav3CW3qgwzcwpeiWGakYtdxq1J9/7SggHQ3hGp9QFYxygbfJSV
	7WY904Q69mYwbBMmJ0UXawNHBp3dj85RBEgyHBDn+DM9tyrBmFFj7ubZrbZka2pgEWSD3GD1BlXfo
	HCxcyieWlnhMmwBPnR8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghcRF-0003vm-QQ; Thu, 10 Jan 2019 15:40:09 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghcRB-0002wl-0s
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 15:40:08 +0000
Received: from DGGEMA402-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 577BBD135CED6078CA60;
 Thu, 10 Jan 2019 23:40:01 +0800 (CST)
Received: from DGGEMA523-MBX.china.huawei.com ([169.254.5.180]) by
 DGGEMA402-HUB.china.huawei.com ([10.3.20.43]) with mapi id 14.03.0415.000;
 Thu, 10 Jan 2019 23:39:58 +0800
From: gengdongjiu <gengdongjiu@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: =?utf-8?B?5pKk5ZueOiBbUkZDIFJFU0VORCBQQVRDSF0ga3ZtOiBhcm02NDogZXhwb3J0?=
 =?utf-8?Q?_memory_error_recovery_capability_to_user_space?=
Thread-Topic: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
Thread-Index: AdSo+rtC3+98LQYESeSIe29UjvqzCw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Thu, 10 Jan 2019 15:39:58 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F202045437@dggema523-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.56.182]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_074005_241162_BC5678D9 
X-CRM114-Status: UNSURE (   6.96  )
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
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 kvm-devel <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>,
 =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Morse <james.morse@arm.com>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Z2VuZ2RvbmdqaXUg5bCG5pKk5Zue6YKu5Lu24oCcW1JGQyBSRVNFTkQgUEFUQ0hdIGt2bTogYXJt
NjQ6IGV4cG9ydCBtZW1vcnkgZXJyb3IgcmVjb3ZlcnkgY2FwYWJpbGl0eSB0byB1c2VyIHNwYWNl
4oCd44CCCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
