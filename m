Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E8BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:10:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEB4206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jdcbbNqI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldt8w1V7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEB4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PbCuua29QgDkY+IciqMON9p4loTJopgwc94m/KEFruM=; b=jdcbbNqI6NF24v
	48y5Rulewgls1WRQC2BnlQ8X7lRSiNcQsvmDkglcLuE2vXgUjt2Vdodjw/zbKyovIjJ4zNz6uveMJ
	uFKBatw7iQksKZveuxDvON3K1NV2ApEwNmKCEZ64923Qh7xUd0oKODXyqqTDPrwHRNT0OWuLdolzb
	AAP+mMiAC3lwUkpe+MgU2P7ZfhNMtgsQrtcr8lJBitXcNQE+VECyxERI4IJYdY1/n+ig3qRuFQdj1
	FfPdUSzNvcD1kx+bJmdQFn48mhgQGwDvZMnhIcabcH0dZ0rEqcbI4pfPkCq5Ar/8U+/rpaFx9Eiwj
	dfUf4kFxb3EJTf+ig0QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSdsi-0007oG-Ex; Fri, 30 Nov 2018 08:10:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSdsd-0007mG-BE
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 08:10:34 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E55B0206B7;
 Fri, 30 Nov 2018 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543565421;
 bh=gU4o9r8iFoOeEBSQraFc44QNd+eXnvT5fifJEEQqD8U=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=Ldt8w1V7Q3l9p6TS1PvKa5/21RmLN+2NIQcPNzPIyem9+qKWlgi76K7fASrCcyuZm
 2AjgS0qHGQZE0VddkbSknXysDiBk/C+wMpd5xbJHGsKbOQfRd3Nl9OQ9wK5ZwrA+m/
 Y4eztqxVUjFhxpbj7z8U/pyJWSXJu86LkqiDQIIk=
MIME-Version: 1.0
To: "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 Anson Huang <anson.huang@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <DB3PR0402MB3916F9DC4C054747211EB90FF5D30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543562288-28638-1-git-send-email-Anson.Huang@nxp.com>
 <154356270811.88331.17520386069332746427@swboyd.mtv.corp.google.com>
 <DB3PR0402MB3916F9DC4C054747211EB90FF5D30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Message-ID: <154356542041.88331.1938476424482018533@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
Date: Fri, 30 Nov 2018 00:10:20 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_001031_510796_D7B6A0A8 
X-CRM114-Status: GOOD (  11.26  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UXVvdGluZyBBbnNvbiBIdWFuZyAoMjAxOC0xMS0yOSAyMzozNzoxNCkKPiBIaSwgU3RlcGhlbgo+
IAo+IEJlc3QgUmVnYXJkcyEKPiBBbnNvbiBIdWFuZwo+IAo+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0KPiA+IEZyb206IFN0ZXBoZW4gQm95ZCBbbWFpbHRvOnNib3lkQGtlcm5lbC5vcmdd
Cj4gPiBTZW50OiAyMDE45bm0MTHmnIgzMOaXpSAxNToyNQo+ID4gVG86IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOwo+ID4gbGludXgt
Y2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsKPiA+IG10
dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBzaGF3bmd1b0Br
ZXJuZWwub3JnOwo+ID4gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBGYWJpbyBF
c3RldmFtCj4gPiA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPgo+ID4gQ2M6IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+Cj4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGlteDZzbDog
ZW5zdXJlIE1NREMgQ0gwIGhhbmRzaGFrZSBpcyBieXBhc3NlZAo+ID4gCj4gPiBRdW90aW5nIEFu
c29uIEh1YW5nICgyMDE4LTExLTI5IDIzOjIzOjQ3KQo+ID4gPiBTYW1lIGFzIG90aGVyIGkuTVg2
IFNvQ3MsIGVuc3VyZSB1bnVzZWQgTU1EQyBjaGFubmVsJ3MgaGFuZHNoYWtlIGlzCj4gPiA+IGJ5
cGFzc2VkLCB0aGlzIGlzIHRvIG1ha2Ugc3VyZSBubyByZXF1ZXN0IHNpZ25hbCB3aWxsIGJlIGdl
bmVyYXRlZAo+ID4gPiB3aGVuIHBlcmlwaGVfY2xrX3NlbCBpcyBjaGFuZ2VkIG9yIFNSQyB3YXJt
IHJlc2V0IGlzIHRyaWdnZXJlZC4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+Cj4gPiAKPiA+IERvZXMgdGhpcyBuZWVkIGEgZml4ZXMg
dGFnPwo+IAo+IE5vcm1hbGx5IHRoaXMgYml0IGlzIDFiJzEgYnkgcmVzZXQsIGJ1dCBkdXJpbmcg
b3VyIGRldmVsb3BtZW50LCBpdCB1c2VkIHRvIGJlCj4gb3ZlcndyaXR0ZW4gaW4gdS1ib290IGFu
ZCBsZWFkIHRvIHNvbWUgY2xvY2sgb3BlcmF0aW9uIGZhaWwgaW4gTGludXgga2VybmVsLCB0aGF0
IGlzIHdoeSB3ZSBlbnN1cmUgaXQKPiBpbiBjbG9jayBkcml2ZXIgZWFybHkgcGhhc2UuIElNTywg
aXQgc2hvdWxkIGJlIE9LIHRvIG5vdCBhZGQgYSBmaXggdGFnLCBzaW5jZSBpdCBpcyBqdXN0Cj4g
dG8gbWFrZSBzdXJlIHRoZSBzZXR0aW5nIGlzIGNvcnJlY3QgYW5kIE5PVCBkZXBlbmRzIG9uIHRo
ZSBoYXJkd2FyZSByZXNldCB2YWx1ZSB3aGljaAo+IGNvdWxkIGJlIGNoYW5nZWQgaW4gdS1ib290
Lgo+IAo+IAoKSG1tIG9rLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
