Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE11C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:29:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53B721852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o/qg/nnV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HXWKsmgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53B721852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rZ3tOYRedoRzW91duKqCgVK2udkZvQW35ucHvL9sWJk=; b=o/qg/nnVZPyIef
	69Ky/SR03UOoGRAjrNWqDjmif42rO5AFIB1mlv+Y3a7h+hljaalu1Yp9BEbTh4/yqymEz3odOikUS
	ADa4yrPai4FYISkhVNV718szUku5MpFKAJT7fJ5M86FnRWnWedYRyDe1kC3oB2KKmPuc2lWoEC+xK
	8WpJDGdY+VDEqMWvQhNj6fgo8BvmyX8cpanzeHg4Jzb0+f5Gk2N/V/ZMIozcSrzT6+JMM3gFZLMqK
	2UhPGC0IpoOtoohIbGygXVl5zkZ+/TZj4JEVgZeVq1ycMaafxNKxgy8VjdV4M8nXmlXOElQzaHbJi
	hyBAI5pfihF43FDQ+BZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gofce-0000mO-7I; Wed, 30 Jan 2019 02:29:04 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gofca-0000lU-Ks
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 02:29:02 +0000
Received: by mail-oi1-x244.google.com with SMTP id j21so17996609oii.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 18:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hthliATX6CStMo00A0vGtMXZYxXL92JFmTppLztuTQQ=;
 b=HXWKsmgDRaeLbn2+Gj5Rov/6M7vPWTbRmvH+xEpC3lJC2tMSP8IU6J9KWaMEuddh1E
 W/0B2txGN3CbFyPn3/D+ZE6k4+vhvbh66eUTcXppqxmPSR+OGowZkxt1hLwBUlAf96oS
 pm31rqSgTYAp4zfk2z/u2bSwxiFE9vCojgFRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hthliATX6CStMo00A0vGtMXZYxXL92JFmTppLztuTQQ=;
 b=FgjvZrmh4n9ZETV+eul5ebhbJJsBj7/43lUOih/kr9d+bxrBo9OtJChnIkptJScIa1
 NGJilw4GHI4+w9dzz4d6kDcJ6iq1ZVoRutiA4rlhqJ2sRWIFnBj9mIK9DxxzpK+8DmEn
 6mWp7B9IWkP6i9EBi5ilEMiM1t4HFuNxl/ZaiR4FUf36FG9oWMVetohd9RGVd4gYobn8
 T2rMyzOc1IRD8nfC9NiEuJ+u5Qz7PKlmMleMN8wJaDnQmzQ0xvL+YfBlpN0WumTZjbxs
 xU4J9IeMF4m/0LLWP00EKNnLSWXGDTKE0ueYN31UktGpdzqszfL7QWf2Qt1xI2S8j/p7
 pEog==
X-Gm-Message-State: AHQUAuZj5WIWqbY9Aan7S2RWS+Gxnxgqjoe4fVJBKJNdUUgoswxyL3au
 8bzTfbZ9v2eMwBwjS70s/LLVeyw+64l8NQ==
X-Google-Smtp-Source: ALg8bN4y4ZgFMINZgIkV6COyFlYem3YXqFgcUVC/NnvMdCbG/aapVEkcoT73ZzJBzjuDilSGvXTaRw==
X-Received: by 2002:aca:f288:: with SMTP id
 q130mr10659325oih.228.1548815339143; 
 Tue, 29 Jan 2019 18:28:59 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com.
 [209.85.210.41])
 by smtp.gmail.com with ESMTPSA id r184sm77661oif.56.2019.01.29.18.28.57
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 18:28:57 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id s5so19836193oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 18:28:57 -0800 (PST)
X-Received: by 2002:a9d:7319:: with SMTP id e25mr22328418otk.204.1548815337058; 
 Tue, 29 Jan 2019 18:28:57 -0800 (PST)
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
In-Reply-To: <2442b23d3b0a00c1bd441298a712888e016acf92.camel@ndufresne.ca>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Wed, 30 Jan 2019 11:28:45 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUsbdXvkomtkiq0ygTqj58h4yqVR0PotT=ft94Ai0nbhw@mail.gmail.com>
Message-ID: <CAPBb6MUsbdXvkomtkiq0ygTqj58h4yqVR0PotT=ft94Ai0nbhw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 1/2] media: v4l: Add definitions for the
 HEVC slice format and controls
To: Nicolas Dufresne <nicolas@ndufresne.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_182900_712318_21A221E7 
X-CRM114-Status: GOOD (  32.49  )
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
 Tomasz Figa <tfiga@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 linux-rockchip@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBKYW4gMzAsIDIwMTkgYXQgNjo0MSBBTSBOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFz
QG5kdWZyZXNuZS5jYT4gd3JvdGU6Cj4KPiBMZSBtYXJkaSAyOSBqYW52aWVyIDIwMTkgw6AgMTY6
NDQgKzA5MDAsIEFsZXhhbmRyZSBDb3VyYm90IGEgw6ljcml0IDoKPiA+IE9uIEZyaSwgSmFuIDI1
LCAyMDE5IGF0IDEwOjA0IFBNIFBhdWwgS29jaWFsa293c2tpCj4gPiA8cGF1bC5rb2NpYWxrb3dz
a2lAYm9vdGxpbi5jb20+IHdyb3RlOgo+ID4gPiBIaSwKPiA+ID4KPiA+ID4gT24gVGh1LCAyMDE5
LTAxLTI0IGF0IDIwOjIzICswODAwLCBBeWFrYSB3cm90ZToKPiA+ID4gPiBTZW50IGZyb20gbXkg
aVBhZAo+ID4gPiA+Cj4gPiA+ID4gPiBPbiBKYW4gMjQsIDIwMTksIGF0IDY6MjcgUE0sIFBhdWwg
S29jaWFsa293c2tpIDxwYXVsLmtvY2lhbGtvd3NraUBib290bGluLmNvbT4gd3JvdGU6Cj4gPiA+
ID4gPgo+ID4gPiA+ID4gSGksCj4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPbiBUaHUsIDIwMTktMDEt
MTAgYXQgMjE6MzIgKzA4MDAsIGF5YWthIHdyb3RlOgo+ID4gPiA+ID4gPiBJIGZvcmdldCBhIGlt
cG9ydGFudCB0aGluZywgZm9yIHRoZSBya3ZkZWMgYW5kIHJrIGhldmMgZGVjb2RlciwgaXQgd291
bGQKPiA+ID4gPiA+ID4gcmVxdWVzdHMgY2FiYWMgdGFibGUsIHNjYWxpbmcgbGlzdCwgcGljdHVy
ZSBwYXJhbWV0ZXIgc2V0IGFuZCByZWZlcmVuY2UKPiA+ID4gPiA+ID4gcGljdHVyZSBzdG9yaW5n
IGluIG9uZSBvciB2YXJpb3VzIG9mIERNQSBidWZmZXJzLiBJIGFtIG5vdCB0YWxraW5nIGFib3V0
Cj4gPiA+ID4gPiA+IHRoZSBkYXRhIGJlZW4gcGFyc2VkLCB0aGUgZGVjb2RlciB3b3VsZCByZXF1
ZXN0cyBhIHJhdyBkYXRhLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBGb3IgdGhlIHBwcyBhbmQg
cnBzLCBpdCBpcyBwb3NzaWJsZSB0byByZXVzZSB0aGUgc2xpY2UgaGVhZGVyLCBqdXN0IGxldAo+
ID4gPiA+ID4gPiB0aGUgZGVjb2RlciBrbm93IHRoZSBvZmZzZXQgZnJvbSB0aGUgYml0c3RyZWFt
IGJ1ZmVyLCBJIHdvdWxkIHN1Z2dlc3QgdG8KPiA+ID4gPiA+ID4gYWRkIHRocmVlIHByb3BlcnRp
ZXMod2l0aCBzcHMpIGZvciB0aGVtLiBCdXQgSSB0aGluayB3ZSBuZWVkIGEgbWV0aG9kIHRvCj4g
PiA+ID4gPiA+IG1hcmsgYSBPVVRQVVQgc2lkZSBidWZmZXIgZm9yIHRob3NlIGF1eCBkYXRhLgo+
ID4gPiA+ID4KPiA+ID4gPiA+IEknbSBxdWl0ZSBjb25mdXNlZCBhYm91dCB0aGUgaGFyZHdhcmUg
aW1wbGVtZW50YXRpb24gdGhlbi4gRnJvbSB3aGF0Cj4gPiA+ID4gPiB5b3UncmUgc2F5aW5nLCBp
dCBzZWVtcyB0aGF0IGl0IHRha2VzIHRoZSByYXcgYml0c3RyZWFtIGVsZW1lbnRzIHJhdGhlcgo+
ID4gPiA+ID4gdGhhbiBwYXJzZWQgZWxlbWVudHMuIElzIGl0IHJlYWxseSBhIHN0YXRlbGVzcyBp
bXBsZW1lbnRhdGlvbj8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGUgc3RhdGVsZXNzIGltcGxlbWVu
dGF0aW9uIHdhcyBkZXNpZ25lZCB3aXRoIHRoZSBpZGVhIHRoYXQgb25seSB0aGUKPiA+ID4gPiA+
IHJhdyBzbGljZSBkYXRhIHNob3VsZCBiZSBwYXNzZWQgaW4gYml0c3RyZWFtIGZvcm0gdG8gdGhl
IGRlY29kZXIuIEZvcgo+ID4gPiA+ID4gSC4yNjQsIGl0IHNlZW1zIHRoYXQgc29tZSBkZWNvZGVy
cyBhbHNvIG5lZWQgdGhlIHNsaWNlIGhlYWRlciBpbiByYXcKPiA+ID4gPiA+IGJpdHN0cmVhbSBm
b3JtIChiZWNhdXNlIHRoZXkgdGFrZSB0aGUgZnVsbCBzbGljZSBOQUwgdW5pdCksIHNlZSB0aGUK
PiA+ID4gPiA+IGRpc2N1c3Npb25zIGluIHRoaXMgdGhyZWFkOgo+ID4gPiA+ID4gbWVkaWE6IGRv
Y3MtcnN0OiBEb2N1bWVudCBtMm0gc3RhdGVsZXNzIHZpZGVvIGRlY29kZXIgaW50ZXJmYWNlCj4g
PiA+ID4KPiA+ID4gPiBTdGF0ZWxlc3MganVzdCBtZWFuIGl0IHdvbuKAmXQgdHJhY2sgdGhlIHBy
ZXZpb3VzIHJlc3VsdCwgYnV0IEkgZG9u4oCZdAo+ID4gPiA+IHRoaW5rIHlvdSBjYW4gZGVmaW5l
IHdoYXQgYSBkYXRlIHRoZSBoYXJkd2FyZSB3b3VsZCBuZWVkLiBFdmVuIHlvdQo+ID4gPiA+IGp1
c3QgYnVpbGQgYSBkcGIgZm9yIHRoZSBkZWNvZGVyLCBpdCBpcyBzdGlsbCBzdGF0ZWxlc3MsIGJ1
dCBwYXJzaW5nCj4gPiA+ID4gbGVzcyBvciBtb3JlIGRhdGEgZnJvbSB0aGUgYml0c3RyZWFtIGRv
ZXNu4oCZdCBzdG9wIGEgZGVjb2RlciBiZWNvbWUgYQo+ID4gPiA+IHN0YXRlbGVzcyBkZWNvZGVy
Lgo+ID4gPgo+ID4gPiBZZXMgZmFpciBlbm91Z2gsIHRoZSBmb3JtYXQgaW4gd2hpY2ggdGhlIGhh
cmR3YXJlIGRlY29kZXIgdGFrZXMgdGhlCj4gPiA+IGJpdHN0cmVhbSBwYXJhbWV0ZXJzIGRvZXMg
bm90IG1ha2UgaXQgc3RhdGVsZXNzIG9yIHN0YXRlZnVsIHBlci1zZS4KPiA+ID4gSXQncyBqdXN0
IHRoYXQgc3RhdGVsZXNzIGRlY29kZXJzIHNob3VsZCBoYXZlIG5vIHBhcnRpY3VsYXIgcmVhc29u
IGZvcgo+ID4gPiBwYXJzaW5nIHRoZSBiaXRzdHJlYW0gb24gdGhlaXIgb3duIHNpbmNlIHRoZSBo
YXJkd2FyZSBjYW4gYmUgZGVzaWduZWQKPiA+ID4gd2l0aCByZWdpc3RlcnMgZm9yIGVhY2ggcmVs
ZXZhbnQgYml0c3RyZWFtIGVsZW1lbnQgdG8gY29uZmlndXJlIHRoZQo+ID4gPiBkZWNvZGluZyBw
aXBlbGluZS4gVGhhdCdzIGhvdyBHUFUtYmFzZWQgZGVjb2RlciBpbXBsZW1lbnRhdGlvbnMgYXJl
Cj4gPiA+IGltcGxlbWVudGVkIChWQUFQSS9WRFBBVS9OVkRFQywgZXRjKS4KPiA+ID4KPiA+ID4g
U28gdGhlIGZvcm1hdCB3ZSBoYXZlIGFncmVlZCBvbiBzbyBmYXIgZm9yIHRoZSBzdGF0ZWxlc3Mg
aW50ZXJmYWNlIGlzCj4gPiA+IHRvIHBhc3MgcGFyc2VkIGVsZW1lbnRzIHZpYSB2NGwyIGNvbnRy
b2wgc3RydWN0dXJlcy4KPiA+ID4KPiA+ID4gSWYgdGhlIGhhcmR3YXJlIGNhbiBvbmx5IHdvcmsg
YnkgcGFyc2luZyB0aGUgYml0c3RyZWFtIGl0c2VsZiwgSSdtIG5vdAo+ID4gPiBzdXJlIHdoYXQg
dGhlIGJlc3Qgc29sdXRpb24gd291bGQgYmUuIFJlY29uc3RydWN0aW5nIHRoZSBiaXRzdHJlYW0g
aW4KPiA+ID4gdGhlIGtlcm5lbCBpcyBhIHByZXR0eSBiYWQgb3B0aW9uLCBidXQgc28gaXMgcGFy
c2luZyBpbiB0aGUga2VybmVsIG9yCj4gPiA+IGhhdmluZyB0aGUgZGF0YSBib3RoIGluIHBhcnNl
ZCBhbmQgcmF3IGZvcm1zLiBEbyB5b3Ugc2VlIGFub3RoZXIKPiA+ID4gcG9zc2liaWxpdHk/Cj4g
Pgo+ID4gSXMgcmVjb25zdHJ1Y3RpbmcgdGhlIGJpdHN0cmVhbSBzbyBiYWQ/IFRoZSB2NGwyIGNv
bnRyb2xzIHByb3ZpZGUgYQo+ID4gZ2VuZXJpYyBpbnRlcmZhY2UgdG8gYW4gZW5jb2RlZCBmb3Jt
YXQgd2hpY2ggdGhlIGRyaXZlciBuZWVkcyB0bwo+ID4gY29udmVydCBpbnRvIGEgc2VxdWVuY2Ug
dGhhdCB0aGUgaGFyZHdhcmUgY2FuIHVuZGVyc3RhbmQuIFR5cGljYWxseQo+ID4gdGhpcyBpcyBk
b25lIGJ5IHBvcHVsYXRpbmcgaGFyZHdhcmUtc3BlY2lmaWMgc3RydWN0dXJlcy4gQ2FuJ3Qgd2UK
PiA+IGNvbnNpZGVyIHRoYXQgaW4gdGhpcyBzcGVjaWZpYyBpbnN0YW5jZSwgdGhlIGhhcmR3YXJl
LXNwZWNpZmljCj4gPiBzdHJ1Y3R1cmUganVzdCBoYXBwZW5zIHRvIGJlIGlkZW50aWNhbCB0byB0
aGUgb3JpZ2luYWwgYml0c3RyZWFtCj4gPiBmb3JtYXQ/Cj4KPiBBdCBtYXhpbXVtIGFsbG93ZWQg
Yml0cmF0ZSBmb3IgbGV0J3Mgc2F5IEhFVkMgKDk0ME1CL3MgaWlyYyksIHllcywgaXQKPiB3b3Vs
ZCBiZSByZWFsbHkgcmVhbGx5IGJhZC4gSW4gR1N0cmVhbWVyIHByb2plY3Qgd2UgaGF2ZSBkaXNj
dXNzZWQgZm9yCj4gYSB3aGlsZSAoYnV0IGhhdmUgbmV2ZXIgZG9uZSBhbnl0aGluZyBhYm91dCkg
YWRkaW5nIHRoZSBhYmlsaXR5IHRocm91Z2gKPiBhIGJpdG1hc2sgdG8gc2VsZWN0IHdoaWNoIHBh
cnQgb2YgdGhlIHN0cmVhbSBuZWVkIHRvIGJlIHBhcnNlZCwgYXMKPiBwYXJzaW5nIGl0c2VsZiB3
YXMgY2F1c2luZyBzb21lIG92ZXJoZWFkLiBNYXliZSBzaW1pbGFyIHRoaW5nIGFwcGxpZXMsCj4g
dGhvdWdoIGFzIHBlciBvdXIgbmV3IGRlc2lnbiwgaXQncyB0aGUgZm91cmNjIHRoYXQgZGljdGF0
ZSB0aGUgZHJpdmVyCj4gYmVoYXZpb3VyLCB3ZSdkIG5lZWQgeWV0IGFub3RoZXIgZm91cmNjIGZv
ciBkcml2ZXJzIHRoYXQgd2FudHMgdGhlIGZ1bGwKPiBiaXRzdHJlYW0gKHdoaWNoIHNlZW1zIG9k
ZCBpZiB5b3UgaGF2ZSBhbHJlYWR5IHBhcnNlZCBldmVyeXRoaW5nLCBJCj4gdGhpbmsgdGhpcyBu
ZWVkIHNvbWUgY2xhcmlmaWNhdGlvbikuCgpOb3RlIHRoYXQgSSBhbSBub3QgcHJvcG9zaW5nIHRv
IHJlYnVpbGQgdGhlICplbnRpcmUqIGJpdHN0cmVhbQppbi1rZXJuZWwuIFdoYXQgSSBhbSBzYXlp
bmcgaXMgdGhhdCBpZiB0aGUgaGFyZHdhcmUgaW50ZXJwcmV0cyBzb21lCnN0cnVjdHVyZXMgKGxp
a2UgU1BTL1BQUykgaW4gdGhlaXIgcmF3IGZvcm1hdCwgdGhpcyByYXcgZm9ybWF0IGNvdWxkCmJl
IHJlY29uc3RydWN0ZWQgZnJvbSB0aGUgc3RydWN0dXJlcyBwYXNzZWQgYnkgdXNlcnNwYWNlIGF0
IG5lZ2xpZ2libGUKY29zdC4gU3VjaCBtYW5pcHVsYXRpb24gd291bGQgb25seSBoYXBwZW4gb24g
YSBzbWFsbCBhbW91bnQgb2YgZGF0YS4KCkV4cG9zaW5nIGZpbmVyLWdyYWluZWQgZHJpdmVyIHJl
cXVpcmVtZW50cyB0aHJvdWdoIGEgYml0bWFzayBtYXkKZGVzZXJ2ZSBtb3JlIGV4cGxvcmluZy4g
TWF5YmUgd2UgY291bGQgZW5kIHdpdGggYSBzcGVjdHJ1bSBvZgpjYXBhYmlsaXRpZXMgdGhhdCB3
b3VsZCBhbGxvdyB1cyB0byBjb3ZlciB0aGUgcmFuZ2UgZnJvbSBmdWxseQpzdGF0ZWxlc3MgdG8g
ZnVsbHkgc3RhdGVmdWwgSVBzIG1vcmUgc21vb3RobHkuIFJpZ2h0IG5vdyB3ZSBoYXZlIHR3bwpz
cGVjaWZpY2F0aW9ucyB0aGF0IG9ubHkgY29uc2lkZXIgdGhlIGV4dHJlbWVzIG9mIHRoYXQgcmFu
Z2UuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
