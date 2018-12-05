Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:13:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3F92084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cY1gJh9J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ovA+KgMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3F92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vGLpmipnGFtLrW8yomWETSCDomPAjua+5CPQ9F1MAUo=; b=cY1gJh9JTDceSi
	rvLS/qHRhDuoCH6fUW8aYpwL0vrWBFpydP0HeRyDFzOx3UbAbZaU7zDikRuSU2W34HdHbSGD42anB
	9dGfTcvc5SD/3sHxHhFPV+9RnVtZV1fq6wjTNd6gmgnBfO4l0zKVhTQfmKevRlkfg8k8P8WhHr2oJ
	02PtgmIZnyuUeY0dBHB4YsixonWRRT6W5yQ7heXGzsXqlsk6DpmOPGCoqlmHWk2GZUA13e1Z8hx65
	vJ9XtF9qPMGkbBMlqZDjSlw6ivrPHl89sA+hJ3Bg/SBrAyOzbt8tpcdqpZMtOsdI2hu79cuGJspIY
	bokCDfhPkX3ii2eeDLUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQQh-0007fT-4d; Wed, 05 Dec 2018 06:13:03 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQQd-0007eb-9J
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 06:13:00 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB56CitZ124451;
 Wed, 5 Dec 2018 00:12:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1543990364;
 bh=W2qstvvfPzuVL/vfhmqquMXhuYeb6xJi96vVAmPtDRs=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=ovA+KgMxUEhBiECXZYLxYP7qu7mGyu6zNFKX/MLqsxD+ncxaa8SnbZv9MjQd/cLED
 CScHQk3tVj5WGeZLRdRt4s7b8i+t+36Rhn4hJVW/0BXZR+XQzY61YZi8lvHBqnU9Dp
 kfljr7z9v7pitH2ws8e60Xrkr572dKscjMGJCVZc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB56CieI058153
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Dec 2018 00:12:44 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 5
 Dec 2018 00:12:44 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 5 Dec 2018 00:12:44 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB56Cfrp013721;
 Wed, 5 Dec 2018 00:12:42 -0600
Subject: Re: [PATCH 2/4] ARM: dts: am437x: Move l4 child devices to probe them
 with ti-sysc
To: Tony Lindgren <tony@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <20180925000545.22931-3-tony@atomide.com>
 <f890f989-bfd0-47eb-66e0-5a8573e398b7@ti.com>
 <20181204181121.GC6707@atomide.com> <20181204231833.GF6707@atomide.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <3feb7078-5690-abf6-2a9d-a65807ee701a@ti.com>
Date: Wed, 5 Dec 2018 08:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181204231833.GF6707@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_221259_450001_7475FF3F 
X-CRM114-Status: GOOD (  17.45  )
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
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
 Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
 =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAwNS8xMi8yMDE4IDEuMTgsIFRvbnkgTGluZGdyZW4gd3JvdGU6Cj4gKiBUb255IExpbmRn
cmVuIDx0b255QGF0b21pZGUuY29tPiBbMTgxMjA0IDE4OjExXToKPj4gKiBQZXRlciBVamZhbHVz
aSA8cGV0ZXIudWpmYWx1c2lAdGkuY29tPiBbMTgxMjA0IDEyOjIyXToKPj4+IEhpIFRvbnksCj4+
Pgo+Pj4gT24gMjUvMDkvMjAxOCAzLjA1LCBUb255IExpbmRncmVuIHdyb3RlOgo+Pj4+IFdpdGgg
bDQgaW50ZXJjb25uZWN0IGhpZXJhcmNoeSBhbmQgdGktc3lzYyBpbnRlcmNvbm5lY3QgdGFyZ2V0
IG1vZHVsZQo+Pj4+IGRhdGEgaW4gcGxhY2UsIHdlIGNhbiBzaW1wbHkgbW92ZSBhbGwgdGhlIHJl
bGF0ZWQgY2hpbGQgZGV2aWNlcyB0bwo+Pj4+IHRoZWlyIHByb3BlciBsb2NhdGlvbiBhbmQgZW5h
YmxlIHByb2JpbmcgdXNpbmcgdGktc3lzYy4KPj4+Pgo+Pj4+IEluIGdlbmVyYWwgdGhlIGZpcnN0
IGNoaWxkIGRldmljZSBhZGRyZXNzIHJhbmdlIHN0YXJ0cyBhdCByYW5nZSAwCj4+Pj4gZnJvbSB0
aGUgdGktc3lzYyBpbnRlcmNvbm5lY3QgdGFyZ2V0IHNvIHRoZSBtb3ZlIGludm9sdmVzIGFkanVz
dGluZwo+Pj4+IHRoZSBjaGlsZCBkZXZpY2UgcmVnIHByb3BlcnRpZXMgZm9yIHRoYXQuCj4+Pj4K
Pj4+PiBJbiBjYXNlIG9mIGFueSByZWdyZXNzaW9ucywgcHJvYmxlbSBkZXZpY2VzIGNhbiBiZSBy
ZXZlcnRlZCB0byBwcm9iZQo+Pj4+IHdpdGggbGVnYWN5IHBsYXRmb3JtIGRhdGEgYXMgbmVlZGVk
IGJ5IG1vdmluZyB0aGVtIGJhY2sgYW5kIHJlbW92aW5nCj4+Pj4gdGhlIHJlbGF0ZWQgaW50ZXJj
b25uZWN0IHRhcmdldCBtb2R1bGUgbm9kZS4KPj4+Pgo+Pj4+IE5vdGUgdGhhdCB3ZSBhcmUgbm90
IHlldCBtb3ZpbmcgZHNzIG9yIHdrdXBfbTMsIHRob3NlIHdpbGwgYmUgbW92ZWQKPj4+PiBsYXRl
ciBhZnRlciBzb21lIHJlbGF0ZWQgZHJpdmVyIGNoYW5nZXMuCj4+Pgo+Pj4gRXhhY3RseSB0aGUg
c2FtZSBpc3N1ZSBhcyB3aXRoIGFtMzM1eCBhZnRlcjoKPj4+IEFSTTogZHRzOiBhbTMzNXg6IE1v
dmUgbDQgY2hpbGQgZGV2aWNlcyB0byBwcm9iZSB0aGVtIHdpdGggdGktc3lzYwo+Pj4KPj4+IHJl
dmVydGluZyB0aGlzIHBhdGNoIG1ha2VzIGF1ZGlvIHdvcmtpbmc6Cj4+Pgo+Pj4gV2l0aG91dCBy
ZXZlcnQgdGhlIE1jQVNQIEZJRk8gd291bGQgY29uc3RhbnRseSB1bmRlcmZsb3cuCj4+Pgo+Pj4g
TWVtY3B5IHRlc3QgdmlhIGRtYXRlc3Qgd29ya3Mgd2l0aCBFRE1BCj4+Cj4+IE9LIEkgc2hvdWxk
IGJlIGFibGUgdG8gZGVidWcgaXQgaGVyZSB3aXRoIGFtNDM3eC1zay1ldm0gdGhlbi4KPj4KPj4g
SWYgaXQncyBub3QgaW1tZWRpYXRlbHkgb2J2aW91cyB3aGF0J3MgZ29pbmcgb24sIGxldCdzIGp1
c3QKPj4gZG8gYSByZXZlcnQgaGVyZSB0b28gYW5kIGRlYnVnIGl0IG1vcmUgc2VwYXJhdGVseS4K
PiAKPiBJIGRpZCBub3QgaGF2ZSBhbnkgbHVjayBnZXR0aW5nIG1jYXNwIHdvcmtpbmcgb24gYW00
Mzd4LXNrLWV2bS4KPiAKPiBBZnRlciBhcHBseWluZyAiIGRybS9vbWFwOiBmaXggYnVzX2ZsYWdz
IGZvciBwYW5lbC1kcGkiIExDRAo+IHdvcmtzIGFnYWluLiBCdXQgbW9kcHJvYmUgb2Ygc25kLXNv
Yy1kYXZpbmNpLW1jYXNwIGFuZAo+IHNuZC1zb2MtdGx2MzIwYWljM3ggc3RpbGwgZG9lcyBub3Qg
c2hvdyBhbnl0aGluZyB3aXRoIGFwbGF5IC1sLgoKSHJtLCB3aHkgdGhleSBhcmUgbm90IGxvYWRl
ZCBhdXRvbWF0aWNhbGx5PwoKPiBEbyBJIG5lZWQgc29tZSBvdGhlciBwYXRjaCBvciBjb2RlYyBk
cml2ZXI/CgpzbmQtc29jLWVkbWEKc25kLXNvYy1kYXZpbmNpLW1jYXNwCnNuZC1zb2MtdGx2MzIw
YWljM3gKc25kLXNvYy1zaW1wbGUtY2FyZAoKYXQgdGhlIGJvdHRvbSBvZiB0aGUgc3RhY2sgaXMg
bmVlZGVkLCBidXQgSSBqdXN0IGJ1aWxkIHRoZW0gaW4gZm9yCmNvbnZlbmllbmNlLgoKPiAKPiBS
ZWdhcmRzLAo+IAo+IFRvbnkKPiAKCi0gUMOpdGVyCgpUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5k
IE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3Mg
SUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
