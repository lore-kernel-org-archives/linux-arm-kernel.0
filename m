Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9447C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:36:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEFF52146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aywd3mb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFF52146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FI6WyvRbmVgnPysCoYFa7ugSEn6HjeA0rHkqMTarQeU=; b=aywd3mb5hXVUdzwF67PtLY22x
	85f8W+inBldbFna9mDIaz4fUJT2f6i8E2bXs1E2pEtv9qNGXEtzUSdz47ZFfYKKAQ35h0iqJE3t5o
	AVirj/WEj2vVGisJfyulGlIzMq1D4X9lII+WqQ4NB2+2d04OsICOvJnDxIYGHHuWwUWUHgBJ47yhI
	DHPHW4ImpbbIuj10H8+yvcdMXOfnLRDePddwpd0vTSjXYkqJ7M+IA/th5dB0nGrDMO46TOR2gR5kV
	Me5z5GtNhnx45ZJJhd2eefwk1jXNf1MiOdgO9TCquOaI5Hh+scECZWYUcRJeo40Ut6vBtFNTBXo/D
	9UfYDRDcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwcLd-0001uS-Db; Thu, 21 Feb 2019 00:36:21 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwcLa-0001u0-5t
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 00:36:19 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 21 Feb 2019 09:36:16 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 8D0D218010B;
 Thu, 21 Feb 2019 09:36:16 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Thu, 21 Feb 2019 09:36:16 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id 0E0B0403AA;
 Thu, 21 Feb 2019 09:36:16 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id EE447121B6C;
 Thu, 21 Feb 2019 09:36:15 +0900 (JST)
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
 <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com>
 <CAK8P3a38qgw8LeX=Y_nG53HzjnXjHESekgnJ6jtW_xvd7Zvq-Q@mail.gmail.com>
 <CAA93ih2t34qwVB==LoF2odOCEOd9EE06i3hz0eTuonnXjJCyDw@mail.gmail.com>
 <CAK8P3a3DmKjTNXo8ufExaQxEsQX=MAYymeARbEzu8QXsCJFfiA@mail.gmail.com>
 <CAA93ih3EUfgw9TeduOCOJZzWjQEv_VKp9t0+rdZA6rwk_8ThLA@mail.gmail.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <010ca462-a245-8bec-c2eb-8af21d087486@socionext.com>
Date: Thu, 21 Feb 2019 09:36:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAA93ih3EUfgw9TeduOCOJZzWjQEv_VKp9t0+rdZA6rwk_8ThLA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_163618_330308_39B877A2 
X-CRM114-Status: GOOD (  25.16  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAyMDE5LzAyLzIwIDIyOjIzLCBNYXNhbWkgSGlyYW1hdHN1IHdyb3RlOgo+IEhpIEFy
bmQsCj4gCj4gMjAxOeW5tDLmnIgyMOaXpSjmsLQpIDIyOjE4IEFybmQgQmVyZ21hbm4gPGFybmRA
YXJuZGIuZGU+Ogo+Pgo+PiBPbiBXZWQsIEZlYiAyMCwgMjAxOSBhdCAyOjE2IFBNIE1hc2FtaSBI
aXJhbWF0c3UKPj4gPG1hc2FtaS5oaXJhbWF0c3VAbGluYXJvLm9yZz4gd3JvdGU6Cj4+PiAyMDE5
5bm0MuaciDIw5pelKOawtCkgMjE6MjggQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT46Cj4+
Pj4gT24gV2VkLCBGZWIgMjAsIDIwMTkgYXQgMTI6MjcgUE0gU3VnYXlhLCBUYWljaGkKPj4+PiA8
c3VnYXlhLnRhaWNoaUBzb2Npb25leHQuY29tPiB3cm90ZToKPj4+Pj4gT24gMjAxOS8wMi8yMCAx
ODoyOCwgQXJuZCBCZXJnbWFubiB3cm90ZToKPj4+Pj4+IE9uIFdlZCwgRmViIDIwLCAyMDE5IGF0
IDg6NDQgQU0gU3VnYXlhIFRhaWNoaQo+Pj4+Pj4gPHN1Z2F5YS50YWljaGlAc29jaW9uZXh0LmNv
bT4gd3JvdGU6Cj4+Pj4+Pgo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9jb25maWdzL21p
bGJlYXV0X20xMHZfZGVmY29uZmlnIGIvYXJjaC9hcm0vY29uZmlncy9taWxiZWF1dF9tMTB2X2Rl
ZmNvbmZpZwo+Pj4+Pj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+Pj4+Pj4gaW5kZXggMDAwMDAw
MC4uYTI2MzIxMQo+Pj4+Pj4+IC0tLSAvZGV2L251bGwKPj4+Pj4+PiArKysgYi9hcmNoL2FybS9j
b25maWdzL21pbGJlYXV0X20xMHZfZGVmY29uZmlnCj4+Pj4+Pj4gQEAgLTAsMCArMSwxNzUgQEAK
Pj4+Pj4+Cj4+Pj4+PiBJIG5vIGxvbmdlciBzZWUgYW55dGhpbmcgaGVyZSB0aGF0IHNob3VsZCBi
ZSB0dXJuZWQgb2ZmLCBidXQgeW91Cj4+Pj4+PiBtaWdodCB3YW50IHRvIHJ1biAnbWFrZSBzYXZl
ZGVmY29uZmlnJyBhbmQgdXNlIHRoZSBvdXRwdXQgb2YgdGhhdCwKPj4+Pj4+IHRvIG1ha2UgaXQg
ZWFzaWVyIHRvIGtlZXAgaXQgdXAgdG8gZGF0ZS4KPj4+Pj4+Cj4+Pj4+Cj4+Pj4+IEkgZ290IGl0
LCBJIHVzZSB0aGUgb3V0cHV0IG9mICdtYWtlIHNhdmVkZWZjb25maWcnLgo+Pj4+PiBPbmUgcXVl
c3Rpb24sIGlzIHRoYXQgT0sgdG8gYWRkIHNvbWUgb3B0aW9ucyBvbiBpdD8KPj4+Pj4gICAgLUJl
Y2F1c2UgIkNPTkZJR19BUkNIX01JTEJFQVVUIiB3YXMgbm90IGxpc3RlZC4KPj4+Pgo+Pj4+IFdo
YXQgSSdkIGRvIGhlcmUgaXMgdG8gYXBwbHkgYWxsIHRoZSBwYXRjaGVzIHlvdSB3YW50IHRvIGdl
dCBtZXJnZWQgaW4KPj4+PiB0aGUgbmV4dCBmZXcgcmVsZWFzZXMgYmVmb3JlIHJ1bm5pbmcgJ3Nh
dmVkZWZjb25maWcnIGFuZCB1c2UgdGhlIG91dHB1dAo+Pj4+IG9mIHRoYXQuCj4+Pgo+Pj4gTGV0
IG1lIGNoZWNrLiBXb3VsZCB5b3UgbWVhbiB0aGF0IHRoZSBkZWZjb25maWcgd2lsbCBpbmNsdWRl
IGFsbCB0aG9zZQo+Pj4gZHJpdmVycyBjb25maWdzLCB3aGljaCB3aWxsIG5vdCBhcHBlYXIgYXQg
dGhpcyBtb21lbnQ/Cj4+Cj4+IENvcnJlY3QuCj4+Cj4+Pj4gSWYgeW91IGFscmVhZHkga25vdyB0
aGF0IHlvdSB3aWxsIG5lZWQgdGhlIG9wdGlvbnMsIGluY2x1ZGluZwo+Pj4+IHRoZW0gbm93IG1l
YW5zIHlvdSBkb24ndCBoYXZlIHRvIHVwZGF0ZSB0aGUgZGVmY29uZmlnIGZpbGUKPj4+PiBhcyBt
dWNoIGluIHRoZSBmdXR1cmUuCj4+Pgo+Pj4gSSBqdXN0IGNvbmNlcm4gdGhhdCBpZiBvdGhlciBz
dWJzeXN0ZW0gbWFpbnRhaW5lciBjb21tZW50cwo+Pj4gb24gdGhlIGNvbmZpZyBuYW1lLiBFdmVu
IGluIHRoYXQgY2FzZSwgY2FuIHdlIGp1c3QgdXBkYXRlIHRoZQo+Pj4gZGVmY29uZmlnIHdpdGgg
bmV3IG5hbWU/Cj4+Cj4+IFllcywgdGhhdCdzIGVhc3kgZW5vdWdoLgo+IAo+IE9LLCBJIGdvdCBp
dCA6KQo+IAo+IFRoYW5rIHlvdSEKPiAKClRoYW5rIHlvdSBmb3IgdGhlIGRldGFpbC4gSSBnb3Qg
aXQgdG9vLgoKCj4+Cj4+ICAgICAgICBBcm5kCj4gCj4gCj4gCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
