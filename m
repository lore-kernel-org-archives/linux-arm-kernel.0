Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FCFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:53:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DCA205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fjXKPPEW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpFJBDE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DCA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2ZMvRaPwHWkbhWRelrsvG2YB4b053pqXmBIL/gLinIc=; b=fjXKPPEWDENg5J
	i+ombnnwk2abfYA0KVIg5wDpYyF6kkmZtWOO3ZHqO9QbxKc0xf+8jbFH8U4mZoUxFq7Lc8Rz+xk4C
	PUXYjyFCugf6TgFZLN1A593hOYEymFKTv2vRYKjZC1yduF5B2bUMIt5OMd67+EkmrUmjVFeqdPb/B
	6qlEl63oE+ZCykDolr0SYeN6mq6GlLY2W82t4QcuEBYST4aa6JTpKW3dRSy7DbEpbD7B/rgbPpi0/
	xpOLQO/hfl268cPVW/dOfx7evsxHx0MzMobCtve2oOx7KoHYCt8KcMMtEprI/pOlNvREor03WOcE3
	6sTlnYy+fZxu1o8RnpKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gizs1-00086A-5S; Mon, 14 Jan 2019 10:53:29 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gizry-00085j-8i
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 10:53:27 +0000
Received: by mail-it1-x141.google.com with SMTP id i145so12350550ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 02:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PuyA1u1/e7dZRU052cjFTRNGgKhojhL2AZTNPERZL5I=;
 b=fpFJBDE39PjXMWkep9AhPsABN0vTdzodyp1zEVZhf+jCAKAzp26ZobH+/R+IOtepgX
 lxqwxo3ZPSsY+SpWbNo6oj2c2+vRdH/Q/b3CFYL2TQQgpcwe17s/OxtTANO53DEa0Nb9
 CU64Dm+dadpc1smGvaiLTB0jXv3R4DeuVdy4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PuyA1u1/e7dZRU052cjFTRNGgKhojhL2AZTNPERZL5I=;
 b=RRj8n4+8A0sQ2cySoKI20/92ChD2Yh75IHoCfljWvQlFiDYuK0aNanbIkvnre/AOfv
 yde2VJuZhrjOmrtE6H3Xsn54dZuLi9/lvV78rRmjeHrRLV5zJia+yPuMEJFwL7K3W1pt
 DKP3AcNQ6/D9kqGz0Pt/UetJiW9Xa2f79iHgvKtPlKMAvhQEL7i2VDZ95pzQbxMt9WUN
 uVSMm7yExi2INia48PHdJ/S2meKQ+/WgMO9fCRN+W85OrKcre+4Yop6E9J8mtle/s3tU
 utZsOSgYWLyqW/6lr/CisZwLYsxItd8cEMVBm9yj2c2R93UEJIzjA5JXNhBVX+bPIBxk
 P+Tw==
X-Gm-Message-State: AJcUukfCNsxNxrqb67KRRxxurYGQjHvL0D2glxLGeJTMGwFHcH98UT/0
 usIr3GL5QB7zpALDt66KkG2FJgSv2qROggo9uqDeFg==
X-Google-Smtp-Source: ALg8bN4raaoENgV3w+bjfpA789pOoeoWVVjhiC2FaGQOzen/K53GNT7+rZ8m4kif+5VR/OzymM0mFWmZ9E7bNlHlyW0=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr16806810jab.2.1547463204348;
 Mon, 14 Jan 2019 02:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
In-Reply-To: <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 14 Jan 2019 11:53:13 +0100
Message-ID: <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_025326_316049_6B097CE1 
X-CRM114-Status: GOOD (  25.79  )
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
Cc: Carsten Haitzler <Carsten.Haitzler@arm.com>,
 David Airlie <airlied@linux.ie>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>,
 Junwei Zhang <Jerry.Zhang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <Bernhard.Rosenkranzer@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAxMCBKYW4gMjAxOSBhdCAxMDozNCwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVu
emVyLm5ldD4gd3JvdGU6Cj4KPiBPbiAyMDE5LTAxLTEwIDg6MjggYS5tLiwgQXJkIEJpZXNoZXV2
ZWwgd3JvdGU6Cj4gPiBBUk0gc3lzdGVtcyBkbyBub3QgcGVybWl0IHRoZSB1c2Ugb2YgYW55dGhp
bmcgb3RoZXIgdGhhbiBjYWNoZWQKPiA+IG1hcHBpbmdzIGZvciBzeXN0ZW0gbWVtb3J5LCBzaW5j
ZSB0aGF0IG1lbW9yeSBtYXkgYmUgbWFwcGVkIGluIHRoZQo+ID4gbGluZWFyIHJlZ2lvbiBhcyB3
ZWxsLCBhbmQgdGhlIGFyY2hpdGVjdHVyZSBkb2VzIG5vdCBwZXJtaXQgYWxpYXNlcwo+ID4gd2l0
aCBtaXNtYXRjaGVkIGF0dHJpYnV0ZXMuCj4gPgo+ID4gU28gc2hvcnQtY2lyY3VpdCB0aGUgZXZh
bHVhdGlvbiBpbiB0dG1faW9fcHJvdCgpIGlmIHRoZSBmbGFncyBpbmNsdWRlCj4gPiBUVE1fUExf
U1lTVEVNIHdoZW4gcnVubmluZyBvbiBBUk0gb3IgYXJtNjQsIGFuZCBqdXN0IHJldHVybiBjYWNo
ZWQKPiA+IGF0dHJpYnV0ZXMgaW1tZWRpYXRlbHkuCj4gPgo+ID4gVGhpcyBmaXhlcyB0aGUgcmFk
ZW9uIGFuZCBhbWRncHUgW1RCQ10gZHJpdmVycyB3aGVuIHJ1bm5pbmcgb24gYXJtNjQuCj4gPiBX
aXRob3V0IHRoaXMgY2hhbmdlLCBhbWRncHUgZG9lcyBub3Qgc3RhcnQgYXQgYWxsLCBhbmQgcmFk
ZW9uIG9ubHkKPiA+IHByb2R1Y2VzIGNvcnJ1cHQgZGlzcGxheSBvdXRwdXQuCj4gPgo+ID4gQ2M6
IENocmlzdGlhbiBLb2VuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiA+IENjOiBIdWFu
ZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+ID4gQ2M6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhh
bmdAYW1kLmNvbT4KPiA+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gPiBS
ZXBvcnRlZC1ieTogQ2Fyc3RlbiBIYWl0emxlciA8Q2Fyc3Rlbi5IYWl0emxlckBhcm0uY29tPgo+
ID4gU2lnbmVkLW9mZi1ieTogQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5v
cmc+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib191dGlsLmMgfCA1ICsr
KysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib191dGlsLmMgYi9kcml2ZXJzL2dwdS9kcm0v
dHRtL3R0bV9ib191dGlsLmMKPiA+IGluZGV4IDA0NmE2ZGRhNjkwYS4uMGMxZWVmNWY3YWUzIDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRpbC5jCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib191dGlsLmMKPiA+IEBAIC01MzAsNiArNTMwLDEx
IEBAIHBncHJvdF90IHR0bV9pb19wcm90KHVpbnQzMl90IGNhY2hpbmdfZmxhZ3MsIHBncHJvdF90
IHRtcCkKPiA+ICAgICAgIGlmIChjYWNoaW5nX2ZsYWdzICYgVFRNX1BMX0ZMQUdfQ0FDSEVEKQo+
ID4gICAgICAgICAgICAgICByZXR1cm4gdG1wOwo+ID4KPiA+ICsjaWYgZGVmaW5lZChfX2FybV9f
KSB8fCBkZWZpbmVkKF9fYWFyY2g2NF9fKQo+ID4gKyAgICAgLyogQVJNIG9ubHkgcGVybWl0cyBj
YWNoZWQgbWFwcGluZ3Mgb2Ygc3lzdGVtIG1lbW9yeSAqLwo+ID4gKyAgICAgaWYgKGNhY2hpbmdf
ZmxhZ3MgJiBUVE1fUExfU1lTVEVNKQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gdG1wOwo+ID4g
KyNlbmRpZgo+ID4gICNpZiBkZWZpbmVkKF9faTM4Nl9fKSB8fCBkZWZpbmVkKF9feDg2XzY0X18p
Cj4gPiAgICAgICBpZiAoY2FjaGluZ19mbGFncyAmIFRUTV9QTF9GTEFHX1dDKQo+ID4gICAgICAg
ICAgICAgICB0bXAgPSBwZ3Byb3Rfd3JpdGVjb21iaW5lKHRtcCk7Cj4gPgo+Cj4gQXBhcnQgZnJv
bSBDaHJpc3RpYW4ncyBjb25jZXJucywgSSB0aGluayB0aGlzIGlzIHRoZSB3cm9uZyBwbGFjZSBm
b3IKPiB0aGlzLCBiZWNhdXNlIG90aGVyIFRUTSAvIGRyaXZlciBjb2RlIHdpbGwgc3RpbGwgY29u
c2lkZXIgdGhlIG1lbW9yeQo+IHVuY2FjaGVhYmxlLiBFLmcuIHRoZSBhbWRncHUgZHJpdmVyIHdp
bGwgcHJvZ3JhbSB0aGUgR1BVIHRvIHRyZWF0IHRoZQo+IG1lbW9yeSBhcyB1bmNhY2hlYWJsZSwg
c28gaXQgd29uJ3QgcGFydGljaXBhdGUgaW4gY2FjaGUgY29oZXJlbmN5Cj4gcHJvdG9jb2wgZm9y
IGl0LCB3aGljaCBpcyB1bmxpa2VseSB0byB3b3JrIGFzIGV4cGVjdGVkIGluIGdlbmVyYWwgaWYg
dGhlCj4gQ1BVIHRyZWF0cyB0aGUgbWVtb3J5IGFzIGNhY2hlYWJsZS4KPgoKV2lsbCBhbmQgSSBo
YXZlIHNwZW50IHNvbWUgdGltZSBkaWdnaW5nIGludG8gdGhpcywgc28gYWxsb3cgbWUgdG8Kc2hh
cmUgc29tZSBwcmVsaW1pbmFyeSBmaW5kaW5ncyB3aGlsZSB3ZSBjYXJyeSBvbiBhbmQgdHJ5IHRv
IGZpeCB0aGlzCnByb3Blcmx5LgoKLSBUaGUgcGF0Y2ggYWJvdmUgaXMgZmxhd2VkLCBpLmUuLCBp
dCBkb2Vzbid0IGRvIHdoYXQgaXQgaW50ZW5kcyB0bwpzaW5jZSBpdCB1c2VzIFRUTV9QTF9TWVNU
RU0gaW5zdGVhZCBvZiBUVE1fUExfRkxBR19TWVNURU0uIEFwb2xvZ2llcwpmb3IgdGhhdC4KLSBU
aGUgZXhpc3RlbmNlIG9mIGEgbGluZWFyIHJlZ2lvbiBtYXBwaW5nIHdpdGggbWlzbWF0Y2hlZCBh
dHRyaWJ1dGVzCmlzIGxpa2VseSBub3QgdGhlIGN1bHByaXQgaGVyZS4gKFdlIGRvIHNvbWV0aGlu
ZyBzaW1pbGFyIHdpdGgKbm9uLWNhY2hlIGNvaGVyZW50IERNQSBpbiBvdGhlciBwbGFjZXMpLgot
IFRoZSByZWFzb24gcmVtYXBwaW5nIHRoZSBDUFUgc2lkZSBhcyBjYWNoZWFibGUgZG9lcyB3b3Jr
ICh3aGljaCBJCmRpZCB0ZXN0KSBpcyBiZWNhdXNlIHRoZSBHUFUncyB1bmNhY2hlYWJsZSBhY2Nl
c3NlcyAod2hpY2ggSSBhc3N1bWUKYXJlIG1hZGUgdXNpbmcgdGhlIE5vU25vb3AgUENJZSB0cmFu
c2FjdGlvbiBhdHRyaWJ1dGUpIGFyZSBhY3R1YWxseQplbWl0dGVkIGFzIGNhY2hlYWJsZSBpbiBz
b21lIGNhc2VzLgogIC4gT24gbXkgQU1EIFNlYXR0bGUsIHdpdGggb3Igd2l0aG91dCBTTU1VICh3
aGljaCBpcyBzdGFnZSAyIG9ubHkpLCBJCm11c3QgdXNlIGNhY2hlYWJsZSBhY2Nlc3NlcyBmcm9t
IHRoZSBDUFUgc2lkZSBvciB0aGluZ3MgYXJlIGJyb2tlbi4KVGhpcyBtaWdodCBiZSBhIGgvdyBm
bGF3LCB0aG91Z2guCiAgLiBPbiBzeXN0ZW1zIHdpdGggc3RhZ2UgMSsyIFNNTVVzLCB0aGUgZHJp
dmVyIHVzZXMgc3RhZ2UgMQp0cmFuc2xhdGlvbnMgd2hpY2ggYWx3YXlzIG92ZXJyaWRlIHRoZSBt
ZW1vcnkgYXR0cmlidXRlcyB0byBjYWNoZWFibGUKZm9yIERNQSBjb2hlcmVudCBkZXZpY2VzLiBU
aGlzIGlzIHdoYXQgaXMgYWZmZWN0aW5nIHRoZSBDYXZpdW0KVGh1bmRlclgyIChhbHRob3VnaCBp
dCBhcHBlYXJzIHRoZSBhdHRyaWJ1dGVzIGVtaXR0ZWQgYnkgdGhlIFJDIG1heSBiZQppbmNvcnJl
Y3QgYXMgd2VsbC4pCgpUaGUgbGF0dGVyIGlzc3VlIGlzIGEgc2hvcnRjb21pbmcgaW4gdGhlIFNN
TVUgZHJpdmVyIHRoYXQgd2UgaGF2ZSB0bwpmaXgsIGkuZS4sIGl0IHNob3VsZCB0YWtlIGNhcmUg
bm90IHRvIG1vZGlmeSB0aGUgaW5jb21pbmcgYXR0cmlidXRlcwpvZiBETUEgY29oZXJlbnQgUENJ
ZSBkZXZpY2VzIGZvciBOb1Nub29wIHRvIGJlIGFibGUgdG8gd29yay4KClNvIGluIHN1bW1hcnks
IHRoZSBtaXNtYXRjaCBhcHBlYXJzIHRvIGJlIGJldHdlZW4gdGhlIENQVSBhY2Nlc3NpbmcKdGhl
IHZtYXAgcmVnaW9uIHdpdGggbm9uLWNhY2hlYWJsZSBhdHRyaWJ1dGVzIGFuZCB0aGUgR1BVIGFj
Y2Vzc2luZwp0aGUgc2FtZSBtZW1vcnkgd2l0aCBjYWNoZWFibGUgYXR0cmlidXRlcywgcmVzdWx0
aW5nIGluIGEgbG9zcyBvZgpjb2hlcmVuY3kgYW5kIGxvdHMgb2YgdmlzaWJsZSBjb3JydXB0aW9u
LgoKVG8gYmUgYWJsZSB0byBkZWJ1ZyB0aGlzIGZ1cnRoZXIsIGNvdWxkIHlvdSBlbGFib3JhdGUg
YSBiaXQgb24KLSBIb3cgZG9lcyB0aGUgaGFyZHdhcmUgZW1pdCB0aG9zZSB1bmNhY2hlZC93YyBp
bmJvdW5kIGFjY2Vzc2VzPyBEbwp0aGV5IHJlbHkgb24gTm9Tbm9vcD8KLSBDaHJpc3RpYW4gcG9p
bnRlZCBvdXQgdGhhdCBzb21lIGFjY2Vzc2VzIG11c3QgYmUgdW5jYWNoZWQgZXZlbiB3aGVuCm5v
dCB1c2luZyBXQy4gV2hhdCBraW5kIG9mIGFjY2Vzc2VzIGFyZSB0aG9zZT8gQW5kIGRvIHRoZXkg
YWNjZXNzCnN5c3RlbSBSQU0/CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
