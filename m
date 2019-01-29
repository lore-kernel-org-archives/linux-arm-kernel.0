Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C4AC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:39:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D552082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mediO9qZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ffxiBSYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D552082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HQcOf5iq1DMqWu71uXrktLfEzXgwXviNVE6uw59ywmU=; b=mediO9qZ46Ky2V
	kOYQUKbHefmcbaquJMf3wjYb0JbNKX/t4WHWDfY9FsasJ6bS8RLYvLKQkKZ2SjCTdgchTwKnMJOYm
	7sPt/ZATE1Qs5W7yrK/XdUs67rcXhl0j5d/VMosKeeKdggP77lYIf6y0l8HHvlwVyViuBvRwe1IJY
	WBWkxh5WKqgKkQdToXfvcej23A4diSWimCiaxvoK0wj6WrFmNu380iJRA0h0GnQAuRDof5toS/2/X
	aKEWw/+wtbEx2FDJ33HodUHYTi/kvFWA3112l+QAPCCusZNeAHGhjYPVx5OoUSL0+BnVAWIXdIrT5
	xVpZE5GLuirNPSNUHPQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPrh-0005do-1g; Tue, 29 Jan 2019 09:39:33 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPrT-0005ZA-4x
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:39:26 +0000
Received: by mail-ot1-x344.google.com with SMTP id s5so17307010oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 01:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Nm1T119/ObMPWzlbIjDOJhaxurTOMjpaUAb/kBTk4so=;
 b=ffxiBSYwq/uNpoCkbvO9KLc1zr4H28VXciGMmTIaTzIhmwEObRT4vl2TPKOpBTLWlS
 234Nh/yOKNs+T510GOhT1amqWCH0mO2mMp8v12ILQqKnc5mA0ts+vOPPI6/1t8JgtVJC
 Jk8H9gh4jF//cLmvDPSkwjAQk0kFl0X6xppLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Nm1T119/ObMPWzlbIjDOJhaxurTOMjpaUAb/kBTk4so=;
 b=PrAotMkx0ijrvzwuNa+L6pv1w26X67fBS6+mhql4xIgiL7mFO+4kFINtmjVpE4n3K+
 P5udHsrlgLiQ5xjE18mlb1oqp2TkMkcbo0MGeTDmMfZklsKbd7zHF7f7RDvfGoB2htxE
 kh9Md/b3V14Jh8VkyWmvMVb6WhTQuFP8Jnpah1hoZQhS2Xgtz79LkZn43Pl2fHKcV5Jw
 Yw/aXXGPbyLhfUPR7I9d8cJYoC0/qCwsmDejtFcoVqXeBx0u5XgEFSX+IM2Uy513ENCA
 6f1lZZ/ubgDEISD2RlfkzVZX+TPobAR3/em7DrDDrjx9TI54UeTsJ6U4Pj6SCcrnxZHG
 A+jg==
X-Gm-Message-State: AJcUukf6WhtvHIDaohuXmZJcSMJ/oc1jUv9Qbxn9UMO/JIEV/Sj9QQZR
 RIPmVqaBcwesXbrWcl2LcJUJPjyseJY=
X-Google-Smtp-Source: ALg8bN61plCBXrnmku7jvYYYiJEtEzIQTfKjTqosE7MCybBqtTNXZFmBE/Gu6H1Q0d+QF4j3DgonlQ==
X-Received: by 2002:a9d:46b:: with SMTP id 98mr19475109otc.339.1548754757823; 
 Tue, 29 Jan 2019 01:39:17 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com.
 [209.85.167.176])
 by smtp.gmail.com with ESMTPSA id v3sm8449703oib.57.2019.01.29.01.39.15
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 01:39:15 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id c206so15658153oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 01:39:15 -0800 (PST)
X-Received: by 2002:aca:ea57:: with SMTP id i84mr8842617oih.346.1548754754671; 
 Tue, 29 Jan 2019 01:39:14 -0800 (PST)
MIME-Version: 1.0
References: <776e63c9-d4a5-342a-e0f7-200ef144ffc4@rock-chips.com>
 <64c793e08d61181b78125b3956ec38623fa5d261.camel@bootlin.com>
 <D8005130-F7FD-4CBD-8396-1BB08BB08E81@soulik.info>
 <f982ef378a8ade075bc7077b93640e20ecebf9f4.camel@bootlin.com>
 <82FA0C3F-BC54-4D89-AECB-90D81B89B1CE@soulik.info>
 <c3619a00-17e7-fb92-a427-a7478b96f356@soulik.info>
 <bdf14f97e98f2fd06307545ab9038ac3c2086ae7.camel@bootlin.com>
 <42520087-4EAE-4F7F-BCA0-42E422170E91@soulik.info>
 <ab8ca098ad60f209fe97f79bb93b2d1e898da524.camel@bootlin.com>
 <CAPBb6MUJu3cX9A-E32bSSjxc1cvGP83ayzZzUxa5_QMf6niK4g@mail.gmail.com>
 <20190129080944.pfhumtugsm7mzzcc@flea>
In-Reply-To: <20190129080944.pfhumtugsm7mzzcc@flea>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 29 Jan 2019 18:39:03 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A=wT4RcVWmKR2vLA7e5P_mX5vDnOiaHSoA3odEqWvbDg@mail.gmail.com>
Message-ID: <CAAFQd5A=wT4RcVWmKR2vLA7e5P_mX5vDnOiaHSoA3odEqWvbDg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 1/2] media: v4l: Add definitions for the
 HEVC slice format and controls
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_013919_369431_4B4F9E78 
X-CRM114-Status: GOOD (  32.42  )
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
Cc: devel@driverdev.osuosl.org, Hans Verkuil <hverkuil@xs4all.nl>,
 Alexandre Courbot <acourbot@chromium.org>, Ayaka <ayaka@soulik.info>,
 Randy Li <randy.li@rock-chips.com>, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKYW4gMjksIDIwMTkgYXQgNTowOSBQTSBNYXhpbWUgUmlwYXJkIDxtYXhpbWUucmlw
YXJkQGJvb3RsaW4uY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgSmFuIDI5LCAyMDE5IGF0IDA0OjQ0
OjM1UE0gKzA5MDAsIEFsZXhhbmRyZSBDb3VyYm90IHdyb3RlOgo+ID4gT24gRnJpLCBKYW4gMjUs
IDIwMTkgYXQgMTA6MDQgUE0gUGF1bCBLb2NpYWxrb3dza2kKPiA+ID4gT24gVGh1LCAyMDE5LTAx
LTI0IGF0IDIwOjIzICswODAwLCBBeWFrYSB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IFNlbnQgZnJv
bSBteSBpUGFkCj4gPiA+ID4KPiA+ID4gPiA+IE9uIEphbiAyNCwgMjAxOSwgYXQgNjoyNyBQTSwg
UGF1bCBLb2NpYWxrb3dza2kgPHBhdWwua29jaWFsa293c2tpQGJvb3RsaW4uY29tPiB3cm90ZToK
PiA+ID4gPiA+Cj4gPiA+ID4gPiBIaSwKPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIFRodSwgMjAx
OS0wMS0xMCBhdCAyMTozMiArMDgwMCwgYXlha2Egd3JvdGU6Cj4gPiA+ID4gPiA+IEkgZm9yZ2V0
IGEgaW1wb3J0YW50IHRoaW5nLCBmb3IgdGhlIHJrdmRlYyBhbmQgcmsgaGV2YyBkZWNvZGVyLCBp
dCB3b3VsZAo+ID4gPiA+ID4gPiByZXF1ZXN0cyBjYWJhYyB0YWJsZSwgc2NhbGluZyBsaXN0LCBw
aWN0dXJlIHBhcmFtZXRlciBzZXQgYW5kIHJlZmVyZW5jZQo+ID4gPiA+ID4gPiBwaWN0dXJlIHN0
b3JpbmcgaW4gb25lIG9yIHZhcmlvdXMgb2YgRE1BIGJ1ZmZlcnMuIEkgYW0gbm90IHRhbGtpbmcg
YWJvdXQKPiA+ID4gPiA+ID4gdGhlIGRhdGEgYmVlbiBwYXJzZWQsIHRoZSBkZWNvZGVyIHdvdWxk
IHJlcXVlc3RzIGEgcmF3IGRhdGEuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEZvciB0aGUgcHBz
IGFuZCBycHMsIGl0IGlzIHBvc3NpYmxlIHRvIHJldXNlIHRoZSBzbGljZSBoZWFkZXIsIGp1c3Qg
bGV0Cj4gPiA+ID4gPiA+IHRoZSBkZWNvZGVyIGtub3cgdGhlIG9mZnNldCBmcm9tIHRoZSBiaXRz
dHJlYW0gYnVmZXIsIEkgd291bGQgc3VnZ2VzdCB0bwo+ID4gPiA+ID4gPiBhZGQgdGhyZWUgcHJv
cGVydGllcyh3aXRoIHNwcykgZm9yIHRoZW0uIEJ1dCBJIHRoaW5rIHdlIG5lZWQgYSBtZXRob2Qg
dG8KPiA+ID4gPiA+ID4gbWFyayBhIE9VVFBVVCBzaWRlIGJ1ZmZlciBmb3IgdGhvc2UgYXV4IGRh
dGEuCj4gPiA+ID4gPgo+ID4gPiA+ID4gSSdtIHF1aXRlIGNvbmZ1c2VkIGFib3V0IHRoZSBoYXJk
d2FyZSBpbXBsZW1lbnRhdGlvbiB0aGVuLiBGcm9tIHdoYXQKPiA+ID4gPiA+IHlvdSdyZSBzYXlp
bmcsIGl0IHNlZW1zIHRoYXQgaXQgdGFrZXMgdGhlIHJhdyBiaXRzdHJlYW0gZWxlbWVudHMgcmF0
aGVyCj4gPiA+ID4gPiB0aGFuIHBhcnNlZCBlbGVtZW50cy4gSXMgaXQgcmVhbGx5IGEgc3RhdGVs
ZXNzIGltcGxlbWVudGF0aW9uPwo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoZSBzdGF0ZWxlc3MgaW1w
bGVtZW50YXRpb24gd2FzIGRlc2lnbmVkIHdpdGggdGhlIGlkZWEgdGhhdCBvbmx5IHRoZQo+ID4g
PiA+ID4gcmF3IHNsaWNlIGRhdGEgc2hvdWxkIGJlIHBhc3NlZCBpbiBiaXRzdHJlYW0gZm9ybSB0
byB0aGUgZGVjb2Rlci4gRm9yCj4gPiA+ID4gPiBILjI2NCwgaXQgc2VlbXMgdGhhdCBzb21lIGRl
Y29kZXJzIGFsc28gbmVlZCB0aGUgc2xpY2UgaGVhZGVyIGluIHJhdwo+ID4gPiA+ID4gYml0c3Ry
ZWFtIGZvcm0gKGJlY2F1c2UgdGhleSB0YWtlIHRoZSBmdWxsIHNsaWNlIE5BTCB1bml0KSwgc2Vl
IHRoZQo+ID4gPiA+ID4gZGlzY3Vzc2lvbnMgaW4gdGhpcyB0aHJlYWQ6Cj4gPiA+ID4gPiBtZWRp
YTogZG9jcy1yc3Q6IERvY3VtZW50IG0ybSBzdGF0ZWxlc3MgdmlkZW8gZGVjb2RlciBpbnRlcmZh
Y2UKPiA+ID4gPgo+ID4gPiA+IFN0YXRlbGVzcyBqdXN0IG1lYW4gaXQgd29u4oCZdCB0cmFjayB0
aGUgcHJldmlvdXMgcmVzdWx0LCBidXQgSSBkb27igJl0Cj4gPiA+ID4gdGhpbmsgeW91IGNhbiBk
ZWZpbmUgd2hhdCBhIGRhdGUgdGhlIGhhcmR3YXJlIHdvdWxkIG5lZWQuIEV2ZW4geW91Cj4gPiA+
ID4ganVzdCBidWlsZCBhIGRwYiBmb3IgdGhlIGRlY29kZXIsIGl0IGlzIHN0aWxsIHN0YXRlbGVz
cywgYnV0IHBhcnNpbmcKPiA+ID4gPiBsZXNzIG9yIG1vcmUgZGF0YSBmcm9tIHRoZSBiaXRzdHJl
YW0gZG9lc27igJl0IHN0b3AgYSBkZWNvZGVyIGJlY29tZSBhCj4gPiA+ID4gc3RhdGVsZXNzIGRl
Y29kZXIuCj4gPiA+Cj4gPiA+IFllcyBmYWlyIGVub3VnaCwgdGhlIGZvcm1hdCBpbiB3aGljaCB0
aGUgaGFyZHdhcmUgZGVjb2RlciB0YWtlcyB0aGUKPiA+ID4gYml0c3RyZWFtIHBhcmFtZXRlcnMg
ZG9lcyBub3QgbWFrZSBpdCBzdGF0ZWxlc3Mgb3Igc3RhdGVmdWwgcGVyLXNlLgo+ID4gPiBJdCdz
IGp1c3QgdGhhdCBzdGF0ZWxlc3MgZGVjb2RlcnMgc2hvdWxkIGhhdmUgbm8gcGFydGljdWxhciBy
ZWFzb24gZm9yCj4gPiA+IHBhcnNpbmcgdGhlIGJpdHN0cmVhbSBvbiB0aGVpciBvd24gc2luY2Ug
dGhlIGhhcmR3YXJlIGNhbiBiZSBkZXNpZ25lZAo+ID4gPiB3aXRoIHJlZ2lzdGVycyBmb3IgZWFj
aCByZWxldmFudCBiaXRzdHJlYW0gZWxlbWVudCB0byBjb25maWd1cmUgdGhlCj4gPiA+IGRlY29k
aW5nIHBpcGVsaW5lLiBUaGF0J3MgaG93IEdQVS1iYXNlZCBkZWNvZGVyIGltcGxlbWVudGF0aW9u
cyBhcmUKPiA+ID4gaW1wbGVtZW50ZWQgKFZBQVBJL1ZEUEFVL05WREVDLCBldGMpLgo+ID4gPgo+
ID4gPiBTbyB0aGUgZm9ybWF0IHdlIGhhdmUgYWdyZWVkIG9uIHNvIGZhciBmb3IgdGhlIHN0YXRl
bGVzcyBpbnRlcmZhY2UgaXMKPiA+ID4gdG8gcGFzcyBwYXJzZWQgZWxlbWVudHMgdmlhIHY0bDIg
Y29udHJvbCBzdHJ1Y3R1cmVzLgo+ID4gPgo+ID4gPiBJZiB0aGUgaGFyZHdhcmUgY2FuIG9ubHkg
d29yayBieSBwYXJzaW5nIHRoZSBiaXRzdHJlYW0gaXRzZWxmLCBJJ20gbm90Cj4gPiA+IHN1cmUg
d2hhdCB0aGUgYmVzdCBzb2x1dGlvbiB3b3VsZCBiZS4gUmVjb25zdHJ1Y3RpbmcgdGhlIGJpdHN0
cmVhbSBpbgo+ID4gPiB0aGUga2VybmVsIGlzIGEgcHJldHR5IGJhZCBvcHRpb24sIGJ1dCBzbyBp
cyBwYXJzaW5nIGluIHRoZSBrZXJuZWwgb3IKPiA+ID4gaGF2aW5nIHRoZSBkYXRhIGJvdGggaW4g
cGFyc2VkIGFuZCByYXcgZm9ybXMuIERvIHlvdSBzZWUgYW5vdGhlcgo+ID4gPiBwb3NzaWJpbGl0
eT8KPiA+Cj4gPiBJcyByZWNvbnN0cnVjdGluZyB0aGUgYml0c3RyZWFtIHNvIGJhZD8gVGhlIHY0
bDIgY29udHJvbHMgcHJvdmlkZSBhCj4gPiBnZW5lcmljIGludGVyZmFjZSB0byBhbiBlbmNvZGVk
IGZvcm1hdCB3aGljaCB0aGUgZHJpdmVyIG5lZWRzIHRvCj4gPiBjb252ZXJ0IGludG8gYSBzZXF1
ZW5jZSB0aGF0IHRoZSBoYXJkd2FyZSBjYW4gdW5kZXJzdGFuZC4gVHlwaWNhbGx5Cj4gPiB0aGlz
IGlzIGRvbmUgYnkgcG9wdWxhdGluZyBoYXJkd2FyZS1zcGVjaWZpYyBzdHJ1Y3R1cmVzLiBDYW4n
dCB3ZQo+ID4gY29uc2lkZXIgdGhhdCBpbiB0aGlzIHNwZWNpZmljIGluc3RhbmNlLCB0aGUgaGFy
ZHdhcmUtc3BlY2lmaWMKPiA+IHN0cnVjdHVyZSBqdXN0IGhhcHBlbnMgdG8gYmUgaWRlbnRpY2Fs
IHRvIHRoZSBvcmlnaW5hbCBiaXRzdHJlYW0KPiA+IGZvcm1hdD8KPiA+Cj4gPiBJIGFncmVlIHRo
YXQgdGhpcyBpcyBub3Qgc3RyaWN0bHkgb3B0aW1hbCBmb3IgdGhhdCBwYXJ0aWN1bGFyCj4gPiBo
YXJkd2FyZSwgYnV0IHN1Y2ggaXMgdGhlIGNvc3Qgb2YgYWJzdHJhY3Rpb25zLCBhbmQgaW4gdGhp
cyBzcGVjaWZpYwo+ID4gY2FzZSBJIGRvbid0IGJlbGlldmUgdGhlIGNvc3Qgd291bGQgYmUgcGFy
dGljdWxhcmx5IGhpZ2g/Cj4KPiBJIG1lYW4sIHRoYXQgYXJndW1lbnQgY2FuIGJlIG1hZGUgZm9y
IHRoZSByb2NrY2hpcCBkcml2ZXIgYXMgd2VsbC4gSWYKPiByZWNvbnN0cnVjdGluZyB0aGUgYml0
c3RyZWFtIGlzIHNvbWV0aGluZyB3ZSBjYW4gZG8sIGFuZCBpZiB3ZSBkb24ndAo+IGNhcmUgYWJv
dXQgYmVpbmcgc3Vib3B0aW1hbCBmb3Igb25lIHBhcnRpY3VsYXIgaGFyZHdhcmUsIHRoZW4gd2h5
IHRoZQo+IHJvY2tjaGlwIGRyaXZlciBkb2Vzbid0IGp1c3QgcmVjcmVhdGUgdGhlIGJpdHN0cmVh
bSBmcm9tIHRoYXQgQVBJPwo+Cj4gQWZ0ZXIgYWxsLCB0aGlzIGlzIGp1c3QgYSBoYXJkd2FyZSBz
cGVjaWZpYyBoZWFkZXIgdGhhdCBoYXBwZW5zIHRvIGJlCj4gaWRlbnRpY2FsIHRvIHRoZSBvcmln
aW5hbCBiaXRzdHJlYW0gZm9ybWF0CgpJIHRoaW5rIGluIGFub3RoZXIgdGhyZWFkIChhYm91dCBI
LjI2NCBJIGJlbGlldmUpLCB3ZSByZWFsaXplZCB0aGF0IGl0CmNvdWxkIGJlIGEgZ29vZCBpZGVh
IHRvIGp1c3QgaW5jbHVkZSB0aGUgU2xpY2UgTkFMIHVuaXRzIGluIHRoZQpBbm5leC5CIGZvcm1h
dCBpbiB0aGUgYnVmZmVycyBhbmQgdGhhdCBzaG91bGQgd29yayBmb3IgYWxsIHRoZQpoYXJkd2Fy
ZSB3ZSBjb3VsZCB0aGluayBvZiAoZ2l2ZW4gb2Zmc2V0cyB0byBwYXJ0aWN1bGFyIHBhcnRzIGlu
c2lkZQpvZiB0aGUgYnVmZmVyKS4gV291bGRuJ3Qgc29tZXRoaW5nIHNpbWlsYXIgd29yayBoZXJl
IGZvciBIRVZDPwoKSSBkb24ndCByZWFsbHkgZ2V0IHRoZSBtZWFuaW5nIG9mICJyYXciIGZvciAi
Y2FiYWMgdGFibGUsIHNjYWxpbmcKbGlzdCwgcGljdHVyZSBwYXJhbWV0ZXIgc2V0IGFuZCByZWZl
cmVuY2UgcGljdHVyZSIsIHNpbmNlIHRob3NlIGFyZQpwYXJ0cyBvZiB0aGUgYml0c3RyZWFtLCB3
aGljaCBuZWVkcyB0byBiZSBwYXJzZWQgdG8gb2J0YWluIHRob3NlLgoKQmVzdCByZWdhcmRzLApU
b21hc3oKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
