Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32D1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:51:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D7D2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OpFI/1fr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JxNZSnzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D7D2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Io25hZUPvjErsorGqcYsPyjTwWtIucu6GJhpDfrUiZc=; b=OpFI/1frfDxw//FIIgpP3MKvp
	nf34FCO36/BstVzj0RiizVi70aWPTntpojzbAhOaf8O40pwOgsNJ7sXQh2mwZTcWSFLbgtxIcsDxP
	aKcZsIUGaNfhrm65hAUY5vdK+qOuxIvuI3Nr8RwyjOmYeypw8hSgvk1mZkcUX0Facdygtmew6PYOB
	LyA4JwH9aFueCBxmLrJaKhCJ/3pwRJ5RH36zzee+zRucg9o+TJvAUC/T7sXdbolyE2yX/Y61UlneJ
	/xjId1rohwglQfyOb16eIupmHZ7qkwRbQVjPVWeZYwvnT6EUl/+MpfIVB8eUnJiMN+0HoEwO3w2do
	UESog18SA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUR1p-0006uh-VQ; Wed, 05 Dec 2018 06:51:25 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUR1l-0006u9-Qn
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 06:51:23 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0775600000>; Tue, 04 Dec 2018 22:51:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 22:51:11 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 22:51:11 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 06:51:09 +0000
Subject: Re: [PATCH 08/19] clk: tegra: dfll: round down voltages based on
 alignment
From: Joseph Lo <josephl@nvidia.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-9-josephl@nvidia.com>
 <20181204154618.GC26056@pdeschrijver-desktop.Nvidia.com>
 <1cbe2662-1b5e-8261-f0c1-04a760cb08c1@nvidia.com>
Message-ID: <7f90eae3-42fe-e771-b2f0-421c617db11e@nvidia.com>
Date: Wed, 5 Dec 2018 14:51:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1cbe2662-1b5e-8261-f0c1-04a760cb08c1@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543992672; bh=wDcb0tE8VsHRnL9YXF8xhOph+Gr1Ob8bJme31H1o4+0=;
 h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=JxNZSnzcSLQKUymBIj8l95Sy94WGQOOjKJFU2IvLd2j4UF7aTZFN9ubZKc9h9jCEh
 A1kzSwDaiHDuTdUTdaeZ8pN/rjj6xjux36wS7pjPiQHYN+vB3OGfv9OHZ10HpjuOeA
 UvDJoUiB+tdFku9/2ZQr6ymGptsRfaglfeH4guXyOnkP019dE2XljOPNd817lve2TF
 qlKjx4VIXgailw00CqMpdUuxK4J7MDs1pwk/48gfyy6o5auMZCIl2jPgNyHAlB79En
 oO3qTj6938j8Bi5A9Dv5yWwHK+AjXgApTfjCSIK7vmYBh6YK2nGAdo1zapn+R8QLIq
 DRwbnmbuaqvVg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_225121_879909_33E3E4BA 
X-CRM114-Status: GOOD (  13.37  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvNS8xOCAyOjIwIFBNLCBKb3NlcGggTG8gd3JvdGU6Cj4gT24gMTIvNC8xOCAxMTo0NiBQ
TSwgUGV0ZXIgRGUgU2NocmlqdmVyIHdyb3RlOgo+PiBPbiBUdWUsIERlYyAwNCwgMjAxOCBhdCAw
NToyNTozN1BNICswODAwLCBKb3NlcGggTG8gd3JvdGU6Cj4+PiBXaGVuIGdlbmVyYXRpbmcgdGhl
IE9QUCB0YWJsZSwgdGhlIHZvbHRhZ2VzIGFyZSByb3VuZCBkb3duIHdpdGggdGhlCj4+PiBhbGln
bm1lbnQgZnJvbSB0aGUgcmVndWxhdG9yLiBUaGUgYWxpZ25tZW50IHNob3VsZCBiZSBhcHBsaWVk
IGZvcgo+Pj4gdm9sdGFnZXMgbG9vayB1cCBhcyB3ZWxsLgo+Pj4KPj4+IEJhc2VkIG9uIHRoZSB3
b3JrIG9mIFBlbm55IENoaXUgPHBjaGl1QG52aWRpYS5jb20+Lgo+Pj4KPj4+IFNpZ25lZC1vZmYt
Ynk6IEpvc2VwaCBMbyA8am9zZXBobEBudmlkaWEuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJz
L2Nsay90ZWdyYS9jbGstZGZsbC5jIHwgMjYgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KPj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPj4+
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvdGVncmEvY2xrLWRmbGwuYyBiL2RyaXZlcnMv
Y2xrL3RlZ3JhL2Nsay1kZmxsLmMKPj4+IGluZGV4IGMyOTRhMjk4OWYzMS4uNGE5NDNjMTM2ZDRk
IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9jbGsvdGVncmEvY2xrLWRmbGwuYwo+Pj4gKysrIGIv
ZHJpdmVycy9jbGsvdGVncmEvY2xrLWRmbGwuYwo+Pj4gQEAgLTgwNCwxNyArODA0LDE3IEBAIHN0
YXRpYyB2b2lkIGRmbGxfaW5pdF9vdXRfaWYoc3RydWN0IHRlZ3JhX2RmbGwgCj4+PiAqdGQpCj4+
PiDCoCBzdGF0aWMgaW50IGZpbmRfbHV0X2luZGV4X2Zvcl9yYXRlKHN0cnVjdCB0ZWdyYV9kZmxs
ICp0ZCwgdW5zaWduZWQgCj4+PiBsb25nIHJhdGUpCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIHN0
cnVjdCBkZXZfcG1fb3BwICpvcHA7Cj4+PiAtwqDCoMKgIGludCBpLCB1djsKPj4+ICvCoMKgwqAg
aW50IGksIGFsaWduX3ZvbHQ7Cj4+PiDCoMKgwqDCoMKgIG9wcCA9IGRldl9wbV9vcHBfZmluZF9m
cmVxX2NlaWwodGQtPnNvYy0+ZGV2LCAmcmF0ZSk7Cj4+PiDCoMKgwqDCoMKgIGlmIChJU19FUlIo
b3BwKSkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihvcHApOwo+Pj4gLcKg
wqDCoCB1diA9IGRldl9wbV9vcHBfZ2V0X3ZvbHRhZ2Uob3BwKTsKPj4+ICvCoMKgwqAgYWxpZ25f
dm9sdCA9IGRldl9wbV9vcHBfZ2V0X3ZvbHRhZ2Uob3BwKSAvIAo+Pj4gdGQtPnNvYy0+YWxpZ25t
ZW50LnN0ZXBfdXY7Cj4+PiDCoMKgwqDCoMKgIGRldl9wbV9vcHBfcHV0KG9wcCk7Cj4+PiDCoMKg
wqDCoMKgIGZvciAoaSA9IHRkLT5sdXRfYm90dG9tOyBpIDwgdGQtPmx1dF9zaXplOyBpKyspIHsK
Pj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAocmVndWxhdG9yX2xpc3Rfdm9sdGFnZSh0ZC0+dmRkX3Jl
ZywgdGQtPmx1dFtpXSkgPT0gdXYpCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCh0ZC0+bHV0X3V2
W2ldIC8gdGQtPnNvYy0+YWxpZ25tZW50LnN0ZXBfdXYpID49IGFsaWduX3ZvbHQpCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gaTsKPj4+IMKgwqDCoMKgwqAgfQo+Pj4gQEAg
LTE1MzIsMTUgKzE1MzIsMTcgQEAgc3RhdGljIGludCBkZmxsX2luaXQoc3RydWN0IHRlZ3JhX2Rm
bGwgKnRkKQo+Pj4gwqDCoCAqLwo+Pgo+PiBUaGVzZSAyIGZ1bmN0aW9ucyBhcmUgb25seSB2YWxp
ZCBmb3IgSTJDIG1vZGUuIFdlIHNob3VsZCBwcm9iYWJseSBhZGQgYQo+PiBXQVJOX09OKCkgaW4g
Y2FzZSB0aGV5IGFyZSBjYWxsZWQgd2hlbiBQV00gbW9kZSBpcyB1c2VkIGFuZCByZXR1cm4KPj4g
LUVJTlZBTC4KPj4KPiAKPiBPa2F5LCB3aWxsIGFkZCB0aGF0Lgo+IApQZXRlciwKClNvcnJ5LCBq
dXN0IGRvdWJsZSBjaGVjayBhZ2Fpbi4gVGhlc2UgMiBmdW5jdGlvbnMgYXJlIHVzZWQgZm9yIApn
ZW5lcmF0aW5nIExVVCB0YWJsZSBmb3IgREZMTC1JMkMgbW9kZS4gVGhleSBhcmUgb25seSB1c2Vk
IGluIAoiZGZsbF9idWlsZF9pMmNfbHV0IiBmdW5jdGlvbi4gU28gSSB0aGluayBpdCdzIGZpbmUu
IFRoZSBXQVJOX09OIGZvciAKcHJvdGVjdGlvbiBmcm9tIFBXTSBtb2RlIGlzIG5vdCBuZWNlc3Nh
cnkuCgoKPiAKPj4+IMKgIHN0YXRpYyBpbnQgZmluZF92ZGRfbWFwX2VudHJ5X2V4YWN0KHN0cnVj
dCB0ZWdyYV9kZmxsICp0ZCwgaW50IHVWKQo+Pj4gwqAgewo+Pj4gLcKgwqDCoCBpbnQgaSwgbl92
b2x0YWdlcywgcmVnX3VWOwo+Pj4gK8KgwqDCoCBpbnQgaSwgbl92b2x0YWdlcywgcmVnX3ZvbHQs
IGFsaWduX3ZvbHQ7Cj4+PiArwqDCoMKgIGFsaWduX3ZvbHQgPSB1ViAvIHRkLT5zb2MtPmFsaWdu
bWVudC5zdGVwX3V2Owo+Pj4gwqDCoMKgwqDCoCBuX3ZvbHRhZ2VzID0gcmVndWxhdG9yX2NvdW50
X3ZvbHRhZ2VzKHRkLT52ZGRfcmVnKTsKPj4+IMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IG5f
dm9sdGFnZXM7IGkrKykgewo+Pj4gLcKgwqDCoMKgwqDCoMKgIHJlZ191ViA9IHJlZ3VsYXRvcl9s
aXN0X3ZvbHRhZ2UodGQtPnZkZF9yZWcsIGkpOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChyZWdf
dVYgPCAwKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJlZ192b2x0ID0gcmVndWxhdG9yX2xpc3Rfdm9s
dGFnZSh0ZC0+dmRkX3JlZywgaSkgLwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB0ZC0+c29jLT5hbGlnbm1lbnQuc3RlcF91djsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmVn
X3ZvbHQgPCAwKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+PiAtwqDC
oMKgwqDCoMKgwqAgaWYgKHVWID09IHJlZ191VikKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoYWxp
Z25fdm9sdCA9PSByZWdfdm9sdCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBpOwo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiBAQCAtMTU1NCwxNSArMTU1NiwxNyBAQCBzdGF0aWMg
aW50IGZpbmRfdmRkX21hcF9lbnRyeV9leGFjdChzdHJ1Y3QgCj4+PiB0ZWdyYV9kZmxsICp0ZCwg
aW50IHVWKQo+Pj4gwqDCoCAqICovCj4+PiDCoCBzdGF0aWMgaW50IGZpbmRfdmRkX21hcF9lbnRy
eV9taW4oc3RydWN0IHRlZ3JhX2RmbGwgKnRkLCBpbnQgdVYpCj4+PiDCoCB7Cj4+PiAtwqDCoMKg
IGludCBpLCBuX3ZvbHRhZ2VzLCByZWdfdVY7Cj4+PiArwqDCoMKgIGludCBpLCBuX3ZvbHRhZ2Vz
LCByZWdfdm9sdCwgYWxpZ25fdm9sdDsKPj4+ICvCoMKgwqAgYWxpZ25fdm9sdCA9IHVWIC8gdGQt
PnNvYy0+YWxpZ25tZW50LnN0ZXBfdXY7Cj4+PiDCoMKgwqDCoMKgIG5fdm9sdGFnZXMgPSByZWd1
bGF0b3JfY291bnRfdm9sdGFnZXModGQtPnZkZF9yZWcpOwo+Pj4gwqDCoMKgwqDCoCBmb3IgKGkg
PSAwOyBpIDwgbl92b2x0YWdlczsgaSsrKSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgcmVnX3VWID0g
cmVndWxhdG9yX2xpc3Rfdm9sdGFnZSh0ZC0+dmRkX3JlZywgaSk7Cj4+PiAtwqDCoMKgwqDCoMKg
wqAgaWYgKHJlZ191ViA8IDApCj4+PiArwqDCoMKgwqDCoMKgwqAgcmVnX3ZvbHQgPSByZWd1bGF0
b3JfbGlzdF92b2x0YWdlKHRkLT52ZGRfcmVnLCBpKSAvCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHRkLT5zb2MtPmFsaWdubWVudC5zdGVwX3V2Owo+Pj4gK8KgwqDCoMKgwqDC
oMKgIGlmIChyZWdfdm9sdCA8IDApCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVh
azsKPj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAodVYgPD0gcmVnX3VWKQo+Pj4gK8KgwqDCoMKgwqDC
oMKgIGlmIChhbGlnbl92b2x0IDw9IHJlZ192b2x0KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIGk7Cj4+PiDCoMKgwqDCoMKgIH0KPj4+IC0tIAo+Pj4gMi4xOS4yCj4+PgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
