Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33663C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:34:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05012086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HSikSibD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05012086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7j5aB7zjKiVsP1k6zxd8lFbG5Uk8O00GM6oAo6qAs0E=; b=HSikSibDesmBeP
	iSVEh544w/B20rrXrD2dZJaOgJsWNAnCqwrfhOlZiae3Du7s/4BEqH4XeBkVD2vywNPb/kST3DDMd
	E8FhWo7M85EOoV1BilZFJPu5VqSVQWoPe4FACqKWLsa6QMfliUja2J0Q6dSaP3nVckrSY3gPGvchx
	m9jtWAD0pXKx1TlfG0BS9P5W7PEwSOKv2qPuM68UJRkfNWz+JvaFSk9IM1p2qAhZQNq6No94m5eBI
	VfpBuy39aFFbgSwVc+qWiEw0YEaQs53J79VOBn+kjHkJ2Xu/VFTM2ORkDEFOO2eAICFk5B/PRDgYv
	SRjqM5adLXUOvjbt0gcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWz1w-0004iA-El; Wed, 12 Dec 2018 07:34:04 +0000
Received: from smtpbg297.qq.com ([184.105.67.100] helo=smtpproxy21.qq.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWz1q-0004du-2N
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 07:34:02 +0000
X-QQ-mid: bizesmtp10t1544599938t6vfhmnv
Received: from [192.168.117.185] (unknown [210.22.22.130])
 by esmtp10.qq.com (ESMTP) with 
 id ; Wed, 12 Dec 2018 15:32:17 +0800 (CST)
X-QQ-SSF: 00400000002000F0FL51B00B0000000
X-QQ-FEAT: uYVTUVBxCQ/Rrgam3KjbyMhQzTg7OsZMGe5ezqON2R0wgaLdyw5SfryopwMmF
 3uSplCa3eMODwbOX/4uPvIExjXEz5yevQx8XCfaK8c4TkcUXxPwplj0y54kj2Jkh9E+PYzg
 oOpo07e1HV+H1xFY7yDc3bkRNPX/NtPftGfthMKaGB5IzJ+gNoJ+wvVhl7QlGmmrIQzx98o
 HEfgWCHZ2mmduzyvZ3TWK28HTSFJxYNOBbRpFQyKFNHgoKCbJPS2PZ58Zcn0b7ovBnALlS5
 tdnXiFamrLok9tMntghTkaVmJxypmPuWGpOzKizGBX8JWX
X-QQ-GoodBg: 2
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: Built a neon version copy_page/clear_page is correct?
From: JackieLiu <liuyun01@kylinos.cn>
In-Reply-To: <CAKv+Gu-OWVd_oq-Zb49Kgsswr99oZ5pUOoTN5pkYPFmRDDWoOA@mail.gmail.com>
Date: Wed, 12 Dec 2018 15:32:17 +0800
Message-Id: <370722B9-5CAE-4420-9126-3DF805BC115B@kylinos.cn>
References: <BE9C50D9-738C-4EAD-9BBC-5D1CE6BC077E@kylinos.cn>
 <CAKv+Gu-OWVd_oq-Zb49Kgsswr99oZ5pUOoTN5pkYPFmRDDWoOA@mail.gmail.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: Apple Mail (2.3445.101.1)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_233358_110800_1E5DE7DD 
X-CRM114-Status: UNSURE (   7.53  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Andrew Pinski <apinski@cavium.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

WWVzLiBJIGhhdmUgYSBib3R0bGVuZWNrLCBtYXliZSBpdKGvcyBub3QgY29weV9wYWdloa9zLiBi
dXQKZHVyaW5nIHRoZSBkZWJ1Z2dpbmcgcHJvY2VzcywgdGhpcyBmdW5jdGlvbiBoYXMgYSB2ZXJ5
IGhpZ2gKQ1BVIHV0aWxpemF0aW9uLiAKClRoZSB0ZXN0IHByb2dyYW0gaXMgVW5peEJlbmNooa9z
IHNyYy9zcGF3bi5jLCB3aXRoIGEgd2hpbGUgdG8gCmZvcmsgcHJvY2Vzcy4gVGhlIG9ubHkgdmFy
aWFibGUgZm9yIHRlc3QgaXMgUEFHRV9TSVpFLCBvbmUgaXMKNGsgUEFHRV9TSVpFLCBuZXh0IGlz
IDY0ayBQQUdFX1NJWkUuCgpyZXN1bHQgZm9yICJwZXJmIHRvcCI6CjRrICB8ICAxMyUgQ1BVICBj
b3B5X3BhZ2UgCjY0ayB8ICA0OCUgQ1BVICBjb3B5X3BhZ2UKClRoaXMgaXMgd2h5IEkgd2FudCB0
byBvcHRpbWl6ZSB0aGlzIGZ1bmN0aW9uLiBNYXliZSBib3R0bGVuZWNrCmlzIG5vdCBoZXJlPwoK
PiDU2iAyMDE4xOoxMtTCMTLI1aOsMTU6MTijrEFyZCBCaWVzaGV1dmVsIDxhcmQuYmllc2hldXZl
bEBsaW5hcm8ub3JnPiDQtLXAo7oKPiAKPiBBcyBmb3IgY29weV9wYWdlKCksIHBsZWFzZSBkZXNj
cmliZSBhIHVzZSBjYXNlIHdoZXJlIGl0IGlzIGEKPiBib3R0bGVuZWNrLCBhbmQgcmVhc29uIGFi
b3V0IGhvdyBtdWNoIHlvdSBjb3VsZCBpbXByb3ZlIHBlcmZvcm1hbmNlIGluCj4gdGhhdCBjYXNl
IGJ5IGltcHJvdmluZyB0aGUgc3BlZWQgb2YgY29weV9wYWdlKCkgaXRzZWxmLiBPdGhlcndpc2Us
Cj4gd2UncmUganVzdCBhZGRpbmcgTkVPTiByb3V0aW5lcyBmb3IgdGhlIHNha2UgaWYgaXQsIHdo
aWNoIGlzIGEgYmFkCj4gaWRlYSBpbW8uCgoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
