Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DBAC6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:22:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F0920866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JN77zs72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F0920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RvDQa7Ekv704fotZzlb+QF1Ej1hib7mBcDbYzXuUPME=; b=JN77zs72MyPnQs
	30RWafzk54Nu+iZe7WwN6q2tz1DWTkSN8S7Api9kCGN1VmWMfNfUJ17oxUJ59q2Ap/jPvCwil5plL
	JawTNV4If2UClXLlf0DRYZI+lyrpxY0fZJsMJ8ojEugWTrfDyGur+5gqcFgAEiRmbuPC9wGx7j41v
	vZSx2nFMmFpChPuhqy/mgphfPWSdtow1Vmsby9b3H6vSFk3BS/CQAc3rx8C+99kHTEwa30iL5D/WI
	jedpYvYGHGNg0pWkHFnxeJ+5V7zvQKeqRZ/1CWuxGK2yBxmh7WgDbynC2v/aXvfp78XaBdFL8LhaQ
	n3tlg2iSb/8znH73fSJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXjg3-0006xW-6O; Fri, 14 Dec 2018 09:22:35 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXjfy-0006wZ-KB
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 09:22:32 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gXjfg-00007T-GT; Fri, 14 Dec 2018 10:22:12 +0100
Message-ID: <1544779331.3137.36.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC
 instead
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>, Abel Vesa <abel.vesa@nxp.com>
Date: Fri, 14 Dec 2018 10:22:11 +0100
In-Reply-To: <20181214011207.GB13243@dragon>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
 <1544707047-4417-2-git-send-email-abel.vesa@nxp.com>
 <1544711727.3137.32.camel@pengutronix.de>
 <20181213145149.6hyyhi6hxdzvikl4@fsr-ub1664-175>
 <20181214011207.GB13243@dragon>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_012230_871405_1A2BD97D 
X-CRM114-Status: GOOD (  23.25  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU2hhd24sCgpBbSBGcmVpdGFnLCBkZW4gMTQuMTIuMjAxOCwgMDk6MTIgKzA4MDAgc2Nocmll
YiBTaGF3biBHdW86Cj4gT24gVGh1LCBEZWMgMTMsIDIwMTggYXQgMDI6NTE6NTBQTSArMDAwMCwg
QWJlbCBWZXNhIHdyb3RlOgo+IC4uLgo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L0tj
b25maWcucGxhdGZvcm1zCj4gPiA+ID4gYi9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zCj4g
PiA+ID4gaW5kZXggN2UxNTQ1YS4uMzE4ZGJiOSAxMDA2NDQKPiA+ID4gPiAtLS0gYS9hcmNoL2Fy
bTY0L0tjb25maWcucGxhdGZvcm1zCj4gPiA+ID4gKysrIGIvYXJjaC9hcm02NC9LY29uZmlnLnBs
YXRmb3Jtcwo+ID4gPiA+IEBAIC0xNDgsMTQgKzE0OCw2IEBAIGNvbmZpZyBBUkNIX01YQwo+ID4g
PiA+ID4gPiA+ID4gwqAJwqDCoFRoaXMgZW5hYmxlcyBzdXBwb3J0IGZvciB0aGUgQVJNdjggYmFz
ZWQgU29DcyBpbiB0aGUKPiA+ID4gPiA+ID4gPiA+IMKgCcKgwqBOWFAgaS5NWCBmYW1pbHkuCj4g
PiA+ID4gwqAKPiA+ID4gPiAtY29uZmlnIFNPQ19JTVg4TVEKPiA+ID4gPiA+ID4gPiA+IC0JYm9v
bCAiaS5NWDhNUSBzdXBwb3J0Igo+ID4gPiA+ID4gPiA+ID4gLQlkZXBlbmRzIG9uIEFSQ0hfTVhD
Cj4gPiA+ID4gPiA+ID4gPiAtCXNlbGVjdCBBUk02NF9FUlJBVFVNXzg0MzQxOQo+ID4gPiA+ID4g
PiA+ID4gLQlzZWxlY3QgQVJNNjRfRVJSQVRVTV84NDU3MTkKPiA+ID4gPiA+ID4gPiA+IC0JaGVs
cAo+ID4gPiA+ID4gPiA+ID4gLQnCoMKgVGhpcyBlbmFibGVzIHN1cHBvcnQgZm9yIHRoZSBpLk1Y
OE1RIFNvQy4KPiA+ID4gPiAtCj4gPiA+IAo+ID4gPiBOQUNLIG9uIHRoaXMgb25lLiBIYXZpbmcg
YSBzaW5nbGUgcGxhY2Ugd2hlcmUgc3R1ZmYgdGhhdCBpcyBhYnNvbHV0ZWx5Cj4gPiA+IGNyaXRp
Y2FsIGZvciBwcm9wZXIgU29DIG9wZXJhdGlvbiBjYW4gYmUgc2VsZWN0ZWQgaXMgdmVyeSB1c2Vm
dWwgYW5kCj4gPiA+IGF2b2lkcyBoYXJkIHRvIGRlYnVnIGlzc3VlcyBkdWUgdG8gc2xpZ2h0bHkg
d3JvbmcgY29uZmlncyBpbiB0aGUgbG9uZwo+ID4gPiBydW4uCj4gPiAKPiA+IEFzIG1lbnRpb25l
ZCBpbiB0aGUgY292ZXIgbGV0dGVyLCBwbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2ggc2V0IGVudGly
ZWx5Lgo+ID4gVGhlIEFSQ0hfTVhDIGlzIGFjdHVhbGx5IHVzZWQgb24gYXJtMzIgdG9vLCBzbyBp
dCB3b24ndCB3b3JrLgo+ID4gCj4gPiBJJ20gd29ya2luZyBvbiBhIHBhdGNoc2V0IHRoYXQgd2ls
bCBhZGQgdGhlIEtjb25maWcgaW50b8KgCj4gPiBkcml2ZXJzL2Nsay9pbXgvIGFuZCBpbiBpdCB3
aWxsIGFkZCBDTEtfSU1YOE1RLiBUaGF0IHdpbGwKPiA+IGZpeCB0aGUgY2xvY2sgZGVwZW5kZW5j
eSBzaW5jZSB0aGUgQ0xLX0lNWDhNUSB3aWxsIGRlcGVuZCBvbgo+ID4gQVJDSF9NWEMgYW5kIEFS
TTY0LiBJIGJlbGlldmUgdGhlIENMS19JTVg4UVhQIHdpbGwgZm9sbG93Cj4gPiB0aGUgc2FtZSBw
YXR0ZXJuLgo+ID4gCj4gPiBBcyBmb3IgdGhlIFNPQ19JTVg4TVEsIGFsbCB0aGUgb3RoZXIgdmVu
ZG9ycyBoYXZlIG9uZSBzaW5nbGUKPiA+IGNvbmZpZyBmb3IgYWxsIHRoZSBhcm02NCBwbGF0Zm9y
bXMuIFRCSCwgdG8gY29udHJvbCBldmVyeSBTb0MKPiA+IGluZGVwZW5kZW50bHkgaXQncyBhIGxp
dHRsZSBiaXQgb2YgYW4gb3ZlcmtpbGwuCj4gCj4gTHVjYXMsCj4gCj4gV2UgYXJlIHN0aWxsIHdh
aXRpbmcgZm9yIGZ1cnRoZXIgY29tbWVudHMgZnJvbSBPbG9mIFsxXS7CoMKgQnV0IGl0IHNvdW5k
cwo+IGxpa2UgU29DIHNwZWNpZmljIG9wdGlvbiBpcyBub3Qgd2VsY29tZWQgb24gQVJNNjQuCgpX
aGlsZSBJIHBlcnNvbmFsbHkgd291bGQgcHJlZmVyIHRvIGtlZXAgdGhlIFNvQyBvcHRpb25zLCBJ
IHNlZSB0aGF0IHdlCm5lZWQgdG8gYWxpZ24gd2l0aCB0aGUganVkZ21lbnQgb2YgdGhlIGFybS1z
b2MgbWFpbnRhaW5lcnMuCgpCdXQgYXQgdGhlIHZlcnkgbGVhc3Qgd2Ugc2hvdWxkIGtlZXAgdGhl
IHNlbGVjdCBmb3Igdml0YWwgc3lzdGVtCndvcmthcm91bmRzLiBUaGV5IG5lZWQgdG8gbW92ZSB0
byB0aGUgYXJjaCBLY29uZmlnIHN5bWJvbCBpbiB0aGF0IGNhc2UKYW5kIG1pZ2h0IHNlbGVjdCBz
dHVmZiB0aGF0IGlzbid0IG5lZWRlZCBvbiBlYWNoIG9mIHRoZSBpLk1YOCBTb0NzLiBCdXQKYmV0
dGVyIGVuYWJsaW5nIG1vcmUgd29ya2Fyb3VuZCBhbmQgZHJpdmVycyB0aGFuIG5lY2Vzc2FyeSB0
aGFuIGhhdmluZwpoYXJkIHRvIGRlYnVnIHN5c3RlbSBmYWlsdXJlcyBpbiB0aGUgZnV0dXJlLgoK
UmVnYXJkcywKTHVjYXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
