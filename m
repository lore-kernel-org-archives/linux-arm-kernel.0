Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CAEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:34:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359DA20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GuVsjhBm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="Kk1vkqh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359DA20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XkqhTAuX27ZtGOB9xObS8MjxTocAnUznxbu1slrhOfc=; b=GuVsjhBmyqz3QU
	jzCSdKQPlGaGyPwBFX1G+Xfr9+S48mEiC3GbupyiW5AUqG9L7q6uLpf4rufnHWJ2W1j8aeKHcZd7y
	x1yChE+Ih3qBFR6GZNbauF36cHRNMKwdvTt8Vc8VgUXBBH94D8nEuQdOGBjoIv5jY6pbEK5NFRoWf
	hRDhlsufgcsVjAI8HtT2ZTC3J0tWrJ1RYvICTTOlzLyDy6zeFpCYXIXts+4xKXzK6IMrYADJogvPY
	LOQuR/Jc1Yz4E2ba8s18f5IMElSVHJyhb+9w9Ohl8zxjp2ba2+i3CVd2G4/ZG4JwctDqO+kDjhdOv
	6JRAZTJwBb3ciZhObKpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ0XK-0008II-7k; Mon, 17 Dec 2018 21:34:50 +0000
Received: from mail.nic.cz ([217.31.204.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ0XG-0008GX-K6
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 21:34:48 +0000
Received: from localhost (unknown [172.20.6.233])
 by mail.nic.cz (Postfix) with ESMTPS id CEE55601FB;
 Mon, 17 Dec 2018 22:34:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1545082473; bh=8d7f2T8gmoGdbmbuVrMD+gAx0cbRgRHlQgbYUy0eDeg=;
 h=Date:From:To;
 b=Kk1vkqh9c7p2YKhLb/jMnRyee7n1OBuyEsOAtLaPjb5MTL907NUo7Qgf9dYWcF/dY
 +uz30UiTJ9Rs4WzKSuSlURbTylK8KcSS6VsbTsVjz3mUtTuvvTT3ky50sNwRAmvRDh
 ZW7GXyq19o8YLUiXTyVnnjJ0jQmpJOwYZvJA8yLg=
Date: Mon, 17 Dec 2018 22:34:30 +0100
From: Marek Behun <marek.behun@nic.cz>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181217223430.182d01d8@nic.cz>
In-Reply-To: <20181217170724.58421a29@xps13>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-4-miquel.raynal@bootlin.com>
 <20181214014701.373b220b@nic.cz> <20181214015712.31f749ea@nic.cz>
 <20181217170724.58421a29@xps13>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_133446_816125_F456BC4B 
X-CRM114-Status: GOOD (  20.03  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TWlxdWVsLAoKSSB0cmllZCB0aGUgcGF0Y2hlcyBhbmQgdGhleSBhcmUgd29ya2luZywgd2l0aCB0
aGUgZXhjZXB0aW9uIG9mIENvbXBleApXTEU5MDBYIGNhcmQsIGJ1dCB3ZSBrbm93IHRoYXQgdGhp
cyBjYXJkIGlzIHByb2JsZW1hdGljLgpJIGFtIGludGVyZXN0aW5nIGlmIHRoZXJlIGlzIGEga25v
d24gd2F5IHRvIHR1cm4gb2YgdGhlIGNvbXBoeSBvbgpBMzcyMCwgb3IgYXQgbGVhc3QgY2hhbmdl
IHRoZSBTR01JSSBtb2RlIGZyb20gMUdicHMgdG8gMi41R2JwcyBhbmQKYmFjay4gTWFydmVsbCBk
b2N1bWVudGF0aW9uIGRvZXMgbm90IHByb3ZpZGUgdGhpcyBpbmZvcm1hdGlvbiBhbmQgdGhlCmNv
ZGUgaW4gQVRGIHByb3ZpZGluZyB0aGUgU01DIGNhbGxzIGRvZXMgbm90IGRvIHRoaXMgZWl0aGVy
LgpEbyB5b3Uga25vdyBob3cgdGhpcyBjYW4gYmUgYWNoaWV2ZWQ/ClRoYW5rcywKCk1hcmVrCgpP
biBNb24sIDE3IERlYyAyMDE4IDE3OjA3OjI0ICswMTAwCk1pcXVlbCBSYXluYWwgPG1pcXVlbC5y
YXluYWxAYm9vdGxpbi5jb20+IHdyb3RlOgoKPiBIaSBNYXJlaywKPiAKPiBNYXJlayBCZWh1biA8
bWFyZWsuYmVodW5AbmljLmN6PiB3cm90ZSBvbiBGcmksIDE0IERlYyAyMDE4IDAxOjU3OjEyCj4g
KzAxMDA6Cj4gCj4gPiBPbiBGcmksIDE0IERlYyAyMDE4IDAxOjQ3OjAxICswMTAwCj4gPiBNYXJl
ayBCZWh1biA8bWFyZWsuYmVodW5AbmljLmN6PiB3cm90ZToKPiA+ICAgCj4gPiA+IEhpIE1pcXVl
bCwKPiA+ID4gYXJlIHRoZXJlIGFscmVhZHkgcGF0Y2hlcyBmb3IgdGhlIEEzN3h4IGNvbXBoeSBk
cml2ZXI/ICAgIAo+IAo+IFBsZWFzZSB0cnkgdGhlIGxhdGVzdCBwYXRjaGVzIG9uIHRvcCBvZiBw
aHkgLW5leHQgKHdpdGggUEhZIGludGVyZmFjZQo+IG1vZGUpLCBhdmFpbGFibGUgdGhlcmUgWzFd
LiBZb3UgY2FuIHBpY2sgb25seSB0aGUgQ09NUEhZIHBhdGNoZXMsIGJ1dAo+IGtlZXAgdGhlbSBv
dmVyIHRoZSBwaHkgLW5leHQgYnJhbmNoLgo+IAo+IFBsZWFzZSBub3RlIHRoYXQgZm9yIHRoZSBT
TUMgY2FsbHMgdG8gc3VjY2VlZCB5b3UgbXVzdCB1c2UgYSByZWNlbnQKPiBBVEYuIFBlcnNvbmFs
bHkgSSB1c2VkIHRvIHdvcmsgd2l0aCB0aGUgJ2F0Zi12MS41LWRldmVsJyBicmFuY2ggb2YKPiBN
YXJ2ZWxsJ3MgbWlzbC1hdGYgcmVwb3NpdG9yeSBidXQgaXQgaXMgbm90IGF2YWlsYWJsZSBhbnlt
b3JlLiBJZiB5b3UKPiBhbHJlYWR5IGhhdmUgYSBjbG9uZSwgdGhlbiB5b3UgYXJlIGdvb2QgdG8g
Z28sIG90aGVyd2lzZSBpdCBtaWdodCBiZQo+IGdyZWF0IGlmIHNvbWVvbmUgZnJvbSBNYXJ2ZWxs
IGNvdWxkIHNoYXJlIGEgcHVibGljIEdpdGh1YiBsaW5rPwo+IAo+ID4gTmV2ZXIgbWluZCwgSSBm
b3VuZCB0aGVtLiBJIHNoYWxsIHRlc3QgdGhpcyBvbiBUdXJyaXMgTW94Lgo+ID4gSXMgdGhlIGNv
bXBoeSBkcml2ZXIgc3VwcG9zZWQgdG8gYmUgYWJsZSB0byBjaGFuZ2UgZXRoIG1vZGUgZnJvbQo+
ID4gMTAwMEJBU0UtWCB0byAyNTAwQkFTRS1YIGFuZCBiYWNrIHdpdGhvdXQgcmVib290PyAgCj4g
Cj4gSW4gdGhlb3J5IHllcywgdW5mb3J0dW5hdGVseSBJIGFtIHdvcmtpbmcgb24gYW4gRXNwcmVz
c29CaW4gd2hpY2ggdXNlcwo+IHRoZSBTQVRBLCBQQ0llIGFuZCBTQVRBIGNvbmZpZ3VyYXRpb25z
IG9mIHRoZSBDT01QSFksIGJ1dCBub3QgdGhlCj4gRXRoZXJuZXQgb25lcyAoU0dNSUkvMTAwMEJB
U0UtWCBhbmQgSFNfU0dNSUkvMjUwMEJBU0UtWCkuIFNvIHRoZQo+IHN1cHBvcnQgaXMgcmVhZHkg
dG8gYmUgdGVzdGVkIQo+IAo+ID4gCj4gPiBUaGlzIHdvdWxkIGJlIGNvb2wgZm9yIG91ciBTRlAg
Y2FnZSBtb2R1bGUgb2YgVHVycmlzIE1veCwganVzdCB0bwo+ID4gYWRkIHN1cHBvcnQgZm9yIGNv
bXBoeSBpbnRvIG12bmV0YS4KPiA+IAo+ID4gTWFyZWsgIAo+IAo+IFsxXSBodHRwczovL2dpdGh1
Yi5jb20vbWlxdWVscmF5bmFsL2xpbnV4LmdpdCBicmFuY2gKPiBtYXJ2ZWxsL3BoeS1uZXh0L3Bt
Cj4gCj4gCj4gVGhhbmtzLAo+IE1pcXXDqGwKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
