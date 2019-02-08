Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61786C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:45:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C94B218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RXLxE82E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C94B218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=48RCcmCuR2IZnEH7QW5r+XVjrKP8knQsLlmbY2ebTg0=; b=RXLxE82EeFiCp1
	K9lMNJRrhTpeK3SE5DfAC3Pck0ugVO1QqyVtOuz+NVclkYO6QpxNpzG1xq5zdnNPI6zmudIgcqiXh
	FQ76nejl0k4cJYlHBdb6+p7hgSzU94I8lnxUd18smRDkHpPRmPuGcdbNgfSy+2zm0DHgHoMmXgFq4
	a2dgE/KlqV2a9o3TzxS6a7kQ0XUZKCDBwynRf8IRvmSRwz/9iP7djIaZ9QkvmrW1AY8DAiVFVmVSI
	+xrkRsvJBOK7ykvi7BjmzJC2BCF/b8UTR3RLuJPIp22UoJyCX0LH2tGxuvFTrkd2U12IOAzlqDl2O
	wBchFaje1YbQ04X7jh2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs2iw-00081R-Nb; Fri, 08 Feb 2019 09:45:30 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs2iq-000808-KB
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 09:45:28 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gs2il-0000Mm-CS; Fri, 08 Feb 2019 10:45:19 +0100
Message-ID: <1549619117.2544.85.camel@pengutronix.de>
Subject: Re: [RFC v2 3/5] arm64: dts: imx8mq: Combine PCIE power domains
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 08 Feb 2019 10:45:17 +0100
In-Reply-To: <20190208002941.30343-4-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
 <20190208002941.30343-4-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_014524_824980_A0936065 
X-CRM114-Status: GOOD (  17.92  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDA3LjAyLjIwMTksIDE2OjI5IC0wODAwIHNjaHJpZWIgQW5kcmV5
IFNtaXJub3Y6Cj4gQWNjb3JkaW5nIHRvIE5YUCdzIEZBRSBmZWVkYmFjayBhbmQgYSBjb21tZW50
IGluIEFURiBmaXJtd2FyZSwgUENJRTEKPiBhbmQgUENJRTIgcG93ZXIgZG9tYWlucyBjYW4ndCBy
ZWFsbHkgYmUgdXNlZCBpbmRlcGVuZGVudGx5LiBEdWUgdG8KPiBzaGFyZWQgcmVzZXQgbGluZSBi
b3RoIHBvd2VyIGRvbWFpbnMgaGF2ZSB0byBiZSB0dXJuZWQgb24gYXQgdGhlIHNhbWUKPiB0aW1l
LiBBY2NvdW50IGZvciB0aGF0IHF1aXJrIGJ5IGNvbWJpbmluZyBQQ0lFIHBvd2VyIGRvbWFpbnMg
aW50byBhCj4gc2luZ2xlICdwZ2NfcGNpZScgcG93ZXIgZG9tYWluLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IEFuZHJleSBTbWlybm92IDxhbmRyZXcuc21pcm5vdkBnbWFpbC5jb20+Cj4gQ2M6IFNoYXdu
IEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4KPiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0
ZXZhbUBueHAuY29tPgo+IENjOiBDaHJpcyBIZWFseSA8Y3BoZWFseUBnbWFpbC5jb20+Cj4gQ2M6
IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgo+IENjOiBMZW9uYXJkIENyZXN0
ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPgo+IENjOiAiQS5zLiBEb25nIiA8YWlzaGVuZy5k
b25nQG54cC5jb20+Cj4gQ2M6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4KPiBD
YzogbGludXgtaW14QG54cC5jb20KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKCk5pdCBiZWxvdywgb3Ro
ZXJ3aXNlOgoKUmV2aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRl
PgoKPiAtLS0KPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpIHwg
MjEgKysrKysrKysrKysrKysrKysrKystCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtcS5kdHNpCj4gaW5kZXggNTA0MzZiZDM5M2VkLi44OWJhYmM1MzEzODAgMTAwNjQ0Cj4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiArKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQo+IEBAIC0yNzMsOSArMjczLDI4
IEBACj4gwqAJCQkJCQlyZWcgPSA8SU1YOE1fUE9XRVJfRE9NQUlOX01JUEk+Owo+IMKgCQkJCQl9
Owo+IMKgCj4gLQkJCQkJcGdjX3BjaWUxOiBwb3dlci1kb21haW5AMSB7Cj4gKwkJCQkJLyoKPiAr
CQkJCQnCoCogQXMgcGVyIGNvbW1lbnQgaW4gQVRGIHNvdXJjZSBjb2RlOgo+ICsJCQkJCcKgKgo+
ICsJCQkJCcKgKiBQQ0lFMSBhbmQgUENJRTIgc2hhcmUgdGhlCj4gKwkJCQkJwqAqIHNhbWUgcmVz
ZXQgc2lnbmFsLCBpZiB3ZQo+ICsJCQkJCcKgKiBwb3dlciBkb3duIFBDSUUyLCBQQ0lFMQo+ICsJ
CQkJCcKgKiB3aWxsIGJlIGhlbGQgaW4gcmVzZXQgdG9vLgo+ICsJCQkJCcKgKgo+ICsJCQkJCcKg
KiBTbyBpbnN0ZWFkIG9mIGNyZWF0aW5nIHR3bwo+ICsJCQkJCcKgKiBzZXBhcmF0ZSBwb3dlciBk
b21haW5zIGZvcgo+ICsJCQkJCcKgKiBQQ0lFMSBhbmQgUENJRTIuIFdlIGNyZWF0ZQo+ICsJCQkJ
CcKgKiBhIGxpbmsgYmV0d2VlbiAxIGFuZCAxMCBhbmQKCjEgYW5kIDEwIGlzIG5vdCBzb21ldGhp
bmcgdGhhdCBkaXJlY3RseSBzaG93cyB1cCBpbiB0aGUgRFRTLCBzbyBJIHRoaW5rCml0IGNvdWxk
IGJlIGNvbmZ1c2luZyB0byB0aGUgcmVhZGVyLiBJIHdvdWxkIGp1c3Qgc3RhdGUgdGhhdCBhcyAi
bGluawpiZXR3ZWVuIGJvdGgiIG9yIHNvbWV0aGluZyB0byB0aGF0IHR1bmUuCgo+ICsJCQkJCcKg
KiB1c2Ugd2hhdCB3YXMgc3VwcG9zZWQgdG8gYmUKPiArCQkJCQnCoCogZG9tYWluIDEgYXMgYSBz
aGFyZWQgUENJRQo+ICsJCQkJCcKgKiBwb3dlciBkb21haW4gcG93ZXJpbmcgYm90aAo+ICsJCQkJ
CcKgKiBQQ0lFMSBhbmQgUENJRTIgYXQgdGhlIHNhbWUKPiArCQkJCQnCoCogdGltZQo+ICsJCQkJ
CcKgKi8KPiArCQkJCQlwZ2NfcGNpZTogcG93ZXItZG9tYWluQDEgewo+IMKgCQkJCQkJI3Bvd2Vy
LWRvbWFpbi1jZWxscyA9IDwwPjsKPiDCoAkJCQkJCXJlZyA9IDxJTVg4TV9QT1dFUl9ET01BSU5f
UENJRTE+Owo+ICsJCQkJCQlwb3dlci1kb21haW5zID0gPCZwZ2NfcGNpZTI+Owo+IMKgCQkJCQl9
Owo+IMKgCj4gwqAJCQkJCXBnY19vdGcxOiBwb3dlci1kb21haW5AMiB7CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
