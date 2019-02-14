Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC8DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:31:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE328222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I0XGXo+p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K0wZ9UJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE328222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gzkNzIOd80AVOcblzvbsE8GV5jyA0LVlbiWnFFL98LE=; b=I0XGXo+pB4dzVV
	KItcSJ0oinRsjLxGWCh0vL4Cil1aOivZaDIVxz+4LDHqq2RhUlpVbZBoNeQ2jAQ4fcyl1lZm9z62R
	PD6o9pSxqSqcZUT7z6JhB2iqfpdsgWhgFlEuWisAXPQZYY8R9oUp+QmAXH9642dF+YfqJYJEt0kVV
	QAL5CDSV5e78MS6JMzIEgriMTJhGcOZHrrs8ClSWpL4xVK5mlrU0pKtur/MBr61lnRVDPzuQnOLyX
	0FPQ3G1tQgk0lfbGHRccUnNMfelMj+LScpcV+ilo0700Uensryh5Vdn5alZVE4i92As29Ltlq111d
	2SOhXzhF4a2Zr+OnX88g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIzB-0004es-3Z; Thu, 14 Feb 2019 15:31:37 +0000
Received: from smtprelay.synopsys.com ([198.182.60.111])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIz3-0004e5-LF
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:31:35 +0000
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com
 [10.12.135.162])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtprelay.synopsys.com (Postfix) with ESMTPS id 2883010C150E;
 Thu, 14 Feb 2019 07:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1550158288; bh=gHIPm80IUSLZcW5vAWa5DSVuzQ4+taDlm71Oi3DhJek=;
 h=Subject:To:CC:References:From:Date:In-Reply-To:From;
 b=K0wZ9UJ2GbqpwdZd+H9uKU6d3LLD+E/jU4f8TjS6B4ES5nE0zzpv0UnX0X6pJ6zoc
 yW2hY6I7TfiGYUtqUeCb1RCjdxav8VcjGV85DW64/ypbqm7O5aMcUqc5uAY2J2cpM0
 WbcGSk+Irr4joTz4NZXNv80oKD+f2wFJtZub+vT8SlLVZL3kpAc8SX4YlypT72fhAQ
 j49ws27Im+9uERTirzm1v8R03ROohBMU64EPNMJAWMz5UVvsJOp49sZkJEdi08BC3D
 dOD1ZJiLVctv63lrKNUta2XCFL5rWzw40z0iqctlWwYZ78R4gcQHv2Yjn0/MZXq9PQ
 nqGke5aFDJoSw==
Received: from US01WEHTC2.internal.synopsys.com
 (us01wehtc2.internal.synopsys.com [10.12.239.237])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mailhost.synopsys.com (Postfix) with ESMTPS id BD4BEA0091;
 Thu, 14 Feb 2019 15:31:27 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Feb 2019 07:30:48 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Feb 2019 16:30:46 +0100
Received: from [10.107.19.176] (10.107.19.176) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Feb 2019 16:30:45 +0100
Subject: Re: [net-next, PATCH] net: stmmac: use correct define to get rx
 timestamp on GMAC4
To: Alexandre Torgue <alexandre.torgue@st.com>,
 Jose Abreu <jose.abreu@synopsys.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, <davem@davemloft.net>
References: <1550153571-14404-1-git-send-email-alexandre.torgue@st.com>
 <7c03dff4-5185-dbd2-eeb4-867972512f2b@synopsys.com>
 <a62c35de-7afa-14ec-5ca6-05bd61b6d09d@st.com>
From: Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <478975ee-2254-96f2-be45-ab4e9539ad08@synopsys.com>
Date: Thu, 14 Feb 2019 15:30:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <a62c35de-7afa-14ec-5ca6-05bd61b6d09d@st.com>
Content-Language: en-US
X-Originating-IP: [10.107.19.176]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_073129_706607_C4D50E57 
X-CRM114-Status: GOOD (  16.95  )
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
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMi8xNC8yMDE5IDM6MDAgUE0sIEFsZXhhbmRyZSBUb3JndWUgd3JvdGU6Cj4gSGkgSm9zZQo+
IAo+IE9uIDIvMTQvMTkgMzoxOCBQTSwgSm9zZSBBYnJldSB3cm90ZToKPj4gSGkgQWxleGFuZHJl
LAo+Pgo+PiBPbiAyLzE0LzIwMTkgMjoxMiBQTSwgQWxleGFuZHJlIFRvcmd1ZSB3cm90ZToKPj4+
IEluIGR3bWFjNF93cmJhY2tfZ2V0X3J4X3RpbWVzdGFtcF9zdGF0dXMgd2UgbG9va2luZyBmb3Ig
YSBSWAo+Pj4gdGltZXN0YW1wLgo+Pj4gRm9yIHRoYXQgcmVjZWl2ZSBkZXNjcmlwdG9ycyBhcmUg
aGFuZGxlZCBhbmQgc28gd2Ugc2hvdWxkIHVzZQo+Pj4gZGVmaW5lcwo+Pj4gcmVsYXRlZCB0byBy
ZWNlaXZlIGRlc2NyaXB0b3JzLiBJdCdsbCBubyBjaGFuZ2UgdGhlIGZ1bmN0aW9uYWwKPj4+IGJl
aGF2aW9yCj4+PiBhcyBSREVTM19SREVTMV9WQUxJRD1UREVTM19SUzFWPUJJVCgyNikgYnV0IGl0
IG1ha2VzIGNvZGUKPj4+IGVhc2llciB0byByZWFkLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRyZSBUb3JndWUgPGFsZXhhbmRyZS50b3JndWVAc3QuY29tPgo+Pj4KPj4+IGRpZmYgLS1n
aXQKPj4+IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWM0X2Rlc2Nz
LmMKPj4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWM0X2Rlc2Nz
LmMKPj4+IGluZGV4IDIwMjk5ZjYuLjlmMDYyYjMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYzRfZGVzY3MuYwo+Pj4gKysrIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWM0X2Rlc2NzLmMKPj4+IEBAIC0yNjgs
NyArMjY4LDcgQEAgc3RhdGljIGludAo+Pj4gZHdtYWM0X3dyYmFja19nZXRfcnhfdGltZXN0YW1w
X3N0YXR1cyh2b2lkICpkZXNjLCB2b2lkCj4+PiAqbmV4dF9kZXNjLAo+Pj4gwqDCoMKgwqDCoCBp
bnQgcmV0ID0gLUVJTlZBTDsKPj4+IMKgIMKgwqDCoMKgwqAgLyogR2V0IHRoZSBzdGF0dXMgZnJv
bSBub3JtYWwgdy9iIGRlc2NyaXB0b3IgKi8KPj4+IC3CoMKgwqAgaWYgKGxpa2VseShwLT5kZXMz
ICYgVERFUzNfUlMxVikpIHsKPj4+ICvCoMKgwqAgaWYgKGxpa2VseShwLT5kZXMzICYgUkRFUzNf
UkRFUzFfVkFMSUQpKSB7Cj4+Cj4+IFNob3VsZG4ndCB0aGlzIGFsc28gdXNlIGxlMzJfdG9fY3B1
KCkgbGlrZSBiZWxsb3cgPwo+IAo+IEkgYWdyZWUuIEkgZm9jdXNlZCBvbiBjb3NtZXRpYyBidXQg
eWVzIHlvdSBhcmUgcmlnaHQsIHdlIGhhdmUgdG8KPiB0YWtlIGNhciBhYm91dCBlbmRpYW5uZXNz
IGFzIHRoaXMgSVAgaXMgdXNlZCBieSBkaWZmZXJlbnQKPiBwcm9jZXNzb3JzICh1c2luZyBkaWZm
ZXJlbnQgZW5kaWFubmVzcykuIEkgZ29ubmEgc2VuZCBhIHYyLgo+IEkgdGhpbmsgZHdtYWM0X3J4
X2NoZWNrX3RpbWVzdGFtcCBoYXZlIHRoZSBzYW1lIGtpbmQgb2YgaXNzdWUuCj4gQW5vdGhlciBw
YXRjaCBzaG91bGQgYmUgc2VudCBmb3IgaXQuIG5vID8KClllYWguIE1heWJlIHlvdSBjYW4gc2Vu
ZCBhbGwgb2YgdGhhdCBpbiB0aGlzIHYyIHBhdGNoIGFsc28gPwoKVGhhbmtzLApKb3NlIE1pZ3Vl
bCBBYnJldQoKPiAKPiByZWdhcmRzCj4gQWxleAo+IAo+IAo+IAo+Pgo+PiBUaGFua3MsCj4+IEpv
c2UgTWlndWVsIEFicmV1Cj4+Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGxpa2VseShsZTMy
X3RvX2NwdShwLT5kZXMxKSAmCj4+PiBSREVTMV9USU1FU1RBTVBfQVZBSUxBQkxFKSkgewo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGkgPSAwOwo+Pj4gwqAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
