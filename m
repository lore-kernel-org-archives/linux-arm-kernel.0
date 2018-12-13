Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4081C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:59:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9282B2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gEH76GXl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="RQzViI0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9282B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Lk1S2/4Rz46Ky+cBZSN6ZS/501v+30pUFqsn1LCcyjE=; b=gEH76GXl2B5R2CeoG66OuG07Z
	svOERQvr11VUSz7XblZNzv0dgUIsf39jt+UpQo1rHBavaFhmzdr+mJ103MlgHY5N23dAhRvO3JU2P
	dBpa6F1YiKF8w/L/a9MvX5S05jmi4QiUhHUsHL4D+G7mk09aueox/aBPPH1Z1jKfCEbTMsUboztph
	hWN3iUknQh7KEkha5TwxyfKKmIvw7YY2WrcWErk9zPA6Gq2WVANcO3Vyx/Gtkw+thINGf5q7wpotl
	EHrGh7EhHgRgeP5xK3liRvQ0/AaBsT6vVPGby3JvGKgRIvSiA2e1Cw++jOa9i+z3J1orRdTAOLcbF
	C1r2aflwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPe1-00029S-SC; Thu, 13 Dec 2018 11:59:09 +0000
Received: from mail.micronovasrl.com ([212.103.203.10])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPdy-00028S-88
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:59:08 +0000
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
 by mail.micronovasrl.com (Postfix) with ESMTP id E0143B019B5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 12:58:54 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
 h=content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:user-agent:date:date
 :message-id:from:from:references:to:subject:subject; s=dkim; t=
 1544702333; x=1545566334; bh=Bx8meC0FWDSHNC6fJ6mJV61gPaVubU8oonO
 /vQEzoys=; b=RQzViI0Ufi8nAnkjiy8slEtjCIekZ4JaR8rZYtYL0rvXBNgNqZf
 MLC7Bx8S5XGwsGxHVNp8GbZfECyMcC26yRdh0eHo4agay80qFoW1BeZFinMztPhF
 B5IFYMl/5wfAnru7ZCeGSR0HO9pGInvgeW1EP2a2dnzoXFQvsUPWQoPw=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
 by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id UM6WMfaIXL6D for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 12:58:53 +0100 (CET)
Received: from [192.168.178.33]
 (host180-21-dynamic.5-87-r.retail.telecomitalia.it [87.5.21.180])
 by mail.micronovasrl.com (Postfix) with ESMTPSA id 107B4B01928;
 Thu, 13 Dec 2018 12:58:52 +0100 (CET)
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
To: Jonathan Liu <net147@gmail.com>
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
 <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
 <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
 <CANwerB1aUP4Rw-B_qmzOu0BWmkpr-LQ5b4FKQbzZeeYHPtGoqA@mail.gmail.com>
 <05786c98-6bc9-44f1-91ea-14452448cced@micronovasrl.com>
 <CANwerB0mR3NK8488g4bWCroEzoEQkoE+btVivq9m_TzHctTfuQ@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <f75bfd8a-5f1a-8860-78ec-4af1f394f01c@micronovasrl.com>
Date: Thu, 13 Dec 2018 12:58:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CANwerB0mR3NK8488g4bWCroEzoEQkoE+btVivq9m_TzHctTfuQ@mail.gmail.com>
Content-Language: it
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_035906_464513_D84EB072 
X-CRM114-Status: GOOD (  53.02  )
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

CgpJbCAxMy8xMi8yMDE4IDA0OjA4LCBKb25hdGhhbiBMaXUgaGEgc2NyaXR0bzoKPiBIaSBHaXVs
aW8sCj4gCj4gT24gV2VkLCAxMiBEZWMgMjAxOCBhdCAwNDoyMCwgR2l1bGlvIEJlbmV0dGkKPiA8
Z2l1bGlvLmJlbmV0dGlAbWljcm9ub3Zhc3JsLmNvbT4gd3JvdGU6Cj4+Cj4+IEhpIEpvbmF0aGFu
LAo+Pgo+PiBJbCAxMS8xMi8yMDE4IDExOjQ5LCBKb25hdGhhbiBMaXUgaGEgc2NyaXR0bzoKPj4+
IEhpIEdpdWxpbywKPj4+Cj4+PiBPbiBUaHUsIDYgRGVjIDIwMTggYXQgMjI6MDAsIEdpdWxpbyBC
ZW5ldHRpCj4+PiA8Z2l1bGlvLmJlbmV0dGlAbWljcm9ub3Zhc3JsLmNvbT4gd3JvdGU6Cj4+Pj4K
Pj4+PiBIaSBKb25hdGhhbiwKPj4+Pgo+Pj4+IElsIDA2LzEyLzIwMTggMDg6MjksIEpvbmF0aGFu
IExpdSBoYSBzY3JpdHRvOgo+Pj4+PiBIaSBHaXVsaW8sCj4+Pj4+Cj4+Pj4+IE9uIFRodSwgMTUg
RmViIDIwMTggYXQgMTc6NTQsIEdpdWxpbyBCZW5ldHRpCj4+Pj4+IDxnaXVsaW8uYmVuZXR0aUBt
aWNyb25vdmFzcmwuY29tPiB3cm90ZToKPj4+Pj4+Cj4+Pj4+PiBEaWZmZXJlbnRseSBmcm9tIG90
aGVyIExjZCBzaWduYWxzLCBIU1lOQyBhbmQgVlNZTkMgc2lnbmFscwo+Pj4+Pj4gcmVzdWx0IGlu
dmVydGVkIGlmIHRoZWlyIGJpdHMgYXJlIGNsZWFyZWQgdG8gMC4KPj4+Pj4+Cj4+Pj4+PiBJbnZl
cnQgdGhlaXIgc2V0dGluZ3Mgb2YgSU9fUE9MIHJlZ2lzdGVyLgo+Pj4+Pj4KPj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEdpdWxpbyBCZW5ldHRpIDxnaXVsaW8uYmVuZXR0aUBtaWNyb25vdmFzcmwuY29t
Pgo+Pj4+Pj4gLS0tCj4+Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL3N1bjRpL3N1bjRpX3Rjb24u
YyB8IDQgKystLQo+Pj4+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4+Pj4+Pgo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9z
dW40aS9zdW40aV90Y29uLmMgYi9kcml2ZXJzL2dwdS9kcm0vc3VuNGkvc3VuNGlfdGNvbi5jCj4+
Pj4+PiBpbmRleCAzYzE1Y2YyLi5hYWY5MTFhIDEwMDY0NAo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3N1bjRpL3N1bjRpX3Rjb24uYwo+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3N1
bjRpL3N1bjRpX3Rjb24uYwo+Pj4+Pj4gQEAgLTM4OSwxMCArMzg5LDEwIEBAIHN0YXRpYyB2b2lk
IHN1bjRpX3Rjb24wX21vZGVfc2V0X3JnYihzdHJ1Y3Qgc3VuNGlfdGNvbiAqdGNvbiwKPj4+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICAgIFNVTjRJX1RDT04wX0JBU0lDM19IX1NZTkMoaHN5bmMp
KTsKPj4+Pj4+Cj4+Pj4+PiAgICAgICAgICAgIC8qIFNldHVwIHRoZSBwb2xhcml0eSBvZiB0aGUg
dmFyaW91cyBzaWduYWxzICovCj4+Pj4+PiAtICAgICAgIGlmICghKG1vZGUtPmZsYWdzICYgRFJN
X01PREVfRkxBR19QSFNZTkMpKQo+Pj4+Pj4gKyAgICAgICBpZiAobW9kZS0+ZmxhZ3MgJiBEUk1f
TU9ERV9GTEFHX1BIU1lOQykKPj4+Pj4+ICAgICAgICAgICAgICAgICAgICB2YWwgfD0gU1VONElf
VENPTjBfSU9fUE9MX0hTWU5DX1BPU0lUSVZFOwo+Pj4+Pj4KPj4+Pj4+IC0gICAgICAgaWYgKCEo
bW9kZS0+ZmxhZ3MgJiBEUk1fTU9ERV9GTEFHX1BWU1lOQykpCj4+Pj4+PiArICAgICAgIGlmICht
b2RlLT5mbGFncyAmIERSTV9NT0RFX0ZMQUdfUFZTWU5DKQo+Pj4+Pj4gICAgICAgICAgICAgICAg
ICAgIHZhbCB8PSBTVU40SV9UQ09OMF9JT19QT0xfVlNZTkNfUE9TSVRJVkU7Cj4+Pj4+Pgo+Pj4+
Pj4gICAgICAgICAgICByZWdtYXBfdXBkYXRlX2JpdHModGNvbi0+cmVncywgU1VONElfVENPTjBf
SU9fUE9MX1JFRywKPj4+Pj4KPj4+Pj4gSSBhbSBydW5uaW5nIExpbnV4IDQuMTkuNiBhbmQgbm90
aWNlZCB3aXRoIE9saW1leCBMQ0QtT0xpbnVYaW5vLTdUUyA3Igo+Pj4+PiBMQ0QgdG91Y2hzY3Jl
ZW4gKElubm9sdXggQVQwNzBUTjkyKSBjb25uZWN0ZWQgdG8gT2xpbWV4Cj4+Pj4+IEEyMC1PTGlu
dVhpbm8tTUlDUk8gdGhhdCB0aGUgaW1hZ2UgZG9lcyBub3QgZGlzcGxheSBjb3JyZWN0bHkgYWZ0
ZXIKPj4+Pj4gdGhpcyBjaGFuZ2UuCj4+Pj4+IFRoZSBpbWFnZSBpcyBzaGlmdGVkIHRvIHRoZSBy
aWdodC4KPj4+Pj4KPj4+Pj4gUmV2ZXJ0aW5nIHRoZSBjaGFuZ2UgcmVzdWx0cyBpbiB0aGUgaW1h
Z2UgYmVpbmcgZGlzcGxheWVkIGNvcnJlY3RseSBvbgo+Pj4+PiB0aGUgc2NyZWVuLgo+Pj4+Pgo+
Pj4+PiBJIGhhdmUgaW4gdGhlIGRldmljZSB0cmVlIGEgInBhbmVsIiBub2RlIHdpdGggY29tcGF0
aWJsZSA9Cj4+Pj4+ICJpbm5vbHV4LGF0MDcwdG45MiIgd2hpY2ggdXNlcyB0aGUgdGltaW5ncyBp
bgo+Pj4+PiBkcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtc2ltcGxlLmMuCj4+Pj4+Cj4+Pj4+
IEFueSBpZGVhcz8KPj4+Cj4+Pj4KPj4+PiBDaGVja2luZyBEaXNwbGF5IERhdGFzaGVldDoKPj4+
PiBodHRwczovL3d3dy5vbGltZXguY29tL1Byb2R1Y3RzL1JldGlyZWQvQTEzLUxDRDctVFMvcmVz
b3VyY2VzL1M3MDAtQVQwNzBUTjkyLnBkZgo+Pj4+Cj4+Pj4gUGFnZSAxMyBzZWN0aW9uIDMuMy4y
IHlvdSBjYW4gc2VlIGl0IG5lZWRzIGFjdGl2ZSBsb3cgVlMgYW5kIEhTLgo+Pj4+Cj4+Pj4gWW91
IGNhbiByZWZlciB0byB0aGlzIFRocmVhZCBhbmQgY2hlY2sgc2NvcGUgY2FwdHVyZXMgYWJvdXQg
VlMgYW5kIEhTCj4+Pj4gdmVyc3VzIFRDT04wX0lPUE9MIHJlZ2lzdGVyOgo+Pj4+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hpdmVzL2RyaS1kZXZlbC8yMDE4LUphbnVhcnkvMTYz
ODc0Lmh0bWwKPj4+Pgo+Pj4+IFRoZXJlIHNob3VsZCBiZSBzb21ldGhpbmcgdGhhdCB3cm9uZ2x5
IHNldHMgb25lIG9mIHRoZXNlIG9yIGJvdGg6Cj4+Pj4gbW9kZS0+ZmxhZ3MgfD0gRFJNX01PREVf
RkxBR19QSFNZTkM7Cj4+Pj4gYW5kL29yCj4+Pj4gbW9kZS0+ZmxhZ3MgfD0gRFJNX01PREVfRkxB
R19QVlNZTkM7Cj4+Pj4KPj4+PiBDaGVja2VkIGluIHBhbmVsLXNpbXBsZS5jIGJ1dCBpdCdzIG5v
dCB0aGVyZS4KPiAKPj4+Cj4+PiBmbGFncyBpcyAwIGJlY2F1c2UgaXQgaXMgbm90IGFzc2lnbmVk
IGluIHRoZSBzdHJ1Y3QgZGVmaW5pdGlvbiBmb3IgdGhlIHBhbmVsLgo+Pgo+PiBJIGRvbid0IHRo
aW5rIGl0IGlzIDAsIGJlY2F1c2Ugb3RoZXJ3aXNlIElPX1BPTF9SRUcgd291bGRuJ3QgYmUgc2V0
IHRvCj4+IDB4MDMwMDAwMDAgYnV0IHRvIDAuCj4+IFdoYXQgaXMgY2hlY2tlZCBpcyBleGFjdGx5
IG1vZGUtPmZsYWdzLCBzbyB0aGUgcHJvYmxlbSBzZWVtcyB0byBiZSB1cHN0cmVhbS4KPj4KPj4g
VGhpcyBpcyBteSBkb3VidCwgaXQgc2VlbXMgbW9kZS0+ZmxhZ3MgaXMgbm90IGluaXRpYWxpemVk
IG9yIG92ZXJyaWRlbgo+PiBhdCBhIGNlcnRhaW4gcG9pbnQsIHRoaXMgaXMgd2h5IEkgd2FudCB0
byBkZWJ1ZyBpdCB3aXRoIEp0YWcgdG9tb3Jyb3cuCgptb2RlLT5mbGFncyBpcyBjb3JyZWN0LCBq
dXN0IGNoZWNrZWQgd2l0aCBkZWJ1Z2dlci4KCj4+Cj4gCj4gSWYgeW91IGxvb2sgYXQgdGhlIGNo
YW5nZSBtYWRlIGJ5IHlvdXIgcGF0Y2g6Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3N1bjRpL3N1
bjRpX3Rjb24uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdW40aS9zdW40aV90Y29uLmMKPiBA
QCAtMzg5LDEwICszODksMTAgQEAgc3RhdGljIHZvaWQgc3VuNGlfdGNvbjBfbW9kZV9zZXRfcmdi
KHN0cnVjdAo+IHN1bjRpX3Rjb24gKnRjb24sCj4gICAgICAgICAgICAgICAgICAgICAgIFNVTjRJ
X1RDT04wX0JBU0lDM19IX1NZTkMoaHN5bmMpKTsKPiAKPiAgICAgICAgICAvKiBTZXR1cCB0aGUg
cG9sYXJpdHkgb2YgdGhlIHZhcmlvdXMgc2lnbmFscyAqLwo+IC0gICAgICAgaWYgKCEobW9kZS0+
ZmxhZ3MgJiBEUk1fTU9ERV9GTEFHX1BIU1lOQykpCj4gKyAgICAgICBpZiAobW9kZS0+ZmxhZ3Mg
JiBEUk1fTU9ERV9GTEFHX1BIU1lOQykKPiAgICAgICAgICAgICAgICAgIHZhbCB8PSBTVU40SV9U
Q09OMF9JT19QT0xfSFNZTkNfUE9TSVRJVkU7Cj4gCj4gLSAgICAgICBpZiAoIShtb2RlLT5mbGFn
cyAmIERSTV9NT0RFX0ZMQUdfUFZTWU5DKSkKPiArICAgICAgIGlmIChtb2RlLT5mbGFncyAmIERS
TV9NT0RFX0ZMQUdfUFZTWU5DKQo+ICAgICAgICAgICAgICAgICAgdmFsIHw9IFNVTjRJX1RDT04w
X0lPX1BPTF9WU1lOQ19QT1NJVElWRTsKPiAKPiAgICAgICAgICByZWdtYXBfdXBkYXRlX2JpdHMo
dGNvbi0+cmVncywgU1VONElfVENPTjBfSU9fUE9MX1JFRywKPiAKPiBJZiBtb2RlLT5mbGFncyBp
cyAwLCAKCm1vZGUtPmZsYWdzIGlzIDB4YShEUk1fTU9ERV9GTEFHX05IU1lOQyB8IERSTV9NT0RF
X0ZMQUdfTlZTWU5DKSBieSAKZGVmYXVsdCBpZiBub3Qgc3BlY2lmaWVkIGRpZmZlcmVudCBpbiBw
YW5lbC1zaW1wbGUuYyBzbyB0aGUgc2lnbmFscyBtdXN0IApiZSBhY3RpdmUgTE9XKElPX1BPTF9S
RUcgPSAweDAwMDAwMDAwKS4KCj4gdGhlbiBiZWZvcmUgeW91ciBjaGFuZ2UgaXQgd291bGQgc2V0
Cj4gU1VONElfVENPTjBfSU9fUE9MX0hTWU5DX1BPU0lUSVZFIGFuZAo+IFNVTjRJX1RDT04wX0lP
X1BPTF9WU1lOQ19QT1NJVElWRSBiaXRzIHRvIDEgKHJlc3VsdGluZyBpbiAweDAzMDAwMDAwKS4K
CkFuZCBpdCB3YXMgd3JvbmcsIGJlY2F1c2UgYXMgSSd2ZSBwb2ludGVkIHlvdSBhYm92ZSwgZXNw
ZWNpYWxseSBpbiB0aGUgClRocmVhZCB3aXRoIGFsbCB0aGUgc2NvcGUgY2FwdHVyZXMsIDB4MDMw
MDAwMDAgbWVhbnMgYWN0aXZlIEhJR0ggCkgvVnN5bmMsIHdoaWxlIDB4MDAwMDAwMDAgbWVhbnMg
YWN0aXZlIExPVyBIL1ZzeW5jLgoKPiBJZiBtb2RlLT5mbGFncyBpcyBub3QgMCwgdGhlbiBhZnRl
ciB5b3VyIGNoYW5nZSBpdCB3b3VsZCBub3Qgc2V0Cj4gU1VONElfVENPTjBfSU9fUE9MX0hTWU5D
X1BPU0lUSVZFIGFuZAo+IFNVTjRJX1RDT04wX0lPX1BPTF9WU1lOQ19QT1NJVElWRSBiaXRzIHRv
IDEgKHJlc3VsdGluZyBpbiAweDAwMDAwMDAwKS4KCklmIG1vZGUtPmZsYWdzIGlzIDB4NShEUk1f
TU9ERV9GTEFHX1BIU1lOQyB8IERSTV9NT0RFX0ZMQUdfUFZTWU5DKSBpLmUuIApzcGVjaWZpZWQg
aW4gcGFuZWwtc2ltcGxlLmMgdGhlIHNpZ25hbHMgbXVzdCBiZSBhY3RpdmUgSElHSChJT19QT0xf
UkVHID0gCjB4MDMwMDAwMDApLgoKSU9fUE9MX1JFRyA9IDB4MDMwMDAwMDAgaXMgYWN0aXZlIEhJ
R0gKSU9fUE9MX1JFRyA9IDB4MDAwMDAwMDAgaXMgYWN0aXZlIExPVwoKYXMgSSd2ZSBjaGVja2Vk
IG1hbnkgdGltZXMgYW5kIHJlY2hlY2tlZCB0b2RheSBsb3Qgb2YgdGltZXMgdG9vLgoKPj4+IEJl
Zm9yZSB0aGlzIGNoYW5nZSwgVENPTjBfSU9fUE9MX1JFRyB3b3VsZCBiZSAweDAzMDAwMDAwIChi
b3RoIGJpdHMKPj4+IHNldCB0byAxKSBhbmQgaW1hZ2UgZGlzcGxheXMgY29ycmVjdGx5ID4gQWZ0
ZXIgdGhpcyBjaGFuZ2UsIFRDT04wX0lPX1BPTF9SRUcgaXMgMHgwMDAwMDAwMCAoYm90aCBiaXRz
IHNldCB0byAwKQo+Pj4gYW5kIGltYWdlIGRvZXNuJ3QgZGlzcGxheSBjb3JyZWN0bHkuCj4+Pgo+
Pj4gQ2hlY2tlZCB1c2luZyAiZGV2bWVtMiAweDAxYzBjMDg4IiBvbiBBMjAtT0xpbnVYaW5vLU1J
Q1JPIFJldiBKLgo+Pgo+PiAweDAzMDAwMDAwIGFzIEkndmUgdHJpcGxlIGNoZWNrZWQgd2l0aCBz
Y29wZSBtZWFucyBQb3NpdGl2ZSBIL1ZzeW5jLAo+PiBhbmQgMHgwMDAwMDAwMCBOZWdhdGl2ZSBI
L1ZTeW5jLgo+Pgo+PiBQbGVhc2UgY2hlY2sgb24gdGhlIFRocmVhZCBJJ3ZlIHBvaW50ZWQgeW91
IGFib3ZlIHdoZXJlIHRoZXJlIGFyZSBhbGwKPj4gdGhlIGxpbmtzIHRvIHRoZSBzY29wZSBjYXB0
dXJlcy4KPj4KPj4gQXJlIHlvdSBjb21wbGV0ZWx5IHN1cmUgeW91J3JlIHVzaW5nIHRoZSBjb3Jy
ZWN0IHBhbmVsPwo+IAo+IFllcywgSSBhbSBzdXJlIEkgYW0gdXNpbmcgdGhlIGNvcnJlY3QgcGFu
ZWwuIEl0IGhhcyB0aGUgZm9sbG93aW5nCj4gbWFya2luZyBvbiBzdGlja2VyOgo+IEFUMDcwVE45
MlYuWCA4OUEwNzBaWi0wSzEKCkF0IHRoaXMgcG9pbnQgdGhlIG9ubHkgd2F5IHRvIG1ha2UgaXQg
d29ya2luZyBpcyB0byBzcGVjaWZ5IApEUk1fTU9ERV9GTEFHX05IU1lOQyB8IERSTV9NT0RFX0ZM
QUdfTlZTWU5DIGluIHBhbmVsLXNpbXBsZS5jIGFuZCBjaGVjay4KQ2FuIHlvdSBkbyBhIGNoZWNr
IGFuZCB0ZWxsIG1lIGlmIHRoaXMgc29sdmVzIHRoZSBwcm9ibGVtPwpBbHNvLCBpdCdzIG5vdCBz
dWZmaWNpZW50IHRvIHN1Ym1pdCBhIHBhdGNoIGZvciB0aGF0IGRpc3BsYXkgaW4gCnBhbmVsLXNp
bXBsZS5jIChJTUhPKSBiZWNhdXNlIEkgd291bGQgY2hlY2sgd2l0aCBzY29wZSBpZiBpdCBpcyB0
aGUgd2F5IAp3b3UncmUgZGVzY3JpYmluZy4KCkkgZG9uJ3Qga25vdyBob3cgdG8gZGVzY3JpYmUg
aXQgYmV0dGVyIHRoYW4gdGhpcyBhbmQgSU1ITyB0aGUgc2NvcGUgY2FuIApnaXZlIHVzIHRoZSBm
aW5hbCBhbnN3ZXIuCgpIb3BlIEkndmUgYmVlbiBoZWxwZnVsLgoKQmVzdCByZWdhcmRzCi0tIApH
aXVsaW8gQmVuZXR0aQpDVE8KCk1JQ1JPTk9WQSBTUkwKU2VkZTogVmlhIEEuIE5pZWRkYSAzIC0g
MzUwMTAgVmlnb256YSAoUEQpClRlbC4gMDQ5Lzg5MzE1NjMgLSBGYXggMDQ5Lzg5MzEzNDYKQ29k
LkZpc2NhbGUgLSBQLklWQSAwMjY2MzQyMDI4NQpDYXBpdGFsZSBTb2NpYWxlIOKCrCAyNi4wMDAg
aS52LgpJc2NyaXR0YSBhbCBSZWcuIEltcHJlc2UgZGkgUGFkb3ZhIE4uIDAyNjYzNDIwMjg1Ck51
bWVybyBSLkUuQS4gMjU4NjQyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
