Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1552DC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:42:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66DA20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="utx4pgAt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ypLVR4O1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66DA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6U7HO44obMuH5qRUW/9GdaPqSP5Y2C4lYkt+LurM104=; b=utx4pgAtTCp3cT
	a5AXtyEaQ/Fw3Y9D5XcS2PeJitj2wbw30p23pbUj8B4RGIgTwzcvW8sxQaHM6ynvlmc6KbZAcBV0w
	0zEdB9M9udsNikqkimA2ZxRLZsD7jxzE+QdOzHVr9pyr10ubCmWyE274p6OM750CiuWgAZ9eDSyB4
	26tAAv95tWHDkXsNkkM6EnWHrQKCgXoEUz9+d0cvWUv+E06F560oraHTz0IKS5URJwB+3T0vewcLN
	ky0sJt8bM3B8lkODpcq44i8s/yDWksz5JbrGFSx2dtajfYbSkqqm+n9t0Z5WLrJNo0BXX3CqWnfD5
	+5vAy2GHsgZ9ZV1mPENQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk70S-0005Ak-LT; Thu, 17 Jan 2019 12:42:48 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk70O-0004yw-7O
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 12:42:46 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0HCgL0g107826;
 Thu, 17 Jan 2019 06:42:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547728941;
 bh=8Or3VrkNirQ12Q3+vnoWE6DAY4MdJCWb/qU8lUtw4tE=;
 h=Subject:From:To:CC:References:Date:In-Reply-To;
 b=ypLVR4O1dpHZHTmOxEN6/5Dn7UdRSjBrs1jtaUsjHIRzwCxJ8VQdN3ukdLFCraN3E
 5phE9ks6R1XChvfUYp/ct9+l2cJnp8ackpZrKPkvzl223YFjvkb8q3ZLFYHY1hPepj
 AjjqKjBec5wPPIFnJib3nj7WDvSEVhs33xnQ0yeA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0HCgL8n116640
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Jan 2019 06:42:21 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 17
 Jan 2019 06:42:21 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 17 Jan 2019 06:42:21 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0HCgHva011564;
 Thu, 17 Jan 2019 06:42:18 -0600
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
From: Sekhar Nori <nsekhar@ti.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-3-brgl@bgdev.pl>
 <08200de1-fde5-c525-c874-c7872259067b@ti.com>
 <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
 <a7d4994d-7740-c845-da67-9d06e6d874cc@ti.com>
Message-ID: <d9bc1153-3b65-19a8-67ef-e131296cd8b1@ti.com>
Date: Thu, 17 Jan 2019 18:12:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a7d4994d-7740-c845-da67-9d06e6d874cc@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_044244_390915_BD13E0DB 
X-CRM114-Status: GOOD (  23.14  )
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
 devicetree <devicetree@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTYvMDEvMTkgMjo0OCBQTSwgU2VraGFyIE5vcmkgd3JvdGU6Cj4gT24gMTQvMDEvMTkgMTA6
MDkgUE0sIEJhcnRvc3ogR29sYXN6ZXdza2kgd3JvdGU6Cj4+IHBvbi4sIDE0IHN0eSAyMDE5IG8g
MTM6MjAgU2VraGFyIE5vcmkgPG5zZWtoYXJAdGkuY29tPiBuYXBpc2HFgihhKToKPj4+Cj4+PiBI
aSBCYXJ0b3N6LAo+Pj4KPj4+IE9uIDExLzAxLzE5IDEwOjUxIFBNLCBCYXJ0b3N6IEdvbGFzemV3
c2tpIHdyb3RlOgo+Pj4+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBi
YXlsaWJyZS5jb20+Cj4+Pj4KPj4+PiBDdXJyZW50bHkgdGhlIGNsb2Nrc291cmNlIGFuZCBjbG9j
a2V2ZW50IHN1cHBvcnQgZm9yIGRhdmluY2kgcGxhdGZvcm1zCj4+Pj4gbGl2ZXMgaW4gbWFjaC1k
YXZpbmNpLiBJdCBoYXJkLWNvZGVzIG1hbnkgdGhpbmdzLCB1c2VkIGdsb2JhbCB2YXJpYWJsZXMs
Cj4+Pj4gaW1wbGVtZW50cyBmdW5jdGlvbmFsaXRpZXMgdW51c2VkIGJ5IGFueSBwbGF0Zm9ybSBh
bmQgaGFzIGNvZGUgZnJhZ21lbnRzCj4+Pj4gc2NhdHRlcmVkIGFjcm9zcyBtYW55IChvZnRlbiB1
bnJlbGF0ZWQpIGZpbGVzLgo+Pj4+Cj4+Pj4gSW1wbGVtZW50IGEgbmV3LCBtb2Rlcm4gYW5kIHNp
bXBsaWZpZWQgdGltZXIgZHJpdmVyIGFuZCBwdXQgaXQgaW50bwo+Pj4+IGRyaXZlcnMvY2xvY2tz
b3VyY2UuIFdlIHN0aWxsIG5lZWQgdG8gc3VwcG9ydCBsZWdhY3kgYm9hcmQgZmlsZXMgc28KPj4+
PiBleHBvcnQgYSBjb25maWcgc3RydWN0dXJlIGFuZCBhIGZ1bmN0aW9uIHRoYXQgYWxsb3dzIG1h
Y2hpbmUgY29kZSB0bwo+Pj4+IHJlZ2lzdGVyIHRoZSB0aW1lci4KPj4+Pgo+Pj4+IFdlIGRvbid0
IGNoZWNrIHRoZSByZXR1cm4gdmFsdWVzIG9mIHJlZ21hcCByZWFkcyBhbmQgd3JpdGVzIHNpbmNl
IHdpdGgKPj4+PiBtbWlvIGl0J3Mgb25seSBsaWtlbHkgdG8gZmFpbCBkdWUgdG8gcHJvZ3JhbW1l
cidzIGVycm9ycy4KPj4+Pgo+Pj4+IFdlIGFsc28gZG9uJ3QgYm90aGVyIGZyZWVpbmcgcmVzb3Vy
Y2VzIG9uIGVycm9ycyBpbgo+Pj4+IGRhdmluY2lfdGltZXJfcmVnaXN0ZXIoKSBhcyB0aGUgc3lz
dGVtIHdvbid0IGJvb3Qgd2l0aG91dCBhIHRpbWVyIGFueXdheS4KPj4+Pgo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Cj4+
Pgo+Pj4gV2l0aCB0aGlzIHNlcmllcywgREE4MzAgZmFpbHMgdG8gYm9vdC4gUmVzdCBvZiB0aGUg
ZGV2aWNlcyBhcmUgb2theSBmcm9tCj4+PiBib290IHBlcnNwZWN0aXZlLgo+Pj4KPj4+IERBODMw
IGlzIHByZXR0eSB1bmlxdWUgYmVjYXVzZSBpdCB1c2VzIHRoZSBzYW1lIHRpbWVyLWhhbGYgZm9y
IGJvdGgKPj4+IGNsb2Nrc291cmNlIGFuZCBjbG9ja2V2ZW50LiBNYXkgYmUgeW91IGNhbiBzZXQg
dGhlIHNhbWUgY29uZmlndXJhdGlvbiBvbgo+Pj4geW91ciBEQTg1MCB0byBzZWUgdGhlIHNhbWUg
aXNzdWU/IEVsc2UsIEkgd2lsbCBlbmFibGUgbG93LWxldmVsIGRlYnVnCj4+PiBhbmQgdHJ5IHRv
IHByb3ZpZGUgbW9yZSBkZWJ1ZyBkYXRhLgo+Pj4KPj4KPj4gSSBjYW4ndCBib290IGRhODUwIHdp
dGggdGhlIHNhbWUgY29uZmlnIGFzIGRhODMwICgweDYwIGNvbXBhcmUKPj4gcmVnaXN0ZXIsIGNv
bXBhcmUgaXJxIDc0KSBldmVuIHdpdGggdGhlIG9sZCB0aW1lciBjb2RlLiBKdXN0IHRvIG1ha2UK
Pj4gc3VyZTogZG9lcyBkYTgzMCBib290IGZpbmUgd2l0aCBtYWlubGluZSB2NS4wLXJjMj8KPiAK
PiBZZWFoLCBJIGRpZCBjaGVjayB0aGF0IHdpdGhvdXQgdGhlIHBhdGNoIERBODMwIGRvZXMgYm9v
dC4KCllvdSBhcmUgcmlnaHQgdGhhdCBEQTg1MCBsYWNrcyBjb21wYXJlIGludGVycnVwdHMgZm9y
IHRpbWVycyAwIGFuZCAxLgpTbywgeWVzLCBpdCBzZWVtcyBsaWtlIHdlIHdpbGwgaGF2ZSB0byBz
aGlmdCB0byB0aW1lcjIgdG8gdGVzdApjb21wYXJlIGludGVycnVwdHMgb24gREE4NTAuCgpKdXN0
IHRvIGNvbmZpcm0sIERBODMwIGJvb3RzIGZpbmUgd2l0aCB0aGUgY29tcGFyZSBzZWN0aW9uIHJl
bW92ZWQ6CgotLS04PC0tLQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2RhODMw
LmMgYi9hcmNoL2FybS9tYWNoLWRhdmluY2kvZGE4MzAuYwppbmRleCAwZDgxYThmZGQ5ZTYuLmYz
NDM5OGE3ZTQ3YyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2RhODMwLmMKKysr
IGIvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2RhODMwLmMKQEAgLTc4OCwxNCArNzg4LDYgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBkYXZpbmNpX3RpbWVyX2NmZyBkYTgzMF90aW1lcl9jZmcgPSB7CiAJ
CQkuZmxhZ3MJPSBJT1JFU09VUkNFX0lSUSwKIAkJfSwKIAl9LAotCS5jbXAgPSB7Ci0JCS5pcnEg
PSB7Ci0JCQkuc3RhcnQJPSBJUlFfREE4MzBfVDEyQ01QSU5UMF8wLAotCQkJLmVuZAk9IElSUV9E
QTgzMF9UMTJDTVBJTlQwXzAsCi0JCQkuZmxhZ3MJPSBJT1JFU09VUkNFX0lSUSwKLQkJfSwKLQkJ
Lm9mZnNldAkJPSBEQTgzMF9DTVAxMl8wLAotCX0KIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZGF2aW5jaV9zb2NfaW5mbyBkYXZpbmNpX3NvY19pbmZvX2RhODMwID0gewotLS04PC0tLQoKQW5k
IHRoZSBsb3ctbGV2ZWwgZGVidWcgd2l0aCB5b3VyIHBhdGNoZXMgc2hvd3MgdGhhdCBpdHMgaGFu
Z2luZyBhdCAKZGVsYXkgbG9vcCBjYWxpYnJhdGlvbi4KClVuY29tcHJlc3NpbmcgTGludXguLi4g
ZG9uZSwgYm9vdGluZyB0aGUga2VybmVsLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
CkJvb3RpbmcgTGludXggb24gcGh5c2ljYWwgQ1BVIDB4MCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgCkxpbnV4IHZlcnNpb24gNS4wLjAtcmMxLTA4Njk5LWdj
ODdkMzg2Nzg0ZjMtZGlydHkgKGEwODc1NTE2QHBzcGxpbnV4MDYzKSAoZ2NjIHY5CkNQVTogQVJN
OTI2RUotUyBbNDEwNjkyNjVdIHJldmlzaW9uIDUgKEFSTXY1VEVKKSwgY3I9MDAwNTMxN2YgICAg
ICAgICAgICAgICAgICAgCkNQVTogVklWVCBkYXRhIGNhY2hlLCBWSVZUIGluc3RydWN0aW9uIGNh
Y2hlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCk1hY2hpbmU6IERhVmluY2kg
REE4MzAvT01BUC1MMTM3L0FNMTd4IEVWTSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgCk1lbW9yeSBwb2xpY3k6IERhdGEgY2FjaGUgd3JpdGV0aHJvdWdoICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCmNtYTogUmVzZXJ2ZWQgMTYgTWlCIGF0IDB4
YzI4MDAwMDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCkRh
VmluY2kgZGE4MzAvb21hcC1sMTM3IHJldjIuMCB2YXJpYW50IDB4OSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgCk9uIG5vZGUgMCB0b3RhbHBhZ2VzOiAxNDMzNiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgRE1BIHpvbmU6
IDExMiBwYWdlcyB1c2VkIGZvciBtZW1tYXAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCiAgRE1BIHpvbmU6IDAgcGFnZXMgcmVzZXJ2ZWQgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgRE1BIHpvbmU6IDE0MzM2IHBh
Z2VzLCBMSUZPIGJhdGNoOjMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgCnJhbmRvbTogZ2V0X3JhbmRvbV9ieXRlcyBjYWxsZWQgZnJvbSBzdGFydF9rZXJuZWwrMHg4
MC8weDNlYyB3aXRoIGNybmdfaW5pdD0wICAgCnBjcHUtYWxsb2M6IHMwIHIwIGQzMjc2OCB1MzI3
NjggYWxsb2M9MSozMjc2OCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCnBjcHUt
YWxsb2M6IFswXSAwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgCkJ1aWx0IDEgem9uZWxpc3RzLCBtb2JpbGl0eSBncm91cGluZyBv
bi4gIFRvdGFsIHBhZ2VzOiAxNDIyNCAgICAgICAgICAgICAgICAgICAgCktlcm5lbCBjb21tYW5k
IGxpbmU6IGNvbnNvbGU9dHR5UzIsMTE1MjAwbjggICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCkRlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDgxOTIgKG9yZGVyOiAz
LCAzMjc2OCBieXRlcykgICAgICAgICAgICAgICAgICAgCklub2RlLWNhY2hlIGhhc2ggdGFibGUg
ZW50cmllczogNDA5NiAob3JkZXI6IDIsIDE2Mzg0IGJ5dGVzKSAgICAgICAgICAgICAgICAgICAg
Ck1lbW9yeTogMzM4NzZLLzU3MzQ0SyBhdmFpbGFibGUgKDQ2MDdLIGtlcm5lbCBjb2RlLCAzMDhL
IHJ3ZGF0YSwgMTA3Mksgcm9kYXRhLCApClZpcnR1YWwga2VybmVsIG1lbW9yeSBsYXlvdXQ6ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICB2ZWN0
b3IgIDogMHhmZmZmMDAwMCAtIDB4ZmZmZjEwMDAgICAoICAgNCBrQikgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgCiAgICBmaXhtYXAgIDogMHhmZmMwMDAwMCAtIDB4ZmZmMDAwMDAgICAo
MzA3MiBrQikgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICB2bWFsbG9jIDogMHhj
NDAwMDAwMCAtIDB4ZmY4MDAwMDAgICAoIDk1MiBNQikgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgCiAgICBsb3dtZW0gIDogMHhjMDAwMDAwMCAtIDB4YzM4MDAwMDAgICAoICA1NiBNQikg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICBtb2R1bGVzIDogMHhiZjAwMDAwMCAt
IDB4YzAwMDAwMDAgICAoICAxNiBNQikgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAg
ICAgIC50ZXh0IDogMHgocHRydmFsKSAtIDB4KHB0cnZhbCkgICAoNDYwOSBrQikgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgCiAgICAgIC5pbml0IDogMHgocHRydmFsKSAtIDB4KHB0cnZh
bCkgICAoIDIxMiBrQikgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgIC5kYXRh
IDogMHgocHRydmFsKSAtIDB4KHB0cnZhbCkgICAoIDMwOSBrQikgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCiAgICAgICAuYnNzIDogMHgocHRydmFsKSAtIDB4KHB0cnZhbCkgICAoIDEz
NyBrQikgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgClNMVUI6IEhXYWxpZ249MzIsIE9y
ZGVyPTAtMywgTWluT2JqZWN0cz0wLCBDUFVzPTEsIE5vZGVzPTEgICAgICAgICAgICAgICAgICAg
ICAgCnJjdTogUHJlZW1wdGlibGUgaGllcmFyY2hpY2FsIFJDVSBpbXBsZW1lbnRhdGlvbi4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgVGFza3MgUkNVIGVuYWJsZWQuICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCnJjdTog
UkNVIGNhbGN1bGF0ZWQgdmFsdWUgb2Ygc2NoZWR1bGVyLWVubGlzdG1lbnQgZGVsYXkgaXMgMTAg
amlmZmllcy4gICAgICAgICAgCk5SX0lSUVM6IDI0NSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCmNsb2Nrc291cmNlOiB0
aW1lcjBfMDogbWFzazogMHhmZmZmZmZmZiBtYXhfY3ljbGVzOiAweGZmZmZmZmZmLCBtYXhfaWRs
ZV9uczogNzlzCnNjaGVkX2Nsb2NrOiAzMiBiaXRzIGF0IDI0TUh6LCByZXNvbHV0aW9uIDQxbnMs
IHdyYXBzIGV2ZXJ5IDg5NDc4NDg0OTcxbnMgICAgICAgCkNvbnNvbGU6IGNvbG91ciBkdW1teSBk
ZXZpY2UgODB4MzAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
CkNhbGlicmF0aW5nIGRlbGF5IGxvb3AuLi4gCjxoYW5ncz4KClRoYW5rcywKU2VraGFyCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
