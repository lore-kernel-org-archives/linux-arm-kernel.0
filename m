Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00BCC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:37:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F53218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HPTcWdVv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGemaN4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F53218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=69pVrWeOAsF5Ff4hgVFDgku2POD+xxnh/AG7J47X924=; b=HPTcWdVvumyjde
	dC4W8ZIOCx/qRepwWE7s4zCwKanLqSphMImml9xXzXfyjX5h+jn4tAHcMzgNuQm2iuPfarOcIJYCp
	jGGLCAZUD516lrA7d4tDE+vOTXrLXCmqaGNCzjEPvXWjyV4MjkI79vTBgzY4q5DKcjKM/9Gpr0TY5
	LrpYh2Fx5V0OaVKh5M44x1ZB/cLv/fxqTH7ToWrZbkCu1BJ43VDzgm1LNrbHOT3H0gYRggqd0MIkp
	EzwqaskzA6is7PnhCumrWKLF7IgQMk0NOOFtk3sQ1Of4c2U4kv9915tztBXq13g/9n4SaPr0GoOk3
	O+rcqyKAG7AiQ8fyG71A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbRy-0001g1-VF; Thu, 24 Jan 2019 09:37:30 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbRw-0001fd-DS
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:37:30 +0000
Received: by mail-it1-x142.google.com with SMTP id m8so2073573itk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 01:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=19Ghs0w/nhlo4uQ8eD+zwEIEKJRefRDb4wX388+r+8k=;
 b=XGemaN4QR7SjKl697wLRKBep/wFxn817peN9hS+Mcc6b8n7AV+0PFgGHxPE/RUAxqm
 JG3uEo872Puw9oxIDWLryDmo/TERQThN8+wTMqLeAfV35nl71WaubbxQ/Nm+OOM9Z8UT
 VTdzQ/o5rBGu7pVDQhCoUR2Lammzr2M1unJrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=19Ghs0w/nhlo4uQ8eD+zwEIEKJRefRDb4wX388+r+8k=;
 b=BYRWGK4DWnzlQedsqVM+GKjAkEoriByD90yGciB3JZN4scpA6xKftW1JJwgTa/CkT8
 45fhAC8QuOCYn46/GB49Jc21c7tbWwKWiU2D32VdaeMp9ngQB2BpOSIlUo01JynJsI1f
 UHyOJ7BaM8Pdk1kKjQi59MZM+JPPJRxgADUbY9H4PqfkOaKlw3AkJzhs0Uo79oCbHc2z
 q3AnO4P8ERLpspjSc/fdZSkwlytn5GtOdXnkE+Q6hZVCLvpIPv8BrTzlqGMRQhdOBJe6
 K2hp8j9As+MqrV0nXyiBe1fGSGQTZGver4EEAw/5SQTRztlL7R8ThvyYI+VGrZLsbRsp
 S9EA==
X-Gm-Message-State: AJcUukeoAZrUwN9HKwHZenws4PefWwmiITK622DH2mH1AXWkyq/84FP5
 e/J/SJs7AcsI5EsAGQMWU6iCkQdgR49iuBMeWkONDQ==
X-Google-Smtp-Source: ALg8bN4ne/hR+SuW9iYCOPhafqRBnpHtutg5GMpH6iXvnvxu03ZZFm+w6EPHsZKic/F0XM3mbeVJt6EW3o9tdYM35AM=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr3714050jab.2.1548322645960;
 Thu, 24 Jan 2019 01:37:25 -0800 (PST)
MIME-Version: 1.0
References: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <ee261b46-1a83-6af2-31fe-fb9f30894c1e@daenzer.net>
In-Reply-To: <ee261b46-1a83-6af2-31fe-fb9f30894c1e@daenzer.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Jan 2019 10:37:14 +0100
Message-ID: <CAKv+Gu-6=kUd_OYoe4TpFSUXHqC4etxH98mAN_gkHKvS1=1BGA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_013728_459090_CF6C8F90 
X-CRM114-Status: GOOD (  19.38  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>,
 Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 Junwei Zhang <Jerry.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAyNCBKYW4gMjAxOSBhdCAxMDozMSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVu
emVyLm5ldD4gd3JvdGU6Cj4KPiBPbiAyMDE5LTAxLTIzIDU6NTIgcC5tLiwgQXJkIEJpZXNoZXV2
ZWwgd3JvdGU6Cj4gPiBPbiBXZWQsIDIzIEphbiAyMDE5IGF0IDE3OjQ0LCBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+ID4+Cj4gPj4gSSB0aGluayB3ZSBqdXN0
IHdhbnQgYSBkcml2ZXItbG9jYWwgY2hlY2sgZm9yIHRob3NlIGNvbWJpbmF0aW9ucwo+ID4+IHdo
ZXJlIHdlIGtub3cgdGhpcyBoYWNrIGFjdHVhbGx5IHdvcmtzLCB3aGljaCByZWFsbHkganVzdCBz
ZWVtcwo+ID4+IHRvIGJlIHg4Ni02NCB3aXRoIFBBVC4gU29tZXRoaW5nIGxpa2UgdGhlIHBhdGNo
IGJlbG93LCBidXQgbWF5YmUgd2l0aAo+ID4+IGV2ZW4gbW9yZSBzdHJvbmcgd2FybmluZ3MgdG8g
bm90IGRvIHNvbWV0aGluZyBsaWtlIHRoaXMgZWxzZXdoZXJlOgo+ID4KPiA+IEkgYWdyZWUgdGhh
dCB5b3VyIHBhdGNoIHNlZW1zIGxpa2UgdGhlIHJpZ2h0IHdheSB0byBlbnN1cmUgdGhhdCB0aGUg
V0MKPiA+IG9wdGltaXphdGlvbiBoYWNrIGlzIG9ubHkgdXNlZCB3aGVyZSB3ZSBrbm93IGl0IHdv
cmtzLgo+ID4KPiA+IEJ1dCBteSBjb25jZXJuIGlzIHRoYXQgaXQgc2VlbXMgbGlrZWx5IHRoYXQg
bm9uLWNhY2hlIGNvaGVyZW50Cj4gPiBpbXBsZW1lbnRhdGlvbnMgYXJlIHJlbHlpbmcgb24gdGhp
cyBoYWNrIGFzIHdlbGwuCj4KPiBJJ3ZlIGJlZW4gdHJ5aW5nIHRvIHRlbGwgeW91IHRoZXkgY2Fu
J3QgcmVseSBvbiB0aGF0LCBiZWNhdXNlIHRoZSBhbWRncHUKPiBkcml2ZXIgZG9lc24ndCB1c2Ug
dGhpcyBmdW5jdGlvbmFsaXR5IGZvciBmdW5kYW1lbnRhbHMgc3VjaCBhcyByaW5nCj4gYnVmZmVy
cyB1c2VkIGZvciBmZWVkaW5nIHRoZSBoYXJkd2FyZSB3aXRoIGNvbW1hbmRzLiBJbnN0ZWFkLCBm
b3IgdGhvc2UKPiBpdCByZWxpZXMgb24gc25vb3BlZCBQQ0llIHRyYW5zZmVycyBiZWluZyBjb2hl
cmVudCB3aXRoIHRoZSBDUFUgY2FjaGVzLgo+CgpJIHVuZGVyc3RhbmQgaXQgZG9lcyBub3QgdXNl
IHRoaXMgZnVuY3Rpb25hbGl0eSBmb3IgdGhlIHJpbmcuIEluc3RlYWQsCml0IHVzZXMgdGhlIERN
QSBBUEksIG5vPwoKT24gbm9uLWNhY2hlIGNvaGVyZW50IHN5c3RlbXMsIHRoYXQgRE1BIEFQSSB3
aWxsIGFsbG9jYXRlIG1lbW9yeSBhbmQKbWFwIGl0IHVuY2FjaGVkIGZvciB0aGUgQ1BVIHNvIHRo
YXQgaXQgaXMgY29oZXJlbnQgd2l0aCB0aGUgbm9uLWNhY2hlCmNvaGVyZW50IGRldmljZS4KCklu
IGFueSBjYXNlLCBpZiBub24tY2FjaGUgY29oZXJlbnQgc3lzdGVtcyBhcmUgdW5saWtlbHkgdG8g
d29yaywgYW5kCnVuc3VwcG9ydGVkIGluIGNhc2UgdGhleSBkbywgSSBhbSBmaW5lIHdpdGggZGlz
YWJsaW5nIHRoaXMKb3B0aW1pemF0aW9uIHVuY29uZGl0aW9uYWxseSBmb3Igbm9uLVg4NiBhcmNo
aXRlY3R1cmVzLgoKPgo+ID4+IC0jZWxpZiBkZWZpbmVkKENPTkZJR19YODYpICYmICFkZWZpbmVk
KENPTkZJR19YODZfUEFUKQo+ID4+IC0gICAgICAgLyogRG9uJ3QgdHJ5IHRvIGVuYWJsZSB3cml0
ZS1jb21iaW5pbmcgd2hlbiBpdCBjYW4ndCB3b3JrLCBvciB0aGluZ3MKPiA+PiAtICAgICAgICAq
IG1heSBiZSBzbG93Cj4gPj4gLSAgICAgICAgKiBTZWUgaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9w
Lm9yZy9zaG93X2J1Zy5jZ2k/aWQ9ODg3NTgKPiA+PiAtICAgICAgICAqLwo+ID4+IC0KPiA+PiAt
I2lmbmRlZiBDT05GSUdfQ09NUElMRV9URVNUCj4gPj4gLSN3YXJuaW5nIFBsZWFzZSBlbmFibGUg
Q09ORklHX01UUlIgYW5kIENPTkZJR19YODZfUEFUIGZvciBiZXR0ZXIgcGVyZm9ybWFuY2UgXAo+
ID4+IC0gICAgICAgIHRoYW5rcyB0byB3cml0ZS1jb21iaW5pbmcKPiA+PiAtI2VuZGlmCj4gPj4g
LQo+ID4+IC0gICAgICAgaWYgKGJvLT5mbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRf
VVNXQykKPiA+PiAtICAgICAgICAgICAgICAgRFJNX0lORk9fT05DRSgiUGxlYXNlIGVuYWJsZSBD
T05GSUdfTVRSUiBhbmQgQ09ORklHX1g4Nl9QQVQgZm9yICIKPiA+PiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiYmV0dGVyIHBlcmZvcm1hbmNlIHRoYW5rcyB0byB3cml0ZS1jb21iaW5p
bmdcbiIpOwo+Cj4gRldJVywgcGxlYXNlIGRvbid0IGRyb3AgdGhlc2UgY29tcGlsZSBhbmQgYnVp
bGQgdGltZSB3YXJuaW5ncyB3aGVyZSB3ZQo+IGNvbnRpbnVlIHRvIHRha2UgYWR2YW50YWdlIG9m
IFBBVC4KPgo+Cj4gLS0KPiBFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8
ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCj4gTGlicmUgc29mdHdhcmUgZW50aHVz
aWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
