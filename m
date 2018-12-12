Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53129C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:18:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238BD20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PBSPY8M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238BD20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DHL4p7Zy/ouFsyPBO18tEbeeeYucIxof1LWBq/Ojspw=; b=PBSPY8M5Z4IadUO+vGoPrmH57
	CXsKihgHm3tc9f8Hrsj7WI4m1AQhn3gONvnypN9OgGJwUY1JzfyDlL+iMXchwoGq9hV7h8qnjxaUC
	T0ggL+yBo87Yxv22aKuI+KoADx8bVrKBhQIY0E03/6zfxRv5zNruFKaippTlG2IIwQJHZKsyWpXZW
	UKNzW6H/AT5qr/WMabb+6SuUEVudgNbfpXhz4tC3jlzyHTtMlFychBW4l2aqT+fDGAQ8xAreKFBBy
	JNto3iqMLfJTGlNk12CLF/devsEYSvfibmiIl8vHwGs/6XZY0vvl6hGBuOO7X3ZTolnQmovPtveEN
	x8fGjKBlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX891-0003FF-LM; Wed, 12 Dec 2018 17:17:59 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX88x-00033i-7l
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 17:17:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C632880D;
 Wed, 12 Dec 2018 09:17:44 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079E73F575;
 Wed, 12 Dec 2018 09:17:43 -0800 (PST)
Subject: Re: arm64 board boot pauses on linux-next (resend)
To: John Garry <john.garry@huawei.com>, linux-arm-kernel@lists.infradead.org
References: <95b1b28c-da6d-fa1f-4b39-ed3c37c4bb9e@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8e1e38dd-70b0-a0ec-0687-581cc773b600@arm.com>
Date: Wed, 12 Dec 2018 17:17:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <95b1b28c-da6d-fa1f-4b39-ed3c37c4bb9e@huawei.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_091755_288630_B2A60AE1 
X-CRM114-Status: GOOD (  16.71  )
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
Cc: Linuxarm <linuxarm@huawei.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

WyArU3V6dWtpIF0KCkhpIEpvaG4sCgpPbiAxMi8xMi8yMDE4IDE2OjQ4LCBKb2huIEdhcnJ5IHdy
b3RlOgo+IEhpIGFsbCwKPiAKPiBJIGFtIGZpbmRpbmcgb3VyIGFybTY0IEQwNSBib2FyZCBwYXJ0
aWN1bGFybHkgc2xvdyB0byBib290IGZyb20gCj4gbGludXgtbmV4dCwgc3BlY2lmaWNhbGx5IGEg
MzArIHNlY29uZCBwYXVzZSB3aGVuIHNldHRpbmcgdXAgQ1BVIGZlYXR1cmVzLgoKVGhhdCBkb2Vz
IGxvb2sgbGlrZSBpdCdzIGFsbW9zdCBjZXJ0YWlubHkgc3BlbmRpbmcgdGhlIG15c3RlcnkgdGlt
ZSBpbiAKc2V0dXBfY3B1X2ZlYXR1cmVzKCkgaXRzZWxmLgoKPiBJIHRyaWVkIHRvIGJpc2VjdCwg
YnV0IEkgYW0gZmluZGluZyBiaXNlY3QgaG9sZXMgKGJvYXJkIGRvZXMgbm90IGJvb3QgYXQgCj4g
YWxsKS4KCkknZCBzdWdnZXN0IGZvY3VzaW5nIG9uIHRoZSBhcm02NCBmb3ItbmV4dC9jb3JlIGJy
YW5jaCwgc2luY2Ugd2UgaGF2ZSAKc29tZSBjcHVmZWF0dXJlIHJld29yayBxdWV1ZWQgdGhlcmUg
d2hpY2ggd2FzIHN1cHBvc2VkIHRvIG1ha2UgaXQgZ28gCnF1aWNrZXIuLi4KClJvYmluLgoKPiAK
PiBTbmlwcGV0IGdvb2QsIGxpa2UgdjQuMjAtcmM2Ogo+IFvCoMKgwqAgNS40ODI3NTZdIHNtcDog
QnJvdWdodCB1cCA0IG5vZGVzLCA2NCBDUFVzCj4gW8KgwqDCoCA3LjQyMzI0Ml0gU01QOiBUb3Rh
bCBvZiA2NCBwcm9jZXNzb3JzIGFjdGl2YXRlZC4KPiBbwqDCoMKgIDcuNDI4MDg3XSBDUFUgZmVh
dHVyZXM6IGRldGVjdGVkOiBHSUMgc3lzdGVtIHJlZ2lzdGVyIENQVSBpbnRlcmZhY2UKPiBbwqDC
oMKgIDcuNDM0NjIwXSBDUFUgZmVhdHVyZXM6IGRldGVjdGVkOiAzMi1iaXQgRUwwIFN1cHBvcnQK
PiBbwqDCoMKgIDcuNDM5ODEzXSBDUFUgZmVhdHVyZXM6IGRldGVjdGVkOiBDUkMzMiBpbnN0cnVj
dGlvbnMKPiBbwqDCoMKgIDcuNTMwMzM2XSBDUFU6IEFsbCBDUFUocykgc3RhcnRlZCBhdCBFTDIK
PiBbwqDCoMKgIDcuNTM0NTk5XSBhbHRlcm5hdGl2ZXM6IHBhdGNoaW5nIGtlcm5lbCBjb2RlCj4g
W8KgwqDCoCA3LjU1NjA0Ml0gZGV2dG1wZnM6IGluaXRpYWxpemVkCj4gW8KgwqDCoCA3LjU1OTk4
Ml0gY2xvY2tzb3VyY2U6IGppZmZpZXM6IG1hc2s6IDB4ZmZmZmZmZmYgbWF4X2N5Y2xlczogCj4g
MHhmZmZmZmZmZiwgbWF4X2lkbGVfbnM6IDc2NDUwNDE3ODUxMDAwMDAgbnMKPiBbwqDCoMKgIDcu
NTY5OTkxXSBmdXRleCBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjogOCwgMTA0ODU3
NiBieXRlcykKPiBbwqDCoMKgIDcuNTc3MjYyXSBwaW5jdHJsIGNvcmU6IGluaXRpYWxpemVkIHBp
bmN0cmwgc3Vic3lzdGVtCj4gW8KgwqDCoCA3LjU4Mjk0N10gU01CSU9TIDMuMC4wIHByZXNlbnQu
Cj4gW8KgwqDCoCA3LjU4NjI5M10gRE1JOiBIdWF3ZWkgVGFpc2hhbiAyMjgwIC9EMDUsIEJJT1Mg
SGlzaWxpY29uIEQwNSBJVDE3IAo+IE5lbW8gMi4wIFJDMCAxMC8wNS8yMDE4Cj4gW8KgwqDCoCA3
LjU5NDgxMl0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxNgo+IFvCoMKgwqAgNy42
MDAwNzNdIGF1ZGl0OiBpbml0aWFsaXppbmcgbmV0bGluayBzdWJzeXMgKGRpc2FibGVkKQo+IFvC
oMKgwqAgNy42MDU1OTNdIGF1ZGl0OiB0eXBlPTIwMDAgYXVkaXQoNS4wNzI6MSk6IHN0YXRlPWlu
aXRpYWxpemVkIAo+IGF1ZGl0X2VuYWJsZWQ9MCByZXM9MQo+IAo+IAo+IFNuaXBwZXQgbmV4dC0y
MDE4MTIxMToKPiBbwqDCoMKgIDUuNDgzNDIwXSBHSUN2MzogQ1BVNjM6IGZvdW5kIHJlZGlzdHJp
YnV0b3IgNzAzMDMgcmVnaW9uIAo+IDYzOjB4MDAwMDA0MDA2ZDRjMDAwMAo+IFvCoMKgwqAgNS40
ODM0MzhdIEdJQ3YzOiBDUFU2MzogdXNpbmcgYWxsb2NhdGVkIExQSSBwZW5kaW5nIHRhYmxlIAo+
IEAweDAwMDAwMDFmYjhkZDAwMDAKPiBbwqDCoMKgIDUuNDgzNTc4XSBhcmNoX3RpbWVyOiBDUFU2
MzogVHJhcHBpbmcgQ05UVkNUIGFjY2Vzcwo+IFvCoMKgwqAgNS40ODM1ODJdIENQVTYzOiBCb290
ZWQgc2Vjb25kYXJ5IHByb2Nlc3NvciAweDAwMDAwNzAzMDMgWzB4NDEwZmQwODJdCj4gW8KgwqDC
oCA1LjQ4MzY2Nl0gc21wOiBCcm91Z2h0IHVwIDQgbm9kZXMsIDY0IENQVXMKPiBbwqDCoMKgIDcu
NDI0MTYyXSBTTVA6IFRvdGFsIG9mIDY0IHByb2Nlc3NvcnMgYWN0aXZhdGVkLgo+IFvCoMKgwqAg
Ny40MjkwMDZdIENQVSBmZWF0dXJlczogZGV0ZWN0ZWQ6IEdJQyBzeXN0ZW0gcmVnaXN0ZXIgQ1BV
IGludGVyZmFjZQo+IFvCoMKgwqAgNy40MzU1MzhdIENQVSBmZWF0dXJlczogZGV0ZWN0ZWQ6IDMy
LWJpdCBFTDAgU3VwcG9ydAo+IFvCoMKgwqAgNy40NDA3MzFdIENQVSBmZWF0dXJlczogZGV0ZWN0
ZWQ6IENSQzMyIGluc3RydWN0aW9ucwo+IFvCoMKgIDQwLjEwNzk4NF0gQ1BVOiBBbGwgQ1BVKHMp
IHN0YXJ0ZWQgYXQgRUwyCj4gW8KgwqAgNDAuMTEyMjY0XSBhbHRlcm5hdGl2ZXM6IHBhdGNoaW5n
IGtlcm5lbCBjb2RlCj4gW8KgwqAgNDAuMTM0Mjk5XSBkZXZ0bXBmczogaW5pdGlhbGl6ZWQKPiBb
wqDCoCA0MC4xMzgxOTZdIGNsb2Nrc291cmNlOiBqaWZmaWVzOiBtYXNrOiAweGZmZmZmZmZmIG1h
eF9jeWNsZXM6IAo+IDB4ZmZmZmZmZmYsIG1heF9pZGxlX25zOiA3NjQ1MDQxNzg1MTAwMDAwIG5z
Cj4gW8KgwqAgNDAuMTQ4MjA5XSBmdXRleCBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRl
cjogOCwgMTA0ODU3NiBieXRlcykKPiBbwqDCoCA0MC4xNTU0ODZdIHBpbmN0cmwgY29yZTogaW5p
dGlhbGl6ZWQgcGluY3RybCBzdWJzeXN0ZW0KPiBbwqDCoCA0MC4xNjExMDldIFNNQklPUyAzLjAu
MCBwcmVzZW50Lgo+IFvCoMKgIDQwLjE2NDQ1Nl0gRE1JOiBIdWF3ZWkgVGFpc2hhbiAyMjgwIC9E
MDUsIEJJT1MgSGlzaWxpY29uIEQwNSBJVDE3IAo+IE5lbW8gMi4wIFJDMCAxMC8wNS8yMDE4Cj4g
W8KgwqAgNDAuMTcyOTg1XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE2Cj4gW8Kg
wqAgNDAuMTc4MjM2XSBhdWRpdDogaW5pdGlhbGl6aW5nIG5ldGxpbmsgc3Vic3lzIChkaXNhYmxl
ZCkKPiBbwqDCoCA0MC4xODM3NDhdIGF1ZGl0OiB0eXBlPTIwMDAgYXVkaXQoNS4wNzI6MSk6IHN0
YXRlPWluaXRpYWxpemVkIAo+IGF1ZGl0X2VuYWJsZWQ9MCByZXM9MQo+IAo+IEFueW9uZSBlbHNl
IG5vdGljZSBhIHNpbWlsYXIgaXNzdWU/Cj4gCj4gT3VyIG5leHRnZW4gRDA2IGJvYXJkIGRvZXMg
bm90IHNlZW0gdG8gaGF2ZSB0aGlzIGlzc3VlLgo+IAo+IFRoYW5rcywKPiBKb2huCj4gCj4gCj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdAo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
