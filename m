Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41A9C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:39:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9412C2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QbIO6Woj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="Zo443ti4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9412C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vURrCjpgJ8RcWcre8VAaalrpYywIU68ZDQDaHr1D81Q=; b=QbIO6WojJC8BldJZmw+qzfzeH
	F63ltrgWxe2JGnV9cvVW9Z68vhqHR3yx02csVC1QcA2kFhKAeC/LU6IdeEmj1fYQhe6DCGJ8IUZ6q
	z+zOfWGqzjpBkRM8yAPCURzEav3JHBMtG3/kuvoix7MIVvoKyueQp3qTX9ZgtXhkVrMHQ7MxxY7Lu
	gL6r7H5kqNQFClVsXMOpXJ0j6PBdgNQ6RnkmF5Qh9wVW+eRi1pUrJCxw7yriSZLwVMdbQZ6om5G3Q
	ktuXN20EcLbmEiS4TolbpunT/bxv12NaspA9GOUCGKE7DS/kZNQbEBCPwB7GehK5iLstmHZCdz1ED
	YdT7RzUzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWm0R-0007jU-5k; Tue, 11 Dec 2018 17:39:39 +0000
Received: from mail.micronovasrl.com ([212.103.203.10])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWm0N-0007hE-3t
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:39:37 +0000
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
 by mail.micronovasrl.com (Postfix) with ESMTP id E0650B00C39
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 18:39:23 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
 h=content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:user-agent:date:date
 :message-id:references:to:from:from:subject:subject; s=dkim; t=
 1544549962; x=1545413963; bh=fjo4i1DXGIr7W88H73aZkWxddgCaSKM0ee3
 8UzJxH6w=; b=Zo443ti4MIfRDuBovUc3QH/Mdqyx0HRCCx4Ez/1cqKe3YPrtiX0
 RyjjynqYqfUzR+iN+aGlmLv1Q3RMhqml0Ov0Gq5JoG+7RG2P2RJ+o/FQl8JnsJPc
 GhTZBSywg1qfUcPLtB1nNHpUqBTtCcAaywPthpZ2ZqKP3t2PUjUpP5+0=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
 by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id Rv1BlB5EN6Pc for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 18:39:22 +0100 (CET)
Received: from [192.168.2.69] (88-149-228-83.v4.ngi.it [88.149.228.83])
 by mail.micronovasrl.com (Postfix) with ESMTPSA id 6ECEFB0071D;
 Tue, 11 Dec 2018 18:39:22 +0100 (CET)
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Jonathan Liu <net147@gmail.com>
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
 <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
 <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
 <CANwerB1aUP4Rw-B_qmzOu0BWmkpr-LQ5b4FKQbzZeeYHPtGoqA@mail.gmail.com>
 <05786c98-6bc9-44f1-91ea-14452448cced@micronovasrl.com>
Message-ID: <e3307630-7ae7-2bd4-4933-a31419a0cc3a@micronovasrl.com>
Date: Tue, 11 Dec 2018 18:39:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <05786c98-6bc9-44f1-91ea-14452448cced@micronovasrl.com>
Content-Language: it
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_093935_329432_20328C84 
X-CRM114-Status: GOOD (  51.28  )
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

Rm9yZ290IHRvIGFzayB5b3UsCgpJbCAxMS8xMi8yMDE4IDE4OjIwLCBHaXVsaW8gQmVuZXR0aSBo
YSBzY3JpdHRvOgo+IEhpIEpvbmF0aGFuLAo+IAo+IElsIDExLzEyLzIwMTggMTE6NDksIEpvbmF0
aGFuIExpdSBoYSBzY3JpdHRvOgo+PiBIaSBHaXVsaW8sCj4+Cj4+IE9uIFRodSwgNiBEZWMgMjAx
OCBhdCAyMjowMCwgR2l1bGlvIEJlbmV0dGkKPj4gPGdpdWxpby5iZW5ldHRpQG1pY3Jvbm92YXNy
bC5jb20+IHdyb3RlOgo+Pj4KPj4+IEhpIEpvbmF0aGFuLAo+Pj4KPj4+IElsIDA2LzEyLzIwMTgg
MDg6MjksIEpvbmF0aGFuIExpdSBoYSBzY3JpdHRvOgo+Pj4+IEhpIEdpdWxpbywKPj4+Pgo+Pj4+
IE9uIFRodSwgMTUgRmViIDIwMTggYXQgMTc6NTQsIEdpdWxpbyBCZW5ldHRpCj4+Pj4gPGdpdWxp
by5iZW5ldHRpQG1pY3Jvbm92YXNybC5jb20+IHdyb3RlOgo+Pj4+Pgo+Pj4+PiBEaWZmZXJlbnRs
eSBmcm9tIG90aGVyIExjZCBzaWduYWxzLCBIU1lOQyBhbmQgVlNZTkMgc2lnbmFscwo+Pj4+PiBy
ZXN1bHQgaW52ZXJ0ZWQgaWYgdGhlaXIgYml0cyBhcmUgY2xlYXJlZCB0byAwLgo+Pj4+Pgo+Pj4+
PiBJbnZlcnQgdGhlaXIgc2V0dGluZ3Mgb2YgSU9fUE9MIHJlZ2lzdGVyLgo+Pj4+Pgo+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBHaXVsaW8gQmVuZXR0aSA8Z2l1bGlvLmJlbmV0dGlAbWljcm9ub3Zhc3Js
LmNvbT4KPj4+Pj4gLS0tCj4+Pj4+IMKgwqAgZHJpdmVycy9ncHUvZHJtL3N1bjRpL3N1bjRpX3Rj
b24uYyB8IDQgKystLQo+Pj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
c3VuNGkvc3VuNGlfdGNvbi5jIAo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9zdW40aS9zdW40aV90
Y29uLmMKPj4+Pj4gaW5kZXggM2MxNWNmMi4uYWFmOTExYSAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL3N1bjRpL3N1bjRpX3Rjb24uYwo+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vc3VuNGkvc3VuNGlfdGNvbi5jCj4+Pj4+IEBAIC0zODksMTAgKzM4OSwxMCBAQCBzdGF0aWMg
dm9pZCBzdW40aV90Y29uMF9tb2RlX3NldF9yZ2Ioc3RydWN0IAo+Pj4+PiBzdW40aV90Y29uICp0
Y29uLAo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBT
VU40SV9UQ09OMF9CQVNJQzNfSF9TWU5DKGhzeW5jKSk7Cj4+Pj4+Cj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCAvKiBTZXR1cCB0aGUgcG9sYXJpdHkgb2YgdGhlIHZhcmlvdXMgc2lnbmFscyAqLwo+
Pj4+PiAtwqDCoMKgwqDCoMKgIGlmICghKG1vZGUtPmZsYWdzICYgRFJNX01PREVfRkxBR19QSFNZ
TkMpKQo+Pj4+PiArwqDCoMKgwqDCoMKgIGlmIChtb2RlLT5mbGFncyAmIERSTV9NT0RFX0ZMQUdf
UEhTWU5DKQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCB8PSBT
VU40SV9UQ09OMF9JT19QT0xfSFNZTkNfUE9TSVRJVkU7Cj4+Pj4+Cj4+Pj4+IC3CoMKgwqDCoMKg
wqAgaWYgKCEobW9kZS0+ZmxhZ3MgJiBEUk1fTU9ERV9GTEFHX1BWU1lOQykpCj4+Pj4+ICvCoMKg
wqDCoMKgwqAgaWYgKG1vZGUtPmZsYWdzICYgRFJNX01PREVfRkxBR19QVlNZTkMpCj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsIHw9IFNVTjRJX1RDT04wX0lPX1BP
TF9WU1lOQ19QT1NJVElWRTsKPj4+Pj4KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJlZ21hcF91
cGRhdGVfYml0cyh0Y29uLT5yZWdzLCBTVU40SV9UQ09OMF9JT19QT0xfUkVHLAo+Pj4+Cj4+Pj4g
SSBhbSBydW5uaW5nIExpbnV4IDQuMTkuNiBhbmQgbm90aWNlZCB3aXRoIE9saW1leCBMQ0QtT0xp
bnVYaW5vLTdUUyA3Igo+Pj4+IExDRCB0b3VjaHNjcmVlbiAoSW5ub2x1eCBBVDA3MFROOTIpIGNv
bm5lY3RlZCB0byBPbGltZXgKPj4+PiBBMjAtT0xpbnVYaW5vLU1JQ1JPIHRoYXQgdGhlIGltYWdl
IGRvZXMgbm90IGRpc3BsYXkgY29ycmVjdGx5IGFmdGVyCj4+Pj4gdGhpcyBjaGFuZ2UuCj4+Pj4g
VGhlIGltYWdlIGlzIHNoaWZ0ZWQgdG8gdGhlIHJpZ2h0Lgo+Pj4+Cj4+Pj4gUmV2ZXJ0aW5nIHRo
ZSBjaGFuZ2UgcmVzdWx0cyBpbiB0aGUgaW1hZ2UgYmVpbmcgZGlzcGxheWVkIGNvcnJlY3RseSBv
bgo+Pj4+IHRoZSBzY3JlZW4uCj4+Pj4KPj4+PiBJIGhhdmUgaW4gdGhlIGRldmljZSB0cmVlIGEg
InBhbmVsIiBub2RlIHdpdGggY29tcGF0aWJsZSA9Cj4+Pj4gImlubm9sdXgsYXQwNzB0bjkyIiB3
aGljaCB1c2VzIHRoZSB0aW1pbmdzIGluCj4+Pj4gZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVs
LXNpbXBsZS5jLgo+Pj4+Cj4+Pj4gQW55IGlkZWFzPwo+Pgo+Pj4KPj4+IENoZWNraW5nIERpc3Bs
YXkgRGF0YXNoZWV0Ogo+Pj4gaHR0cHM6Ly93d3cub2xpbWV4LmNvbS9Qcm9kdWN0cy9SZXRpcmVk
L0ExMy1MQ0Q3LVRTL3Jlc291cmNlcy9TNzAwLUFUMDcwVE45Mi5wZGYgCj4+Pgo+Pj4KPj4+IFBh
Z2UgMTMgc2VjdGlvbiAzLjMuMiB5b3UgY2FuIHNlZSBpdCBuZWVkcyBhY3RpdmUgbG93IFZTIGFu
ZCBIUy4KPj4+Cj4+PiBZb3UgY2FuIHJlZmVyIHRvIHRoaXMgVGhyZWFkIGFuZCBjaGVjayBzY29w
ZSBjYXB0dXJlcyBhYm91dCBWUyBhbmQgSFMKPj4+IHZlcnN1cyBUQ09OMF9JT1BPTCByZWdpc3Rl
cjoKPj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hpdmVzL2RyaS1kZXZlbC8y
MDE4LUphbnVhcnkvMTYzODc0Lmh0bWwgCj4+Pgo+Pj4KPj4+IFRoZXJlIHNob3VsZCBiZSBzb21l
dGhpbmcgdGhhdCB3cm9uZ2x5IHNldHMgb25lIG9mIHRoZXNlIG9yIGJvdGg6Cj4+PiBtb2RlLT5m
bGFncyB8PSBEUk1fTU9ERV9GTEFHX1BIU1lOQzsKPj4+IGFuZC9vcgo+Pj4gbW9kZS0+ZmxhZ3Mg
fD0gRFJNX01PREVfRkxBR19QVlNZTkM7Cj4+Pgo+Pj4gQ2hlY2tlZCBpbiBwYW5lbC1zaW1wbGUu
YyBidXQgaXQncyBub3QgdGhlcmUuCj4+Cj4+IGZsYWdzIGlzIDAgYmVjYXVzZSBpdCBpcyBub3Qg
YXNzaWduZWQgaW4gdGhlIHN0cnVjdCBkZWZpbml0aW9uIGZvciB0aGUgCj4+IHBhbmVsLgo+IAo+
IEkgZG9uJ3QgdGhpbmsgaXQgaXMgMCwgYmVjYXVzZSBvdGhlcndpc2UgSU9fUE9MX1JFRyB3b3Vs
ZG4ndCBiZSBzZXQgdG8gCj4gMHgwMzAwMDAwMCBidXQgdG8gMC4KPiBXaGF0IGlzIGNoZWNrZWQg
aXMgZXhhY3RseSBtb2RlLT5mbGFncywgc28gdGhlIHByb2JsZW0gc2VlbXMgdG8gYmUgCj4gdXBz
dHJlYW0uCj4gCj4gVGhpcyBpcyBteSBkb3VidCwgaXQgc2VlbXMgbW9kZS0+ZmxhZ3MgaXMgbm90
IGluaXRpYWxpemVkIG9yIG92ZXJyaWRlbiAKPiBhdCBhIGNlcnRhaW4gcG9pbnQsIHRoaXMgaXMg
d2h5IEkgd2FudCB0byBkZWJ1ZyBpdCB3aXRoIEp0YWcgdG9tb3Jyb3cuCj4gCj4+IEJlZm9yZSB0
aGlzIGNoYW5nZSwgVENPTjBfSU9fUE9MX1JFRyB3b3VsZCBiZSAweDAzMDAwMDAwIChib3RoIGJp
dHMKPj4gc2V0IHRvIDEpIGFuZCBpbWFnZSBkaXNwbGF5cyBjb3JyZWN0bHkgPiBBZnRlciB0aGlz
IGNoYW5nZSwgCj4+IFRDT04wX0lPX1BPTF9SRUcgaXMgMHgwMDAwMDAwMCAoYm90aCBiaXRzIHNl
dCB0byAwKQo+PiBhbmQgaW1hZ2UgZG9lc24ndCBkaXNwbGF5IGNvcnJlY3RseS4KPj4KPj4gQ2hl
Y2tlZCB1c2luZyAiZGV2bWVtMiAweDAxYzBjMDg4IiBvbiBBMjAtT0xpbnVYaW5vLU1JQ1JPIFJl
diBKLgo+IAo+IDB4MDMwMDAwMDAgYXMgSSd2ZSB0cmlwbGUgY2hlY2tlZCB3aXRoIHNjb3BlIG1l
YW5zIFBvc2l0aXZlIEgvVnN5bmMsCj4gYW5kIDB4MDAwMDAwMDAgTmVnYXRpdmUgSC9WU3luYy4K
PiAKPiBQbGVhc2UgY2hlY2sgb24gdGhlIFRocmVhZCBJJ3ZlIHBvaW50ZWQgeW91IGFib3ZlIHdo
ZXJlIHRoZXJlIGFyZSBhbGwgCj4gdGhlIGxpbmtzIHRvIHRoZSBzY29wZSBjYXB0dXJlcy4KPiAK
PiBBcmUgeW91IGNvbXBsZXRlbHkgc3VyZSB5b3UncmUgdXNpbmcgdGhlIGNvcnJlY3QgcGFuZWw/
Cj4gVGhpcyBpcyBiZWNhdXNlIGlmIHdpdGggMHgwMzAwMDAwMCBpdCB3b3JrcyBjb3JyZWN0bHks
IGl0IG1lYW5zIHRoYXQgCj4geW91J3JlIHVzaW5nIFBvc2l0aXZlIFZTIGFuZCBIUyBidXQgb24g
ZGF0YXNoZWV0IG9uIEZpZ3VyZSAzLjIgaXQgc2hvd3MgCj4gdGhhdCB0aGV5IG11c3QgYmUgbmVn
YXRpdmUuCj4gCj4gRG8geW91IGhhdmUgYW55IGNoYW5jZSB0byBtZWFzdXJlIHRob3NlIHNpZ25h
bHMgd2l0aCBhIHNjb3BlPwo+IAo+IFRvbW9ycm93LCB3aGlsZSBkZWJ1Z2dpbmcsIEknbGwgcmUt
Y2hlY2sgSC9Wc3luYyBzaWduYWxzIGFnYWluLgo+IAo+IEtpbmQgcmVnYXJkcwoKQ2FuIHlvdSBw
cmVjaXNlbHkgcG9pbnQgbWUgdGhlIHNvdXJjZXMgb2Y6Ci0gdS1ib290Ci0ga2VybmVsCi0gZHRz
Cgp5b3UncmUgdXNpbmc/CgpUaGFua3MKCi0tIApHaXVsaW8gQmVuZXR0aQpDVE8KCk1JQ1JPTk9W
QSBTUkwKU2VkZTogVmlhIEEuIE5pZWRkYSAzIC0gMzUwMTAgVmlnb256YSAoUEQpClRlbC4gMDQ5
Lzg5MzE1NjMgLSBGYXggMDQ5Lzg5MzEzNDYKQ29kLkZpc2NhbGUgLSBQLklWQSAwMjY2MzQyMDI4
NQpDYXBpdGFsZSBTb2NpYWxlIOKCrCAyNi4wMDAgaS52LgpJc2NyaXR0YSBhbCBSZWcuIEltcHJl
c2UgZGkgUGFkb3ZhIE4uIDAyNjYzNDIwMjg1Ck51bWVybyBSLkUuQS4gMjU4NjQyCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
