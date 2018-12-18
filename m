Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:42:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072A521841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YTHmXtkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072A521841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v0RXZj0jxyGqx7dS96aIIEvVwmGXYig3RmApezcfIIw=; b=YTHmXtkUpj9q/e
	af50aiDGFi8FIo4mXDecU9aBEOyBsXnKfXEWraLsMznnljNEzIgDj/rlYwj+hGDaZNOArP8qjBIHV
	n6vYswKf6QVqxbowxiOQ9zPf3wZbgpC624LsB84I0d8jLk2KZpsP+QrJ/97Vrh1iwhX0aJAKLFIO3
	Xg9clsG5YEjxTGe2yYUV/xrBxbcdV4NudSrlW/O24HdW4j8403qef9/fgyqONDT4hFrkGOZ805Vhf
	wrmUhY1OmVeJPipCKfvFFbo2je3voeAYIhVWU/wY0cdmrhY8YyT3605YkRAOqpCqwL8wZxPauovw6
	TUXn7owqTEj3p2m2N4PQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZFdP-0002sS-SE; Tue, 18 Dec 2018 13:42:07 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZFdM-0002VL-Td
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 13:42:06 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gZFd3-0007BL-DD; Tue, 18 Dec 2018 14:41:45 +0100
Message-ID: <1545140504.5874.25.camel@pengutronix.de>
Subject: Re: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
From: Lucas Stach <l.stach@pengutronix.de>
To: Anson Huang <anson.huang@nxp.com>
Date: Tue, 18 Dec 2018 14:41:44 +0100
In-Reply-To: <7E78DD25-BA90-4EBA-81B9-755CD89BD0BF@nxp.com>
References: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com>
 ,<1545129634.5874.20.camel@pengutronix.de>
 <7E78DD25-BA90-4EBA-81B9-755CD89BD0BF@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_054205_124876_79F8CBD4 
X-CRM114-Status: GOOD (  18.07  )
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
Cc: "sboyd@kernel.org" <sboyd@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQW5zb24sCgpBbSBEaWVuc3RhZywgZGVuIDE4LjEyLjIwMTgsIDEzOjM1ICswMDAwIHNjaHJp
ZWIgQW5zb24gSHVhbmc6Cj4gSGksIEx1Y2FzCj4gCj4gRnJvbSBBbnNvbidzIGlQaG9uZSA2Cj4g
Cj4gCj4gPiDlnKggMjAxOOW5tDEy5pyIMTjml6XvvIwxODo0MO+8jEx1Y2FzIFN0YWNoIDxsLnN0
YWNoQHBlbmd1dHJvbml4LmRlPiDlhpnpgZPvvJoKPiA+IAo+ID4gQW0gRGllbnN0YWcsIGRlbiAx
OC4xMi4yMDE4LCAwODoyNCAtMDIwMCBzY2hyaWViIEZhYmlvIEVzdGV2YW06Cj4gPiA+IEhpIEFu
c29uLAo+ID4gPiAKPiA+ID4gT24gVHVlLCBEZWMgMTgsIDIwMTggYXQgMTI6NTYgQU0gQW5zb24g
SHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20KPiA+ID4gPgo+ID4gPiB3cm90ZToKPiA+ID4gPiAK
PiA+ID4gPiBPbiBpLk1YOE0sIHNvbWUgb2YgdGhlIGJ1cyBjbG9ja3MnIHJhdGUgY291bGQgYmUg
Y2hhbmdlZCBpbiBURi0KPiA+ID4gPiBBLAo+ID4gPiAKPiA+ID4gRG8geW91IG1lYW4gQVRGIChB
Uk0gVHJ1c3RlZCBGaXJtd2FyZSkgaW5zdGVhZD8KPiA+IAo+ID4gVEYtQSBpcyB0aGUgbmFtZSBv
ZiB0aGUgZGF5IGZvciB3aGF0IHdhcyBmb3JtZXJseSBrbm93biBhcyBBVEYuLi4KPiA+IAo+ID4g
SG93ZXZlciBJIGRvbid0IHRoaW5rIHRoYXQgaXQncyBjb3JyZWN0IHRvIGp1c3QgZG9uJ3QgY2Fj
aGUgdGhlCj4gPiBjbG9jawo+ID4gc2V0dGluZ3MuIE5vcm1hbGx5IHRoZSBzZWN1cmUgd29ybGQg
ZmlybXdhcmUgc2hvdWxkIG5vdCBjaGFuZ2UgYW55Cj4gPiBjbG9jayBzZXR0aW5ncyBhdCBydW50
aW1lLCBvciBpdCB3b3VsZCBydW4gaW50byBhbGwga2luZHMgb2YKPiA+IGNvbmZsaWN0cwo+ID4g
d2l0aCB0aGUgY2xvY2sgZHJpdmVyLiBTbyB0aGVyZSBhcmUgcHJvYmFibHkgc29tZSB3ZWxsIGtu
b3duIHBvaW50cwo+ID4gaW4KPiA+IHRpbWUgbGlrZSBhIHN1c3BlbmQgb3IgcmVzdW1lIGV2ZW50
IHdoZW4gdGhlIGZpcm13YXJlIG1pZ2h0IGNoYW5nZQo+ID4gY2xvY2sgc2V0dGluZ3MsIHNvIHdl
IGNvdWxkIGluc3RlYWQgdXNlIHRob3NlIHRvIHRyaWdnZXIgYW4KPiA+IGV4cGxpY2l0Cj4gPiBp
bnZhbGlkYXRlIG9mIHRoZSBjbG9jayBjYWNoZXMgd2l0aCBtdWNoIGxvd2VyIG92ZXJoZWFkLgo+
ID4gCj4gPiBSZWdhcmRzLAo+ID4gTHVjYXMKPiAKPiBUaGVyZSBpcyBidXMtZnJlcSBmZWF0dXJl
IG9uIGlteDhtIHdoaWNoIGlzIHRvIHNjYWxlIGRkciBjbG9jaywgdGhpcwo+IGlzIGRvbmUgaW4g
QVJNIFRydXN0ZWQgRmlybXdhcmUsIGZvciBzb21lIHNldHBvaW50cywgdGhlIEREUiBQTEwKPiBj
bG9jayByYXRlIG11c3QgYmUgY2hhbmdlZCBkaXJlY3RseSBpbiBURi1BLCBidXQgaXRzIGNoaWxk
IGNsb2NrIGxpa2UKPiBkcmFtIGNvcmUgaXMgdW5hd2FyZSBpbiBMaW51eCBrZXJuZWwsIHNvIHRo
ZSBjbG9jayByYXRlIHdpbGwgbWlzbWF0Y2gKPiB3aXRoIGhhcmR3YXJlLCBzaW5jZSBkZHIgcmVs
YXRlZCBjbG9ja3Mgd2lsbCBOT1QgdXNlZCBieSBhbnkgbW9kdWxlCj4gaW4gTGludXgga2VybmVs
LCBzbyBpdCB3aWxsIE5PVCBpbnRyb2R1Y2UgYW55IGNvbmZsaWN0LgoKSSBkb24ndCB0aGluayB0
aGVyZSBpcyBhbnl0aGluZyBpbXBsZW1lbnRpbmcgdGhlIGJ1cyBmcmVxdWVuY3kgc2NhbGluZwpp
biBtYWlubGluZSwgcmlnaHQ/Cgo+IFJlZ2FyZGluZyBhYm91dCB0aGUgb3ZlciBoZWFkLCB5ZXMs
IHRoZSBjaGFuZ2UgaW4gY29tbW9uIGNvbXBvc2l0ZQo+IGNsb2NrIHJlZ2lzdGVyIGhhcyB0b28g
bWFueSBvdmVyIGhlYWQgZm9yIG90aGVyIGNsb2Nrcywgd2hhdCBpZiBJCj4gT05MWSBoYXZlIGRy
YW0gY29yZSBjbG9jayB0byBwYXNzIHRoZSBDTEtfR0VUX1JBVEVfTk9DQUNIRSBmbGFnIHRvCj4g
cmVnaXN0ZXIgdGhlIGNvbXBvc2l0ZSBjbG9jaz8KCklNSE8gbWFya2luZyBjbG9ja3MgdW5kZXIg
VEYtQSBjb250cm9sIGV4cGxpY2l0bHkgYXMgbm9jYWNoZSB3b3VsZCBiZQptdWNoIG1vcmUgYWNj
ZXB0YWJsZSB0aGFuIGRvaW5nIGl0IGZvciBldmVyeSBjb21wb3NpdGUgY2xvY2suIFRoaXMKc2Vl
bXMgb2theSBmb3IgYSBzaG9ydCB0ZXJtIHNvbHV0aW9uLgoKU3RpbGwgSSB0aGluayB0aGF0IHdo
YXRldmVyIGlzIGNhdXNpbmcgdGhlIGJ1cyBmcmVxdWVuY3kgc2NhbGUgdG8KY2hhbmdlIHNob3Vs
ZCBoYXZlIGEgd2F5IHRvIGV4cGxpY2l0bHkgaW52YWxpZGF0ZSB0aGUgY2xvY2sgY2FjaGUgZm9y
CnRoZSBhZmZlY3RlZCBjbG9ja3MgZXZlbnR1YWxseS4KClJlZ2FyZHMsCkx1Y2FzCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
