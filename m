Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC291C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:18:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B950B218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UrUjrncL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="fmu6F0v7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B950B218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:Mime-Version:References:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4/+ATmdRuLgAdBfEGoOBh9a3PAoVNjfQsktpCMMIT6Y=; b=UrUjrncLyF8azQ
	QtZLh1f7QIA1fix8JteVmoloQJsDpeOR5ev/DfN/uVdDSc7DpSl4se9w67OCuvMbFDEeFn9adYbxE
	qYWEhX6ZBtYjqjJzWK5jHqGQYiDooe5H4ayacXlySEI51Wgk8cwz6k11snR5z57sqoE1yEV4ByJw6
	67+5jxLj5caxWATOHSTE9eQvdAWfpBOaF3waN89RXXiL2OH/Irah+Zr+zs8xunNwMr5+z8YF3jo/T
	8G7U7TMZwJF1mcEUQi9D4lW88H9jTcOX2YxF0iAA6oruKBSXXwUajUMWC8uldkol1FOeJL1TCWrcO
	l4Ymt8F4fDH4xKt++a9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvdBg-0006oW-4T; Mon, 18 Feb 2019 07:18:00 +0000
Received: from m12-16.163.com ([220.181.12.16])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvdBc-0006nr-2K
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 07:17:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Mime-Version:Message-ID; bh=qzoYb
 YNOC1ZuPNkfKC7X7zmWb4ImdHXfdKNpFGmO9eE=; b=fmu6F0v7uYhm3RePsy8VF
 RVldoA7x1dAKOtilrghSe8uV3zZTfeuJY1q2Sw+rMWZyZJDU4COvELuYdzSzKkUr
 cI27X4JLK03Y4bGQ38GLvYygcOzDSvIxZPliKs3pYHaAmd6dkPGCDR+fxF0uKHI3
 kghy2uCcVWXR3clfbRTqOg=
Received: from WIN-20190131HRV (unknown [202.100.35.16])
 by smtp12 (Coremail) with SMTP id EMCowAAXkfQeXGpczS6NGA--.1316S2;
 Mon, 18 Feb 2019 15:17:51 +0800 (CST)
Date: Mon, 18 Feb 2019 15:16:37 +0800
From: "sxauwsk@163.com" <sxauwsk@163.com>
To: "Shubhrajyoti Datta" <shubhrajyoti.datta@gmail.com>
Subject: Re: Re: [PATCH] i2c: cadence: try reset when master receive error
 interrupts
References: <20190129195214.30272-1-sxauwsk@163.com>, 
 <CAKfKVtELqoNNJB0qB88ghGoVrdV2-Ez1DjvmT3dZifntdV0GQg@mail.gmail.com>, 
 <2019021615501780626817@163.com>, 
 <CAKfKVtGu3dzSR71-Rsp8SR8nq8-XhY5FrgDvxv9iu_L-TyL5+Q@mail.gmail.com>
X-Priority: 3
X-GUID: B5CE20E9-F8C3-493E-9146-B27E3736704F
X-Has-Attach: no
X-Mailer: Foxmail 7.2.9.156[cn]
Mime-Version: 1.0
Message-ID: <2019021815163582329937@163.com>
X-CM-TRANSID: EMCowAAXkfQeXGpczS6NGA--.1316S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw43Aw43JFW5Ww47Xr13urg_yoW5ZF1rp3
 W8GanIkFW8Xr12grnFqr1UXr9I9w1UtFy8Wrs5t3srWF1q9rnxtFy7tFy5uF4xCry5Aw40
 qrs8AanxCF1YvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jiiSdUUUUU=
X-Originating-IP: [202.100.35.16]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/xtbBZwBfJlettFJu4gAAsO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_231756_490282_D986D817 
X-CRM114-Status: GOOD (  12.96  )
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
 "michal.simek" <michal.simek@xilinx.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgLCBTaHViaHJhanlvdGkKCj5IaSAsCj5PbiBTYXQsIEZlYiAxNiwgMjAxOSBhdCAxOjIxIFBN
IHN4YXV3c2tAMTYzLmNvbSA8c3hhdXdza0AxNjMuY29tPiB3cm90ZToKPj4KPj4gPkhpIFN4YXV3
c2ssCj4+ID4KPj4gPk9uIFdlZCwgSmFuIDMwLCAyMDE5IGF0IDM6MTMgUE0gc3hhdXdzayA8c3hh
dXdza0AxNjMuY29tPiB3cm90ZToKPj4gPj4KPj4gPj4gV2hlbiB0aGUgYWRhcHRlciByZWNlaXZl
IGVycm9yIGludGVycnVwdHMsIHN1Y2ggYXMgTkFDSywgYXJiaXRyYXRpb24gbG9zdCwKPj4gPj4g
Y2Ruc19pMmNfbWFzdGVyX3hmZXIgcmV0dXJuIHRvIHRoZSBjYWxsZXIgZGlyZWN0bHkgaW5zdGVh
ZCBvZiByZXN1bWluZwo+PiA+PiB0aGUgYWRhcHRlciB3aGljaCByZXN1bHRlZCBpbiB0aGUgYWRh
cHRlciBiZWluZyBvdXQgb2YgY29udHJvbC4KPj4gPj4KPj4gPj4gU28gd2hlbiBkcml2ZXIgZGV0
ZWN0IGVycl9zdGF0dXMgdGhlbiB0cnkgdG8gcmVwYWlyIGFuZCBmaXggaXQuCj4+ID4+Cj4+ID4+
IFNpZ25lZC1vZmYtYnk6IHN4YXV3c2sgPHN4YXV3c2tAMTYzLmNvbT4KPj4gPj4gLS0tCj4+ID4+
wqAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1jYWRlbmNlLmMgfCAxMiArKysrKysrLS0tLS0KPj4g
Pj7CoCAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+PiA+
Pgo+PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1jYWRlbmNlLmMgYi9k
cml2ZXJzL2kyYy9idXNzZXMvaTJjLWNhZGVuY2UuYwo+PiA+PiBpbmRleCBiMTM2MDU3MTgyOTEu
LmUxMDA0OGQ3NTI0YSAxMDA2NDQKPj4gPj4gLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1j
YWRlbmNlLmMKPj4gPj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1jYWRlbmNlLmMKPj4g
Pj4gQEAgLTU0OCwxMCArNTQ4LDYgQEAgc3RhdGljIGludCBjZG5zX2kyY19wcm9jZXNzX21zZyhz
dHJ1Y3QgY2Ruc19pMmMgKmlkLCBzdHJ1Y3QgaTJjX21zZyAqbXNnLAo+PiA+PsKgwqDCoMKgwqDC
oMKgwqAgY2Ruc19pMmNfd3JpdGVyZWcoQ0ROU19JMkNfSVhSX0FMTF9JTlRSX01BU0ssCj4+ID4+
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDRE5T
X0kyQ19JRFJfT0ZGU0VUKTsKPj4gPj4KPj4gPj4gLcKgwqDCoMKgwqDCoCAvKiBJZiBpdCBpcyBi
dXMgYXJiaXRyYXRpb24gZXJyb3IsIHRyeSBhZ2FpbiAqLwo+PiA+PiAtwqDCoMKgwqDCoMKgIGlm
IChpZC0+ZXJyX3N0YXR1cyAmIENETlNfSTJDX0lYUl9BUkJfTE9TVCkKPj4gPj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FQUdBSU47Cj4+ID4+IC0KPj4gPj7CoMKgwqDC
oMKgwqDCoMKgIHJldHVybiAwOwo+PiA+PsKgIH0KPj4gPj4KPj4gPj4gQEAgLTYxNywxMyArNjEz
LDE5IEBAIHN0YXRpYyBpbnQgY2Ruc19pMmNfbWFzdGVyX3hmZXIoc3RydWN0IGkyY19hZGFwdGVy
ICphZGFwLCBzdHJ1Y3QgaTJjX21zZyAqbXNncywKPj4gPj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWQtPmJ1c19ob2xkX2ZsYWcgPSAwOwo+PiA+Pgo+
PiA+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGNkbnNfaTJjX3Byb2Nl
c3NfbXNnKGlkLCBtc2dzLCBhZGFwKTsKPj4gPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKHJldCkKPj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFyZXQp
Cj4+ID4+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdv
dG8gb3V0Owo+PiA+Pgo+PiA+SW4gY2FzZcKgIHRoZSBBcmJpdHJhdGlvbiBlcnJvciBoYXBwZW5k
wqAgdGhlIGNkbnNfaTJjX3Byb2Nlc3NfbXNnIHdvdWxkIHJldHVybiAwCj4+ID5hbmQgd2Ugd2ls
bCBtaXNzIHRoZSBjaGVja8KgIGJlbG93Lgo+PiA+Cj4+ID5BbSBJIG1pc3Npbmcgc29tZXRoaW5n
ID8KPj4gPgo+PiA+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFJlcG9ydCB0
aGUgb3RoZXIgZXJyb3IgaW50ZXJydXB0cyB0byBhcHBsaWNhdGlvbiAqLwo+PiA+PsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpZC0+ZXJyX3N0YXR1cykgewo+PiA+PsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjZG5zX2kyY19tYXN0
ZXJfcmVzZXQoYWRhcCk7Cj4+ID4+Cj4+ID4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAvKiBJZiBpdCBpcyBidXMgYXJiaXRyYXRpb24gZXJyb3IsIHRyeSBh
Z2FpbiAqLwo+PiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGlkLT5lcnJfc3RhdHVzICYgQ0ROU19JMkNfSVhSX0FSQl9MT1NUKSB7Cj4+ID4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0ID0gLUVBR0FJTjsKPj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4gPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gPj4gKwo+PiA+PsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaWQtPmVycl9zdGF0
dXMgJiBDRE5TX0kyQ19JWFJfTkFDSykgewo+PiA+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gLUVOWElPOwo+PiA+
PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZ290byBvdXQ7Cj4+ID4+IC0tCj4+ID4+IDIuMTkuMgo+PiA+Pgo+PiA+Pgo+Pgo+
PiBJbiBjZG5zX2kyY19wcm9jZXNzX21zZyBwcm9jZXNzLCB3aGVuIGRldGVjdCBhcmJpdHJhdGlv
biBsb3N0IGVycm9yIHJldHVybiAtRUFHQUlOIHRvwqAgY2Ruc19pMmNfbWFzdGVyX3hmZXIswqAg
bm90IHJldHVybiAwCj4+IHRoYXQgbWVhbiBjZG5zX2kyY19wcm9jZXNzX21zZ8KgIGp1c3QgZ28g
b3V0IGlnbm9yZSBlcnJvciBjaGVjayBhbmTCoCBwcm9ibGVtIG9jY3VyLCBTbyB3ZSBzaG91bGQg
ZG8gc29tZXRoaW5nIHdoZW4gYXJiaXRyYXRpb24gZXJyb3IgZGV0ZWN0Lgo+Cj5BcmJpdHJhdGlv
biBsb3N0IGlzIGZpbmUgaG93IGFib3V0IG90aGVyIGVycm9ycyBsaWtlIE5BQ0suIAoKPj4gPj4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0ID0gY2Ruc19pMmNfcHJvY2Vzc19tc2coaWQsIG1z
Z3MsIGFkYXApOwo+PiA+PiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChyZXQpCj4+ID4+ICsg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCFyZXQpCj4+ID4+IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGdvdG8gb3V0OwoKWWVzLCB5b3UncmUgcmlnaHQsIMKgVGhpcyBwbGFj
ZSBJIHNob3VsZCd0IG1ha2UgYW55IGNoYW5nZSwgwqBwZXJmZWN0IHNvbHV0aW9uIQoKPj4gPj4K
Pj4gPj4gLSDCoCDCoCDCoCAvKiBJZiBpdCBpcyBidXMgYXJiaXRyYXRpb24gZXJyb3IsIHRyeSBh
Z2FpbiAqLwo+PiA+PiAtIMKgIMKgIMKgIGlmIChpZC0+ZXJyX3N0YXR1cyAmIENETlNfSTJDX0lY
Ul9BUkJfTE9TVCkKPj4gPj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLUVBR0FJTjsK
Pj4gPj4gLQo+PiA+PiDCoCDCoCDCoCDCoCByZXR1cm4gMDsKPj4gPj4gwqB9CgoKPj4gPj4gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogUmVwb3J0IHRoZSBvdGhlciBlcnJvciBpbnRlcnJ1cHRz
IHRvIGFwcGxpY2F0aW9uICovCj4+ID4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChpZC0+
ZXJyX3N0YXR1cykgewo+PiA+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBj
ZG5zX2kyY19tYXN0ZXJfcmVzZXQoYWRhcCk7Cj4+ID4+Cj4+ID4+ICsgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgLyogSWYgaXQgaXMgYnVzIGFyYml0cmF0aW9uIGVycm9yLCB0cnkg
YWdhaW4gKi8KPj4gPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoaWQt
PmVycl9zdGF0dXMgJiBDRE5TX0kyQ19JWFJfQVJCX0xPU1QpIHsKPj4gPj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXQgPSAtRUFHQUlOOwo+PiA+PiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gb3V0Owo+
PiA+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0KPj4gPj4gKwoKTWF5YmUg
SnVzdCByZW1vdmUgQXJiaXRyYXRpb24gbG9zdCBEZXRlY3QgcGFydCBmcm9tIMKgY2Ruc19pMmNf
cHJvY2Vzc19tc2cgZnVuY3Rpb24sIMKgdGhlbiBhZGQgdG8gY2Ruc19pMmNfbWFzdGVyX3hmZXIs
IMKgRG8geW91IHRoaW5rPwoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
