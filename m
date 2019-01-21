Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3CEC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:40:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C622085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GIGuXCzt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="dZPHL+ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C622085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=umnletgIBvSJwFyIac3PYadVr5EWkbLdhDXRqvgooyU=; b=GIGuXCztw1gOqQ
	Yb2ukCBU8kt09thqAN2NUMG4l7+4fnfMpDdQ+dv+5UkDtUyd/hoEvzWEQQ3UIiFOUZ/4pk/HmI1Ld
	nGRR6J3PyZSi76Gy+LhHCF7NMH3kysAdZXFAgd18NdDS32lGxLOyMpaOql6Kb8qV0MDJV+HPn+R2G
	3KIz7fNPMEBcHz49Z/p7CxvBAszgjfoRs1I/xpaZas9NO40q9CkEzvlzTn4yAn+Y85Ax5cFYteO57
	IJM/0FQ62eTCbM8j6H0j7HwDy08XcMlpZIg3xfO3aJ9w1eMEWgQZMsxZ/jvvhG+5+foVSMxRw1Rc2
	TygAsogXlBBL8AQpxRmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glW3s-0001X6-Sg; Mon, 21 Jan 2019 09:40:08 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glW3n-0000J4-NO
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 09:40:06 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 04D375C013A;
 Mon, 21 Jan 2019 10:39:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1548063599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKzpWpIDB0omKf8VnpAO2XxslJMWn9AwfROVElUps2A=;
 b=dZPHL+nii5/fuS4Vnswc4Tr94/ZGVGv0EA9wLsUYRKvIYrM5WCsoMLW6UrgRse6Nl6C2OI
 UIOZTi9GZFMZnUkVoIAm6Isd6zo5JZ1MvGzeEkmPbImpYgG1v+uIy1DTIBLnPJTTF9Fmgi
 zPvWEwdrRd8ZSnB6iwmBcRVg8OCaICc=
MIME-Version: 1.0
Date: Mon, 21 Jan 2019 10:39:58 +0100
From: Stefan Agner <stefan@agner.ch>
To: Lucas Stach <l.stach@pengutronix.de>, will.deacon@arm.com,
 mark.rutland@arm.com
Subject: Re: [PATCH 1/2] ARM: dts: imx6q: add pmu interrupt-affinity
In-Reply-To: <6e4fe68ec80926b4292ce786c6737182@agner.ch>
References: <20190118135907.2336-1-stefan@agner.ch>
 <1547820733.2626.11.camel@pengutronix.de>
 <6e4fe68ec80926b4292ce786c6737182@agner.ch>
Message-ID: <5f35af2bc4b5c97d69ff9ab1c71da1f7@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_014004_272542_F61AF996 
X-CRM114-Status: GOOD (  20.05  )
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

W2FkZGluZyBXaWxsL01hcmtdCgpPbiAxOC4wMS4yMDE5IDE2OjQxLCBTdGVmYW4gQWduZXIgd3Jv
dGU6Cj4gT24gMTguMDEuMjAxOSAxNToxMiwgTHVjYXMgU3RhY2ggd3JvdGU6Cj4+IEFtIEZyZWl0
YWcsIGRlbiAxOC4wMS4yMDE5LCAxNDo1OSArMDEwMCBzY2hyaWViIFN0ZWZhbiBBZ25lcjoKPj4+
IEV4cGxpY2l0bHkgc3BlY2lmeSBpbnRlcnJ1cHQgYWZmaW5pdHkgdG8gYXZvaWQgSFcgcGVyZmV2
ZW50cwo+Pj4gbmVlZCB0byBndWVzcy4gVGhpcyBhdm9pZHMgdGhlIGZvbGxvd2luZyBlcnJvciB1
cG9uIGJvb3Q6Cj4+PiDCoCBodyBwZXJmZXZlbnRzOiBubyBpbnRlcnJ1cHQtYWZmaW5pdHkgcHJv
cGVydHkgZm9yIC9wbXUsIGd1ZXNzaW5nLgo+Pj4KPj4gQnV0IHRoZW4gaXQgaXNuJ3QgY29ycmVj
dCBlaXRoZXIgQUZBSUNTLiBPbiBpLk1YNiBhbGwgdGhlIFBNVSBJUlFzIGFyZQo+PiBPUmVkIHRv
Z2V0aGVyIGludG8gYSBzaW5nbGUgU1BJLCBpbnN0ZWFkIG9mIGVhY2ggY29yZSBkZWFsaW5nIHdp
dGggaXRzCj4+IG93biBQUEkuIFNvIHByZXRlbmRpbmcgdGhhdCB0aGVyZSBhcmUgbW9yZSBJUlFz
IHdpdGggYWZmaW5pdHkgdG8gZWFjaAo+PiBjb3JlIGlzbid0IHRoZSByaWdodCB0aGluZyB0byBk
bywgbm8/Cj4+Cj4gCj4gT2ggSSBzZWUsIHdlIG9ubHkgaGF2ZSBhIHNpbmdsZSBpbnRlcnJ1cHQg
aW4gdGhlIGkuTVggNiBjYXNlLgo+IAo+IEkgYWdyZWUsIHRoaXMgcGF0Y2hlcyBhcmUgd3Jvbmcu
Cj4gCj4gSG0sIGJ1dCB3aHkgZG9lcyBodyBwZXJmIHRoZW4gdGhpbmsgaXQgbmVlZHMgdG8gZ3Vl
c3M/IERvZXNuJ3Qgc2VlbSBoYXJkCj4gdG8gZ3Vlc3MgcmlnaHQgaWYgdGhlcmUgaXMgb25seSBv
bmUgY2hvaWNlLi4uCj4gCj4gV2UgcHJvYmFibHkgbmVlZCB0byBkbyBzb21ldGhpbmcgbGlrZSB0
aGlzPwo+IAo+IC0tLSBhL2RyaXZlcnMvcGVyZi9hcm1fcG11X3BsYXRmb3JtLmMKPiArKysgYi9k
cml2ZXJzL3BlcmYvYXJtX3BtdV9wbGF0Zm9ybS5jCj4gQEAgLTEyMiw3ICsxMjIsOCBAQCBzdGF0
aWMgaW50IHBtdV9wYXJzZV9pcnFzKHN0cnVjdCBhcm1fcG11ICpwbXUpCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHBtdV9wYXJzZV9wZXJjcHVfaXJxKHBtdSwgaXJxKTsKPiAgICAg
ICAgIH0KPiAgCj4gLSAgICAgICBpZiAobnJfY3B1X2lkcyAhPSAxICYmICFwbXVfaGFzX2lycV9h
ZmZpbml0eShwZGV2LT5kZXYub2Zfbm9kZSkpCj4gewo+ICsgICAgICAgaWYgKChucl9jcHVfaWRz
ICE9IDEgfHwgbnVtX2lycXMgIT0gMSkgJiYKPiArICAgICAgICAgICAhcG11X2hhc19pcnFfYWZm
aW5pdHkocGRldi0+ZGV2Lm9mX25vZGUpKSB7Cj4gICAgICAgICAgICAgICAgIHByX3dhcm4oIm5v
IGludGVycnVwdC1hZmZpbml0eSBwcm9wZXJ0eSBmb3IgJXBPRiwKPiBndWVzc2luZy5cbiIsCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgcGRldi0+ZGV2Lm9mX25vZGUpOwo+ICAgICAgICAgfQoK
WWVhaCwgSSBzZWUsIGl0IHdhcyBvbiBGcmlkYXkuLi4gaWYgYW55dGhpbmcsIGl0IHNob3VsZCBi
ZToKCi0gICAgICAgaWYgKG5yX2NwdV9pZHMgIT0gMSAmJiAhcG11X2hhc19pcnFfYWZmaW5pdHko
cGRldi0+ZGV2Lm9mX25vZGUpKQp7CisgICAgICAgaWYgKG5yX2NwdV9pZHMgIT0gMSAmJiBudW1f
aXJxcyAhPSAxICYmCisgICAgICAgICAgICFwbXVfaGFzX2lycV9hZmZpbml0eShwZGV2LT5kZXYu
b2Zfbm9kZSkpIHsKCkhvd2V2ZXIsIEkgcmVhbGl6ZWQgdGhhdCBhcm1fcG11X3BsYXRmb3JtIGFj
dHVhbGx5IGN1cnJlbnRseSBvbmx5CmFzc2lnbnMgdGhlIG9uZSBJUlEgdG8gdGhlIGZpcnN0IENQ
VS4gVGhpcyBsZWFkcyB0byBwZXJmIG5vdCB3b3JraW5nIGlmCmEgcHJvY2VzcyBpcyBzY2hlZHVs
ZWQgb24gYW5vdGhlciBDUFUgdGhlbiB0aGUgZmlyc3QuCgpJIGNvdWxkIHJlcHJvZHVjZSB0aGlz
LiBQSUQgNzYzIGlzIGEgbG9uZyBydW5uaW5nIHRhc2suCgpyb290QGNvbGlicmktaW14Ni0wNTA1
MTA1NDp+IyB0YXNrc2V0IC1wIDB4MSA3NjMKcGlkIDc2MydzIGN1cnJlbnQgYWZmaW5pdHkgbWFz
azogMwpwaWQgNzYzJ3MgbmV3IGFmZmluaXR5IG1hc2s6IDEKCgpyb290QGNvbGlicmktaW14Ni0w
NTA1MTA1NDp+IyBwZXJmIHN0YXQgLWUgY3B1LWN5Y2xlcyAtcCA3NjMKXkMKIFBlcmZvcm1hbmNl
IGNvdW50ZXIgc3RhdHMgZm9yIHByb2Nlc3MgaWQgJzc2Myc6CgogICAgICAgICAgIDc1ODEwMjEg
ICAgICBjcHUtY3ljbGVzCgogICAgICAgMS4yMjIyNDg0OTAgc2Vjb25kcyB0aW1lIGVsYXBzZWQK
Cgpyb290QGNvbGlicmktaW14Ni0wNTA1MTA1NDp+IyB0YXNrc2V0IC1wIDB4MiA3NjMKcGlkIDc2
MydzIGN1cnJlbnQgYWZmaW5pdHkgbWFzazogMQpwaWQgNzYzJ3MgbmV3IGFmZmluaXR5IG1hc2s6
IDIKCgpyb290QGNvbGlicmktaW14Ni0wNTA1MTA1NDp+IyBwZXJmIHN0YXQgLWUgY3B1LWN5Y2xl
cyAtcCA3NjMKXkMKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yIHByb2Nlc3MgaWQgJzc2
Myc6CgogICAgIDxub3QgY291bnRlZD4gICAgICBjcHUtY3ljbGVzICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICgwLjAwJSkKCiAgICAgICAxLjA1MDI1
MzU3NSBzZWNvbmRzIHRpbWUgZWxhcHNlZAoKSSBndWVzcyB3ZSBuZWVkIHRvIHRlbGwgdGhlIFBN
VSBkcml2ZXIgdGhhdCBhIHNpbmdsZSBJUlEgc2hvdWxkIGJlIHVzZWQKZm9yIGFsbCBDUFVzPwoK
LS0KU3RlZmFuCgoKCj4gCj4gCj4+IFJlZ2FyZHMsCj4+IEx1Y2FzCj4+Cj4+PiBTcGVjaWZ5aW5n
IGFsbCBmb3VyIENQVXMgc2hvd3Mgbm8gYXZlcnNpdmUgZWZmZWN0cyBvbiBpLk1YIDZEdWFsCj4+
PiBTb0NzLgo+Pj4KPj4+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEFnbmVyIDxzdGVmYW5AYWdu
ZXIuY2g+Cj4+PiAtLS0KPj4+IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEuZHRzaSB8IDcgKysr
KysrKwo+Pj4gwqAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9p
bXg2cS5kdHNpCj4+PiBpbmRleCA4MzgxZDI0ZWZmN2QuLmQyYzE5NzdjOGIxNiAxMDA2NDQKPj4+
IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLmR0c2kKPj4+ICsrKyBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDZxLmR0c2kKPj4+IEBAIC01MzcsNiArNTM3LDEzIEBACj4+PiA+IMKgCQkJPDB4
MjggMHgwMDAwMDAwYz47IC8qIERDSUMyX01VWF9DVEwgKi8KPj4+IMKgfTsKPj4+IMKgCj4+PiAr
JnBtdSB7Cj4+PiA+ID4gKwlpbnRlcnJ1cHQtYWZmaW5pdHkgPSA8JnsvY3B1cy9jcHVAMH0+LAo+
Pj4gPiA+ICsJCQnCoMKgwqDCoMKgPCZ7L2NwdXMvY3B1QDF9PiwKPj4+ID4gPiArCQkJwqDCoMKg
wqDCoDwmey9jcHVzL2NwdUAyfT4sCj4+PiA+ID4gKwkJCcKgwqDCoMKgwqA8JnsvY3B1cy9jcHVA
M30+Owo+Pj4gK307Cj4+PiArCj4+PiDCoCZ2cHUgewo+Pj4gPiDCoAljb21wYXRpYmxlID0gImZz
bCxpbXg2cS12cHUiLCAiY25tLGNvZGE5NjAiOwo+Pj4gwqB9OwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
