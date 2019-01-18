Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA125C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:42:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6262087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p52kcoYi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="qjBI+XXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6262087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T7VZiIf2RFlPDwQTOPhTLAvi5F0HDG6BPGjT/FTMI7c=; b=p52kcoYiYHYR4C
	MZpvSp3fgpkYf08YxiDw59QD8xXY3K2q/reTdXDEiKORV0ZfzXf1qcYDMKeRl0mwdk7VeJLJDlx2V
	uWdFPxwFFV2ywechKrAxkqUwW9oe7u8FmFEX9VQIC2cOc5txlZ0Ouo2msx3uEvK8oWCnbWfL1aV1C
	YKTHpdFZuS/1rc8z5gexJ4ooIjpoELSquZH7UWRU8aoQ/SnFSirx0UW0fsXbQBYb6GJ5alacY8CzY
	ZFhkzE9lqP6UOAYJoC04j4hAUYLec/yMweRNxRfdiULUDu7/g5vrkdEd2apLB8Xv+RQqt/jcACYZe
	awwHU1WzbeepQe2thseA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWHQ-0000Gj-3L; Fri, 18 Jan 2019 15:42:00 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWHK-0000Fk-NR
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 15:41:58 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id B8CDA5C0690;
 Fri, 18 Jan 2019 16:41:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1547826110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZkMRhCoCqusqJqwcuVH0wDyfIDkueVB6AfkeOJHqZ0=;
 b=qjBI+XXDH1TeGKdZ4x3+5QCq6IY3+ueuLMPt66uDNS/S8PsuD11NHmamHR3Fm7SRVxETEZ
 UG7/a5+4RmF7T63Ks+VCe2YRWzGRjE8a5pBiJLOjdv7pB85b5dSxlCnIjFNwLz0pI+zs1w
 fT1IxwN9Lz5jyWHM5Xrk5rgK93kmz/Q=
MIME-Version: 1.0
Date: Fri, 18 Jan 2019 16:41:50 +0100
From: Stefan Agner <stefan@agner.ch>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/2] ARM: dts: imx6q: add pmu interrupt-affinity
In-Reply-To: <1547820733.2626.11.camel@pengutronix.de>
References: <20190118135907.2336-1-stefan@agner.ch>
 <1547820733.2626.11.camel@pengutronix.de>
Message-ID: <6e4fe68ec80926b4292ce786c6737182@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_074156_873543_88DA31C2 
X-CRM114-Status: GOOD (  16.64  )
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
Cc: kernel@pengutronix.de, marcel.ziswiler@toradex.com, s.hauer@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, max.krummenacher@toradex.com,
 fabio.estevam@nxp.com, shawnguo@kernel.org, dev@pschenker.ch,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTguMDEuMjAxOSAxNToxMiwgTHVjYXMgU3RhY2ggd3JvdGU6Cj4gQW0gRnJlaXRhZywgZGVu
IDE4LjAxLjIwMTksIDE0OjU5ICswMTAwIHNjaHJpZWIgU3RlZmFuIEFnbmVyOgo+PiBFeHBsaWNp
dGx5IHNwZWNpZnkgaW50ZXJydXB0IGFmZmluaXR5IHRvIGF2b2lkIEhXIHBlcmZldmVudHMKPj4g
bmVlZCB0byBndWVzcy4gVGhpcyBhdm9pZHMgdGhlIGZvbGxvd2luZyBlcnJvciB1cG9uIGJvb3Q6
Cj4+IMKgIGh3IHBlcmZldmVudHM6IG5vIGludGVycnVwdC1hZmZpbml0eSBwcm9wZXJ0eSBmb3Ig
L3BtdSwgZ3Vlc3NpbmcuCj4+Cj4gQnV0IHRoZW4gaXQgaXNuJ3QgY29ycmVjdCBlaXRoZXIgQUZB
SUNTLiBPbiBpLk1YNiBhbGwgdGhlIFBNVSBJUlFzIGFyZQo+IE9SZWQgdG9nZXRoZXIgaW50byBh
IHNpbmdsZSBTUEksIGluc3RlYWQgb2YgZWFjaCBjb3JlIGRlYWxpbmcgd2l0aCBpdHMKPiBvd24g
UFBJLiBTbyBwcmV0ZW5kaW5nIHRoYXQgdGhlcmUgYXJlIG1vcmUgSVJRcyB3aXRoIGFmZmluaXR5
IHRvIGVhY2gKPiBjb3JlIGlzbid0IHRoZSByaWdodCB0aGluZyB0byBkbywgbm8/Cj4gCgpPaCBJ
IHNlZSwgd2Ugb25seSBoYXZlIGEgc2luZ2xlIGludGVycnVwdCBpbiB0aGUgaS5NWCA2IGNhc2Uu
CgpJIGFncmVlLCB0aGlzIHBhdGNoZXMgYXJlIHdyb25nLgoKSG0sIGJ1dCB3aHkgZG9lcyBodyBw
ZXJmIHRoZW4gdGhpbmsgaXQgbmVlZHMgdG8gZ3Vlc3M/IERvZXNuJ3Qgc2VlbSBoYXJkCnRvIGd1
ZXNzIHJpZ2h0IGlmIHRoZXJlIGlzIG9ubHkgb25lIGNob2ljZS4uLgoKV2UgcHJvYmFibHkgbmVl
ZCB0byBkbyBzb21ldGhpbmcgbGlrZSB0aGlzPwoKLS0tIGEvZHJpdmVycy9wZXJmL2FybV9wbXVf
cGxhdGZvcm0uYworKysgYi9kcml2ZXJzL3BlcmYvYXJtX3BtdV9wbGF0Zm9ybS5jCkBAIC0xMjIs
NyArMTIyLDggQEAgc3RhdGljIGludCBwbXVfcGFyc2VfaXJxcyhzdHJ1Y3QgYXJtX3BtdSAqcG11
KQogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcG11X3BhcnNlX3BlcmNwdV9pcnEocG11
LCBpcnEpOwogICAgICAgIH0KIAotICAgICAgIGlmIChucl9jcHVfaWRzICE9IDEgJiYgIXBtdV9o
YXNfaXJxX2FmZmluaXR5KHBkZXYtPmRldi5vZl9ub2RlKSkKeworICAgICAgIGlmICgobnJfY3B1
X2lkcyAhPSAxIHx8IG51bV9pcnFzICE9IDEpICYmCisgICAgICAgICAgICFwbXVfaGFzX2lycV9h
ZmZpbml0eShwZGV2LT5kZXYub2Zfbm9kZSkpIHsKICAgICAgICAgICAgICAgIHByX3dhcm4oIm5v
IGludGVycnVwdC1hZmZpbml0eSBwcm9wZXJ0eSBmb3IgJXBPRiwKZ3Vlc3NpbmcuXG4iLAogICAg
ICAgICAgICAgICAgICAgICAgICBwZGV2LT5kZXYub2Zfbm9kZSk7CiAgICAgICAgfQoKLS0KU3Rl
ZmFuCgoKCj4gUmVnYXJkcywKPiBMdWNhcwo+IAo+PiBTcGVjaWZ5aW5nIGFsbCBmb3VyIENQVXMg
c2hvd3Mgbm8gYXZlcnNpdmUgZWZmZWN0cyBvbiBpLk1YIDZEdWFsCj4+IFNvQ3MuCj4+Cj4+ID4g
U2lnbmVkLW9mZi1ieTogU3RlZmFuIEFnbmVyIDxzdGVmYW5AYWduZXIuY2g+Cj4+IC0tLQo+PiDC
oGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLmR0c2kgfCA3ICsrKysrKysKPj4gwqAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy9pbXg2cS5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEuZHRzaQo+PiBpbmRleCA4Mzgx
ZDI0ZWZmN2QuLmQyYzE5NzdjOGIxNiAxMDA2NDQKPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnEuZHRzaQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cS5kdHNpCj4+IEBAIC01
MzcsNiArNTM3LDEzIEBACj4+ID4gwqAJCQk8MHgyOCAweDAwMDAwMDBjPjsgLyogRENJQzJfTVVY
X0NUTCAqLwo+PiDCoH07Cj4+IMKgCj4+ICsmcG11IHsKPj4gPiA+ICsJaW50ZXJydXB0LWFmZmlu
aXR5ID0gPCZ7L2NwdXMvY3B1QDB9PiwKPj4gPiA+ICsJCQnCoMKgwqDCoMKgPCZ7L2NwdXMvY3B1
QDF9PiwKPj4gPiA+ICsJCQnCoMKgwqDCoMKgPCZ7L2NwdXMvY3B1QDJ9PiwKPj4gPiA+ICsJCQnC
oMKgwqDCoMKgPCZ7L2NwdXMvY3B1QDN9PjsKPj4gK307Cj4+ICsKPj4gwqAmdnB1IHsKPj4gPiDC
oAljb21wYXRpYmxlID0gImZzbCxpbXg2cS12cHUiLCAiY25tLGNvZGE5NjAiOwo+PiDCoH07Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
