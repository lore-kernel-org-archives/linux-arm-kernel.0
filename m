Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B295C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:46:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F5821B1A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pT3sx2Ba";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m2w2garc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F5821B1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ml6rb8oouAWyYM04EOpOdYkbynq5vCYDa/o1QehdFCc=; b=pT3sx2BaZhG4Nj
	ntBb8LsjwtqNQRZWCCBh10Vf2e4azk25eyJfqjaEEFq9IOmoGPoWUqXgtIqJ5bvorUdd85dNLzQ0Q
	8Psl/9hZ7Kx6IlNzjLxYWgS4JCDFDzfawZh+UJH0OGZeqUCOL4bUYQUIUX1EnNNDh3PpmfQYbnKtU
	F3Qdl0jAyertdf+T1TJm17rt5/NO2nYmuTx71IpC2D0tSPeNosGuKhz9q18jNuVeGVoT34u65m4PH
	R1BVoISHjEsa+SSnXsNNWXX24A8oQjEbUIyOpRVxE6IFr+sI3JY9hIXbdWSWDLiBn5FHzEW7apgw0
	gQnJuB5KNstuy8lTpRMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtlVC-0002SQ-Th; Wed, 13 Feb 2019 03:46:26 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtlV8-0002Ry-Bs
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 03:46:24 +0000
Received: by mail-ot1-x342.google.com with SMTP id u16so1653147otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 19:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=58B8G8X3Q4XpZNnJHFqf2/dMYMx2cfT2/6gIk5ZPDgM=;
 b=m2w2garcjjHQrlMfRSQO+gegZArUIyGF0sLUg0iEvQWlaINzbFZCdolra4zO/An/56
 QUOdEaaxfICq9CtBwcaTYltoPT/+Ztas1e+5SkS5MVQtTFoce6q81Lmurnm5WVGjBxpt
 WpkX1Q6RXUxFTTgL0UxoF3A7yfudjmy7QGsPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=58B8G8X3Q4XpZNnJHFqf2/dMYMx2cfT2/6gIk5ZPDgM=;
 b=SX7RssVoNei6eDUCijnipAckBLYT0RrYeOX4qd/+KVlhUZ+XAxjQYaEw1FbRfw3yqa
 H7si10gsJX5wSLwVWK5czmZNnCDo9jhGxEUkrEqSGwQbo2AsU2cZoHq8mMvcADLnE/vW
 glTyWNzIe2xqgUPy3sGIUwOCiUL5eqki0K1znogDV1TFeaP7RwjSGLq4YjaSQz3KVlSZ
 44OmERyCC7nafNy1qb19a3fnMp4zgd4fEODuwSoact/v2kaxPw2YxVqfw/zTI9pujo1L
 J4w6iZZXeHN4AX5hnJ52k7wla6BkibtZTfIvp/AcXZnrMo1TKqlunfjKYtwb864YjFva
 g+yA==
X-Gm-Message-State: AHQUAuYaSu5BuNMSKCDhIZhmdl9asLlKLHncCVyzjDDSfB+nmZ4cKO+9
 HQQWStIcazTMD3+R9eElVFk0f3C4a2M=
X-Google-Smtp-Source: AHgI3IbSxpyAURx4fxHRZLp1jetAIU5vQ4EW2DjNfCK602fQ3MN9nEz61OX4NO0K0CDxsu+VetEJnw==
X-Received: by 2002:a9d:63d0:: with SMTP id e16mr6903535otl.322.1550029580448; 
 Tue, 12 Feb 2019 19:46:20 -0800 (PST)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com.
 [209.85.210.42])
 by smtp.gmail.com with ESMTPSA id z6sm71981otq.68.2019.02.12.19.46.19
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 19:46:20 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id w25so1602558otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 19:46:19 -0800 (PST)
X-Received: by 2002:aca:644:: with SMTP id 65mr1104oig.21.1550029271733; Tue,
 12 Feb 2019 19:41:11 -0800 (PST)
MIME-Version: 1.0
References: <1549020091-42064-1-git-send-email-frederic.chen@mediatek.com>
 <1549020091-42064-2-git-send-email-frederic.chen@mediatek.com>
 <20190209155907.rbgwbdablndcesid@valkosipuli.retiisi.org.uk>
 <20190209181705.GB4505@pendragon.ideasonboard.com>
 <1549964242.27207.11.camel@mtksdccf07>
In-Reply-To: <1549964242.27207.11.camel@mtksdccf07>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 13 Feb 2019 12:41:00 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AuvvgGO3t2bUk345QM6zSWo5LSq-j-=H_-qNchWKPPWg@mail.gmail.com>
Message-ID: <CAAFQd5AuvvgGO3t2bUk345QM6zSWo5LSq-j-=H_-qNchWKPPWg@mail.gmail.com>
Subject: Re: [RFC PATCH V0 1/7] [media] dt-bindings: mt8183: Add binding for
 DIP shared memory
To: Frederic Chen <frederic.chen@mediatek.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@iki.fi>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_194622_459653_FBBC5B0B 
X-CRM114-Status: GOOD (  32.58  )
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
Cc: devicetree@vger.kernel.org,
 =?UTF-8?B?U2VhbiBDaGVuZyAo6YSt5piH5byYKQ==?= <Sean.Cheng@mediatek.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 =?UTF-8?B?UnlubiBXdSAo5ZCz6IKy5oGpKQ==?= <Rynn.Wu@mediatek.com>,
 =?UTF-8?B?Q2hyaXN0aWUgWXUgKOa4uOmbheaDoCk=?= <christie.yu@mediatek.com>,
 srv_heupstream@mediatek.com,
 =?UTF-8?B?SG9sbWVzIENoaW91ICjpgrHmjLop?= <holmes.chiou@mediatek.com>,
 Jerry-ch.Chen@mediatek.com,
 =?UTF-8?B?SnVuZ28gTGluICjmnpfmmI7kv4op?= <jungo.lin@mediatek.com>,
 Sj Huang <sj.huang@mediatek.com>, Hans Verkuil <hans.verkuil@cisco.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBGZWIgMTIsIDIwMTkgYXQgNjozNyBQTSBGcmVkZXJpYyBDaGVuCjxmcmVkZXJpYy5j
aGVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6Cj4KPiBEZWFyIExhdXJlbnQgYW5kIFNha2FyaSwKPgo+
IEkgYXBwcmVjaWF0ZSB5b3VyIG1lc3NhZ2VzLgo+Cj4gT24gU2F0LCAyMDE5LTAyLTA5IGF0IDIw
OjE3ICswMjAwLCBMYXVyZW50IFBpbmNoYXJ0IHdyb3RlOgo+ID4gT24gU2F0LCBGZWIgMDksIDIw
MTkgYXQgMDU6NTk6MDdQTSArMDIwMCwgU2FrYXJpIEFpbHVzIHdyb3RlOgo+ID4gPiBIaSBGcmVk
ZXJpYywKPiA+ID4KPiA+ID4gQ291bGQgeW91IGNjIHRoZSBkZXZpY2V0cmVlIGxpc3QsIHBsZWFz
ZT8KPiA+ID4KPiA+ID4gT24gRnJpLCBGZWIgMDEsIDIwMTkgYXQgMDc6MjE6MjVQTSArMDgwMCwg
RnJlZGVyaWMgQ2hlbiB3cm90ZToKPiA+ID4gPiBUaGlzIHBhdGNoIGFkZHMgdGhlIGJpbmRpbmcg
Zm9yIGRlc2NyaWJpbmcgdGhlIHNoYXJlZCBtZW1vcnkKPiA+ID4gPiB1c2VkIHRvIGV4Y2hhbmdl
IGNvbmZpZ3VyYXRpb24gYW5kIHR1bmluZyBkYXRhIGJldHdlZW4gdGhlCj4gPiA+ID4gY28tcHJv
Y2Vzc29yIGFuZCBEaWdpdGFsIEltYWdlIFByb2Nlc3NpbmcgKERJUCkgdW5pdCBvZiB0aGUKPiA+
ID4gPiBjYW1lcmEgSVNQIHN5c3RlbSBvbiBNZWRpYXRlayBTb0NzLgo+ID4gPiA+Cj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogRnJlZGVyaWMgQ2hlbiA8ZnJlZGVyaWMuY2hlbkBtZWRpYXRlay5jb20+
Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIC4uLi9tZWRpYXRlayxyZXNlcnZlLW1lbW9yeS1kaXBfc21l
bS50eHQgICAgICAgICAgIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKQo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2VydmVkLW1lbW9yeS9tZWRpYXRl
ayxyZXNlcnZlLW1lbW9yeS1kaXBfc21lbS50eHQKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXJ2ZWQtbWVtb3J5L21lZGlh
dGVrLHJlc2VydmUtbWVtb3J5LWRpcF9zbWVtLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9yZXNlcnZlZC1tZW1vcnkvbWVkaWF0ZWsscmVzZXJ2ZS1tZW1vcnktZGlwX3Nt
ZW0udHh0Cj4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+ID4gPiBpbmRleCAwMDAwMDAw
Li4wZGVkNDc4Cj4gPiA+ID4gLS0tIC9kZXYvbnVsbAo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNlcnZlZC1tZW1vcnkvbWVkaWF0ZWsscmVzZXJ2ZS1t
ZW1vcnktZGlwX3NtZW0udHh0Cj4gPiA+ID4gQEAgLTAsMCArMSw0NSBAQAo+ID4gPiA+ICtNZWRp
YXRlayBESVAgU2hhcmVkIE1lbW9yeSBiaW5kaW5nCj4gPiA+ID4gKwo+ID4gPiA+ICtUaGlzIGJp
bmRpbmcgZGVzY3JpYmVzIHRoZSBzaGFyZWQgbWVtb3J5LCB3aGljaCBzZXJ2ZXMgdGhlIHB1cnBv
c2Ugb2YKPiA+ID4gPiArZGVzY3JpYmluZyB0aGUgc2hhcmVkIG1lbW9yeSByZWdpb24gdXNlZCB0
byBleGNoYW5nZSBkYXRhIGJldHdlZW4gRGlnaXRhbAo+ID4gPiA+ICtJbWFnZSBQcm9jZXNzaW5n
IChESVApIGFuZCBjby1wcm9jZXNzb3IgaW4gTWVkaWF0ZWsgU29Dcy4KPiA+ID4gPiArCj4gPiA+
ID4gK1RoZSBjby1wcm9jZXNzb3IgZG9lc24ndCBoYXZlIHRoZSBpb21tdSBzbyB3ZSBuZWVkIHRv
IHVzZSB0aGUgcGh5c2ljYWwKPiA+ID4gPiArYWRkcmVzcyB0byBhY2Nlc3MgdGhlIHNoYXJlZCBi
dWZmZXIgaW4gdGhlIGZpcm13YXJlLgo+ID4gPiA+ICsKPiA+ID4gPiArVGhlIERpZ2l0YWwgSW1h
Z2UgUHJvY2Vzc2luZyAoRElQKSBjYW4gYWNjZXNzIG1lbW9yeSB0aHJvdWdoIG10ODE4MyBJT01N
VSBzbwo+ID4gPiA+ICtpdCBjYW4gdXNlIGRtYSBhZGRyZXNzIHRvIGFjY2VzcyB0aGUgbWVtb3J5
IHJlZ2lvbi4KPiA+ID4gPiArKFNlZSBpb21tdS9tZWRpYXRlayxpb21tdS50eHQgZm9yIHRoZSBk
ZXRhaWxlZCBkZXNjcmlwdGlvbiBvZiBNZWRpYXRlayBJT01NVSkKPiA+ID4KPiA+ID4gV2hhdCBr
aW5kIG9mIHB1cnBvc2UgaXMgdGhlIG1lbW9yeSB1c2VkIGZvcj8gQnVmZmVycyBjb250YWluaW5n
IHZpZGVvIGRhdGEsCj4gPiA+IG9yIHNvbWV0aGluZyBlbHNlPyBDb3VsZCB0aGUgYnVmZmVyIG9i
amVjdHMgYmUgbWFwcGVkIG9uIHRoZSBkZXZpY2VzCj4gPiA+IGJhc2VkIG9uIHRoZSBuZWVkIGlu
c3RlYWQ/Cj4KPiBUaGUgbWVtb3J5IGJ1ZmZlcnMgY29udGFpbiBjYW1lcmEgM0EgdHVuaW5nIGRh
dGEsIHdoaWNoIGFyZSB1c2VkIGJ5IHRoZQo+IGNvLXByb2Nlc3NvciBhbmQgRElQIElQLiBBYm91
dCBtYXBwaW5nIHRoZSBidWZmZXIgYmFzZWQgb24gdGhlIG5lZWQKPiBpbnN0ZWFkLCBJ4oCZbSBu
b3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhpcyBwb2ludC4gRG8geW91IG1lYW4gdGhhdAo+IGFsbG9j
YXRpbmcgYW5kIG1hcHBpbmcgdGhlIG1lbW9yeSBkeW5hbWljYWxseT8KPgo+ID4KPiA+IEFuZCBj
b3VsZCBDTUEgYmUgdXNlZCB3aGVuIHBoeXNpY2FsbHkgY29udGlndW91cyBtZW1vcnkgaXMgbmVl
ZGVkID8KPgo+IERJUCBkcml2ZXIgZG9lcyBub3QgdXNlIENNQSBub3csIGJlY2F1c2UgdGhlIGZp
cnN0IHZlcnNpb24gd2lsbCBiZSB1c2VkCj4gYnkgQ3JPUyBidXQgQ3JPUyB3b27igJl0IGVuYWJs
ZSBDTUEuCj4KClRoYW5rcyBGcmVkZXJpYyBmb3IgcmVwbHlpbmcuIExldCBtZSBmdXJ0aGVyIGNs
YXJpZnkgd2hhdCdzIHRoZSBwcm9ibGVtIGhlcmUuCgpUaGUgY28tcHJvY2Vzc29yIGlzIGJlaGlu
ZCBhIHNpbXBsZSBNUFUgKE1lbW9yeSBQcm90ZWN0aW9uIFVuaXQpLAp3aGljaCBkb2VzIG5vdCBo
YXZlIGFueSBtYXBwaW5nIGNhcGFiaWxpdGllcywgYnV0IGNhbiBvbmx5IGFsbG93IG9yCmRlbnkg
YWNjZXNzIHRvIHBhcnRpY3VsYXIgcGFydHMgb2YgdGhlIHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2Uu
IFRoYXQKbWVhbnMgdGhhdCB3ZSBoYXZlIHRvIGVpdGhlciBidWlsZCBzb21lIHNjYXR0ZXIgZ2F0
aGVyIGNhcGFiaWxpdHkKaW5zaWRlIG9mIHRoZSBmaXJtd2FyZSBvciBqdXN0IGRvIHdpdGggY29u
dGlndW91cyBhbGxvY2F0aW9uLgoKVGhlcmUgaXMgYWxzbyBhIHNlY3VyaXR5IGFzcGVjdCBoZXJl
LiBUaGUgTVBVIGNhbiBiZSBhY2Nlc3NlZCBmcm9tCmJvdGggdGhlIGNvLXByb2Nlc3NvciBhbmQg
Q1BVLCBidXQgaXQgaGFzIGEgbG9ja2Rvd24gbW9kZSwgd2hpY2ggbWFrZXMKaXQgcmVhZCBvbmx5
IHVudGlsIHRoZSBTb0MgaXMgcmVzZXQuIElmIHdlIGFsbG9jYXRlIHRoZSBtZW1vcnkKZHluYW1p
Y2FsbHksIHdlIG5lZWQgdG8ga2VlcCB0aGUgTVBVIHVubG9ja2VkLCB3aGljaCBhdXRvbWF0aWNh
bGx5CmdyYW50cyB0aGUgZmlybXdhcmUgYWNjZXNzIHRvIGFsbCB0aGUgYWRkcmVzcyBzcGFjZS4K
CkZvciBzZWN1cml0eSByZWFzb25zIHdlIGRlY2lkZWQgdG8gZ28gd2l0aCBwcmVhbGxvY2F0ZWQg
bWVtb3J5IHBvb2wsCndoaWNoIGxldHMgdXMgcHJlLXByb2dyYW0gdGhlIE1QVSBhbmQgbG9jayBp
dCBkb3duLgoKQmVzdCByZWdhcmRzLApUb21hc3oKCj4gPgo+ID4gPiA+ICsKPiA+ID4gPiArCj4g
PiA+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6Cj4gPiA+ID4gKwo+ID4gPiA+ICstIGNvbXBhdGli
bGU6IG11c3QgYmUgIm1lZGlhdGVrLHJlc2VydmUtbWVtb3J5LWRpcF9zbWVtIgo+ID4gPiA+ICsK
PiA+ID4gPiArLSByZWc6IHJlcXVpcmVkIGZvciBzdGF0aWMgYWxsb2NhdGlvbiAoc2VlIHJlc2Vy
dmVkLW1lbW9yeS50eHQgZm9yCj4gPiA+ID4gKyAgdGhlIGRldGFpbGVkIHVzYWdlKQo+ID4gPiA+
ICsKPiA+ID4gPiArLSBhbGxvYy1yYW5nZTogcmVxdWlyZWQgZm9yIGR5bmFtaWMgYWxsb2NhdGlv
bi4gVGhlIHJhbmdlIG11c3QKPiA+ID4gPiArICBiZXR3ZWVuIDB4MDAwMDA0MDAgYW5kIDB4MTAw
MDAwMDAwIGR1ZSB0byB0aGUgY28tcHJvY2Vzc2VyJ3MKPiA+ID4gPiArICBhZGRyZXNzaW5nIGxp
bWl0YXRpb24KPiA+ID4gPiArCj4gPiA+ID4gKy0gc2l6ZTogcmVxdWlyZWQgZm9yIGR5bmFtaWMg
YWxsb2NhdGlvbi4gVGhlIHVuaXQgaXMgYnl0ZXMuCj4gPiA+ID4gKyAgSWYgeW91IHdhbnQgdG8g
ZW5hYmxlIHRoZSBmdWxsIGZlYXR1cmUgb2YgRGlnaXRhbCBQcm9jZXNzaW5nIFVuaXQsCj4gPiA+
ID4gKyAgeW91IG5lZWQgMjAgTUIgYXQgbGVhc3QuCj4gPiA+ID4gKwo+ID4gPiA+ICsKPiA+ID4g
PiArRXhhbXBsZToKPiA+ID4gPiArCj4gPiA+ID4gK1RoZSBmb2xsb3dpbmcgZXhhbXBsZSBzaG93
cyB0aGUgRElQIHNoYXJlZCBtZW1vcnkgc2V0dXAgZm9yIE1UODE4My4KPiA+ID4gPiArCj4gPiA+
ID4gKyByZXNlcnZlZC1tZW1vcnkgewo+ID4gPiA+ICsgICAgICAgICAjYWRkcmVzcy1jZWxscyA9
IDwyPjsKPiA+ID4gPiArICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47Cj4gPiA+ID4gKyAgICAg
ICAgIHJhbmdlczsKPiA+ID4gPiArICAgICAgICAgcmVzZXJ2ZS1tZW1vcnktaXNwX3NtZW0gewo+
ID4gPiA+ICsgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWsscmVzZXJ2ZS1t
ZW1vcnktZGlwX3NtZW0iOwo+ID4gPiA+ICsgICAgICAgICAgICAgICAgIHNpemUgPSA8MCAweDE0
MDAwMDA+Owo+ID4gPiA+ICsgICAgICAgICAgICAgICAgIGFsaWdubWVudCA9IDwwIDB4MTAwMD47
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgYWxsb2MtcmFuZ2VzID0gPDAgMHg0MDAwMDAwMCAw
IDB4NTAwMDAwMDA+Owo+ID4gPiA+ICsgICAgICAgICB9Owo+ID4gPiA+ICsgfTsKPiA+Cj4KPiBT
aW5jZXJlbHksCj4KPiBGcmVkZXJpYyBDaGVuCj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
