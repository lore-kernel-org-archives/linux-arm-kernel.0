Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E1DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:45:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAAF2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tnIn9Rs9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EDc3rw5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAAF2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cFQXuN1djK4VebEs7uC4NRRHlU4FOsDc9lCqJeP8wzw=; b=tnIn9Rs9SUwwND
	2JR1cb5PlBSRgYCGG/D+XNBEnOrgKh5hZns/zOsxmyTwYNwSnudIQKDe+sc0pQ8JDZ5w71dQdd/rL
	BCUoamQGT8O1vHvY7/OL+y6j/0jln8dnGsJEbkPYOswVvY7KJI50inB2P6Ugf0/YaxD42YjHgZZnY
	b+KG7nqfTodWqPEJRR3s4VzgDtViGSDbmWmGh/ygVlPZNtM0voq4gI1mTFjDCZ19Ys+nyJJdH+YxA
	U00c9QbdFgVeDvU1rxaJqwM7kpbrOvns9to0kiJJzulYZO6rfhWGckVnx8rTJd+bL9/JKk/7vwcgY
	Q/wiBmZBsFkpjwvnlEpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goO4r-0001eF-IT; Tue, 29 Jan 2019 07:45:01 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goO4i-0001cL-2U
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 07:44:53 +0000
Received: by mail-ot1-x343.google.com with SMTP id e12so17083575otl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 23:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sg8RsoaeVSyRM13cr5tOwJLRDxxtn7MjroRD+akYFO8=;
 b=EDc3rw5RmGhwyCdR1w79Ob9Bp8OAgfX8H2Y7qobBPURN3XUJWK+gOmWJ1p2Wtl5qjk
 f+mmr6SX/2LFC/j8SpeDPn/FTZ9GKoua45nie5ASbXR99pDf+8V1bMQ2ow5TSyFLV41X
 9yKTUhQpBi+oc6nVNyshshx/POxsjJ2Zn6+sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sg8RsoaeVSyRM13cr5tOwJLRDxxtn7MjroRD+akYFO8=;
 b=hvQK2eYAwB8+wYaECv2JyJLLsHC1LPEkm5ytNuW84GGM01bHJLtjCpchzrEX7KP+sz
 H2r6gRLNyS4umNujxXo5JLYggvWMF0119PFtBTQpRreMur2fGWSoPFReHl+n2Ocf4nJK
 luriWi4REDTSmLfStUCmcJqkHRl/3ArhD/wiqKgiZ31cqkDZ2uq4amOH0zCGy6GcqfLs
 DDH5jmxVCc/5mG5ElHn7+oqST1jeZ9bCslbonNnpqpmIlTF2rGhcBc1EducFzKkPGqfT
 DzB5MM1dnBsZAkTL941IUciAecvUji+shQ85+aVJiVpgUpUNf0DOvsyMfxMP/lrb1kGk
 cKnw==
X-Gm-Message-State: AJcUukeZwe5n1h+0RNFVFzO0/6jO2WYY/52y1rOReIkVF759DRb/WGBS
 850zeGBiSMcngvC8+mm9X9z80NUFFWWQrg==
X-Google-Smtp-Source: ALg8bN5mYdN+ZRRUxiUuek1Mt22PK06n4iKvmRMLyVnuhI3p/TXSVd6awX4hfHg+o308FE84U1dScg==
X-Received: by 2002:a9d:1f3:: with SMTP id e106mr17923937ote.369.1548747889615; 
 Mon, 28 Jan 2019 23:44:49 -0800 (PST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com.
 [209.85.210.47])
 by smtp.gmail.com with ESMTPSA id j11sm6470664oif.9.2019.01.28.23.44.48
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 23:44:48 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 81so17099038otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 23:44:48 -0800 (PST)
X-Received: by 2002:a05:6830:14d6:: with SMTP id
 t22mr17871926otq.146.1548747887817; 
 Mon, 28 Jan 2019 23:44:47 -0800 (PST)
MIME-Version: 1.0
References: <20181123130209.11696-1-paul.kocialkowski@bootlin.com>
 <20181123130209.11696-2-paul.kocialkowski@bootlin.com>
 <5515174.7lFZcYkk85@jernej-laptop>
 <ffe9c81db34b599f675ca5bbf02de360bf0a1608.camel@bootlin.com>
 <776e63c9-d4a5-342a-e0f7-200ef144ffc4@rock-chips.com>
 <64c793e08d61181b78125b3956ec38623fa5d261.camel@bootlin.com>
 <D8005130-F7FD-4CBD-8396-1BB08BB08E81@soulik.info>
 <f982ef378a8ade075bc7077b93640e20ecebf9f4.camel@bootlin.com>
 <82FA0C3F-BC54-4D89-AECB-90D81B89B1CE@soulik.info>
 <c3619a00-17e7-fb92-a427-a7478b96f356@soulik.info>
 <bdf14f97e98f2fd06307545ab9038ac3c2086ae7.camel@bootlin.com>
 <42520087-4EAE-4F7F-BCA0-42E422170E91@soulik.info>
 <ab8ca098ad60f209fe97f79bb93b2d1e898da524.camel@bootlin.com>
In-Reply-To: <ab8ca098ad60f209fe97f79bb93b2d1e898da524.camel@bootlin.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Tue, 29 Jan 2019 16:44:35 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUJu3cX9A-E32bSSjxc1cvGP83ayzZzUxa5_QMf6niK4g@mail.gmail.com>
Message-ID: <CAPBb6MUJu3cX9A-E32bSSjxc1cvGP83ayzZzUxa5_QMf6niK4g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 1/2] media: v4l: Add definitions for the
 HEVC slice format and controls
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_234452_281545_F1A816F4 
X-CRM114-Status: GOOD (  27.52  )
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
Cc: devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Ayaka <ayaka@soulik.info>, Randy Li <randy.li@rock-chips.com>,
 LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-rockchip@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBKYW4gMjUsIDIwMTkgYXQgMTA6MDQgUE0gUGF1bCBLb2NpYWxrb3dza2kKPHBhdWwu
a29jaWFsa293c2tpQGJvb3RsaW4uY29tPiB3cm90ZToKPgo+IEhpLAo+Cj4gT24gVGh1LCAyMDE5
LTAxLTI0IGF0IDIwOjIzICswODAwLCBBeWFrYSB3cm90ZToKPiA+Cj4gPiBTZW50IGZyb20gbXkg
aVBhZAo+ID4KPiA+ID4gT24gSmFuIDI0LCAyMDE5LCBhdCA2OjI3IFBNLCBQYXVsIEtvY2lhbGtv
d3NraSA8cGF1bC5rb2NpYWxrb3dza2lAYm9vdGxpbi5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBI
aSwKPiA+ID4KPiA+ID4gPiBPbiBUaHUsIDIwMTktMDEtMTAgYXQgMjE6MzIgKzA4MDAsIGF5YWth
IHdyb3RlOgo+ID4gPiA+IEkgZm9yZ2V0IGEgaW1wb3J0YW50IHRoaW5nLCBmb3IgdGhlIHJrdmRl
YyBhbmQgcmsgaGV2YyBkZWNvZGVyLCBpdCB3b3VsZAo+ID4gPiA+IHJlcXVlc3RzIGNhYmFjIHRh
YmxlLCBzY2FsaW5nIGxpc3QsIHBpY3R1cmUgcGFyYW1ldGVyIHNldCBhbmQgcmVmZXJlbmNlCj4g
PiA+ID4gcGljdHVyZSBzdG9yaW5nIGluIG9uZSBvciB2YXJpb3VzIG9mIERNQSBidWZmZXJzLiBJ
IGFtIG5vdCB0YWxraW5nIGFib3V0Cj4gPiA+ID4gdGhlIGRhdGEgYmVlbiBwYXJzZWQsIHRoZSBk
ZWNvZGVyIHdvdWxkIHJlcXVlc3RzIGEgcmF3IGRhdGEuCj4gPiA+ID4KPiA+ID4gPiBGb3IgdGhl
IHBwcyBhbmQgcnBzLCBpdCBpcyBwb3NzaWJsZSB0byByZXVzZSB0aGUgc2xpY2UgaGVhZGVyLCBq
dXN0IGxldAo+ID4gPiA+IHRoZSBkZWNvZGVyIGtub3cgdGhlIG9mZnNldCBmcm9tIHRoZSBiaXRz
dHJlYW0gYnVmZXIsIEkgd291bGQgc3VnZ2VzdCB0bwo+ID4gPiA+IGFkZCB0aHJlZSBwcm9wZXJ0
aWVzKHdpdGggc3BzKSBmb3IgdGhlbS4gQnV0IEkgdGhpbmsgd2UgbmVlZCBhIG1ldGhvZCB0bwo+
ID4gPiA+IG1hcmsgYSBPVVRQVVQgc2lkZSBidWZmZXIgZm9yIHRob3NlIGF1eCBkYXRhLgo+ID4g
Pgo+ID4gPiBJJ20gcXVpdGUgY29uZnVzZWQgYWJvdXQgdGhlIGhhcmR3YXJlIGltcGxlbWVudGF0
aW9uIHRoZW4uIEZyb20gd2hhdAo+ID4gPiB5b3UncmUgc2F5aW5nLCBpdCBzZWVtcyB0aGF0IGl0
IHRha2VzIHRoZSByYXcgYml0c3RyZWFtIGVsZW1lbnRzIHJhdGhlcgo+ID4gPiB0aGFuIHBhcnNl
ZCBlbGVtZW50cy4gSXMgaXQgcmVhbGx5IGEgc3RhdGVsZXNzIGltcGxlbWVudGF0aW9uPwo+ID4g
Pgo+ID4gPiBUaGUgc3RhdGVsZXNzIGltcGxlbWVudGF0aW9uIHdhcyBkZXNpZ25lZCB3aXRoIHRo
ZSBpZGVhIHRoYXQgb25seSB0aGUKPiA+ID4gcmF3IHNsaWNlIGRhdGEgc2hvdWxkIGJlIHBhc3Nl
ZCBpbiBiaXRzdHJlYW0gZm9ybSB0byB0aGUgZGVjb2Rlci4gRm9yCj4gPiA+IEguMjY0LCBpdCBz
ZWVtcyB0aGF0IHNvbWUgZGVjb2RlcnMgYWxzbyBuZWVkIHRoZSBzbGljZSBoZWFkZXIgaW4gcmF3
Cj4gPiA+IGJpdHN0cmVhbSBmb3JtIChiZWNhdXNlIHRoZXkgdGFrZSB0aGUgZnVsbCBzbGljZSBO
QUwgdW5pdCksIHNlZSB0aGUKPiA+ID4gZGlzY3Vzc2lvbnMgaW4gdGhpcyB0aHJlYWQ6Cj4gPiA+
IG1lZGlhOiBkb2NzLXJzdDogRG9jdW1lbnQgbTJtIHN0YXRlbGVzcyB2aWRlbyBkZWNvZGVyIGlu
dGVyZmFjZQo+ID4KPiA+IFN0YXRlbGVzcyBqdXN0IG1lYW4gaXQgd29u4oCZdCB0cmFjayB0aGUg
cHJldmlvdXMgcmVzdWx0LCBidXQgSSBkb27igJl0Cj4gPiB0aGluayB5b3UgY2FuIGRlZmluZSB3
aGF0IGEgZGF0ZSB0aGUgaGFyZHdhcmUgd291bGQgbmVlZC4gRXZlbiB5b3UKPiA+IGp1c3QgYnVp
bGQgYSBkcGIgZm9yIHRoZSBkZWNvZGVyLCBpdCBpcyBzdGlsbCBzdGF0ZWxlc3MsIGJ1dCBwYXJz
aW5nCj4gPiBsZXNzIG9yIG1vcmUgZGF0YSBmcm9tIHRoZSBiaXRzdHJlYW0gZG9lc27igJl0IHN0
b3AgYSBkZWNvZGVyIGJlY29tZSBhCj4gPiBzdGF0ZWxlc3MgZGVjb2Rlci4KPgo+IFllcyBmYWly
IGVub3VnaCwgdGhlIGZvcm1hdCBpbiB3aGljaCB0aGUgaGFyZHdhcmUgZGVjb2RlciB0YWtlcyB0
aGUKPiBiaXRzdHJlYW0gcGFyYW1ldGVycyBkb2VzIG5vdCBtYWtlIGl0IHN0YXRlbGVzcyBvciBz
dGF0ZWZ1bCBwZXItc2UuCj4gSXQncyBqdXN0IHRoYXQgc3RhdGVsZXNzIGRlY29kZXJzIHNob3Vs
ZCBoYXZlIG5vIHBhcnRpY3VsYXIgcmVhc29uIGZvcgo+IHBhcnNpbmcgdGhlIGJpdHN0cmVhbSBv
biB0aGVpciBvd24gc2luY2UgdGhlIGhhcmR3YXJlIGNhbiBiZSBkZXNpZ25lZAo+IHdpdGggcmVn
aXN0ZXJzIGZvciBlYWNoIHJlbGV2YW50IGJpdHN0cmVhbSBlbGVtZW50IHRvIGNvbmZpZ3VyZSB0
aGUKPiBkZWNvZGluZyBwaXBlbGluZS4gVGhhdCdzIGhvdyBHUFUtYmFzZWQgZGVjb2RlciBpbXBs
ZW1lbnRhdGlvbnMgYXJlCj4gaW1wbGVtZW50ZWQgKFZBQVBJL1ZEUEFVL05WREVDLCBldGMpLgo+
Cj4gU28gdGhlIGZvcm1hdCB3ZSBoYXZlIGFncmVlZCBvbiBzbyBmYXIgZm9yIHRoZSBzdGF0ZWxl
c3MgaW50ZXJmYWNlIGlzCj4gdG8gcGFzcyBwYXJzZWQgZWxlbWVudHMgdmlhIHY0bDIgY29udHJv
bCBzdHJ1Y3R1cmVzLgo+Cj4gSWYgdGhlIGhhcmR3YXJlIGNhbiBvbmx5IHdvcmsgYnkgcGFyc2lu
ZyB0aGUgYml0c3RyZWFtIGl0c2VsZiwgSSdtIG5vdAo+IHN1cmUgd2hhdCB0aGUgYmVzdCBzb2x1
dGlvbiB3b3VsZCBiZS4gUmVjb25zdHJ1Y3RpbmcgdGhlIGJpdHN0cmVhbSBpbgo+IHRoZSBrZXJu
ZWwgaXMgYSBwcmV0dHkgYmFkIG9wdGlvbiwgYnV0IHNvIGlzIHBhcnNpbmcgaW4gdGhlIGtlcm5l
bCBvcgo+IGhhdmluZyB0aGUgZGF0YSBib3RoIGluIHBhcnNlZCBhbmQgcmF3IGZvcm1zLiBEbyB5
b3Ugc2VlIGFub3RoZXIKPiBwb3NzaWJpbGl0eT8KCklzIHJlY29uc3RydWN0aW5nIHRoZSBiaXRz
dHJlYW0gc28gYmFkPyBUaGUgdjRsMiBjb250cm9scyBwcm92aWRlIGEKZ2VuZXJpYyBpbnRlcmZh
Y2UgdG8gYW4gZW5jb2RlZCBmb3JtYXQgd2hpY2ggdGhlIGRyaXZlciBuZWVkcyB0bwpjb252ZXJ0
IGludG8gYSBzZXF1ZW5jZSB0aGF0IHRoZSBoYXJkd2FyZSBjYW4gdW5kZXJzdGFuZC4gVHlwaWNh
bGx5CnRoaXMgaXMgZG9uZSBieSBwb3B1bGF0aW5nIGhhcmR3YXJlLXNwZWNpZmljIHN0cnVjdHVy
ZXMuIENhbid0IHdlCmNvbnNpZGVyIHRoYXQgaW4gdGhpcyBzcGVjaWZpYyBpbnN0YW5jZSwgdGhl
IGhhcmR3YXJlLXNwZWNpZmljCnN0cnVjdHVyZSBqdXN0IGhhcHBlbnMgdG8gYmUgaWRlbnRpY2Fs
IHRvIHRoZSBvcmlnaW5hbCBiaXRzdHJlYW0KZm9ybWF0PwoKSSBhZ3JlZSB0aGF0IHRoaXMgaXMg
bm90IHN0cmljdGx5IG9wdGltYWwgZm9yIHRoYXQgcGFydGljdWxhcgpoYXJkd2FyZSwgYnV0IHN1
Y2ggaXMgdGhlIGNvc3Qgb2YgYWJzdHJhY3Rpb25zLCBhbmQgaW4gdGhpcyBzcGVjaWZpYwpjYXNl
IEkgZG9uJ3QgYmVsaWV2ZSB0aGUgY29zdCB3b3VsZCBiZSBwYXJ0aWN1bGFybHkgaGlnaD8KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
