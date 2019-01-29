Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F91C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:25:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77A52175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WW9MEJhf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xo1UTnT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77A52175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OgCm+J06LyFHrT4ejUNncPckDL0575N4dfMcmA/kdQI=; b=WW9MEJhf2qxY8x
	MRZQjFgWIeQfgcvwnreVvF+AWc1TwIPmB3+ACF8NmYpv4mOOZgquTOTiZZZwp1AehNsno/azBHCjc
	2aqWzcb+1338M7LXGbY+hPpvK49fVCr9wF31B4zqgylvVTS8WxZe+6I9un/PHzXTobTEjqWtAGX/q
	dJtQiLBB/bpg+g8NpBYeHJEuHMmVT3hMA7st1NRzCQV1o1zKRZp5lytAj4BPR6rW+JMRA50TYSGfG
	pGnQ60oLQJbxFOP6NgxphEOopdpDPCg/DxO0k2ySmriw9miguL0RajHJcBDupcIVQnVbeUL3dQRkl
	4rV8DzmsfMK+lmvXCniQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOiQ-0001D8-8l; Tue, 29 Jan 2019 08:25:54 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOT5-0004si-SN; Tue, 29 Jan 2019 08:10:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k1i3D1KH81XNw4U/TMsawLtCddTk7jAS6dfz+p8yf0E=; b=xo1UTnT4khL3kQMcXe7O4inJTu
 7Ir2JXXBNCf56r3TeCJLX+eLvycFxyfNmcIvGSLABEBL/hTDjw4tq0u6NkkD4HHr6Po31ZDTxbVTT
 e39iMxBTTzSkR/Uw0fUaRkvYAPmbKUsHnDpkk1Rz2lCHf7KnYzGcjCeib/o3kyrLLB7LbPmZLqz6Q
 QXRZk9DZgefcYWY7Bf2dQd0rAPILz4kPEmM1TDzhsVGmai56x0CDYnljZVoF/k475Jbxw1atyl9kU
 0zZPrOH7FiwL/lXd6gm5azkW1A/txKv19vxWq1ealQDU1uNsSA3zM4tWYvhatoij/HszBFJv55pM1
 Bcn4Qgrg==;
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOT2-0007UU-6U; Tue, 29 Jan 2019 08:10:01 +0000
X-Originating-IP: 90.88.29.206
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2B779E0005;
 Tue, 29 Jan 2019 08:09:45 +0000 (UTC)
Date: Tue, 29 Jan 2019 09:09:44 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Alexandre Courbot <acourbot@chromium.org>
Subject: Re: [linux-sunxi] [PATCH v2 1/2] media: v4l: Add definitions for the
 HEVC slice format and controls
Message-ID: <20190129080944.pfhumtugsm7mzzcc@flea>
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
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPBb6MUJu3cX9A-E32bSSjxc1cvGP83ayzZzUxa5_QMf6niK4g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_031000_466557_43DC2B45 
X-CRM114-Status: GOOD (  36.38  )
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
 Ayaka <ayaka@soulik.info>, Randy Li <randy.li@rock-chips.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
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

T24gVHVlLCBKYW4gMjksIDIwMTkgYXQgMDQ6NDQ6MzVQTSArMDkwMCwgQWxleGFuZHJlIENvdXJi
b3Qgd3JvdGU6Cj4gT24gRnJpLCBKYW4gMjUsIDIwMTkgYXQgMTA6MDQgUE0gUGF1bCBLb2NpYWxr
b3dza2kKPiA+IE9uIFRodSwgMjAxOS0wMS0yNCBhdCAyMDoyMyArMDgwMCwgQXlha2Egd3JvdGU6
Cj4gPiA+Cj4gPiA+IFNlbnQgZnJvbSBteSBpUGFkCj4gPiA+Cj4gPiA+ID4gT24gSmFuIDI0LCAy
MDE5LCBhdCA2OjI3IFBNLCBQYXVsIEtvY2lhbGtvd3NraSA8cGF1bC5rb2NpYWxrb3dza2lAYm9v
dGxpbi5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gSGksCj4gPiA+ID4KPiA+ID4gPiA+IE9u
IFRodSwgMjAxOS0wMS0xMCBhdCAyMTozMiArMDgwMCwgYXlha2Egd3JvdGU6Cj4gPiA+ID4gPiBJ
IGZvcmdldCBhIGltcG9ydGFudCB0aGluZywgZm9yIHRoZSBya3ZkZWMgYW5kIHJrIGhldmMgZGVj
b2RlciwgaXQgd291bGQKPiA+ID4gPiA+IHJlcXVlc3RzIGNhYmFjIHRhYmxlLCBzY2FsaW5nIGxp
c3QsIHBpY3R1cmUgcGFyYW1ldGVyIHNldCBhbmQgcmVmZXJlbmNlCj4gPiA+ID4gPiBwaWN0dXJl
IHN0b3JpbmcgaW4gb25lIG9yIHZhcmlvdXMgb2YgRE1BIGJ1ZmZlcnMuIEkgYW0gbm90IHRhbGtp
bmcgYWJvdXQKPiA+ID4gPiA+IHRoZSBkYXRhIGJlZW4gcGFyc2VkLCB0aGUgZGVjb2RlciB3b3Vs
ZCByZXF1ZXN0cyBhIHJhdyBkYXRhLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEZvciB0aGUgcHBzIGFu
ZCBycHMsIGl0IGlzIHBvc3NpYmxlIHRvIHJldXNlIHRoZSBzbGljZSBoZWFkZXIsIGp1c3QgbGV0
Cj4gPiA+ID4gPiB0aGUgZGVjb2RlciBrbm93IHRoZSBvZmZzZXQgZnJvbSB0aGUgYml0c3RyZWFt
IGJ1ZmVyLCBJIHdvdWxkIHN1Z2dlc3QgdG8KPiA+ID4gPiA+IGFkZCB0aHJlZSBwcm9wZXJ0aWVz
KHdpdGggc3BzKSBmb3IgdGhlbS4gQnV0IEkgdGhpbmsgd2UgbmVlZCBhIG1ldGhvZCB0bwo+ID4g
PiA+ID4gbWFyayBhIE9VVFBVVCBzaWRlIGJ1ZmZlciBmb3IgdGhvc2UgYXV4IGRhdGEuCj4gPiA+
ID4KPiA+ID4gPiBJJ20gcXVpdGUgY29uZnVzZWQgYWJvdXQgdGhlIGhhcmR3YXJlIGltcGxlbWVu
dGF0aW9uIHRoZW4uIEZyb20gd2hhdAo+ID4gPiA+IHlvdSdyZSBzYXlpbmcsIGl0IHNlZW1zIHRo
YXQgaXQgdGFrZXMgdGhlIHJhdyBiaXRzdHJlYW0gZWxlbWVudHMgcmF0aGVyCj4gPiA+ID4gdGhh
biBwYXJzZWQgZWxlbWVudHMuIElzIGl0IHJlYWxseSBhIHN0YXRlbGVzcyBpbXBsZW1lbnRhdGlv
bj8KPiA+ID4gPgo+ID4gPiA+IFRoZSBzdGF0ZWxlc3MgaW1wbGVtZW50YXRpb24gd2FzIGRlc2ln
bmVkIHdpdGggdGhlIGlkZWEgdGhhdCBvbmx5IHRoZQo+ID4gPiA+IHJhdyBzbGljZSBkYXRhIHNo
b3VsZCBiZSBwYXNzZWQgaW4gYml0c3RyZWFtIGZvcm0gdG8gdGhlIGRlY29kZXIuIEZvcgo+ID4g
PiA+IEguMjY0LCBpdCBzZWVtcyB0aGF0IHNvbWUgZGVjb2RlcnMgYWxzbyBuZWVkIHRoZSBzbGlj
ZSBoZWFkZXIgaW4gcmF3Cj4gPiA+ID4gYml0c3RyZWFtIGZvcm0gKGJlY2F1c2UgdGhleSB0YWtl
IHRoZSBmdWxsIHNsaWNlIE5BTCB1bml0KSwgc2VlIHRoZQo+ID4gPiA+IGRpc2N1c3Npb25zIGlu
IHRoaXMgdGhyZWFkOgo+ID4gPiA+IG1lZGlhOiBkb2NzLXJzdDogRG9jdW1lbnQgbTJtIHN0YXRl
bGVzcyB2aWRlbyBkZWNvZGVyIGludGVyZmFjZQo+ID4gPgo+ID4gPiBTdGF0ZWxlc3MganVzdCBt
ZWFuIGl0IHdvbuKAmXQgdHJhY2sgdGhlIHByZXZpb3VzIHJlc3VsdCwgYnV0IEkgZG9u4oCZdAo+
ID4gPiB0aGluayB5b3UgY2FuIGRlZmluZSB3aGF0IGEgZGF0ZSB0aGUgaGFyZHdhcmUgd291bGQg
bmVlZC4gRXZlbiB5b3UKPiA+ID4ganVzdCBidWlsZCBhIGRwYiBmb3IgdGhlIGRlY29kZXIsIGl0
IGlzIHN0aWxsIHN0YXRlbGVzcywgYnV0IHBhcnNpbmcKPiA+ID4gbGVzcyBvciBtb3JlIGRhdGEg
ZnJvbSB0aGUgYml0c3RyZWFtIGRvZXNu4oCZdCBzdG9wIGEgZGVjb2RlciBiZWNvbWUgYQo+ID4g
PiBzdGF0ZWxlc3MgZGVjb2Rlci4KPiA+Cj4gPiBZZXMgZmFpciBlbm91Z2gsIHRoZSBmb3JtYXQg
aW4gd2hpY2ggdGhlIGhhcmR3YXJlIGRlY29kZXIgdGFrZXMgdGhlCj4gPiBiaXRzdHJlYW0gcGFy
YW1ldGVycyBkb2VzIG5vdCBtYWtlIGl0IHN0YXRlbGVzcyBvciBzdGF0ZWZ1bCBwZXItc2UuCj4g
PiBJdCdzIGp1c3QgdGhhdCBzdGF0ZWxlc3MgZGVjb2RlcnMgc2hvdWxkIGhhdmUgbm8gcGFydGlj
dWxhciByZWFzb24gZm9yCj4gPiBwYXJzaW5nIHRoZSBiaXRzdHJlYW0gb24gdGhlaXIgb3duIHNp
bmNlIHRoZSBoYXJkd2FyZSBjYW4gYmUgZGVzaWduZWQKPiA+IHdpdGggcmVnaXN0ZXJzIGZvciBl
YWNoIHJlbGV2YW50IGJpdHN0cmVhbSBlbGVtZW50IHRvIGNvbmZpZ3VyZSB0aGUKPiA+IGRlY29k
aW5nIHBpcGVsaW5lLiBUaGF0J3MgaG93IEdQVS1iYXNlZCBkZWNvZGVyIGltcGxlbWVudGF0aW9u
cyBhcmUKPiA+IGltcGxlbWVudGVkIChWQUFQSS9WRFBBVS9OVkRFQywgZXRjKS4KPiA+Cj4gPiBT
byB0aGUgZm9ybWF0IHdlIGhhdmUgYWdyZWVkIG9uIHNvIGZhciBmb3IgdGhlIHN0YXRlbGVzcyBp
bnRlcmZhY2UgaXMKPiA+IHRvIHBhc3MgcGFyc2VkIGVsZW1lbnRzIHZpYSB2NGwyIGNvbnRyb2wg
c3RydWN0dXJlcy4KPiA+Cj4gPiBJZiB0aGUgaGFyZHdhcmUgY2FuIG9ubHkgd29yayBieSBwYXJz
aW5nIHRoZSBiaXRzdHJlYW0gaXRzZWxmLCBJJ20gbm90Cj4gPiBzdXJlIHdoYXQgdGhlIGJlc3Qg
c29sdXRpb24gd291bGQgYmUuIFJlY29uc3RydWN0aW5nIHRoZSBiaXRzdHJlYW0gaW4KPiA+IHRo
ZSBrZXJuZWwgaXMgYSBwcmV0dHkgYmFkIG9wdGlvbiwgYnV0IHNvIGlzIHBhcnNpbmcgaW4gdGhl
IGtlcm5lbCBvcgo+ID4gaGF2aW5nIHRoZSBkYXRhIGJvdGggaW4gcGFyc2VkIGFuZCByYXcgZm9y
bXMuIERvIHlvdSBzZWUgYW5vdGhlcgo+ID4gcG9zc2liaWxpdHk/Cj4gCj4gSXMgcmVjb25zdHJ1
Y3RpbmcgdGhlIGJpdHN0cmVhbSBzbyBiYWQ/IFRoZSB2NGwyIGNvbnRyb2xzIHByb3ZpZGUgYQo+
IGdlbmVyaWMgaW50ZXJmYWNlIHRvIGFuIGVuY29kZWQgZm9ybWF0IHdoaWNoIHRoZSBkcml2ZXIg
bmVlZHMgdG8KPiBjb252ZXJ0IGludG8gYSBzZXF1ZW5jZSB0aGF0IHRoZSBoYXJkd2FyZSBjYW4g
dW5kZXJzdGFuZC4gVHlwaWNhbGx5Cj4gdGhpcyBpcyBkb25lIGJ5IHBvcHVsYXRpbmcgaGFyZHdh
cmUtc3BlY2lmaWMgc3RydWN0dXJlcy4gQ2FuJ3Qgd2UKPiBjb25zaWRlciB0aGF0IGluIHRoaXMg
c3BlY2lmaWMgaW5zdGFuY2UsIHRoZSBoYXJkd2FyZS1zcGVjaWZpYwo+IHN0cnVjdHVyZSBqdXN0
IGhhcHBlbnMgdG8gYmUgaWRlbnRpY2FsIHRvIHRoZSBvcmlnaW5hbCBiaXRzdHJlYW0KPiBmb3Jt
YXQ/Cj4gCj4gSSBhZ3JlZSB0aGF0IHRoaXMgaXMgbm90IHN0cmljdGx5IG9wdGltYWwgZm9yIHRo
YXQgcGFydGljdWxhcgo+IGhhcmR3YXJlLCBidXQgc3VjaCBpcyB0aGUgY29zdCBvZiBhYnN0cmFj
dGlvbnMsIGFuZCBpbiB0aGlzIHNwZWNpZmljCj4gY2FzZSBJIGRvbid0IGJlbGlldmUgdGhlIGNv
c3Qgd291bGQgYmUgcGFydGljdWxhcmx5IGhpZ2g/CgpJIG1lYW4sIHRoYXQgYXJndW1lbnQgY2Fu
IGJlIG1hZGUgZm9yIHRoZSByb2NrY2hpcCBkcml2ZXIgYXMgd2VsbC4gSWYKcmVjb25zdHJ1Y3Rp
bmcgdGhlIGJpdHN0cmVhbSBpcyBzb21ldGhpbmcgd2UgY2FuIGRvLCBhbmQgaWYgd2UgZG9uJ3QK
Y2FyZSBhYm91dCBiZWluZyBzdWJvcHRpbWFsIGZvciBvbmUgcGFydGljdWxhciBoYXJkd2FyZSwg
dGhlbiB3aHkgdGhlCnJvY2tjaGlwIGRyaXZlciBkb2Vzbid0IGp1c3QgcmVjcmVhdGUgdGhlIGJp
dHN0cmVhbSBmcm9tIHRoYXQgQVBJPwoKQWZ0ZXIgYWxsLCB0aGlzIGlzIGp1c3QgYSBoYXJkd2Fy
ZSBzcGVjaWZpYyBoZWFkZXIgdGhhdCBoYXBwZW5zIHRvIGJlCmlkZW50aWNhbCB0byB0aGUgb3Jp
Z2luYWwgYml0c3RyZWFtIGZvcm1hdAoKTWF4aW1lCgotLSAKTWF4aW1lIFJpcGFyZCwgQm9vdGxp
bgpFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nCmh0dHBzOi8vYm9vdGxpbi5j
b20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
