Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1B8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:36:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9476C21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f4ZtGY4H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SpBSH8Mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9476C21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d4XARrRlr/JnENKQDvkuXA4CtyxdHefjrLpMZjopdH0=; b=f4ZtGY4Hz3V+6R
	+UPc/3ExFYIOBQw3cH0ujWzXau/ArFazPU3QOpWQPpXhKG1VdjxmLVzxV57FSSejdz0NUQa9CpBlZ
	8oxbd9izjrZAbDuR3Ma3s+GaUpoddz9SbNU+MQm78Dpm/sGz1qbve1iwLWjsqkiLDUz0pvVZujHmd
	tMZ15tCBNOjVjCTPYdhcDLY5u2iCszQkOugACobte3oApvldhzYJL7DSCTW1Jf7TjBykK5sVydWS0
	3Bga0OAF0DtIBQvwOx5VC94QJ3EePDcN9vS4hqtdkI9ZeItmdTgUG7Uc+fgVorcD4ngV/bp+MIOTg
	AAWmkjJJ+egkpiPmmsRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gogfR-0007bW-Sa; Wed, 30 Jan 2019 03:36:01 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gogfO-0007b2-HD
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 03:36:00 +0000
Received: by mail-ot1-x341.google.com with SMTP id g16so15936613otg.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 19:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TcsyA1n6pBTmF1Y5oeefdi7XPYD4WXUfVM4aanxIPf4=;
 b=SpBSH8Mf4zPTp2y0b78sCsIPoZBvwdDBA7enAu5Y10R1062+fXZpzl+r8No+CW5FRC
 KSHqM8Af97BnqRFj7t07VBqY6SQJVWsR4NLhxw/Vjw9WCagOoiXtYm4RT+DK8dT4QnPJ
 IHkujlBB3kEBFc1/BOweHMC6JdstIC2rm2gQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TcsyA1n6pBTmF1Y5oeefdi7XPYD4WXUfVM4aanxIPf4=;
 b=pMis1UjAXp6k9H3sAtPgKsQ84UA4ABhellfO02+/xtUpFLKA4K9jCLT3fYokEjduMl
 5JCnHlqgsO1Hsy4i1ettxEVNr8xaSwm0+a3D/FTxKxhGTTZYOuK0ubElJ8yUrzdAkLxS
 /GKf6SUWaW42KJ8Su8M0j4vSwA/lod9P0W6FXqW6Bzx0/iZxeFHDnXAIcWK3P4pekvfG
 X3qkrsHHHNoLTVYMYbVWdH+qBQR6nR2LeauvTIeeHch6eDKbq2oJyEVdlKolzQtTHXUO
 UCFdzVfMKM/Cxc6hkMhciht1+1xw6GxyCIsFj7AChjmEWIHJ7G16XRnKiiYC3sVImlbK
 H5xQ==
X-Gm-Message-State: AJcUukcGVIsT35GzVOnKK8p7ZBdnRbJYWFh5nqTZATIMnhJpJEX5AKGb
 r4WXVoeQzDtcYbzd32lIx7XrfxlNC90=
X-Google-Smtp-Source: ALg8bN7S1lJWcsow1PqHJZOsdb+w+x+hLNFzzJSY3/x+PgFj8tFgLgKLV3qjCTSLsA0CXsKcq2mx8g==
X-Received: by 2002:a9d:1d29:: with SMTP id m38mr20902925otm.264.1548819355540; 
 Tue, 29 Jan 2019 19:35:55 -0800 (PST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com.
 [209.85.167.181])
 by smtp.gmail.com with ESMTPSA id r203sm171328oih.11.2019.01.29.19.35.54
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 19:35:54 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id w13so18071359oiw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 19:35:54 -0800 (PST)
X-Received: by 2002:aca:ea57:: with SMTP id i84mr11319499oih.346.1548819353475; 
 Tue, 29 Jan 2019 19:35:53 -0800 (PST)
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
 <CAPBb6MUJu3cX9A-E32bSSjxc1cvGP83ayzZzUxa5_QMf6niK4g@mail.gmail.com>
 <2442b23d3b0a00c1bd441298a712888e016acf92.camel@ndufresne.ca>
 <CAPBb6MUsbdXvkomtkiq0ygTqj58h4yqVR0PotT=ft94Ai0nbhw@mail.gmail.com>
In-Reply-To: <CAPBb6MUsbdXvkomtkiq0ygTqj58h4yqVR0PotT=ft94Ai0nbhw@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 30 Jan 2019 12:35:41 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BJ6_eQ2QiQLdmkkkeWEiVQ_yo86QccOn9176ZRDQxc=Q@mail.gmail.com>
Message-ID: <CAAFQd5BJ6_eQ2QiQLdmkkkeWEiVQ_yo86QccOn9176ZRDQxc=Q@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 1/2] media: v4l: Add definitions for the
 HEVC slice format and controls
To: Alexandre Courbot <acourbot@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_193558_593587_3C74C3DF 
X-CRM114-Status: GOOD (  36.55  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>, Ayaka <ayaka@soulik.info>,
 Randy Li <randy.li@rock-chips.com>, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
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

T24gV2VkLCBKYW4gMzAsIDIwMTkgYXQgMTE6MjkgQU0gQWxleGFuZHJlIENvdXJib3QKPGFjb3Vy
Ym90QGNocm9taXVtLm9yZz4gd3JvdGU6Cj4KPiBPbiBXZWQsIEphbiAzMCwgMjAxOSBhdCA2OjQx
IEFNIE5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPiB3cm90ZToKPiA+Cj4g
PiBMZSBtYXJkaSAyOSBqYW52aWVyIDIwMTkgw6AgMTY6NDQgKzA5MDAsIEFsZXhhbmRyZSBDb3Vy
Ym90IGEgw6ljcml0IDoKPiA+ID4gT24gRnJpLCBKYW4gMjUsIDIwMTkgYXQgMTA6MDQgUE0gUGF1
bCBLb2NpYWxrb3dza2kKPiA+ID4gPHBhdWwua29jaWFsa293c2tpQGJvb3RsaW4uY29tPiB3cm90
ZToKPiA+ID4gPiBIaSwKPiA+ID4gPgo+ID4gPiA+IE9uIFRodSwgMjAxOS0wMS0yNCBhdCAyMDoy
MyArMDgwMCwgQXlha2Egd3JvdGU6Cj4gPiA+ID4gPiBTZW50IGZyb20gbXkgaVBhZAo+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gT24gSmFuIDI0LCAyMDE5LCBhdCA2OjI3IFBNLCBQYXVsIEtvY2lhbGtv
d3NraSA8cGF1bC5rb2NpYWxrb3dza2lAYm9vdGxpbi5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiBIaSwKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBPbiBUaHUsIDIwMTktMDEt
MTAgYXQgMjE6MzIgKzA4MDAsIGF5YWthIHdyb3RlOgo+ID4gPiA+ID4gPiA+IEkgZm9yZ2V0IGEg
aW1wb3J0YW50IHRoaW5nLCBmb3IgdGhlIHJrdmRlYyBhbmQgcmsgaGV2YyBkZWNvZGVyLCBpdCB3
b3VsZAo+ID4gPiA+ID4gPiA+IHJlcXVlc3RzIGNhYmFjIHRhYmxlLCBzY2FsaW5nIGxpc3QsIHBp
Y3R1cmUgcGFyYW1ldGVyIHNldCBhbmQgcmVmZXJlbmNlCj4gPiA+ID4gPiA+ID4gcGljdHVyZSBz
dG9yaW5nIGluIG9uZSBvciB2YXJpb3VzIG9mIERNQSBidWZmZXJzLiBJIGFtIG5vdCB0YWxraW5n
IGFib3V0Cj4gPiA+ID4gPiA+ID4gdGhlIGRhdGEgYmVlbiBwYXJzZWQsIHRoZSBkZWNvZGVyIHdv
dWxkIHJlcXVlc3RzIGEgcmF3IGRhdGEuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBGb3Ig
dGhlIHBwcyBhbmQgcnBzLCBpdCBpcyBwb3NzaWJsZSB0byByZXVzZSB0aGUgc2xpY2UgaGVhZGVy
LCBqdXN0IGxldAo+ID4gPiA+ID4gPiA+IHRoZSBkZWNvZGVyIGtub3cgdGhlIG9mZnNldCBmcm9t
IHRoZSBiaXRzdHJlYW0gYnVmZXIsIEkgd291bGQgc3VnZ2VzdCB0bwo+ID4gPiA+ID4gPiA+IGFk
ZCB0aHJlZSBwcm9wZXJ0aWVzKHdpdGggc3BzKSBmb3IgdGhlbS4gQnV0IEkgdGhpbmsgd2UgbmVl
ZCBhIG1ldGhvZCB0bwo+ID4gPiA+ID4gPiA+IG1hcmsgYSBPVVRQVVQgc2lkZSBidWZmZXIgZm9y
IHRob3NlIGF1eCBkYXRhLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJJ20gcXVpdGUgY29uZnVz
ZWQgYWJvdXQgdGhlIGhhcmR3YXJlIGltcGxlbWVudGF0aW9uIHRoZW4uIEZyb20gd2hhdAo+ID4g
PiA+ID4gPiB5b3UncmUgc2F5aW5nLCBpdCBzZWVtcyB0aGF0IGl0IHRha2VzIHRoZSByYXcgYml0
c3RyZWFtIGVsZW1lbnRzIHJhdGhlcgo+ID4gPiA+ID4gPiB0aGFuIHBhcnNlZCBlbGVtZW50cy4g
SXMgaXQgcmVhbGx5IGEgc3RhdGVsZXNzIGltcGxlbWVudGF0aW9uPwo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiBUaGUgc3RhdGVsZXNzIGltcGxlbWVudGF0aW9uIHdhcyBkZXNpZ25lZCB3aXRoIHRo
ZSBpZGVhIHRoYXQgb25seSB0aGUKPiA+ID4gPiA+ID4gcmF3IHNsaWNlIGRhdGEgc2hvdWxkIGJl
IHBhc3NlZCBpbiBiaXRzdHJlYW0gZm9ybSB0byB0aGUgZGVjb2Rlci4gRm9yCj4gPiA+ID4gPiA+
IEguMjY0LCBpdCBzZWVtcyB0aGF0IHNvbWUgZGVjb2RlcnMgYWxzbyBuZWVkIHRoZSBzbGljZSBo
ZWFkZXIgaW4gcmF3Cj4gPiA+ID4gPiA+IGJpdHN0cmVhbSBmb3JtIChiZWNhdXNlIHRoZXkgdGFr
ZSB0aGUgZnVsbCBzbGljZSBOQUwgdW5pdCksIHNlZSB0aGUKPiA+ID4gPiA+ID4gZGlzY3Vzc2lv
bnMgaW4gdGhpcyB0aHJlYWQ6Cj4gPiA+ID4gPiA+IG1lZGlhOiBkb2NzLXJzdDogRG9jdW1lbnQg
bTJtIHN0YXRlbGVzcyB2aWRlbyBkZWNvZGVyIGludGVyZmFjZQo+ID4gPiA+ID4KPiA+ID4gPiA+
IFN0YXRlbGVzcyBqdXN0IG1lYW4gaXQgd29u4oCZdCB0cmFjayB0aGUgcHJldmlvdXMgcmVzdWx0
LCBidXQgSSBkb27igJl0Cj4gPiA+ID4gPiB0aGluayB5b3UgY2FuIGRlZmluZSB3aGF0IGEgZGF0
ZSB0aGUgaGFyZHdhcmUgd291bGQgbmVlZC4gRXZlbiB5b3UKPiA+ID4gPiA+IGp1c3QgYnVpbGQg
YSBkcGIgZm9yIHRoZSBkZWNvZGVyLCBpdCBpcyBzdGlsbCBzdGF0ZWxlc3MsIGJ1dCBwYXJzaW5n
Cj4gPiA+ID4gPiBsZXNzIG9yIG1vcmUgZGF0YSBmcm9tIHRoZSBiaXRzdHJlYW0gZG9lc27igJl0
IHN0b3AgYSBkZWNvZGVyIGJlY29tZSBhCj4gPiA+ID4gPiBzdGF0ZWxlc3MgZGVjb2Rlci4KPiA+
ID4gPgo+ID4gPiA+IFllcyBmYWlyIGVub3VnaCwgdGhlIGZvcm1hdCBpbiB3aGljaCB0aGUgaGFy
ZHdhcmUgZGVjb2RlciB0YWtlcyB0aGUKPiA+ID4gPiBiaXRzdHJlYW0gcGFyYW1ldGVycyBkb2Vz
IG5vdCBtYWtlIGl0IHN0YXRlbGVzcyBvciBzdGF0ZWZ1bCBwZXItc2UuCj4gPiA+ID4gSXQncyBq
dXN0IHRoYXQgc3RhdGVsZXNzIGRlY29kZXJzIHNob3VsZCBoYXZlIG5vIHBhcnRpY3VsYXIgcmVh
c29uIGZvcgo+ID4gPiA+IHBhcnNpbmcgdGhlIGJpdHN0cmVhbSBvbiB0aGVpciBvd24gc2luY2Ug
dGhlIGhhcmR3YXJlIGNhbiBiZSBkZXNpZ25lZAo+ID4gPiA+IHdpdGggcmVnaXN0ZXJzIGZvciBl
YWNoIHJlbGV2YW50IGJpdHN0cmVhbSBlbGVtZW50IHRvIGNvbmZpZ3VyZSB0aGUKPiA+ID4gPiBk
ZWNvZGluZyBwaXBlbGluZS4gVGhhdCdzIGhvdyBHUFUtYmFzZWQgZGVjb2RlciBpbXBsZW1lbnRh
dGlvbnMgYXJlCj4gPiA+ID4gaW1wbGVtZW50ZWQgKFZBQVBJL1ZEUEFVL05WREVDLCBldGMpLgo+
ID4gPiA+Cj4gPiA+ID4gU28gdGhlIGZvcm1hdCB3ZSBoYXZlIGFncmVlZCBvbiBzbyBmYXIgZm9y
IHRoZSBzdGF0ZWxlc3MgaW50ZXJmYWNlIGlzCj4gPiA+ID4gdG8gcGFzcyBwYXJzZWQgZWxlbWVu
dHMgdmlhIHY0bDIgY29udHJvbCBzdHJ1Y3R1cmVzLgo+ID4gPiA+Cj4gPiA+ID4gSWYgdGhlIGhh
cmR3YXJlIGNhbiBvbmx5IHdvcmsgYnkgcGFyc2luZyB0aGUgYml0c3RyZWFtIGl0c2VsZiwgSSdt
IG5vdAo+ID4gPiA+IHN1cmUgd2hhdCB0aGUgYmVzdCBzb2x1dGlvbiB3b3VsZCBiZS4gUmVjb25z
dHJ1Y3RpbmcgdGhlIGJpdHN0cmVhbSBpbgo+ID4gPiA+IHRoZSBrZXJuZWwgaXMgYSBwcmV0dHkg
YmFkIG9wdGlvbiwgYnV0IHNvIGlzIHBhcnNpbmcgaW4gdGhlIGtlcm5lbCBvcgo+ID4gPiA+IGhh
dmluZyB0aGUgZGF0YSBib3RoIGluIHBhcnNlZCBhbmQgcmF3IGZvcm1zLiBEbyB5b3Ugc2VlIGFu
b3RoZXIKPiA+ID4gPiBwb3NzaWJpbGl0eT8KPiA+ID4KPiA+ID4gSXMgcmVjb25zdHJ1Y3Rpbmcg
dGhlIGJpdHN0cmVhbSBzbyBiYWQ/IFRoZSB2NGwyIGNvbnRyb2xzIHByb3ZpZGUgYQo+ID4gPiBn
ZW5lcmljIGludGVyZmFjZSB0byBhbiBlbmNvZGVkIGZvcm1hdCB3aGljaCB0aGUgZHJpdmVyIG5l
ZWRzIHRvCj4gPiA+IGNvbnZlcnQgaW50byBhIHNlcXVlbmNlIHRoYXQgdGhlIGhhcmR3YXJlIGNh
biB1bmRlcnN0YW5kLiBUeXBpY2FsbHkKPiA+ID4gdGhpcyBpcyBkb25lIGJ5IHBvcHVsYXRpbmcg
aGFyZHdhcmUtc3BlY2lmaWMgc3RydWN0dXJlcy4gQ2FuJ3Qgd2UKPiA+ID4gY29uc2lkZXIgdGhh
dCBpbiB0aGlzIHNwZWNpZmljIGluc3RhbmNlLCB0aGUgaGFyZHdhcmUtc3BlY2lmaWMKPiA+ID4g
c3RydWN0dXJlIGp1c3QgaGFwcGVucyB0byBiZSBpZGVudGljYWwgdG8gdGhlIG9yaWdpbmFsIGJp
dHN0cmVhbQo+ID4gPiBmb3JtYXQ/Cj4gPgo+ID4gQXQgbWF4aW11bSBhbGxvd2VkIGJpdHJhdGUg
Zm9yIGxldCdzIHNheSBIRVZDICg5NDBNQi9zIGlpcmMpLCB5ZXMsIGl0Cj4gPiB3b3VsZCBiZSBy
ZWFsbHkgcmVhbGx5IGJhZC4gSW4gR1N0cmVhbWVyIHByb2plY3Qgd2UgaGF2ZSBkaXNjdXNzZWQg
Zm9yCj4gPiBhIHdoaWxlIChidXQgaGF2ZSBuZXZlciBkb25lIGFueXRoaW5nIGFib3V0KSBhZGRp
bmcgdGhlIGFiaWxpdHkgdGhyb3VnaAo+ID4gYSBiaXRtYXNrIHRvIHNlbGVjdCB3aGljaCBwYXJ0
IG9mIHRoZSBzdHJlYW0gbmVlZCB0byBiZSBwYXJzZWQsIGFzCj4gPiBwYXJzaW5nIGl0c2VsZiB3
YXMgY2F1c2luZyBzb21lIG92ZXJoZWFkLiBNYXliZSBzaW1pbGFyIHRoaW5nIGFwcGxpZXMsCj4g
PiB0aG91Z2ggYXMgcGVyIG91ciBuZXcgZGVzaWduLCBpdCdzIHRoZSBmb3VyY2MgdGhhdCBkaWN0
YXRlIHRoZSBkcml2ZXIKPiA+IGJlaGF2aW91ciwgd2UnZCBuZWVkIHlldCBhbm90aGVyIGZvdXJj
YyBmb3IgZHJpdmVycyB0aGF0IHdhbnRzIHRoZSBmdWxsCj4gPiBiaXRzdHJlYW0gKHdoaWNoIHNl
ZW1zIG9kZCBpZiB5b3UgaGF2ZSBhbHJlYWR5IHBhcnNlZCBldmVyeXRoaW5nLCBJCj4gPiB0aGlu
ayB0aGlzIG5lZWQgc29tZSBjbGFyaWZpY2F0aW9uKS4KPgo+IE5vdGUgdGhhdCBJIGFtIG5vdCBw
cm9wb3NpbmcgdG8gcmVidWlsZCB0aGUgKmVudGlyZSogYml0c3RyZWFtCj4gaW4ta2VybmVsLiBX
aGF0IEkgYW0gc2F5aW5nIGlzIHRoYXQgaWYgdGhlIGhhcmR3YXJlIGludGVycHJldHMgc29tZQo+
IHN0cnVjdHVyZXMgKGxpa2UgU1BTL1BQUykgaW4gdGhlaXIgcmF3IGZvcm1hdCwgdGhpcyByYXcg
Zm9ybWF0IGNvdWxkCj4gYmUgcmVjb25zdHJ1Y3RlZCBmcm9tIHRoZSBzdHJ1Y3R1cmVzIHBhc3Nl
ZCBieSB1c2Vyc3BhY2UgYXQgbmVnbGlnaWJsZQo+IGNvc3QuIFN1Y2ggbWFuaXB1bGF0aW9uIHdv
dWxkIG9ubHkgaGFwcGVuIG9uIGEgc21hbGwgYW1vdW50IG9mIGRhdGEuCj4KPiBFeHBvc2luZyBm
aW5lci1ncmFpbmVkIGRyaXZlciByZXF1aXJlbWVudHMgdGhyb3VnaCBhIGJpdG1hc2sgbWF5Cj4g
ZGVzZXJ2ZSBtb3JlIGV4cGxvcmluZy4gTWF5YmUgd2UgY291bGQgZW5kIHdpdGggYSBzcGVjdHJ1
bSBvZgo+IGNhcGFiaWxpdGllcyB0aGF0IHdvdWxkIGFsbG93IHVzIHRvIGNvdmVyIHRoZSByYW5n
ZSBmcm9tIGZ1bGx5Cj4gc3RhdGVsZXNzIHRvIGZ1bGx5IHN0YXRlZnVsIElQcyBtb3JlIHNtb290
aGx5LiBSaWdodCBub3cgd2UgaGF2ZSB0d28KPiBzcGVjaWZpY2F0aW9ucyB0aGF0IG9ubHkgY29u
c2lkZXIgdGhlIGV4dHJlbWVzIG9mIHRoYXQgcmFuZ2UuCgpJIGdhdmUgaXQgYSBiaXQgbW9yZSB0
aG91Z2h0IGFuZCBpZiB3ZSBjb21iaW5lIHdoYXQgTmljb2xhcyBzdWdnZXN0ZWQKYWJvdXQgdGhl
IGJpdG1hc2sgY29udHJvbCB3aXRoIHRoZSB1c2Vyc3BhY2UgcHJvdmlkaW5nIHRoZSBmdWxsCmJp
dHN0cmVhbSBpbiB0aGUgT1VUUFVUIGJ1ZmZlcnMsIHNwbGl0IGludG8gc29tZSBsb2dpY2FsIHVu
aXRzIGFuZAoidGFnZ2VkIiB3aXRoIHRoZWlyIHR5cGUgKGUuZy4gU1BTLCBQUFMsIHNsaWNlLCBl
dGMuKSwgd2UgY291bGQKcG90ZW50aWFsbHkgZ2V0IGFuIGludGVyZmFjZSB0aGF0IHdvdWxkIHdv
cmsgZm9yIGFueSBraW5kIG9mIGRlY29kZXIgSQpjYW4gdGhpbmsgb2YsIGFjdHVhbGx5IGVsaW1p
bmF0aW5nIHRoZSBib3VuZGFyeSBiZXR3ZWVuIHN0YXRlZnVsIGFuZApzdGF0ZWxlc3MgZGVjb2Rl
cnMuCgpGb3IgZXhhbXBsZSwgYSBmdWxseSBzdGF0ZWZ1bCBkZWNvZGVyIHdvdWxkIGhhdmUgdGhl
IGJpdG1hc2sgY29udHJvbApzZXQgdG8gMCBhbmQgYWNjZXB0IGRhdGEgZnJvbSBhbGwgdGhlIE9V
VFBVVCBidWZmZXJzIGFzIHRoZXkgY29tZS4gQQpkZWNvZGVyIHRoYXQgZG9lc24ndCBkbyBhbnkg
cGFyc2luZyBvbiBpdHMgb3duIHdvdWxkIGhhdmUgYWxsIHRoZQp2YWxpZCBiaXRzIGluIHRoZSBi
aXRtYXNrIHNldCBhbmQgaWdub3JlIHRoZSBkYXRhIGluIE9VVFBVVCBidWZmZXJzCnRhZ2dlZCBh
cyBhbnkga2luZCBvZiBtZXRhZGF0YS4gQW5kIHRoZW4sIHdlIGNvdWxkIGhhdmUgYW55IGNhc2Vz
IGluCmJldHdlZW4sIGluY2x1ZGluZyBzdGF0ZWZ1bCBkZWNvZGVycyB3aGljaCBqdXN0IGNhbid0
IHBhcnNlIHRoZSBzdHJlYW0Kb24gdGhlaXIgb3duLCBidXQgc3RpbGwgbWFuYWdlIGFueXRoaW5n
IGVsc2UgdGhlbXNlbHZlcywgb3Igc3RhdGVsZXNzCm9uZXMgd2hpY2ggY2FuIHBhcnNlIHBhcnRz
IG9mIHRoZSBzdHJlYW0sIGxpa2UgdGhlIHJrMzM5OSB2ZGVjIGNhbgpwYXJzZSB0aGUgSC4yNjQg
c2xpY2UgaGVhZGVycyBvbiBpdHMgb3duLgoKVGhhdCBjb3VsZCBwb3RlbnRpYWxseSBsZXQgdXMg
Y29tcGxldGVseSBlbGltaW5hdGUgdGhlIGRpc3RpbmN0aW9uCmJldHdlZW4gdGhlIHN0YXRlZnVs
IGFuZCBzdGF0ZWxlc3MgaW50ZXJmYWNlcyBhbmQganVzdCBoYXZlIG9uZSB0aGF0CmNvdmVycyBi
b3RoLgoKVGhvdWdodHM/CgpCZXN0IHJlZ2FyZHMsClRvbWFzegoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
