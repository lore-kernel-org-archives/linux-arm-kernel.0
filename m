Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5260CC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:14:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD4D2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u5/nqL3W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=android.com header.i=@android.com header.b="UsCFOaHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD4D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IoBM7D3/fcWsCLwccZFj4vWIXvmdqnq+f7rovMVprR4=; b=u5/nqL3WivdIOqwieRjGbZJLq
	m45vzGWkoWWa3DPzsc0rgqC3XcEyhJIqAXeSzOrJwq3nN6Bjwtk/75ez9nYhGDUeljFeXofx1tChb
	JEDhMl3FXFz6AZ1a82uV0ec6MIBjWKJ6Mtof7aCbcuj0ZF2MCPDL6MY1WjP0dpMuWhYchUWO9LJi3
	ZwDctbNI+11hWubzEAfcEToBvNTyGFx/NAJA62rZlLH31pV5wB83eIm2pCnQ0jJMlLfjVxnDQ1zdu
	nuxphjkIGNEedTWQVUxb5GZXQem9AVcPJ+FVLh5iREeh0g2HSd2NK2KAqWjpHJgDBknRhUM3a4sd9
	SzGjN6xgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTol-0005hR-E4; Mon, 10 Dec 2018 22:14:23 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWToM-00059r-Tz
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:14:06 +0000
Received: by mail-pg1-x543.google.com with SMTP id z10so5621446pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=android.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=L0dsCXPeVvQ2BusG7EDOj9azDypFYokJJarX2eNjU6g=;
 b=UsCFOaHssNDkq9kObJi6pePrLiMxX5KGkFly4DuCO3ToNh3gGnlJiYu5f9TeBjdkoS
 FUklqAlmLx0Hjap7zViwpBYklmZSxFH+NdAyxX262YzK83xP9pSiUdhH/t8ZoUolhUsw
 oTCw7vSc97AqjEmc03ReOG+aRZYcu2vejGndj0oxRzCof+dHyEqj8HFV2B2xDaaqB+fC
 2hg7htXMEB2SxCJWP+BUPHCuzh/eSrHyJbWQx0BIt1WA+GPui4SISCgoUnh3skIdWO6l
 4f2rG5R9lhQuYQXx7qIGlN9uwV3WQUk2nwrkqp8IdI0fhwgsJmf6rQJrRmQAmNJUFVmb
 hk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=L0dsCXPeVvQ2BusG7EDOj9azDypFYokJJarX2eNjU6g=;
 b=nB5Hn/OmISBUH+V26Lc+tsuwfiEC3qxl2ON4nTzPJhtfkYPPBPQaY22PxKjwAZaVea
 8kxyJrSAjcupUFnR9jo/CHyGdVvV96FjCNt3euHfXMwmKBV0A7cbAkkrKCYtMB0hDdRc
 rEAy8+aahmEb90LsP4oufK1AdFEFc4M4PycSLcAmrwGLFCQKnbzoeWf7sSKIYPo+rkwA
 MmpTRWmJJP75hxnlxLOmQ6IUAfvXOhPnBuktVzrL+3g5Idyb1zkgyyjFlrvseMyFnIZJ
 XAwbfoEOyH1ev1CR0jTM86Gw3QISYZzQf9Sxrh1ZEPE7OEbz0LI0ssrhFXU5cmVlKnGW
 2d6w==
X-Gm-Message-State: AA+aEWY6tSCue0v7rqGtwTtQ4YXsA2R8xFSTHVXOjtKikbwPSzjQN/RG
 CEFwCZeucmsuFXKglAYDRnoPrA==
X-Google-Smtp-Source: AFSGD/Wv3h6oClsVLGngr9D02sxgK2Xvv39D4dmBeQprpr2YlV/t+DsHgpZVBaKZKQkvKKd/AUozFw==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr12183930pgf.87.1544480026082; 
 Mon, 10 Dec 2018 14:13:46 -0800 (PST)
Received: from nebulus.mtv.corp.google.com
 ([2620:0:1000:1612:b4fb:6752:f21f:3502])
 by smtp.googlemail.com with ESMTPSA id
 a10sm15633834pfi.138.2018.12.10.14.13.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 14:13:45 -0800 (PST)
Subject: Re: [PATCH v2 24/28] arm: Add support for generic vDSO
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-25-vincenzo.frascino@arm.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <1f5de1a7-04f0-152f-03ad-e581b0ec1b17@android.com>
Date: Mon, 10 Dec 2018 14:13:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181129170530.37789-25-vincenzo.frascino@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_141359_668794_008C0220 
X-CRM114-Status: GOOD (  14.57  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Collingbourne <pcc@google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTEvMjkvMjAxOCAwOTowNSBBTSwgVmluY2Vuem8gRnJhc2Npbm8gd3JvdGU6Cj4gVGhlIGFy
bSB2RFNPIGxpYnJhcnkgcmVxdWlyZXMgc29tZSBhZGFwdGF0aW9ucyB0byB1c2UgdG8gdGFrZSBh
ZHZhbnRhZ2UKPiBvZiB0aGUgbmV3bHkgaW50cm9kdWNlZCBnZW5lcmljIHZEU08gbGlicmFyeS4K
VGVzdGVkLWJ5PyBXb3VsZCBsaWtlIHRvIG5vdGUgdGhhdCB0aGlzIHBhdGNoIHNlcmllcyB1cCB0
byAyNC8yOCB3YXMgCmJhY2stcG9ydGVkIHRvIGFuZHJvaWQtNC45IGFuZCB3b3JrZWQgc3VjY2Vz
c2Z1bGx5IG9uIGEgSGlrZXkgYXJtNjQgZGV2aWNlLgoKT25seSBzaWduaWZpY2FudCBjaGFuZ2Ug
d2FzIHRvIGFkZCBiYWNrIHN1cHBvcnQgZm9yIGNsYW5nIGluIAphcmNoL2FybTY0L01ha2VmaWxl
IChwc2V1ZG8gcGF0Y2gpOgoKIMKgaWZlcSAoJChDT05GSUdfR0VORVJJQ19DT01QQVRfVkRTTyks
IHkpCiDCoMKgIENST1NTX0NPTVBJTEVfQVJNMzIgPz0gJChDT05GSUdfQ1JPU1NfQ09NUElMRV9D
T01QQVRfVkRTTzoiJSI9JSkKCiDCoMKgIGlmZXEgKCQoQ1JPU1NfQ09NUElMRV9BUk0zMiksKQog
wqDCoCDCoCAkKGVycm9yIENST1NTX0NPTVBJTEVfQVJNMzIgbm90IGRlZmluZWQgb3IgZW1wdHks
IHRoZSBjb21wYXQgdkRTTyAKd2lsbCBub3QgYmUgYnVpbHQpCivCoMKgIGVsc2UgaWZlcSAoJChj
Yy1uYW1lKSxjbGFuZykKK8KgwqAgwqAgZXhwb3J0IENMQU5HX1RSSVBMRV9BUk0zMiA/PSAkKENS
T1NTX0NPTVBJTEVfQVJNMzIpCivCoMKgwqDCoCBleHBvcnQgQ0xBTkdfVEFSR0VUX0FSTTMyIDo9
IC0tdGFyZ2V0PSQobm90ZGlyIAokKENMQU5HX1RSSVBMRV9BUk0zMjolLT0lKSkKK8KgwqDCoMKg
IGV4cG9ydCBDT05GSUdfQ09NUEFUX1ZEU08gOj0geQorwqDCoMKgwqAgY29tcGF0X3Zkc28gOj0g
LURDT05GSUdfQ09NUEFUX1ZEU089MQotKyDCoCBlbHNlIGlmZXEgKCQoc2hlbGwgd2hpY2ggJChD
Uk9TU19DT01QSUxFX0FSTTMyKSQoY2MtbmFtZSkgMj4gCi9kZXYvbnVsbCksKQotKyDCoCDCoCAk
KGVycm9yICQoQ1JPU1NfQ09NUElMRV9BUk0zMikkKGNjLW5hbWUpIG5vdCBmb3VuZCwgY2hlY2sg
CkNST1NTX0NPTVBJTEVfQVJNMzIpCiDCoMKgIGVsc2UKIMKgwqAgwqAgZXhwb3J0IENST1NTX0NP
TVBJTEVfQVJNMzIKIMKgwqDCoMKgIGV4cG9ydCBDT05GSUdfQ09NUEFUX1ZEU08gOj0geQogwqDC
oMKgwqAgY29tcGF0X3Zkc28gOj0gLURDT05GSUdfQ09NUEFUX1ZEU089MQogwqDCoCBlbmRpZgog
wqBlbmRpZgoKLS0gTWFyawoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
