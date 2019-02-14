Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CD1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:13:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81185222DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cc4rXvIU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e3tGii75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81185222DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HzmCWjvQA6LBVSaFn7eGCsRNbRTl5sbLE73NJlD6XNM=; b=Cc4rXvIUtqUC3LaXV+eqWTUZ3
	payeg42Mca3IMIHkD/dd9MeeODv3cq9ySH3+vbLgFFjFyQYHwkWhrUhUkYDTrcKEVQcckk3cG1dW4
	Q1cM2Tqc40Wq8aboqLnqzqEskMW5A8Tq2v1P5xJdO6S8bdxTrmpHauZk5VvXPFpcQ8cHGL8MHh7Vq
	eMEGJRuFZ4USwmTBcOxps8Mwd0r7ghwlStDB6qirerfzpjCBaJ2YVlHjfHnLCGzKYZeFkKSrlTg6w
	KWbcvoy2YDByqDTvrYU7tOXzjHJGz0eDQcJdCo3SBqQc4N8fSkX42Dj9dP+mkL8ftbEPN5IVVcwco
	K/CAH2MMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJdb-00012K-1L; Thu, 14 Feb 2019 16:13:23 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJdO-000075-JA
 for linux-arm-kernel@bombadil.infradead.org; Thu, 14 Feb 2019 16:13:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qn1VYWmtp9WXZUmt+slCoN3q5sPS9RVqzuEnRcGRLLU=; b=e3tGii75JBzE4JnaKagWBSURFH
 G+e/NZCiFyddZYEqv3TNU9gO/hxJUJLBYZ5BRDxjP4fkpeVzjyyfZPzf73DtBSpzd1ICxYKHE6xwR
 MRfvLNagXt5FCJ+YpcG1NQOdlq/dt9Mi25Sn1ma5FgxcSaAl/OQ/OqHpyrMn1CYdGrSXIT0S/S2rX
 y0zbxZV9ZQzy8feJSi6qRf3H7CPI/hVWHuzxkaghkaZlWuutrYfTHCOZ+JifSZVkYKLQydg3syCA5
 ov+wRcYR86j5FXTGE5ZxEzJ2VBx/3WFA+pIgLk49qYzlf8yOnDSpiQ1yu9uNRG/HZf55WvzQfqMSN
 PMmVLEcw==;
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJN0-0003C9-7W
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:56:16 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1EFVCSo024967; Thu, 14 Feb 2019 16:56:07 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qmxr741fh-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 14 Feb 2019 16:56:07 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 52C2E31;
 Thu, 14 Feb 2019 15:56:07 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3299858A3;
 Thu, 14 Feb 2019 15:56:07 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 16:56:07 +0100
Subject: Re: [net-next, PATCH] net: stmmac: use correct define to get rx
 timestamp on GMAC4
To: Jose Abreu <jose.abreu@synopsys.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, <davem@davemloft.net>
References: <1550153571-14404-1-git-send-email-alexandre.torgue@st.com>
 <7c03dff4-5185-dbd2-eeb4-867972512f2b@synopsys.com>
 <a62c35de-7afa-14ec-5ca6-05bd61b6d09d@st.com>
 <478975ee-2254-96f2-be45-ab4e9539ad08@synopsys.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <9cfeff02-0bee-d15b-89f9-c75420c4f5eb@st.com>
Date: Thu, 14 Feb 2019 16:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <478975ee-2254-96f2-be45-ab4e9539ad08@synopsys.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_155614_360505_3A01518C 
X-CRM114-Status: GOOD (  18.88  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAyLzE0LzE5IDQ6MzAgUE0sIEpvc2UgQWJyZXUgd3JvdGU6Cj4gT24gMi8xNC8yMDE5IDM6
MDAgUE0sIEFsZXhhbmRyZSBUb3JndWUgd3JvdGU6Cj4+IEhpIEpvc2UKPj4KPj4gT24gMi8xNC8x
OSAzOjE4IFBNLCBKb3NlIEFicmV1IHdyb3RlOgo+Pj4gSGkgQWxleGFuZHJlLAo+Pj4KPj4+IE9u
IDIvMTQvMjAxOSAyOjEyIFBNLCBBbGV4YW5kcmUgVG9yZ3VlIHdyb3RlOgo+Pj4+IEluIGR3bWFj
NF93cmJhY2tfZ2V0X3J4X3RpbWVzdGFtcF9zdGF0dXMgd2UgbG9va2luZyBmb3IgYSBSWAo+Pj4+
IHRpbWVzdGFtcC4KPj4+PiBGb3IgdGhhdCByZWNlaXZlIGRlc2NyaXB0b3JzIGFyZSBoYW5kbGVk
IGFuZCBzbyB3ZSBzaG91bGQgdXNlCj4+Pj4gZGVmaW5lcwo+Pj4+IHJlbGF0ZWQgdG8gcmVjZWl2
ZSBkZXNjcmlwdG9ycy4gSXQnbGwgbm8gY2hhbmdlIHRoZSBmdW5jdGlvbmFsCj4+Pj4gYmVoYXZp
b3IKPj4+PiBhcyBSREVTM19SREVTMV9WQUxJRD1UREVTM19SUzFWPUJJVCgyNikgYnV0IGl0IG1h
a2VzIGNvZGUKPj4+PiBlYXNpZXIgdG8gcmVhZC4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRyZSBUb3JndWUgPGFsZXhhbmRyZS50b3JndWVAc3QuY29tPgo+Pj4+Cj4+Pj4gZGlmZiAt
LWdpdAo+Pj4+IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWM0X2Rl
c2NzLmMKPj4+PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjNF9k
ZXNjcy5jCj4+Pj4gaW5kZXggMjAyOTlmNi4uOWYwNjJiMyAxMDA2NDQKPj4+PiAtLS0gYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYzRfZGVzY3MuYwo+Pj4+ICsrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjNF9kZXNjcy5jCj4+Pj4g
QEAgLTI2OCw3ICsyNjgsNyBAQCBzdGF0aWMgaW50Cj4+Pj4gZHdtYWM0X3dyYmFja19nZXRfcnhf
dGltZXN0YW1wX3N0YXR1cyh2b2lkICpkZXNjLCB2b2lkCj4+Pj4gKm5leHRfZGVzYywKPj4+PiAg
wqDCoMKgwqDCoCBpbnQgcmV0ID0gLUVJTlZBTDsKPj4+PiAgwqAgwqDCoMKgwqDCoCAvKiBHZXQg
dGhlIHN0YXR1cyBmcm9tIG5vcm1hbCB3L2IgZGVzY3JpcHRvciAqLwo+Pj4+IC3CoMKgwqAgaWYg
KGxpa2VseShwLT5kZXMzICYgVERFUzNfUlMxVikpIHsKPj4+PiArwqDCoMKgIGlmIChsaWtlbHko
cC0+ZGVzMyAmIFJERVMzX1JERVMxX1ZBTElEKSkgewo+Pj4KPj4+IFNob3VsZG4ndCB0aGlzIGFs
c28gdXNlIGxlMzJfdG9fY3B1KCkgbGlrZSBiZWxsb3cgPwo+Pgo+PiBJIGFncmVlLiBJIGZvY3Vz
ZWQgb24gY29zbWV0aWMgYnV0IHllcyB5b3UgYXJlIHJpZ2h0LCB3ZSBoYXZlIHRvCj4+IHRha2Ug
Y2FyIGFib3V0IGVuZGlhbm5lc3MgYXMgdGhpcyBJUCBpcyB1c2VkIGJ5IGRpZmZlcmVudAo+PiBw
cm9jZXNzb3JzICh1c2luZyBkaWZmZXJlbnQgZW5kaWFubmVzcykuIEkgZ29ubmEgc2VuZCBhIHYy
Lgo+PiBJIHRoaW5rIGR3bWFjNF9yeF9jaGVja190aW1lc3RhbXAgaGF2ZSB0aGUgc2FtZSBraW5k
IG9mIGlzc3VlLgo+PiBBbm90aGVyIHBhdGNoIHNob3VsZCBiZSBzZW50IGZvciBpdC4gbm8gPwo+
IAo+IFllYWguIE1heWJlIHlvdSBjYW4gc2VuZCBhbGwgb2YgdGhhdCBpbiB0aGlzIHYyIHBhdGNo
IGFsc28gPwoKSSdsbCBzZW5kIGFub3RoZXIgb25lIHNlcGFyYXRlbHksIGluIG9yZGVyIHRvIGhh
dmUgYSBjb3JyZWN0IGNvbW1pdCAKaGVhZGVyLiBJIHNlbmQgaXQgbm93LgoKPiAKPiBUaGFua3Ms
Cj4gSm9zZSBNaWd1ZWwgQWJyZXUKPiAKPj4KPj4gcmVnYXJkcwo+PiBBbGV4Cj4+Cj4+Cj4+Cj4+
Pgo+Pj4gVGhhbmtzLAo+Pj4gSm9zZSBNaWd1ZWwgQWJyZXUKPj4+Cj4+Pj4gIMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAobGlrZWx5KGxlMzJfdG9fY3B1KHAtPmRlczEpICYKPj4+PiBSREVTMV9USU1F
U1RBTVBfQVZBSUxBQkxFKSkgewo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQg
aSA9IDA7Cj4+Pj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
