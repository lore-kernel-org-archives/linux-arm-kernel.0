Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88668C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:13:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57287206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KWYX69wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57287206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=avj5WmtdjEVRsjFZpl4UWsRUY3jvco1TucYezmen8gU=; b=KWYX69wqXGEWK9
	fgqA0msd65RW54kl7lijnWfmtkFeAkSDC4UrNGQtHHEkFKJVheLr54o5OiGzHaZl2EP04GOq9E7dx
	cfFc9olmjy5loLMzatwnuzZT0mUrcttPgRhaRW6ayd7LaL2NzdRZqu9fd6x0gCxOBUrkWsDNlgNJQ
	tDEuDHQ8VzZiPx95K8IiEN+Mwh0KJSTVmyP4/l2yibchWwjg6vi7Fmgz5we1A7KCR96MEcuiOA3ke
	keYCG7iU+qwfk8ON7dbv5ZUztAqVSPZkLGcFXzl6jMnJJDQcFYpUoVTAY51wIwG2/mQHG5mwh88TE
	WW/9M19bW8FskbjOA4dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYptm-0001Z3-VL; Mon, 17 Dec 2018 10:13:18 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYptj-0001Wz-K1
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 10:13:17 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gYptT-00015H-EZ; Mon, 17 Dec 2018 11:12:59 +0100
Message-ID: <1545041578.5874.3.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/3] PCIE support for i.MX8MQ
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, helgaas@kernel.org
Date: Mon, 17 Dec 2018 11:12:58 +0100
In-Reply-To: <CAHQ1cqG3s4J42V3oUPOGssUPw6dypZqYrtpkRphHPdiYFs9j1g@mail.gmail.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206121550.GA2725@e107981-ln.cambridge.arm.com>
 <20181214203828.GD20725@google.com>
 <CAHQ1cqG3s4J42V3oUPOGssUPw6dypZqYrtpkRphHPdiYFs9j1g@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_021315_815580_2E32A2B8 
X-CRM114-Status: GOOD (  20.57  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 lorenzo.pieralisi@arm.com, Richard Zhu <hongxing.zhu@nxp.com>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Trent Piepho <tpiepho@impinj.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRnJlaXRhZywgZGVuIDE0LjEyLjIwMTgsIDIxOjI1IC0wODAwIHNjaHJpZWIgQW5kcmV5IFNt
aXJub3Y6Cj4gPiBPbiBGcmksIERlYyAxNCwgMjAxOCBhdCAxMjozOCBQTSBCam9ybiBIZWxnYWFz
IDxoZWxnYWFzQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gCj4gPiBbK2NjIFRyZW50XQo+ID4gCj4g
PiBPbiBUaHUsIERlYyAwNiwgMjAxOCBhdCAxMjoxNTo1MFBNICswMDAwLCBMb3JlbnpvIFBpZXJh
bGlzaSB3cm90ZToKPiA+ID4gT24gV2VkLCBEZWMgMDUsIDIwMTggYXQgMTE6MzU6NDJQTSAtMDgw
MCwgQW5kcmV5IFNtaXJub3Ygd3JvdGU6Cj4gPiA+ID4gRXZlcnlvbmU6Cj4gPiA+ID4gCj4gPiA+
ID4gVGhpcyBzZXJpZXMgY29udGFpbnMgY2hhbmdlcyBJIG1hZGUgaW4gb3JkZXIgdG8gZW5hYmxl
IHN1cHBvcnQgb2YgUENJRQo+ID4gPiA+IElQIGJsb2NrIG9uIGkuTVg4TVEgU29DcyAoZnVsbCB0
cmVlIGNhbiBiZSBmb3VuZCBhdCBbZ2l0aHViLXYyXSkuCj4gPiA+ID4gCj4gPiA+ID4gTk9URTog
VGhlIGxhc3QgcGF0Y2ggaGF2ZSBhIEtjb25maWcgc3ltYm9sIGRlcGVuZW5jeSBvbiBbaW14OG1x
LWtjb25maWddLgo+ID4gPiA+IAo+ID4gPiA+IENoYW5nZXMgc2luY2UgW3YxXToKPiA+ID4gPiAK
PiA+ID4gPiDCoC0gRHJpdmVyIGNoYW5nZWQgdG8gdXNlIHNpbmdsZSAiZnNsLGNvbnRyb2xsZXIt
aWQiIHByb3BlcnR5IHRvCj4gPiA+ID4gwqDCoMKgZGlzdGluZ3Vpc2ggYmV0d2VlbiB0d28gaW50
YW5jZXMgb2YgUENJRSBJUCBibG9jawo+ID4gPiA+IAo+ID4gPiA+IMKgLSBBbGwgY29kZSBwZXJ0
YWluaW5nIHRvIEwxU1Mgd2FzIGRyb3BwZWQgdG8gc2ltcGxpZnkgdGhlIHBhdGNoCj4gPiA+ID4g
Cj4gPiA+ID4gwqAtIERvY3VtZW50ZWQgYWRkaXRpb25zIHRvIERUIGJpbmRpbmdzCj4gPiA+ID4g
Cj4gPiA+ID4gRmVlZGJhY2sgaXMgd2VsY29tZSEKPiA+ID4gPiAKPiA+ID4gPiBUaGFua3MsCj4g
PiA+ID4gQW5kcmV5IFNtaXJub3YKPiA+ID4gCj4gPiA+IEFuZHJleSwKPiA+ID4gCj4gPiA+IEkg
aGF2ZSBhcHBsaWVkIHRoZSBwYXRjaGVzLCAuLi4KPiA+IAo+ID4gV2hlbiBJIG1lcmdlZCB5b3Vy
IHBjaS9kd2MgYnJhbmNoLCBJIG5vdGljZWQgd2hhdCBsb29rcyBsaWtlIGEgbWVyZ2UKPiA+IGNv
bmZsaWN0IGJldHdlZW4gdGhlc2UgY29tbWl0czoKPiA+IAo+ID4gwqAgZDEyMzc2NWI1OGVlICgi
UENJOiBkd2M6IEFkanVzdCBLY29uZmlnIHRvIGFsbG93IElNWDYgUENJZSBob3N0IG9uIElNWDci
KQo+ID4gwqAgMWEwNTlkOTk0MTg5ICgiUENJOiBpbXg6IEFkZCBzdXBwb3J0IGZvciBpLk1YOE1R
IikKPiA+IAo+ID4gZDEyMzc2NWI1OGVlIGFkZGVkIFNPQ19JTVg3RDoKPiA+IAo+ID4gwqAgLcKg
wqDCoMKgwqDCoMKgZGVwZW5kcyBvbiBTT0NfSU1YNlEgfHwgKEFSTSAmJiBDT01QSUxFX1RFU1Qp
Cj4gPiDCoCArwqDCoMKgwqDCoMKgwqBkZXBlbmRzIG9uIFNPQ19JTVg2USB8fCBTT0NfSU1YN0Qg
fHwgKEFSTSAmJiBDT01QSUxFX1RFU1QpCj4gPiAKPiA+IGFuZCAxYTA1OWQ5OTQxODkgYWRkZWQg
U09DX0lNWDhNUSBidXQgZHJvcHBlZCBTT0NfSU1YN0QgYWdhaW4sIHdoaWNoIGxvb2tzCj4gPiBs
aWtlIGEgbWlzdGFrZToKPiA+IAo+ID4gwqAgLcKgwqDCoMKgwqDCoMKgZGVwZW5kcyBvbiBTT0Nf
SU1YNlEgfHwgU09DX0lNWDdEIHx8IChBUk0gJiYgQ09NUElMRV9URVNUKQo+ID4gwqAgK8KgwqDC
oMKgwqDCoMKgZGVwZW5kcyBvbiBTT0NfSU1YOE1RIHx8IFNPQ19JTVg2USB8fCAoQVJNICYmIENP
TVBJTEVfVEVTVCkKPiA+IAo+ID4gU28gbXkgIm5leHQiIGJyYW5jaFsxXSAoY3VycmVudCBoZWFk
IDcwNTNlZWIwMDllMCkgaXM6Cj4gPiAKPiA+IMKgIGNvbmZpZyBQQ0lfSU1YNgo+ID4gwqDCoMKg
wqDCoMKgwqDCoGJvb2wgIkZyZWVzY2FsZSBpLk1YNi83IFBDSWUgY29udHJvbGxlciIKPiA+IMKg
wqDCoMKgwqDCoMKgwqBkZXBlbmRzIG9uIFNPQ19JTVg4TVEgfHwgU09DX0lNWDZRIHx8IChBUk0g
JiYgQ09NUElMRV9URVNUKQo+ID4gwqDCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gUENJX01TSV9J
UlFfRE9NQUlOCj4gPiDCoMKgwqDCoMKgwqDCoMKgc2VsZWN0IFBDSUVfRFdfSE9TVAo+ID4gCj4g
PiB3aGljaCBJIHRoaW5rIGlzIHdyb25nLgo+IAo+IFllYWgsIHRoaXMgaXMgZGVmaW5pdGVseSB3
cm9uZywgc2hvdWxkIGJlIFNPQ19JTVg4TVEgfHwgU09DX0lNWDZRIHx8Cj4gU09DX0lNWDdEIHx8
IChBUk0gJiYgQ09NUElMRV9URVNUKQoKYXJtLXNvYyB3b3VsZCBsaWtlIHRvIHNlZSB0aGUgU09D
X0lNWDhNUSBvcHRpb24gcmVtb3ZlZCwgc28gbGV0J3MgdHJ5CnRvIG5vdCBhZGQgYW55IG1vcmUg
dGhpbmdzIHRoYXQgZGVwZW5kIG9uIHRoaXMuIFBsZWFzZSB1c2UgKEFSTTY0ICYmCk1BQ0hfTVhD
KSBvciBzb21ldGhpbmcgdG8gdGhhdCB0dW5lIGluc3RlYWQuCgpSZWdhcmRzLApMdWNhcwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
