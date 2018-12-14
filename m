Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE631C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:16:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FEA2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W81+opRi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow/ASwOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FEA2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bdNyodtyFTI0H8DVBwonMYqlB7JeZyx2adzkibpJudU=; b=W81+opRihRkJl5
	L+ohySQZp3E2xoKRP8Tl5RM6B7/wHMl9LGzylZLpCPVAzfOyh+iwnZfT/F8ZnwhebcKw/H246Nui4
	GJzByFPgugH/RgJgSaJi8kzLNU7GqzTIeJLvq4QU2t4Qx4EYv0DxgFBaBWqt/NGNnAPEOw+75Vod2
	QD4vUACJmevVBFR0/1KpaDm9gKbBA/YAmEwOdyboyyodfWwmf61btXV9R3ZTOt3aXeA0AxzmYHh+6
	a0CbqdeNT4GwKHoduNhWRUQ6Pg1pqkorvmk/BmyfZ4XlMliOJ3hGz2VitwTJYPloFfSRgux1qH5cu
	aHrCPcaDAlM+1P/PTcaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXr4T-0002Fw-76; Fri, 14 Dec 2018 17:16:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXr4P-0002EO-7H
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 17:16:14 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C18AF206DD;
 Fri, 14 Dec 2018 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544807763;
 bh=ySFlzq5RjV08D0LJcC5AwZ6G1xf3mFqoVIv4qlhNNmM=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=Ow/ASwOosmXhefebjh04Lye50s8P5Wz0971HNukWKwnrcz9p40voQDBSeFQtcGHHj
 HRwVxmh/XdryZD8DfY+B35UhBVNfbhsp4KVC1PrNkxxoDqA9X1omGE/metCXDEGQlc
 cePgdb85M+aJgtnTYz6PJ5eDBkGQJpa7zpLCqcnI=
MIME-Version: 1.0
In-Reply-To: <20181214124145.dbtx6z3itwepsuwb@fsr-ub1664-175>
Subject: Re: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC
 instead
To: Abel Vesa <abel.vesa@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
 <1544707047-4417-2-git-send-email-abel.vesa@nxp.com>
 <1544711727.3137.32.camel@pengutronix.de>
 <20181213145149.6hyyhi6hxdzvikl4@fsr-ub1664-175>
 <20181214011207.GB13243@dragon> <1544779331.3137.36.camel@pengutronix.de>
 <20181214124145.dbtx6z3itwepsuwb@fsr-ub1664-175>
Message-ID: <154480776200.19322.2879096818180669421@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Fri, 14 Dec 2018 09:16:02 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_091613_298369_14722978 
X-CRM114-Status: GOOD (  29.40  )
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
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>, Shawn Guo <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UXVvdGluZyBBYmVsIFZlc2EgKDIwMTgtMTItMTQgMDQ6NDE6NDYpCj4gT24gMTgtMTItMTQgMTA6
MjI6MTEsIEx1Y2FzIFN0YWNoIHdyb3RlOgo+ID4gSGkgU2hhd24sCj4gPiAKPiA+IEFtIEZyZWl0
YWcsIGRlbiAxNC4xMi4yMDE4LCAwOToxMiArMDgwMCBzY2hyaWViIFNoYXduIEd1bzoKPiA+ID4g
T24gVGh1LCBEZWMgMTMsIDIwMTggYXQgMDI6NTE6NTBQTSArMDAwMCwgQWJlbCBWZXNhIHdyb3Rl
Ogo+ID4gPiAuLi4KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvS2NvbmZpZy5w
bGF0Zm9ybXMKPiA+ID4gPiA+ID4gYi9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zCj4gPiA+
ID4gPiA+IGluZGV4IDdlMTU0NWEuLjMxOGRiYjkgMTAwNjQ0Cj4gPiA+ID4gPiA+IC0tLSBhL2Fy
Y2gvYXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMKPiA+ID4gPiA+ID4gKysrIGIvYXJjaC9hcm02NC9L
Y29uZmlnLnBsYXRmb3Jtcwo+ID4gPiA+ID4gPiBAQCAtMTQ4LDE0ICsxNDgsNiBAQCBjb25maWcg
QVJDSF9NWEMKPiA+ID4gPiA+ID4gPiA+ID4gPiDCoCAgICAgwqDCoFRoaXMgZW5hYmxlcyBzdXBw
b3J0IGZvciB0aGUgQVJNdjggYmFzZWQgU29DcyBpbiB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiDC
oCAgICAgwqDCoE5YUCBpLk1YIGZhbWlseS4KPiA+ID4gPiA+ID4gwqAKPiA+ID4gPiA+ID4gLWNv
bmZpZyBTT0NfSU1YOE1RCj4gPiA+ID4gPiA+ID4gPiA+ID4gLSAgICAgYm9vbCAiaS5NWDhNUSBz
dXBwb3J0Igo+ID4gPiA+ID4gPiA+ID4gPiA+IC0gICAgIGRlcGVuZHMgb24gQVJDSF9NWEMKPiA+
ID4gPiA+ID4gPiA+ID4gPiAtICAgICBzZWxlY3QgQVJNNjRfRVJSQVRVTV84NDM0MTkKPiA+ID4g
PiA+ID4gPiA+ID4gPiAtICAgICBzZWxlY3QgQVJNNjRfRVJSQVRVTV84NDU3MTkKPiA+ID4gPiA+
ID4gPiA+ID4gPiAtICAgICBoZWxwCj4gPiA+ID4gPiA+ID4gPiA+ID4gLSAgICAgwqDCoFRoaXMg
ZW5hYmxlcyBzdXBwb3J0IGZvciB0aGUgaS5NWDhNUSBTb0MuCj4gPiA+ID4gPiA+IC0KPiA+ID4g
PiA+IAo+ID4gPiA+ID4gTkFDSyBvbiB0aGlzIG9uZS4gSGF2aW5nIGEgc2luZ2xlIHBsYWNlIHdo
ZXJlIHN0dWZmIHRoYXQgaXMgYWJzb2x1dGVseQo+ID4gPiA+ID4gY3JpdGljYWwgZm9yIHByb3Bl
ciBTb0Mgb3BlcmF0aW9uIGNhbiBiZSBzZWxlY3RlZCBpcyB2ZXJ5IHVzZWZ1bCBhbmQKPiA+ID4g
PiA+IGF2b2lkcyBoYXJkIHRvIGRlYnVnIGlzc3VlcyBkdWUgdG8gc2xpZ2h0bHkgd3JvbmcgY29u
ZmlncyBpbiB0aGUgbG9uZwo+ID4gPiA+ID4gcnVuLgo+ID4gPiA+IAo+ID4gPiA+IEFzIG1lbnRp
b25lZCBpbiB0aGUgY292ZXIgbGV0dGVyLCBwbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2ggc2V0IGVu
dGlyZWx5Lgo+ID4gPiA+IFRoZSBBUkNIX01YQyBpcyBhY3R1YWxseSB1c2VkIG9uIGFybTMyIHRv
bywgc28gaXQgd29uJ3Qgd29yay4KPiA+ID4gPiAKPiA+ID4gPiBJJ20gd29ya2luZyBvbiBhIHBh
dGNoc2V0IHRoYXQgd2lsbCBhZGQgdGhlIEtjb25maWcgaW50b8KgCj4gPiA+ID4gZHJpdmVycy9j
bGsvaW14LyBhbmQgaW4gaXQgd2lsbCBhZGQgQ0xLX0lNWDhNUS4gVGhhdCB3aWxsCj4gPiA+ID4g
Zml4IHRoZSBjbG9jayBkZXBlbmRlbmN5IHNpbmNlIHRoZSBDTEtfSU1YOE1RIHdpbGwgZGVwZW5k
IG9uCj4gPiA+ID4gQVJDSF9NWEMgYW5kIEFSTTY0LiBJIGJlbGlldmUgdGhlIENMS19JTVg4UVhQ
IHdpbGwgZm9sbG93Cj4gPiA+ID4gdGhlIHNhbWUgcGF0dGVybi4KPiA+ID4gPiAKPiA+ID4gPiBB
cyBmb3IgdGhlIFNPQ19JTVg4TVEsIGFsbCB0aGUgb3RoZXIgdmVuZG9ycyBoYXZlIG9uZSBzaW5n
bGUKPiA+ID4gPiBjb25maWcgZm9yIGFsbCB0aGUgYXJtNjQgcGxhdGZvcm1zLiBUQkgsIHRvIGNv
bnRyb2wgZXZlcnkgU29DCj4gPiA+ID4gaW5kZXBlbmRlbnRseSBpdCdzIGEgbGl0dGxlIGJpdCBv
ZiBhbiBvdmVya2lsbC4KPiA+ID4gCj4gPiA+IEx1Y2FzLAo+ID4gPiAKPiA+ID4gV2UgYXJlIHN0
aWxsIHdhaXRpbmcgZm9yIGZ1cnRoZXIgY29tbWVudHMgZnJvbSBPbG9mIFsxXS7CoMKgQnV0IGl0
IHNvdW5kcwo+ID4gPiBsaWtlIFNvQyBzcGVjaWZpYyBvcHRpb24gaXMgbm90IHdlbGNvbWVkIG9u
IEFSTTY0Lgo+ID4gCj4gPiBXaGlsZSBJIHBlcnNvbmFsbHkgd291bGQgcHJlZmVyIHRvIGtlZXAg
dGhlIFNvQyBvcHRpb25zLCBJIHNlZSB0aGF0IHdlCj4gPiBuZWVkIHRvIGFsaWduIHdpdGggdGhl
IGp1ZGdtZW50IG9mIHRoZSBhcm0tc29jIG1haW50YWluZXJzLgo+ID4gCj4gPiBCdXQgYXQgdGhl
IHZlcnkgbGVhc3Qgd2Ugc2hvdWxkIGtlZXAgdGhlIHNlbGVjdCBmb3Igdml0YWwgc3lzdGVtCj4g
PiB3b3JrYXJvdW5kcy4gVGhleSBuZWVkIHRvIG1vdmUgdG8gdGhlIGFyY2ggS2NvbmZpZyBzeW1i
b2wgaW4gdGhhdCBjYXNlCj4gPiBhbmQgbWlnaHQgc2VsZWN0IHN0dWZmIHRoYXQgaXNuJ3QgbmVl
ZGVkIG9uIGVhY2ggb2YgdGhlIGkuTVg4IFNvQ3MuIEJ1dAo+ID4gYmV0dGVyIGVuYWJsaW5nIG1v
cmUgd29ya2Fyb3VuZCBhbmQgZHJpdmVycyB0aGFuIG5lY2Vzc2FyeSB0aGFuIGhhdmluZwo+ID4g
aGFyZCB0byBkZWJ1ZyBzeXN0ZW0gZmFpbHVyZXMgaW4gdGhlIGZ1dHVyZS4KCkNQVSBlcnJhdGFz
IGFyZSB0eXBpY2FsbHkgaW1wbGVtZW50ZWQgd2l0aCBydW50aW1lIGNvZGUgcGF0Y2hpbmcgYW5k
CnRoZXkncmUgcHJldHR5IG11Y2ggYWxsICdkZWZhdWx0IHknIHNvIGhhdmluZyB0aGUgU29DIGNv
bmZpZyBvcHRpb24Kc2VsZWN0IHRoZW0gZG9lc24ndCBkbyBtdWNoIGJlc2lkZXMgZm9yY2UgdGhl
IGVycmF0YSB0byBhbHdheXMgYmUKZW5hYmxlZC4gSWYgYWxsb3dpbmcgdGhlIHVzZXIgdG8gZGlz
YWJsZSBlcnJhdGEgaGFuZGxpbmcgaXMgYSBwcm9ibGVtLAp0aGVuIHBlcmhhcHMgdGhvc2Ugc2hv
dWxkIG9ubHkgYmUgdmlzaWJsZSB3aGVuIENPTkZJR19FWFBFUlQ9eS4KCj4gPiAKPiAKPiBJIGdl
dCB5b3VyIHBvaW50LiBCdXQgdGhhdCBzZWVtcyB0byBiZSBhbiBpc3N1ZSB3aXRoIHRoZSB3aG9s
ZSBhcm02NCBhcHByb2FjaC4KPiBUQkgsIEkgYmVsaWV2ZSBub3cgd291bGQgYmUgdGhlIHBlcmZl
Y3QgdGltZSB0byAiZ2V0IGl0IHJpZ2h0IiBvbiBJTVggc2luY2UgdGhlIDhNUQo+IGlzIHRoZSBm
aXJzdCBvbmUgdG8gZ2V0IGJvb3QtdXAgc3VwcG9ydCB1cHN0cmVhbS4gSXQgd2lsbCBiZSB3YXkg
bXVjaCBoYXJkZXIKPiB0byBjaGFuZ2UgdGhpcyBsYXRlciB3aGVuIG1vcmUgYXJtNjQgSU1YIFNv
Q3MgZ2V0IHVwc3RyZWFtZWQuCj4gCj4gSSB3b3VsZCByZWFsbHkgbG92ZSBtb3JlIG9waW5pb25z
IG9uIHRoaXMuCj4gCj4gSSBoYXZlIHBhdGNoZXMgb24gc3RhbmQtYnkgdGhhdCByZW1vdmUgdGhl
IFNPQ19JTVg4TVEgaW4gYWxsIHRoZSBzdWJzeXN0ZW1zIGFuZAo+IGEgcGF0Y2ggZm9yIHRoZSBk
ZWZjb25maWcgdXBkYXRlIHdoaWNoIEknbGwga2VlcCBvbiBob2xkaW5nIG9uIHRvIHVudGlsIHRo
ZXJlCj4gaXMgYSBhZ3JlZW1lbnQgb24gdGhpcy4KPiAKCkkgd2lsbCBtZXJnZSB0aGUgY2xrIHBh
dGNoIG5vdy4gSG9wZSB0aGF0IGhlbHBzIHlvdSBmZWVsIG1vcmUgY29uZmlkZW50CnRoYXQgQ09O
RklHX1NPQ19GT08gb3B0aW9ucyBhcmVuJ3Qgd2VsY29tZS4KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
