Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F37C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:29:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D77E20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KPouEbNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D77E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OJdJmUnBIC4kv/hCE3N1iCPYGcvabvEOo3Jqp6z5WpE=; b=KPouEbNFcqDo63
	ge0uKj+zDnNH4vD+3L0xaYo2DFXuR1hbFcZg/F8KwkRy5dLuduEpTnauu11/yQ1HUR/cU5zVxmmZE
	5cRmQXzPJWSV3Aw8rOPxYMfTcdlZjF3V839sEfHlMfsBlwBWKmMlDZmNqbvUSyE9sULsmS9+h9AC3
	vk6htqDWB8kNnI8J/SLeJv5Zlmzc42AJ7vIHU/pEwXtVdGEqocli6+oPD69s0RmEPMlPYjOeWSe7j
	Oa9/a/zfMxJvWFvEDgmHd8DJippzwono9pNcpice+bnRnaUD/wR0C7Oe4Z5fuCXwhHx2MZCsRkKs2
	7atbwSTJL8O9p7QfYk1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTjba-0008Cm-NF; Mon, 03 Dec 2018 08:29:26 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjbW-0008CM-Tn
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 08:29:24 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gTjbJ-0005y2-1R; Mon, 03 Dec 2018 09:29:09 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gTjbI-0004GM-7K; Mon, 03 Dec 2018 09:29:08 +0100
Date: Mon, 3 Dec 2018 09:29:08 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Robin Gong <yibin.gong@nxp.com>
Subject: Re: [PATCH v3 4/5] spi: imx: rename config callback and add useful
 parameters
Message-ID: <20181203082908.rmn74jazswzharxd@pengutronix.de>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181130064709.6998-5-u.kleine-koenig@pengutronix.de>
 <AM0PR04MB4532047E26FD6FC62193A11689AE0@AM0PR04MB4532.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4532047E26FD6FC62193A11689AE0@AM0PR04MB4532.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_002923_118150_801E0CB2 
X-CRM114-Status: GOOD (  21.35  )
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
Cc: Marek Vasut <marex@denx.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBEZWMgMDMsIDIwMTggYXQgMDg6MDk6NTlBTSArMDAwMCwgUm9iaW4gR29uZyB3cm90
ZToKPiAKPiAKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBVd2UgS2xl
aW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgo+ID4gU2VudDogMjAx
OOW5tDEx5pyIMzDml6UgMTQ6NDcKPiA+IFRvOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5v
cmc+OyBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+Cj4gPiBDYzogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsKPiA+IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsKPiA+IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+ID4gU3ViamVjdDogW1BBVENIIHYzIDQv
NV0gc3BpOiBpbXg6IHJlbmFtZSBjb25maWcgY2FsbGJhY2sgYW5kIGFkZCB1c2VmdWwKPiA+IHBh
cmFtZXRlcnMKPiA+IAo+ID4gVGhlIGNvbmZpZyBjYWxsYmFjayBpcyBjYWxsZWQgb25jZSBwZXIg
dHJhbnNmZXIgd2hpbGUgc29tZSB0aGluZ3MgY2FuIChhbmQKPiA+IHNob3VsZCkgYmUgZG9uZSBv
biBhIHBlciBtZXNzYWdlIG1hbm5lci4gVG8gaGF2ZSB1bmFtYmlndW91cyBuYW1pbmcgaW4gdGhl
Cj4gPiBlbmQgaW5jbHVkZSAidHJhbnNmZXIiIGluIHRoZSBjYWxsYmFjaydzIG5hbWUgYW5kIHJl
bmFtZSB0aGUgaW1wbGVtZW50YXRpb25zCj4gPiBhY2NvcmRpbmdseS4gQWxzbyBwYXNzIHRoZSBk
cml2ZXIgc3RydWN0IGFuZCB0cmFuc2ZlciB3aGljaCBhbGxvd3MgZnVydGhlcgo+ID4gc2ltcGxp
ZmljYXRpb25zIGluIHRoZSBmb2xsb3dpbmcgcGF0Y2guCj4gPiAKPiA+IFRoZXJlIGlzIG5vIGNo
YW5nZSBpbiBiZWhhdmlvciBpbnRlbmRlZCBoZXJlLgo+ID4gCj4gPiBSZXZpZXdlZC1ieTogTWFy
ZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvD
tm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgo+ID4gLS0tCj4gPiAgZHJpdmVy
cy9zcGkvc3BpLWlteC5jIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygt
KQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWlteC5jIGIvZHJpdmVycy9z
cGkvc3BpLWlteC5jIGluZGV4Cj4gPiBkOTU0YjZkOTU4YzIuLjcyYzg3OTIyNmFiZCAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1pbXguYwo+ID4gKysrIGIvZHJpdmVycy9zcGkvc3Bp
LWlteC5jCj4gPiBAQCAtNjAsNyArNjAsOCBAQCBzdHJ1Y3Qgc3BpX2lteF9kYXRhOwo+ID4gIHN0
cnVjdCBzcGlfaW14X2RldnR5cGVfZGF0YSB7Cj4gPiAgCXZvaWQgKCppbnRjdHJsKShzdHJ1Y3Qg
c3BpX2lteF9kYXRhICosIGludCk7Cj4gPiAgCWludCAoKnByZXBhcmVfbWVzc2FnZSkoc3RydWN0
IHNwaV9pbXhfZGF0YSAqLCBzdHJ1Y3Qgc3BpX21lc3NhZ2UgKik7Cj4gPiAtCWludCAoKmNvbmZp
Zykoc3RydWN0IHNwaV9kZXZpY2UgKik7Cj4gPiArCWludCAoKnByZXBhcmVfdHJhbnNmZXIpKHN0
cnVjdCBzcGlfaW14X2RhdGEgKiwgc3RydWN0IHNwaV9kZXZpY2UgKiwKPiA+ICsJCQkJc3RydWN0
IHNwaV90cmFuc2ZlciAqKTsKPiA+ICAJdm9pZCAoKnRyaWdnZXIpKHN0cnVjdCBzcGlfaW14X2Rh
dGEgKik7Cj4gPiAgCWludCAoKnJ4X2F2YWlsYWJsZSkoc3RydWN0IHNwaV9pbXhfZGF0YSAqKTsK
PiA+ICAJdm9pZCAoKnJlc2V0KShzdHJ1Y3Qgc3BpX2lteF9kYXRhICopOwo+ID4gQEAgLTU1Niw5
ICs1NTcsMTAgQEAgc3RhdGljIGludCBteDUxX2Vjc3BpX3ByZXBhcmVfbWVzc2FnZShzdHJ1Y3QK
PiA+IHNwaV9pbXhfZGF0YSAqc3BpX2lteCwKPiA+ICAJcmV0dXJuIDA7Cj4gPiAgfQo+ID4gCj4g
PiAtc3RhdGljIGludCBteDUxX2Vjc3BpX2NvbmZpZyhzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQo+
ID4gK3N0YXRpYyBpbnQgbXg1MV9lY3NwaV9wcmVwYXJlX3RyYW5zZmVyKHN0cnVjdCBzcGlfaW14
X2RhdGEgKnNwaV9pbXgsCj4gPiArCQkJCSAgICAgICBzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLAo+
ID4gKwkJCQkgICAgICAgc3RydWN0IHNwaV90cmFuc2ZlciAqdCkKPiA+ICB7Cj4gPiAtCXN0cnVj
dCBzcGlfaW14X2RhdGEgKnNwaV9pbXggPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKHNwaS0+bWFz
dGVyKTsKPiBTaW5jZSBzcGlfaW14IGNvdWxkIGJlIGdldCBmcm9tIHNwaSBhcyBiZWZvcmUsIHdo
eSBub3QgcmVtb3ZlIHRoZSBwYXJhbWV0ZXIgKnNwaV9pbXggZm9yCj4gcHJlcGFyZV90cmFuc2Zl
cigpIGZ1bmN0aW9uPwoKTXkgcmF0aW9uYWxlIHRvIGFkZCBzcGlfaW14IHdhcyB0aGF0IHRoZSBj
YWxsZXIgYWxyZWFkeSBoYXMgaXQgYW5kIHRoaXMKZnVuY3Rpb24gbmVlZHMgaXQuIFNvIGl0IHNl
ZW1zIG5hdHVyYWwgZm9yIG1lIHRvIHBhc3MgaXQgYXMgYXJndW1lbnQuCkFsc28gdGhlIHByZXBh
cmVfbWVzc2FnZSBjYWxsYmFjayBnZXRzIHRoZSBkcml2ZXIgZGF0YSBzbyBpdCBhbHNvIGxvb2tz
CmNvbnNpc3RlbnQgdG8gbWUuIEFsc28gaXQgbWlnaHQgc2F2ZSBhIGZldyBjeWNsZXMgdG8gZm9s
bG93IHRoZSBwb2ludGVyCmNoYWluIChzcGktPm1hc3Rlci0+ZGV2LmRyaXZlcl9kYXRhKSBpZiB0
aGUgY29tcGlsZXIgZG9lc24ndCBub3RpY2UgaXQKYWxyZWFkeSBoYXMgdGhlIHJlcXVlc3RlZCB2
YWx1ZS4gQnV0IEkgZG9uJ3QgZmVlbCBsaWtlIGFyZ3VpbmcgYW5kCmRpZG4ndCBjaGVjayBpZiBp
dCBtYWtlcyBhIGRpZmZlcmVuY2UgaGVyZSBpbiB0aGUgYmluYXJ5LgoKQmVzdCByZWdhcmRzClV3
ZQoKLS0gClBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8IFV3ZSBL
bGVpbmUtS8O2bmlnICAgICAgICAgICAgfApJbmR1c3RyaWFsIExpbnV4IFNvbHV0aW9ucyAgICAg
ICAgICAgICAgICAgfCBodHRwOi8vd3d3LnBlbmd1dHJvbml4LmRlLyAgfAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
