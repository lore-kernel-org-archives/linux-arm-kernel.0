Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31D7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:00:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80AA620874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IJq4esVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AA620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:Subject:To:From:
	Date:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PzBD1sf7gH5UAF24/y3s5/SCBE2tomoZedigtxbY43s=; b=IJq4esVQV6jFSzvauzW+KyWuv
	knp+Tihotf+cGfDYI0HuXjEuvEFq/Kx+8m4aiCNd6XNQL7jeLCt08ECNN2INynJP2rep0+qD2nIRf
	TcZgySzaFSejMaShvS++IqDDgPnhCibVAcG9MJWZrGEUsR3tV5NAimljYrSvDBDRdmB9efrTcGiET
	poHDxPWfrCkVbtrdQ9wQ5M0UnJPaTAsAj01bONpE9JYOoi5WmuiNLrA67vc6Svg4Bsu9h5KSwmuzS
	6gcGULNT87SkA1yVkvP2P6VSu53q7fKxl2zXuCQVZ+i4GHJgbmzKVsKzvDIBgosbMVDaQHPjDFATQ
	X/bRC1qEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuNQ-0006tn-3S; Mon, 17 Dec 2018 15:00:12 +0000
Received: from mailgate-2.ics.forth.gr ([139.91.1.5])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuNK-0005d1-Ce; Mon, 17 Dec 2018 15:00:09 +0000
Received: from av1.ics.forth.gr (av3in [139.91.1.77])
 by mailgate-2.ics.forth.gr (8.14.4/ICS-FORTH/V10-1.8-GATE) with ESMTP id
 wBHExMmr001882; Mon, 17 Dec 2018 14:59:24 GMT
X-AuditID: 8b5b9d4d-90dff7000000235c-08-5c17b9c9032a
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.1.35])
 by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id
 8B.2C.09052.9C9B71C5; Mon, 17 Dec 2018 16:59:22 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
 by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with
 ESMTP id wBHExJbC026827; Mon, 17 Dec 2018 16:59:20 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Date: Mon, 17 Dec 2018 16:59:19 +0200
From: Nick Kossifidis <mick@ics.forth.gr>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2 6/6] RISC-V: Implement sparsemem
Organization: FORTH
In-Reply-To: <20181015175702.9036-7-logang@deltatee.com>
References: <20181015175702.9036-1-logang@deltatee.com>
 <20181015175702.9036-7-logang@deltatee.com>
Message-ID: <4b591ba933363e29392dba218ef63267@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsXSHc2orHtqp3iMwbMJrBZz1q9hs9hyO8Zi
 6+9Z7BZ/Jx1jt1i5+iiTxabH11gtLu+aw2Zxb81/Vottn1vYLOb8mcJssaT1OJvFxw2fWSxO
 Xf/MZrF5wgJWi/97drBbfD4zj9Xi+cpeNgdBjz2nZzF7/P41idHj2dVnjB6HO76we2xa1cnm
 senTJHaPEzN+s3hsXlLvceVEE6vH7psNbB6rOvexe2xb/JLV41LzdXaPz5vkAviiuGxSUnMy
 y1KL9O0SuDKe/j3HWNCiUbHoeyNbA2OTQhcjJ4eEgInE49aZzF2MXBxCAkcYJXqON7NDOIcY
 JX68XcUKUWUqMXtvJyOIzSsgKHFy5hMWEJtZwEJi6pX9jBC2vETz1tnMIDaLgKpE+/eN7CA2
 m4CmxPxLB4HqOThEgOwtr3xB5jMLfGCRmPvhItgcYQFziYePu5hAbH4BYYlPdy+C7eUEmt+2
 +AdYjZBAqsS8S2ehbnCRWHRxBQvEbSoSH34/ANslKqAs8eLEdNYJjEKzkJw6C8mps5CcuoCR
 eRWjQGKZsV5mcrFeWn5RSYZeetEmRnAcz/XdwXhugf0hRgEORiUeXs39YjFCrIllxZW5wIDh
 YFYS4e21BArxpiRWVqUW5ccXleakFh9ilOZgURLnPfwiPEhIID2xJDU7NbUgtQgmy8TBKdXA
 WGsvmfPvnOm0uCdu15l5Feb+br7ieOLMMimxeAM+7lef9h3b7bBjUfjpdn0Gv86qjnOHVFaL
 NzMVV59fHJ7V//VFlIW74B2+Vfsnu8o8Fk4VqvTaYZuwovJYkrhT9jT+NL2amteHJ+7I5rR8
 dnbiis2+Z1zZVU/saDghPGORhMt9zm/5H4SvKbEUZyQaajEXFScCAEfgw+ffAgAA
X-Greylist: inspected by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr
 [139.91.1.5]);
 Mon, 17 Dec 2018 14:59:25 +0000 (GMT) for IP:'139.91.1.77' DOMAIN:'av3in'
 HELO:'av1.ics.forth.gr' FROM:'mick@ics.forth.gr' RCPT:''
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mailgate-2.ics.forth.gr [139.91.1.5]); Mon, 17 Dec 2018 14:59:25 +0000 (GMT)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_070006_807746_0BAE6F49 
X-CRM114-Status: GOOD (  22.28  )
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
Cc: Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Waterman <andrew@sifive.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
 linux-kernel@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
 Zong Li <zong@andestech.com>, linux-mm@kvack.org,
 Olof Johansson <olof@lixom.net>, linux-riscv@lists.infradead.org,
 Michael Clark <michaeljclark@mac.com>, Christoph Hellwig <hch@lst.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8gTG9nYW4sCgrOo8+EzrnPgiAyMDE4LTEwLTE1IDIwOjU3LCBMb2dhbiBHdW50aG9ycGUg
zq3Os8+BzrHPiM61Ogo+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyBzcGFyc2VtZW0gc3VwcG9ydCBm
b3IgcmlzYy12IHdoaWNoIGhlbHBzIHBhdmUgdGhlCj4gd2F5IGZvciBtZW1vcnkgaG90cGx1ZyBh
bmQgZXZlbnR1YWxseSBQMlAgc3VwcG9ydC4KPiAKPiBXZSBpbnRyb2R1Y2UgS2NvbmZpZyBvcHRp
b25zIGZvciB2aXJ0dWFsIGFuZCBwaHlzaWNhbCBhZGRyZXNzIGJpdHMgCj4gd2hpY2gKPiBhcmUg
dXNlZCB0byBjYWxjdWxhdGUgdGhlIHNpemUgb2YgdGhlIHZtZW1tYXAgYW5kIHNldCB0aGUKPiBN
QVhfUEhZU01FTV9CSVRTLgo+IAo+IFRoZSB2bWVtbWFwIGlzIGxvY2F0ZWQgZGlyZWN0bHkgYmVm
b3JlIHRoZSBWTUFMTE9DIHJlZ2lvbiBhbmQgc2l6ZWQKPiBzdWNoIHRoYXQgd2UgY2FuIGFsbG9j
YXRlIGVub3VnaCBwYWdlcyB0byBwb3B1bGF0ZSBhbGwgdGhlIHZpcnR1YWwKPiBhZGRyZXNzIHNw
YWNlIGluIHRoZSBzeXN0ZW0gKHNpbWlsYXIgdG8gdGhlIHdheSBpdCdzIGRvbmUgaW4gYXJtNjQp
Lgo+IAo+IER1cmluZyBpbml0aWFsaXphdGlvbiwgY2FsbCBtZW1ibG9ja3NfcHJlc2VudCgpIGFu
ZCBzcGFyc2VfaW5pdCgpLAo+IGFuZCBwcm92aWRlIGEgc3R1YiBmb3Igdm1lbW1hcF9wb3B1bGF0
ZSgpIChhbGwgb2Ygd2hpY2ggaXMgc2ltaWxhciB0bwo+IGFybTY0KS4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+Cj4gUmV2aWV3ZWQtYnk6
IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAc2lmaXZlLmNvbT4KPiBDYzogQWxiZXJ0IE91IDxhb3VA
ZWVjcy5iZXJrZWxleS5lZHU+Cj4gQ2M6IEFuZHJldyBXYXRlcm1hbiA8YW5kcmV3QHNpZml2ZS5j
b20+Cj4gQ2M6IE9sb2YgSm9oYW5zc29uIDxvbG9mQGxpeG9tLm5ldD4KPiBDYzogTWljaGFlbCBD
bGFyayA8bWljaGFlbGpjbGFya0BtYWMuY29tPgo+IENjOiBSb2IgSGVycmluZyA8cm9iaEBrZXJu
ZWwub3JnPgo+IENjOiBab25nIExpIDx6b25nQGFuZGVzdGVjaC5jb20+Cj4gLS0tCj4gIGFyY2gv
cmlzY3YvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrKysrKysr
Kwo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3BndGFibGUuaCAgIHwgMjEgKysrKysrKysrKysr
KysrKystLS0tCj4gIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3BhcnNlbWVtLmggfCAxMSArKysr
KysrKysrKwo+ICBhcmNoL3Jpc2N2L2tlcm5lbC9zZXR1cC5jICAgICAgICAgIHwgIDQgKysrLQo+
ICBhcmNoL3Jpc2N2L21tL2luaXQuYyAgICAgICAgICAgICAgIHwgIDggKysrKysrKysKPiAgNSBm
aWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zcGFyc2VtZW0uaAo+IAo+IGRpZmYg
LS1naXQgYS9hcmNoL3Jpc2N2L0tjb25maWcgYi9hcmNoL3Jpc2N2L0tjb25maWcKPiBpbmRleCBh
MzQ0OTgwMjg3YTUuLmExYjVkNzU4YTU0MiAxMDA2NDQKPiAtLS0gYS9hcmNoL3Jpc2N2L0tjb25m
aWcKPiArKysgYi9hcmNoL3Jpc2N2L0tjb25maWcKPiBAQCAtNTIsMTIgKzUyLDMyIEBAIGNvbmZp
ZyBaT05FX0RNQTMyCj4gIAlib29sCj4gIAlkZWZhdWx0IHkgaWYgNjRCSVQKPiAKPiArY29uZmln
IFZBX0JJVFMKPiArCWludAo+ICsJZGVmYXVsdCAzMiBpZiAzMkJJVAo+ICsJZGVmYXVsdCAzOSBp
ZiA2NEJJVAo+ICsKPiArY29uZmlnIFBBX0JJVFMKPiArCWludAo+ICsJZGVmYXVsdCAzNCBpZiAz
MkJJVAo+ICsJZGVmYXVsdCA1NiBpZiA2NEJJVAo+ICsKPiAgY29uZmlnIFBBR0VfT0ZGU0VUCj4g
IAloZXgKPiAgCWRlZmF1bHQgMHhDMDAwMDAwMCBpZiAzMkJJVCAmJiBNQVhQSFlTTUVNXzJHQgo+
ICAJZGVmYXVsdCAweGZmZmZmZmZmODAwMDAwMDAgaWYgNjRCSVQgJiYgTUFYUEhZU01FTV8yR0IK
PiAgCWRlZmF1bHQgMHhmZmZmZmZlMDAwMDAwMDAwIGlmIDY0QklUICYmIE1BWFBIWVNNRU1fMTI4
R0IKPiAKPiArY29uZmlnIEFSQ0hfRkxBVE1FTV9FTkFCTEUKPiArCWRlZl9ib29sIHkKPiArCj4g
K2NvbmZpZyBBUkNIX1NQQVJTRU1FTV9FTkFCTEUKPiArCWRlZl9ib29sIHkKPiArCXNlbGVjdCBT
UEFSU0VNRU1fVk1FTU1BUF9FTkFCTEUKPiArCj4gK2NvbmZpZyBBUkNIX1NFTEVDVF9NRU1PUllf
TU9ERUwKPiArCWRlZl9ib29sIEFSQ0hfU1BBUlNFTUVNX0VOQUJMRQo+ICsKPiAgY29uZmlnIFNU
QUNLVFJBQ0VfU1VQUE9SVAo+ICAJZGVmX2Jvb2wgeQo+IAo+IEBAIC05Miw2ICsxMTIsOSBAQCBj
b25maWcgUEdUQUJMRV9MRVZFTFMKPiAgY29uZmlnIEhBVkVfS1BST0JFUwo+ICAJZGVmX2Jvb2wg
bgo+IAo+ICtjb25maWcgSEFWRV9BUkNIX1BGTl9WQUxJRAo+ICsJZGVmX2Jvb2wgeQo+ICsKPiAg
bWVudSAiUGxhdGZvcm0gdHlwZSIKPiAKPiAgY2hvaWNlCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlz
Y3YvaW5jbHVkZS9hc20vcGd0YWJsZS5oIAo+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3Rh
YmxlLmgKPiBpbmRleCAxNjMwMTk2NmQ2NWIuLmUxMTYyMzM2ZjVlYSAxMDA2NDQKPiAtLS0gYS9h
cmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3BndGFibGUuaAo+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVk
ZS9hc20vcGd0YWJsZS5oCj4gQEAgLTg5LDYgKzg5LDIzIEBAIGV4dGVybiBwZ2RfdCBzd2FwcGVy
X3BnX2RpcltdOwo+ICAjZGVmaW5lIF9fUzExMAlQQUdFX1NIQVJFRF9FWEVDCj4gICNkZWZpbmUg
X19TMTExCVBBR0VfU0hBUkVEX0VYRUMKPiAKPiArI2RlZmluZSBWTUFMTE9DX1NJWkUgICAgIChL
RVJOX1ZJUlRfU0laRSA+PiAxKQo+ICsjZGVmaW5lIFZNQUxMT0NfRU5EICAgICAgKFBBR0VfT0ZG
U0VUIC0gMSkKPiArI2RlZmluZSBWTUFMTE9DX1NUQVJUICAgIChQQUdFX09GRlNFVCAtIFZNQUxM
T0NfU0laRSkKPiArCj4gKy8qCj4gKyAqIFJvdWdobHkgc2l6ZSB0aGUgdm1lbW1hcCBzcGFjZSB0
byBiZSBsYXJnZSBlbm91Z2ggdG8gZml0IGVub3VnaAo+ICsgKiBzdHJ1Y3QgcGFnZXMgdG8gbWFw
IGhhbGYgdGhlIHZpcnR1YWwgYWRkcmVzcyBzcGFjZS4gVGhlbgo+ICsgKiBwb3NpdGlvbiB2bWVt
bWFwIGRpcmVjdGx5IGJlbG93IHRoZSBWTUFMTE9DIHJlZ2lvbi4KPiArICovCj4gKyNkZWZpbmUg
Vk1FTU1BUF9TSElGVCBcCj4gKwkoQ09ORklHX1ZBX0JJVFMgLSBQQUdFX1NISUZUIC0gMSArIFNU
UlVDVF9QQUdFX01BWF9TSElGVCkKPiArI2RlZmluZSBWTUVNTUFQX1NJWkUJKDFVTCA8PCBWTUVN
TUFQX1NISUZUKQo+ICsjZGVmaW5lIFZNRU1NQVBfRU5ECShWTUFMTE9DX1NUQVJUIC0gMSkKPiAr
I2RlZmluZSBWTUVNTUFQX1NUQVJUCShWTUFMTE9DX1NUQVJUIC0gVk1FTU1BUF9TSVpFKQo+ICsK
PiArI2RlZmluZSB2bWVtbWFwCQkoKHN0cnVjdCBwYWdlICopVk1FTU1BUF9TVEFSVCkKPiArCj4g
IC8qCj4gICAqIFpFUk9fUEFHRSBpcyBhIGdsb2JhbCBzaGFyZWQgcGFnZSB0aGF0IGlzIGFsd2F5
cyB6ZXJvLAo+ICAgKiB1c2VkIGZvciB6ZXJvLW1hcHBlZCBtZW1vcnkgYXJlYXMsIGV0Yy4KPiBA
QCAtNDExLDEwICs0MjgsNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcGd0YWJsZV9jYWNoZV9pbml0
KHZvaWQpCj4gIAkvKiBObyBwYWdlIHRhYmxlIGNhY2hlcyB0byBpbml0aWFsaXplICovCj4gIH0K
PiAKPiAtI2RlZmluZSBWTUFMTE9DX1NJWkUgICAgIChLRVJOX1ZJUlRfU0laRSA+PiAxKQo+IC0j
ZGVmaW5lIFZNQUxMT0NfRU5EICAgICAgKFBBR0VfT0ZGU0VUIC0gMSkKPiAtI2RlZmluZSBWTUFM
TE9DX1NUQVJUICAgIChQQUdFX09GRlNFVCAtIFZNQUxMT0NfU0laRSkKPiAtCj4gIC8qCj4gICAq
IFRhc2sgc2l6ZSBpcyAweDQwMDAwMDAwMDAwIGZvciBSVjY0IG9yIDB4YjgwMDAwMCBmb3IgUlYz
Mi4KPiAgICogTm90ZSB0aGF0IFBHRElSX1NJWkUgbXVzdCBldmVubHkgZGl2aWRlIFRBU0tfU0la
RS4KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zcGFyc2VtZW0uaAo+IGIv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zcGFyc2VtZW0uaAo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
Cj4gaW5kZXggMDAwMDAwMDAwMDAwLi4yMTU1MzBiMjQzMzYKPiAtLS0gL2Rldi9udWxsCj4gKysr
IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zcGFyc2VtZW0uaAo+IEBAIC0wLDAgKzEsMTEgQEAK
PiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8KPiArCj4gKyNpZm5kZWYg
X19BU01fU1BBUlNFTUVNX0gKPiArI2RlZmluZSBfX0FTTV9TUEFSU0VNRU1fSAo+ICsKPiArI2lm
ZGVmIENPTkZJR19TUEFSU0VNRU0KPiArI2RlZmluZSBNQVhfUEhZU01FTV9CSVRTCUNPTkZJR19Q
QV9CSVRTCj4gKyNkZWZpbmUgU0VDVElPTl9TSVpFX0JJVFMJMzAKCkhhdmluZyBtZW1vcnkgYmxv
Y2tzIG9mIGEgbWluaW11bSBzaXplIG9mIDFHQiBkb2Vzbid0IG1ha2UgbXVjaCBzZW5zZS4gCkl0
IG1ha2VzIGl0IGhhcmRlciB0byBpbXBsZW1lbnQgaG90cGx1ZyBvbiB0b3Agb2YgdGhpcyBzaW5j
ZSB3ZSdsbCBvbmx5IAphYmxlIHRvIGFkZC9yZW1vdmUgMUdCIGF0IGEgdGltZS4gQVJNIHVzZWQg
dG8gZG8gdGhlIHNhbWUgYW5kIHRoZXkgCnN3aXRjaGVkIHRvIDI3Yml0cyAoaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wYXRjaC85MTcyODQ1LyksIEFSTTY0IApzdGlsbCB1c2VzIDFHQiwg
eDg2IGFsc28gdXNlcyAyN2JpdHMgYW5kIG1vc3QgYXJjaHMgYWxzbyB1c2Ugc29tZXRoaW5nIApi
ZWxvdyAzMC4gSSBiZWxpZXZlIHdlIHNob3VsZCBnbyBmb3IgMjdiaXRzIGFzIHdlbGwgb3IgZXZl
biBiZXR0ZXIgaGF2ZSAKdGhpcyBhcyBhIGNvbXBpbGUgdGltZSBvcHRpb24uCgpCVFcgbWVtYmxv
Y2tzX3ByZXNlbnQgaXMgb24gbWFzdGVyIG5vdyAoZ290IG1lcmdlZCAzIGRheXMgYWdvKS4KClJl
Z2FyZHMsCk4uCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
