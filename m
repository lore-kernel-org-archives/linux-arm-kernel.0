Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E52C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:02:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7AC2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gb3DCEp/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fxYZgq7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7AC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:Subject:Mime-Version
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Erdd0mblvk0xgpj4ziaNlojxaCvo4aGzfz9LalSBOu4=; b=gb3DCEp/Q7O+/O
	rvjzG5WZPAOrHKQXy/o+Czgg4MQi3D4/KP9FgmxA/L5ycgNunwnW+fwZpog+WmnN90fMOFItEbgZi
	c72ADvWpRS1nP//HRd05MMLmi3q6kMloF0QwVoplLYDX/msZinU8uGzyiTyIyGUvdxLlkOZ2T56UH
	GiMPAilUwvk2xh8pbLzE1P7SarRQGzbvh2Oz7B3knAW0eYWO7dHME/ptP/XkNDFqJJ2bYP9EOyleC
	ARAPvD8Gixdf5cc1r4ZRiCDMCfyEqBX4n7gaif02fBHjCdlCeYafDsH8+UfGY/utX1P4egyjQ3r8h
	MI0qciH6MW3AoHg2fYTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWxbM-0005TU-0E; Wed, 12 Dec 2018 06:02:32 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWxbJ-0005TD-6P
 for linux-arm-kernel@bombadil.infradead.org; Wed, 12 Dec 2018 06:02:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=To:Cc:Date:Message-Id:Subject:
 Mime-Version:Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3jVv8DqO6bOLDbtwqinouV6Iuu7cCqnQqgvwW6MFbMY=; b=fxYZgq7bHIIFn6OydwmjtPk9S
 MadhoSpNwCxGQzu9XVoZbDze1+QdbhADdx0JkQbBJcSG57FFxo20AxN0NYLy3fUkj30PD7QVKoC7O
 dqcxOFS2lBtLsQzLTNdWAvUaHsqlroPyqQDoe72xTyavC/gHoN/Ld6//zdjcKmSclmMAh/BZ/C5Wd
 MJl0PZF6l1MBBgw057T/bU9VYy/86X032Zibbk7R40ALXdVr0ywAIE/MGZ/WyHgFqjYhyS5Y0CzRS
 2Chc5pADkBra4sVcyuCBjCUlxRAYwcMyIL7tapQy4EFwvAhUe3XtmHm2/9AkYuJKAa40uKQXl3Rvt
 gdlPQkA3Q==;
Received: from smtpbgsg2.qq.com ([54.254.200.128])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWxbE-0005XN-Bc
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 06:02:26 +0000
X-QQ-mid: bizesmtp18t1544594501tcaj7zno
Received: from [192.168.117.185] (unknown [210.22.22.130])
 by esmtp6.qq.com (ESMTP) with 
 id ; Wed, 12 Dec 2018 14:01:41 +0800 (CST)
X-QQ-SSF: 00400000002000F0FL51B00B0000000
X-QQ-FEAT: 2PHmmy4qbuIIpnEBlAKFZ4p/hW84lV8w8EtrdgNg0RJ+HMOoi3G3YCTrW/DVS
 /Vi3IyFoQcdTmb7f1r8wGpDFZmuWJ6389XGkXkIoQLpfSkCpxso1bbNrPFHzHdM76sdYHIu
 H4ctd0HMB1+Om79l/9lyCb7DLGqWmzcmUsOUD+nUqb0XYD0BpGy8+ZQaUjeig36RvlvIn6h
 DU+3x4Voe6t7PxMStgQZ1PtVbT/+AKvg6srYrblwi5lZJgEwYuv41JJnCbSU3mvSgc8wqNf
 cLAihfLd8hMyfbzv3K+favMuw=
X-QQ-GoodBg: 2
From: JackieLiu <liuyun01@kylinos.cn>
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Built a neon version copy_page/clear_page is correct?
Message-Id: <BE9C50D9-738C-4EAD-9BBC-5D1CE6BC077E@kylinos.cn>
Date: Wed, 12 Dec 2018 14:01:40 +0800
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: Apple Mail (2.3445.101.1)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_010224_905251_A1F66DC0 
X-CRM114-Status: UNSURE (   4.93  )
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

SGVsbG8sIE1haW50YWluZXIuCgpJIHdhbnQgdXNlIG5lb24taW50cmluc2ljcyB0byBidWlsdCBh
IG5lb24gdmVyc2lvbiBjb3B5X3BhZ2UvY2xlYXJfcGFnZQpmdW5jdGlvbi4gYnV0IEkgZG9uoa90
IGtub3cgd2h5IG90aGVyIHBsYXRmb3JtIGhhdmVuoa90IGRvIHRoaXMgYmVmb3JlLiBzbwpJIHNl
bmQgdGhpcyBlbWFpbCB0byBhc2sgaXMgdGhhdCBjb3JyZWN0PwoKQlRXLCBJIGZvdW5kIGEgc2lt
aWxhciBpbXBsZW1lbnRhdGlvbiBpbiBhcmNoL3g4Ni9saWIvbW14XzMyLmMsIGFueSBpZGVhCndl
bGNvbWUuCgpCUi4gCkphY2tpZQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
