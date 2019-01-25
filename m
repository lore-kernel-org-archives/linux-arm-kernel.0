Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F84C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:56:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5351218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CUcPG/Fz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JYCLunqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5351218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MNhPhEq1eSGQ+c8W07/m8B3x1xvJnPeAxlJNl8rQWUQ=; b=CUcPG/Fz4sg98y
	k/vA1I4Cu/BCw0M1eGs6CUjYXWUTaIidKNtPUBaFyeu4XjyGXY07TriXRgXVUd/iuoKy8f/XPMM0I
	zaOPmKEzlcZJKK4vlHFYKcYk7DVepivzP0gxQcTfNWQ6zNmXK1vdl1x6XHPte5c0w+3tZro6HMalb
	tvVtaMzbiSLuZMq9VbgQSzfNR/gOVzJSjAd9yJm7SLo0rzasaArmPN43bsEY5ZzTUEYg0H4tySDiU
	OVb8qiYs4iF8UzMzv+AG/NLrWBH16GP8O8MhhBPUWVekZgezBc/0OAbXAyRSOtFqYrjjNA9vWFDnG
	qA3SOy/pi16p9d8oORIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn05d-0004NA-Dx; Fri, 25 Jan 2019 11:56:05 +0000
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]
 helo=smtprelay.synopsys.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn05Z-0004LF-LQ; Fri, 25 Jan 2019 11:56:03 +0000
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com
 [10.192.0.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtprelay.synopsys.com (Postfix) with ESMTPS id B62EE24E1F01;
 Fri, 25 Jan 2019 03:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1548417358; bh=sLzsIhrHvnKuCoZpk2jbAO+U4ETDaqmUABewGzbAhzA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To:From;
 b=JYCLunqcNvalhBK2S/mHJvCbRb2d4tzRXaSFmbaco84rirEBfUJ32hW2m8gP1DD+T
 UwwTLXTbBUTeBNugz/ZsPEPuhRTzIicH3Nz/2NFpom6pv4e8zyy4sa9dFDE0RZXCge
 Cez8TmfzAhzb7Vp63YDPYgi9VECs1+uE0GGtACzYch9VxIswGH2+uIaFdW5qTHGVz3
 JN0VHsGrDfNvVfGiycPqrg2UoxKi82cN693apNVokWOKwdQRYbRtYHc4pmzh2G41Sl
 has0AwyZcIWJG154QEhjSXVYQqMt6uXYJJTT2ka4u4gioX1udlTl0v44CtuH52MBtF
 fo/J9eGprqenA==
Received: from US01WEHTC3.internal.synopsys.com
 (us01wehtc3.internal.synopsys.com [10.15.84.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mailhost.synopsys.com (Postfix) with ESMTPS id ADBCDA0071;
 Fri, 25 Jan 2019 11:55:56 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 25 Jan 2019 03:55:56 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 25 Jan 2019 12:55:55 +0100
Received: from [10.0.2.15] (10.107.19.109) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Fri, 25 Jan 2019 12:55:55 +0100
Subject: Re: [PATCH] i3c: master: dw: fix deadlock
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Vitor Soares <vitor.soares@synopsys.com>,
 Boris Brezillon <bbrezillon@kernel.org>
References: <20190125152300.248d58f4@xhacker.debian>
From: vitor <vitor.soares@synopsys.com>
Message-ID: <54d8926f-f0fd-c2c7-1b8a-dce1384892b7@synopsys.com>
Date: Fri, 25 Jan 2019 11:55:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125152300.248d58f4@xhacker.debian>
Content-Language: en-US
X-Originating-IP: [10.107.19.109]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_035601_705632_7C218FCE 
X-CRM114-Status: GOOD (  16.25  )
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
Cc: "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSmlzaGVuZywKClRoYW5rcyBmb3IgeW91ciByZXBvcnQuCgpPbiAyNS8wMS8xOSAwNzoyOSwg
SmlzaGVuZyBaaGFuZyB3cm90ZToKPiBJbiBkd19pM2NfbWFzdGVyX2lycV9oYW5kbGVyKCksIHdl
IGFscmVhZHkgaGF2ZSBnb3R0ZW4KPiAmbWFzdGVyLT54ZmVycXVldWUubG9jaywgaWYgd2UgdHJ5
IHRvIGdldCB0aGUgc2FtZSBsb2NrIGFnYWluIGluCj4gZHdfaTNjX21hc3Rlcl9kZXF1ZXVlX3hm
ZXIoKSwgZGVhZGxvY2sgaGFwcGVucy4KPgo+IFdlIGZpeCB0aGlzIGlzc3VlIGJ5IGludHJvZHVp
bmcgZHdfaTNjX21hc3Rlcl9kZXF1ZXVlX3hmZXJfbG9ja2VkKCkKPiB3aGljaCBkb2VzIGFsbCB3
aGF0IGR3X2kzY19tYXN0ZXJfZGVxdWV1ZV94ZmVyKCkgZG9lcyB3aXRob3V0IHRyeWluZwo+IHRv
IGxvY2sgJm1hc3Rlci0+eGZlcnF1ZXVlLmxvY2suCj4KPiBTaWduZWQtb2ZmLWJ5OiBKaXNoZW5n
IFpoYW5nIDxKaXNoZW5nLlpoYW5nQHN5bmFwdGljcy5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvaTNj
L21hc3Rlci9kdy1pM2MtbWFzdGVyLmMgfCAxOCArKysrKysrKysrKystLS0tLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pM2MvbWFzdGVyL2R3LWkzYy1tYXN0ZXIuYyBiL2RyaXZlcnMvaTNjL21hc3Rl
ci9kdy1pM2MtbWFzdGVyLmMKPiBpbmRleCBmOGMwMGI5NDgxN2YuLmJiMDMwNzlmYmFkZSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2kzYy9tYXN0ZXIvZHctaTNjLW1hc3Rlci5jCj4gKysrIGIvZHJp
dmVycy9pM2MvbWFzdGVyL2R3LWkzYy1tYXN0ZXIuYwo+IEBAIC00MTksMTIgKzQxOSw5IEBAIHN0
YXRpYyB2b2lkIGR3X2kzY19tYXN0ZXJfZW5xdWV1ZV94ZmVyKHN0cnVjdCBkd19pM2NfbWFzdGVy
ICptYXN0ZXIsCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZtYXN0ZXItPnhmZXJxdWV1ZS5s
b2NrLCBmbGFncyk7Cj4gIH0KPiAgCj4gLXN0YXRpYyB2b2lkIGR3X2kzY19tYXN0ZXJfZGVxdWV1
ZV94ZmVyKHN0cnVjdCBkd19pM2NfbWFzdGVyICptYXN0ZXIsCj4gLQkJCQkgICAgICAgc3RydWN0
IGR3X2kzY194ZmVyICp4ZmVyKQo+ICtzdGF0aWMgdm9pZCBkd19pM2NfbWFzdGVyX2RlcXVldWVf
eGZlcl9sb2NrZWQoc3RydWN0IGR3X2kzY19tYXN0ZXIgKm1hc3RlciwKPiArCQkJCQkgICAgICBz
dHJ1Y3QgZHdfaTNjX3hmZXIgKnhmZXIpCj4gIHsKPiAtCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4g
LQo+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJm1hc3Rlci0+eGZlcnF1ZXVlLmxvY2ssIGZsYWdzKTsK
PiAgCWlmIChtYXN0ZXItPnhmZXJxdWV1ZS5jdXIgPT0geGZlcikgewo+ICAJCXUzMiBzdGF0dXM7
Cj4gIAo+IEBAIC00MzksNiArNDM2LDE1IEBAIHN0YXRpYyB2b2lkIGR3X2kzY19tYXN0ZXJfZGVx
dWV1ZV94ZmVyKHN0cnVjdCBkd19pM2NfbWFzdGVyICptYXN0ZXIsCj4gIAl9IGVsc2Ugewo+ICAJ
CWxpc3RfZGVsX2luaXQoJnhmZXItPm5vZGUpOwo+ICAJfQo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9p
ZCBkd19pM2NfbWFzdGVyX2RlcXVldWVfeGZlcihzdHJ1Y3QgZHdfaTNjX21hc3RlciAqbWFzdGVy
LAo+ICsJCQkJICAgICAgIHN0cnVjdCBkd19pM2NfeGZlciAqeGZlcikKPiArewo+ICsJdW5zaWdu
ZWQgbG9uZyBmbGFnczsKPiArCj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmbWFzdGVyLT54ZmVycXVl
dWUubG9jaywgZmxhZ3MpOwo+ICsJZHdfaTNjX21hc3Rlcl9kZXF1ZXVlX3hmZXJfbG9ja2VkKG1h
c3RlciwgeGZlcik7Cj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZtYXN0ZXItPnhmZXJxdWV1
ZS5sb2NrLCBmbGFncyk7Cj4gIH0KPiAgCj4gQEAgLTQ5NCw3ICs1MDAsNyBAQCBzdGF0aWMgdm9p
ZCBkd19pM2NfbWFzdGVyX2VuZF94ZmVyX2xvY2tlZChzdHJ1Y3QgZHdfaTNjX21hc3RlciAqbWFz
dGVyLCB1MzIgaXNyKQo+ICAJY29tcGxldGUoJnhmZXItPmNvbXApOwo+ICAKPiAgCWlmIChyZXQg
PCAwKSB7Cj4gLQkJZHdfaTNjX21hc3Rlcl9kZXF1ZXVlX3hmZXIobWFzdGVyLCB4ZmVyKTsKPiAr
CQlkd19pM2NfbWFzdGVyX2RlcXVldWVfeGZlcl9sb2NrZWQobWFzdGVyLCB4ZmVyKTsKPiAgCQl3
cml0ZWwocmVhZGwobWFzdGVyLT5yZWdzICsgREVWSUNFX0NUUkwpIHwgREVWX0NUUkxfUkVTVU1F
LAo+ICAJCSAgICAgICBtYXN0ZXItPnJlZ3MgKyBERVZJQ0VfQ1RSTCk7Cj4gIAl9CkFja2VkLWJ5
OsKgVml0b3LCoFNvYXJlc8KgPHZpdG9yLnNvYXJlc0BzeW5vcHN5cy5jb20+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
