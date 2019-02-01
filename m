Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253E5C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:47:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E658F21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BUPGR3bj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="HIcz7aYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E658F21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:Mime-Version:References:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=sEFx2HT7bubTIbTWMTEMbSwlLJmbkblZpW1+1OACO+8=; b=BUPGR3bjfNODkT
	JiFue+aHuT+jE9muCNiGSGNHqhnEk63g/RdNkKVF6RQzXDxc5RRIwUaXwgBworz+X8k8VfFRSngD3
	EK/2xPPy0jnDtujnpXmrOgBBf+VpMEcIDhlNmcK3s9T/iVF6vi6BvPlmB6wqwFvxNj8bk3bjarGkr
	q5Q1ghO9ep7XLaF03h8n4gGpTYOE24GMMp1kFBPgAicYp5Ufa/CRlUxh44yFK7NgIOVYNXYZlaVEK
	HKBoSDHnHsMeJYtWCXeG3Ywr/SF5SsADvQOdJFQg0SZZFl9BqWiRJ4CjpnylurVb3Mme/Phu1r0sI
	4IMNAFoWKubQih7OCRcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpVPk-00023q-VH; Fri, 01 Feb 2019 09:47:12 +0000
Received: from m15-114.126.com ([220.181.15.114])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpVPh-00023T-9K
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 09:47:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:Subject:Mime-Version:Message-ID; bh=neC7A
 HVnmTciVZSv/fUF6t8TVABpDhG6tFemJpzdhNU=; b=HIcz7aYtIOTQwt8NEgD+o
 DgOY+ESizuLCRCLAFU1CdQQIfa1w9y4FDKU7Vn6Of1+nC0mUvAEUTFXHvjY7wX5V
 3Yiws7LrJymQ7J7FDhrLDSIKNcN36rMaZRqLiNlmMz1Rk14tZXYmU2Vx0egbUqDE
 TAY8P93YXo0YMtY7qMWzlc=
Received: from yingangl2 (unknown [1.83.232.102])
 by smtp7 (Coremail) with SMTP id DsmowAAXOfiDFVRcH+j4Bg--.29565S2;
 Fri, 01 Feb 2019 17:46:44 +0800 (CST)
Date: Fri, 1 Feb 2019 17:46:44 +0800
From: "kassey@126.com" <kassey@126.com>
To: "Will Deacon" <will.deacon@arm.com>, 
 "kassey1216@gmail.com" <kassey1216@gmail.com>
Subject: Re: Re: arm64: copy_from_user access the last page of ddr has problem
 on 4.14 kernel
References: <CAKwPUowmzZ2BNi-RmJm3=ENrZ5sxPf1SeT+b9A9iHHSCUQQAUw@mail.gmail.com>, 
 <20190116164817.GG1910@brain-police>, 
 <CAKwPUoyWy64-o2NgB5iPXNs4UR7bmYjmKk3Ub0X6DND40fCtPA@mail.gmail.com>, 
 <20190120020829.GA28576@brain-police>
X-Priority: 3
X-GUID: 1A1A322B-B2FD-4024-A504-0C65C521DD47
X-Has-Attach: no
X-Mailer: Foxmail 7.2.9.156[cn]
Mime-Version: 1.0
Message-ID: <201902011746430858184@126.com>
X-CM-TRANSID: DsmowAAXOfiDFVRcH+j4Bg--.29565S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxur4DKw4rJrykWr47KF17Jrb_yoW5Ar47pF
 yYqFWUCr4kXr17Jr1DJ3WjvFZ8tr1Iya4UJFW8Kry8uryUWr1Dury0vFW7tr15Xr1Dt347
 J3srAFy5tryUWw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jHwZwUUUUU=
X-Originating-IP: [1.83.232.102]
X-CM-SenderInfo: 5ndv2vb16rjloofrz/1tbipARO8lpD781vpgAAsu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_014709_656329_EA27FDD4 
X-CRM114-Status: GOOD (  10.46  )
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
Cc: "mark.rutland" <mark.rutland@arm.com>,
 "ard.biesheuvel" <ard.biesheuvel@linaro.org>,
 "catalin.marinas" <catalin.marinas@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, willy <willy@infradead.org>,
 "robin.murphy" <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

aGkgV2lsbDoKwqAgwqAgwqBzb3JyeSBmb3IgbGF0ZSByZXNwb25zZS7CoArCoCDCoCDCoHdlIGRp
ZCBoYXZlIHByb2Nlc3MgaW4gdXNlcnNwYWNlIGRvaW5nIG1tYXAuwqAKwqAgwqAgwqBtdWx0IGRl
dmljZSBjYW4gcmVwcm9jdWVkIHRoaXMgaXNzdWUsIHNvIHdlIGRvIG5vdCBzdXNwZWN0IHRoZSBk
ZHIgbm90IHN0YWJsZS7CoArCoCDCoCDCoGNhbiB5b3UgaGVscCByZXZpZXcgwqBiZWxvdyBwYXRj
aCB0byBhZ2FpbnN0IHdpdGggc3VjaCBpc3N1ZSwgYmVjYXVzZSB3ZSBmaW5kIGlmIGVuYWJsZSBr
YXNhbiAsIGlzc3VlIG5vdCBzZWVuLsKgCgrCoCDCoCDCoCBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9oPXY1
LjAtcmMyJmlkPWM4YTQzYzE4YTk3ODQ1ZTdmOTRlZDdkMTgxYzExZjQxOTY0OTc2YTIKCkJSCkth
c3NlecKgCgrCoApGcm9tOsKgV2lsbCBEZWFjb24KRGF0ZTrCoDIwMTktMDEtMjDCoDEwOjA4ClRv
OsKgS2Fzc2V5CkNDOsKgbGludXgta2VybmVsOyB3aWxseTsga2Fzc2V5OyBsaW51eC1hcm0ta2Vy
bmVsOyBjYXRhbGluLm1hcmluYXM7IG1hcmsucnV0bGFuZDsgcm9iaW4ubXVycGh5OyBhcmQuYmll
c2hldXZlbApTdWJqZWN0OsKgUmU6IGFybTY0OiBjb3B5X2Zyb21fdXNlciBhY2Nlc3MgdGhlIGxh
c3QgcGFnZSBvZiBkZHIgaGFzIHByb2JsZW0gb24gNC4xNCBrZXJuZWwKT24gVGh1LCBKYW4gMTcs
IDIwMTkgYXQgMDk6NTc6MTdBTSArMDgwMCwgS2Fzc2V5IHdyb3RlOgo+IGhpLCBXaWxsCj7CoMKg
wqDCoMKgwqAgaXQgaXMgaGFyZCB0byB0cnkgb24gdjUuMC1yYzIga2VybmVsLCBzaW5jZSB0aGVy
ZSBpcyBtdWNoIHBvcnQKPiBqb2IgdG8gYmUgZG9uZS4KPsKgwqDCoMKgwqAgZHN0IGtlcm5lbCBi
dWZmZXIgaXMgbG9va3Mgb3ZlcndyaXRlbiBieSBzb21lIHNhbWUoZml4KSBwYXR0ZXIKPiBzdGFy
dCB3aXRoICJtbWFwIsKgwqDCoCAoMHg2ZDZkNzA2MSnCoCBzZWUgYmVsb3cgY29kZSAoZGF0YSBm
cm9tIHZtYWxsb2MpLAo+IGFuZCBmaWxlIGlzIG1tYXBlZCAoaW5jbHVkZSB0aGUgbGFzdCBwaHkg
cGFnZSBvZiBkZHIuKQo+wqDCoMKgwqDCoCBzZWUgYmVsb3cgcGF0dGVybiBhbmQgcGllY2VzIG9m
IGNvZGUuCsKgCldlaXJkIQrCoAo+wqDCoMKgwqDCoCBub3Qgc3VyZSBpZiB0aGVyZSBpcyBib3Vu
ZGFyeSBpc3N1ZSBmb3IgY29weV9mcm9tX3VzZXIsIHBsZWFzZQo+IGhlbHAgdG8gc3VnZ2VzdCBp
ZiB5b3UgZ290IHNvbWUgaWRlYSBmcm9tIHRoZSBwYXR0ZXJuLCB0aGFua3MuCsKgCmNvcHlfZnJv
bV91c2VyKCkgZG9lc24ndCBjYXJlIGFib3V0IHRoZSBwaHlzaWNhbCBhZGRyZXNzLCBzbyBJIGNh
bid0IHNlZSB3aHkKaXQgd291bGQgbWF0dGVyIChhc3N1bWluZyB3ZSBoYXZlbid0IGRvbmUgc29t
ZXRoaW5nIG51dHMgZWxzZXdoZXJlLCBsaWtlCmRvdWJsZS1hbGxvY2F0ZSB0aGUgcGFnZSkuCsKg
ClRoZSBjb3JydXB0aW9uIHlvdSBoYXZlIGlzIHJlYXNvbmFibHkgcmVndWxhcjoKwqAKPiAwMDc5
YzAwIDZkNmQgNzA2MSAwMDAwIDAwMDAgMDg0OCBmZDhmIDAwMDEgMDAwMAo+IDAwNzljMTAgMDA0
OCBmZDhmIDAwMDEgMDAwMCAwMDAxIDAwMDAgMDAwMyAwMDAwCj4gMDA3OWMyMCAyMDAwIGZkODMg
MDAwMSAwMDAwIDFmZmYgZmQ4NiAwMDAxIDAwMDAKPiAwMDc5YzMwIDAwMDAgMDAwMCAwMDAwIDAw
MDAgNzAwZiAwMDAwIDAwMDAgMDAwMArCoApIZXJlJ3MgIm1tYXAiIGFnYWluLCBidXQgdGhlIHJl
Y29yZCBpcyB0d2ljZSBhcyBsb25nOgrCoAo+IDAwNzljNDAgNmQ2ZCA3MDYxIDAwMDAgMDAwMCBm
NDQ4IGZmZmYgMDAwMSAwMDAwCj4gMDA3OWM1MCBmNzQ4IGZmZmYgMDAwMSAwMDAwIDAwMDEgMDAw
MCAwMDA0IDAwMDAKPiAwMDc5YzYwIDMwMDAgZmQ4YyAwMDAxIDAwMDAgMmZmZiBmZDhlIDAwMDEg
MDAwMAo+IDAwNzljNzAgMDAwMCAwMDAwIDAwMDAgMDAwMCA3MDBmIDAwMDAgMDAwMCAwMDAwCj4g
MDA3OWM4MCBjMTAzIDA2MDYgMDEwMCBiZTAwIDEwMDkgM2IwMCAzYjA3IDA2MDcKPiAwMDc5Yzkw
IDAxMDAgNTcwMCAxMDA2IGU4MDAgOGMwMyAzMTAzIDAxMDAgMGEwMAo+IDAwNzljYTAgMDAwMCBj
ZjAwIGJmMDggMGEwMCAwMTAwIDU3MDAgMTAwNiAzNzAwCj4gMDA3OWNiMCAzOTA2IDA2MDYgMDEw
MCAxNjAwIDAwMDQgNDcwMCA5OTAyIDAyMDcKwqAKQW5kIHRoZW4gdGhlIHdob2xlIHN0cnVjdHVy
ZSByZXBlYXRzOgrCoAo+IDAwNzljYzAgNmQ2ZCA3MDYxIDAwMDAgMDAwMCBmODA4IGZmZmYgMDAw
MSAwMDAwCj4gMDA3OWNkMCBmMWM4IGZmZmYgMDAwMSAwMDAwIDAwMDEgMDAwMCAwMDA1IDAwMDAK
PiAwMDc5Y2UwIGQwMDAgZmZmOCAwMDAxIDAwMDAgZWZmZiBmZmZhIDAwMDEgMDAwMAo+IDAwNzlj
ZjAgMDAwMCAwMDAwIDAwMDAgMDAwMCA3MDBmIDAwMDAgMDAwMCAwMDAwCsKgCj4gMDA3OWQwMCA2
ZDZkIDcwNjEgMDAwMCAwMDAwIGYxYzggZmZmZiAwMDAxIDAwMDAKPiAwMDc5ZDEwIGYzODggZmZm
ZiAwMDAxIDAwMDAgMDAwMSAwMDAwIDAwMDMgMDAwMAo+IDAwNzlkMjAgYzAwMCBmZmRmIDAwMDEg
MDAwMCA2ZmZmIGZmZjggMDAwMSAwMDAwCj4gMDA3OWQzMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDcw
MGYgMDAwMCAwMDAwIDAwMDAKPiAwMDc5ZDQwIDk0MDcgMDkwMSAwMTAwIDUzMDAgMDIwNCBiNDAw
IGQ1MDMgMGEwNAo+IDAwNzlkNTAgMDEwMCAwMDAwIDAwMDEgMDIwMCA3MzA5IDAyMDIgMDEwMCAw
MjAwCj4gMDA3OWQ2MCA1MDAwIDAyMDAgNzMwOSAwMjAyIDA0MDAgZmYwMCBmN2ZmIDk0ZmYKPiAw
MDc5ZDcwIGI0MDAgMDIwOCAwMTAwIGRjMDAgMDAwMCBiNDAwIDU4MDMgMDYwNwo+IDAwNzlkODAg
NmQ2ZCA3MDYxIDAwMDAgMDAwMCBmN2M4IGZmZmYgMDAwMSAwMDAwCsKgCkRvIHlvdSBoYXZlIGFu
eSBhcHBsaWNhdGlvbnMgcnVubmluZyB3aXRoIHRoZSBuYW1lICJtbWFwIj8KwqAKQWxzbywgaGF2
ZSB5b3UgYm9vdGVkIHdpdGggIm1lbXRlc3QiIG9uIHRoZSBjb21tYW5kLWxpbmUsIHNvIHRoYXQg
d2UgY2FuCnJ1bGUgb3V0IGFueSBkcmFtIGFsaWFzaW5nIGlzc3VlcyBhbmQgdGhlIGxpa2U/CsKg
CldpbGwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
