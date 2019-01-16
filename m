Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19DCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:12:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F13B20840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VGwAvw/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F13B20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zQEmUE9jvN6nxb8pCCArsc5WPcGud5BFJSlg7stgcYM=; b=VGwAvw/iepwKol
	pG13uS5ElZ8+9/VFHjhGempO4eUg9V9QhotheZNTVk4nT1VP6zY/+rIUupk21hcRqHebXGdNRIYfQ
	OXfC0NLuN4K7KOa8vjQMz7uOHabjtxL2XGeKlRJDuAEj3Cm2L2Az3LwLa4/8DvmXiF/rnnuHixHYy
	aygoTiMIte7IqXBmGgsJkO1Oo7G/YPVUfU3gNvSXaGrmTZjDZ63FmjmlVEs3Al/8pYJYdownE6ZPc
	+J+GUt62wc+UHU4DvMfPmP0lXvJqlK2iEhtEpKDkhjGXMts6jeiNt4evvMk3PEUBJ9DRDUlVky/kx
	4vQw4o6ehh7+g0k5yLTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiBX-0004KI-PV; Wed, 16 Jan 2019 10:12:35 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiBU-0004Jv-La
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:12:34 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gjiBL-0004pE-VS; Wed, 16 Jan 2019 11:12:23 +0100
Message-ID: <1547633543.4339.30.camel@pengutronix.de>
Subject: Re: [PATCH v3] arm64: defconfig: Add i.MX8MQ boot necessary configs
From: Lucas Stach <l.stach@pengutronix.de>
To: Abel Vesa <abel.vesa@nxp.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, Shawn Guo <shawnguo@kernel.org>, Will Deacon
 <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Jan 2019 11:12:23 +0100
In-Reply-To: <1547631712-24544-1-git-send-email-abel.vesa@nxp.com>
References: <1547631712-24544-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_021232_864850_37BDCADF 
X-CRM114-Status: GOOD (  12.98  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAxNi4wMS4yMDE5LCAwOTo0MSArMDAwMCBzY2hyaWViIEFiZWwgVmVz
YToKPiBFbmFibGUgYWxsIHRoZSBpLk1YOE1RIGNvbmZpZ3MgbmVjZXNzYXJ5IHRvIGJvb3QuCj4g
Cj4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+Cj4gQ2M6IFdp
bGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPgo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+Cj4gQ2M6IFNhc2NoYSBIYXVlciA8a2VybmVsQHBlbmd1dHJvbml4LmRlPgo+
IENjOiBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT4KClJldmlld2VkLWJ5OiBMdWNhcyBTdGFj
aCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KCj4gLS0tCj4gCj4gQ2hhbmdlcyBzaW5jZSB2MjoK
PiDCoCogcnVuIHNhdmVkZWZjb25maWcgdG8gb3JkZXIgdGhlIG5ld2x5IGFkZGVkIGNvbmZpZ3MK
PiAKPiDCoGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgfCA1ICsrKysrCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvY29u
Zmlncy9kZWZjb25maWcKPiBiL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcKPiBpbmRleCAw
MzI5MTJlLi42ZTVhZjI1IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25m
aWcKPiArKysgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnCj4gQEAgLTMyMyw2ICszMjMs
OCBAQCBDT05GSUdfU0VSSUFMX01FU09OX0NPTlNPTEU9eQo+IMKgQ09ORklHX1NFUklBTF9TQU1T
VU5HPXkKPiDCoENPTkZJR19TRVJJQUxfU0FNU1VOR19DT05TT0xFPXkKPiDCoENPTkZJR19TRVJJ
QUxfVEVHUkE9eQo+ICtDT05GSUdfU0VSSUFMX0lNWD15Cj4gK0NPTkZJR19TRVJJQUxfSU1YX0NP
TlNPTEU9eQo+IMKgQ09ORklHX1NFUklBTF9TSF9TQ0k9eQo+IMKgQ09ORklHX1NFUklBTF9NU009
eQo+IMKgQ09ORklHX1NFUklBTF9NU01fQ09OU09MRT15Cj4gQEAgLTM3MSw2ICszNzMsNyBAQCBD
T05GSUdfU1BJX1NQSURFVj1tCj4gwqBDT05GSUdfU1BNST15Cj4gwqBDT05GSUdfUElOQ1RSTF9T
SU5HTEU9eQo+IMKgQ09ORklHX1BJTkNUUkxfTUFYNzc2MjA9eQo+ICtDT05GSUdfUElOQ1RSTF9J
TVg4TVE9eQo+IMKgQ09ORklHX1BJTkNUUkxfSU1YOFFYUD15Cj4gwqBDT05GSUdfUElOQ1RSTF9J
UFE4MDc0PXkKPiDCoENPTkZJR19QSU5DVFJMX01TTTg5MTY9eQo+IEBAIC02MjgsNiArNjMxLDcg
QEAgQ09ORklHX0NPTU1PTl9DTEtfQ1MyMDAwX0NQPXkKPiDCoENPTkZJR19DT01NT05fQ0xLX1My
TVBTMTE9eQo+IMKgQ09ORklHX0NMS19RT1JJUT15Cj4gwqBDT05GSUdfQ09NTU9OX0NMS19QV009
eQo+ICtDT05GSUdfQ0xLX0lNWDhNUT15Cj4gwqBDT05GSUdfQ0xLX0lNWDhRWFA9eQo+IMKgQ09O
RklHX1RJX1NDSV9DTEs9eQo+IMKgQ09ORklHX0NPTU1PTl9DTEtfUUNPTT15Cj4gQEAgLTY2MSw2
ICs2NjUsNyBAQCBDT05GSUdfUlBNU0dfUUNPTV9HTElOS19SUE09eQo+IMKgQ09ORklHX1JQTVNH
X1FDT01fR0xJTktfU01FTT1tCj4gwqBDT05GSUdfUlBNU0dfUUNPTV9TTUQ9eQo+IMKgQ09ORklH
X1JBU1BCRVJSWVBJX1BPV0VSPXkKPiArQ09ORklHX0lNWF9HUENWMl9QTV9ET01BSU5TPXkKPiDC
oENPTkZJR19RQ09NX0NPTU1BTkRfREI9eQo+IMKgQ09ORklHX1FDT01fR0VOSV9TRT15Cj4gwqBD
T05GSUdfUUNPTV9HTElOS19TU1I9bQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
