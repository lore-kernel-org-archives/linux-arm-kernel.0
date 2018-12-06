Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A465C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:00:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0DA2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bwrljbyL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="kMWyiNzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0DA2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p5LIVpmY0diWt9fsrfjh3kOZIiFewM8B3ohs+CY2Xf4=; b=bwrljbyLz3xWWK2SjL/z60Sl0
	22hVsTdzwa7/PGVCqZ9fK6z/Lczh7+GpT9gCTL+rBD/1WkJfRkAmpN2QYgh2QwY+4vHNazkFwhejR
	usTsVtEfb/Jv2/r8HA5eSyDC8bpCQmiJzWzsLZjO3qYZGpx+OIM0xQ9zrN5iqCSpuS6Z+Ow4tla3U
	nhs9aZTEAC/RdNEn+N3HlCI8zztsj3E4xsQjW777cv1gcqMQAYLM/cK03Ry0BKw0b6rPymCBETxAB
	QfglND4HSbXUh5v1eHusWjwoJu/P1GHrm3pCCKB3gAKIfoUwBxB77vxRDWHMEi3D0wJ5KJOk4l+qL
	Y8bPVrHew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUrOh-0008My-Ox; Thu, 06 Dec 2018 11:00:47 +0000
Received: from mail.micronovasrl.com ([212.103.203.10])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUrOa-0008M6-PZ
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:00:45 +0000
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
 by mail.micronovasrl.com (Postfix) with ESMTP id 95C13B01581
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 12:00:17 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
 h=content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:user-agent:date:date
 :message-id:references:to:subject:subject:from:from; s=dkim; t=
 1544094013; x=1544958014; bh=6UmA2urPp/XhmsO8K4zUHxGAh9AUsE1+RDP
 890zGn78=; b=kMWyiNzOw85aP371Rj7Umj8RoeW9TNQmP65dUX9gZhLJbSpzTpE
 etMvH+qIugEvJV8H2nyws0aL2TdVY1yafNv82PNzHMkkj26dOM+40h6rdB/UyyMX
 OJhA+/am24Hqd5rj/AkMPj1+ayep2ARp6jXgqzuo2cGqii0xWJ4nFaTM=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
 by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id AFsC49MZ0Dy8 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 12:00:13 +0100 (CET)
Received: from [192.168.178.33]
 (host128-8-dynamic.21-79-r.retail.telecomitalia.it [79.21.8.128])
 by mail.micronovasrl.com (Postfix) with ESMTPSA id 0BF78B00117;
 Thu,  6 Dec 2018 12:00:12 +0100 (CET)
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
To: Jonathan Liu <net147@gmail.com>
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
 <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
Message-ID: <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
Date: Thu, 6 Dec 2018 12:00:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
Content-Language: it
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_030041_010930_EEB4460B 
X-CRM114-Status: GOOD (  50.53  )
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
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSm9uYXRoYW4sCgpJbCAwNi8xMi8yMDE4IDA4OjI5LCBKb25hdGhhbiBMaXUgaGEgc2NyaXR0
bzoKPiBIaSBHaXVsaW8sCj4gCj4gT24gVGh1LCAxNSBGZWIgMjAxOCBhdCAxNzo1NCwgR2l1bGlv
IEJlbmV0dGkKPiA8Z2l1bGlvLmJlbmV0dGlAbWljcm9ub3Zhc3JsLmNvbT4gd3JvdGU6Cj4+Cj4+
IERpZmZlcmVudGx5IGZyb20gb3RoZXIgTGNkIHNpZ25hbHMsIEhTWU5DIGFuZCBWU1lOQyBzaWdu
YWxzCj4+IHJlc3VsdCBpbnZlcnRlZCBpZiB0aGVpciBiaXRzIGFyZSBjbGVhcmVkIHRvIDAuCj4+
Cj4+IEludmVydCB0aGVpciBzZXR0aW5ncyBvZiBJT19QT0wgcmVnaXN0ZXIuCj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IEdpdWxpbyBCZW5ldHRpIDxnaXVsaW8uYmVuZXR0aUBtaWNyb25vdmFzcmwuY29t
Pgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vc3VuNGkvc3VuNGlfdGNvbi5jIHwgNCArKy0t
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zdW40aS9zdW40aV90Y29uLmMgYi9kcml2
ZXJzL2dwdS9kcm0vc3VuNGkvc3VuNGlfdGNvbi5jCj4+IGluZGV4IDNjMTVjZjIuLmFhZjkxMWEg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zdW40aS9zdW40aV90Y29uLmMKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL3N1bjRpL3N1bjRpX3Rjb24uYwo+PiBAQCAtMzg5LDEwICszODks
MTAgQEAgc3RhdGljIHZvaWQgc3VuNGlfdGNvbjBfbW9kZV9zZXRfcmdiKHN0cnVjdCBzdW40aV90
Y29uICp0Y29uLAo+PiAgICAgICAgICAgICAgICAgICAgICAgU1VONElfVENPTjBfQkFTSUMzX0hf
U1lOQyhoc3luYykpOwo+Pgo+PiAgICAgICAgICAvKiBTZXR1cCB0aGUgcG9sYXJpdHkgb2YgdGhl
IHZhcmlvdXMgc2lnbmFscyAqLwo+PiAtICAgICAgIGlmICghKG1vZGUtPmZsYWdzICYgRFJNX01P
REVfRkxBR19QSFNZTkMpKQo+PiArICAgICAgIGlmIChtb2RlLT5mbGFncyAmIERSTV9NT0RFX0ZM
QUdfUEhTWU5DKQo+PiAgICAgICAgICAgICAgICAgIHZhbCB8PSBTVU40SV9UQ09OMF9JT19QT0xf
SFNZTkNfUE9TSVRJVkU7Cj4+Cj4+IC0gICAgICAgaWYgKCEobW9kZS0+ZmxhZ3MgJiBEUk1fTU9E
RV9GTEFHX1BWU1lOQykpCj4+ICsgICAgICAgaWYgKG1vZGUtPmZsYWdzICYgRFJNX01PREVfRkxB
R19QVlNZTkMpCj4+ICAgICAgICAgICAgICAgICAgdmFsIHw9IFNVTjRJX1RDT04wX0lPX1BPTF9W
U1lOQ19QT1NJVElWRTsKPj4KPj4gICAgICAgICAgcmVnbWFwX3VwZGF0ZV9iaXRzKHRjb24tPnJl
Z3MsIFNVTjRJX1RDT04wX0lPX1BPTF9SRUcsCj4gCj4gSSBhbSBydW5uaW5nIExpbnV4IDQuMTku
NiBhbmQgbm90aWNlZCB3aXRoIE9saW1leCBMQ0QtT0xpbnVYaW5vLTdUUyA3Igo+IExDRCB0b3Vj
aHNjcmVlbiAoSW5ub2x1eCBBVDA3MFROOTIpIGNvbm5lY3RlZCB0byBPbGltZXgKPiBBMjAtT0xp
bnVYaW5vLU1JQ1JPIHRoYXQgdGhlIGltYWdlIGRvZXMgbm90IGRpc3BsYXkgY29ycmVjdGx5IGFm
dGVyCj4gdGhpcyBjaGFuZ2UuCj4gVGhlIGltYWdlIGlzIHNoaWZ0ZWQgdG8gdGhlIHJpZ2h0Lgo+
IAo+IFJldmVydGluZyB0aGUgY2hhbmdlIHJlc3VsdHMgaW4gdGhlIGltYWdlIGJlaW5nIGRpc3Bs
YXllZCBjb3JyZWN0bHkgb24KPiB0aGUgc2NyZWVuLgo+IAo+IEkgaGF2ZSBpbiB0aGUgZGV2aWNl
IHRyZWUgYSAicGFuZWwiIG5vZGUgd2l0aCBjb21wYXRpYmxlID0KPiAiaW5ub2x1eCxhdDA3MHRu
OTIiIHdoaWNoIHVzZXMgdGhlIHRpbWluZ3MgaW4KPiBkcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFu
ZWwtc2ltcGxlLmMuCj4gCj4gQW55IGlkZWFzPwoKQ2hlY2tpbmcgRGlzcGxheSBEYXRhc2hlZXQ6
Cmh0dHBzOi8vd3d3Lm9saW1leC5jb20vUHJvZHVjdHMvUmV0aXJlZC9BMTMtTENENy1UUy9yZXNv
dXJjZXMvUzcwMC1BVDA3MFROOTIucGRmCgpQYWdlIDEzIHNlY3Rpb24gMy4zLjIgeW91IGNhbiBz
ZWUgaXQgbmVlZHMgYWN0aXZlIGxvdyBWUyBhbmQgSFMuCgpZb3UgY2FuIHJlZmVyIHRvIHRoaXMg
VGhyZWFkIGFuZCBjaGVjayBzY29wZSBjYXB0dXJlcyBhYm91dCBWUyBhbmQgSFMgCnZlcnN1cyBU
Q09OMF9JT1BPTCByZWdpc3RlcjoKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvYXJjaGl2
ZXMvZHJpLWRldmVsLzIwMTgtSmFudWFyeS8xNjM4NzQuaHRtbAoKVGhlcmUgc2hvdWxkIGJlIHNv
bWV0aGluZyB0aGF0IHdyb25nbHkgc2V0cyBvbmUgb2YgdGhlc2Ugb3IgYm90aDoKbW9kZS0+Zmxh
Z3MgfD0gRFJNX01PREVfRkxBR19QSFNZTkM7CmFuZC9vcgptb2RlLT5mbGFncyB8PSBEUk1fTU9E
RV9GTEFHX1BWU1lOQzsKCkNoZWNrZWQgaW4gcGFuZWwtc2ltcGxlLmMgYnV0IGl0J3Mgbm90IHRo
ZXJlLgoKQXQgdGhlIG1vbWVudCBJIGRvbid0IGhhdmUgYSBib2FyZCB0byBjaGVjayBpdCB3aXRo
IG1lLCBJJ2xsIHRyeSB0byBkbyAKaXQgc29vbiwgYnV0IEknbSBmdWxsIHdpdGggb3RoZXIgd29y
ayBhdCB0aGUgbW9tZW50LgoKSWYgeW91IGhhdmUgdGhlIGNoYW5jZSB0byBkZWJ1ZyB5b3UgY291
bGQgdHJ5IHRvIGZpbmQgaW4gd2hpY2ggcG9pbnQgCm1vZGUtPmZsYWdzIGdldHMgY2hhbmdlZCB3
aXRoIHRob3NlIDIgZmxhZ3MuCgpXaGVuIHRoZSBwcm9ibGVtIGNhbWUgb3V0IEkndmUgbm90aWNl
ZCB0aGUgc2FtZSB0aGluZyBmb3IgdS1ib290IHRvbyBidXQgCml0J3MgYmVlbiBkZWNpZGVkIHRv
IG5vdCBwYXRjaCBpdCBiZWNhdXNlIGluIHRoYXQgY2FzZSBldmVyeSBzaW5nbGUgCnN1bnhpIGRl
ZmNvbmZpZyBoYWQgdG8gYmUgY2hhbmdlZCBmcm9tOgpDT05GSUdfVklERU9fTENEX01PREU9Ii4u
LixzeW5jOjMsLi4uIgp0bzoKQ09ORklHX1ZJREVPX0xDRF9NT0RFPSIuLi4sc3luYzowLC4uLiIK
YW5kIGl0IHdvdWxkIGhhdmUgYmVlbiBhIGdyZWF0IG1lc3MsIHByb2JhYmx5IG5vdCB3b3J0aCBp
dDoKaHR0cHM6Ly9saXN0cy5kZW54LmRlL3BpcGVybWFpbC91LWJvb3QvMjAxOC1GZWJydWFyeS8z
MjE0MDUuaHRtbAoKU28ga2VlcCBpbiBtaW5kIHRoYXQgVENPTiBkcml2ZXIgd29ya3MgZGlmZmVy
ZW50bHkgZm9yIEhTIGFuZCAKVlMoaW52ZXJ0ZWQpIHBvbGFyaXR5IGluIHUtYm9vdCBhbmQgbGlu
dXguCgpIb3BlIHRvIHdvcmsgdGhpcyBvdXQgc29vbi4KQmVzdCByZWdhcmRzCi0tIApHaXVsaW8g
QmVuZXR0aQpDVE8KCk1JQ1JPTk9WQSBTUkwKU2VkZTogVmlhIEEuIE5pZWRkYSAzIC0gMzUwMTAg
Vmlnb256YSAoUEQpClRlbC4gMDQ5Lzg5MzE1NjMgLSBGYXggMDQ5Lzg5MzEzNDYKQ29kLkZpc2Nh
bGUgLSBQLklWQSAwMjY2MzQyMDI4NQpDYXBpdGFsZSBTb2NpYWxlIOKCrCAyNi4wMDAgaS52LgpJ
c2NyaXR0YSBhbCBSZWcuIEltcHJlc2UgZGkgUGFkb3ZhIE4uIDAyNjYzNDIwMjg1Ck51bWVybyBS
LkUuQS4gMjU4NjQyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
