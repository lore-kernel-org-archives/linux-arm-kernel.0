Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC43C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:48:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3FB2184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uowbbTcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3FB2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=A4ZfPKznHjSHF0nQrvGTGNoMUq7ID2h1ngBFPda2mXk=; b=uowbbTcSq48LPJ
	ZGvy94wPjnSJXNXISs7blCretJTDk7Pbxw/42RlJPTHtdL+kecZhTPZw0aoMj8QDTWrGKiqiFnjd5
	/mFwxYXyNIPRM7dJUtKUqS6BsxS1RqqC9BwI2nrvCxu5/PvQkHrSKUiElQogiJVeyOY5OISGEl5o1
	tqUS6dqd6QohQ/yLQqwXz9yq4TpfRDe/1b2MFWLID5/F50nyHfjTlfOmjyzRR6IpInRcR86G7Eh9w
	OzbZfjQILht7v6C2X4iJKZ+JL7P5rtd75Wkf1KSyM17jDnvApsA3YuW6U7bfIDdM/9EjMeZx7IAAG
	PfFMOGH19zcbfuG+/xgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtKNP-0007ZV-3M; Mon, 11 Feb 2019 22:48:35 +0000
Received: from gateway31.websitewelcome.com ([192.185.144.218])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtKNL-0007Yc-Dg
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 22:48:32 +0000
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id D1E4CD5B27
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 16:48:28 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id tKNIgGWxWYTGMtKNIgaQEI; Mon, 11 Feb 2019 16:48:28 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=34554 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gtKNH-004NRh-R2; Mon, 11 Feb 2019 16:48:27 -0600
Date: Mon, 11 Feb 2019 16:48:27 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] mfd: mxs-lradc: Mark expected switch fall-through
Message-ID: <20190211224827.GA28902@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gtKNH-004NRh-R2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:34554
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 58
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_144831_502937_B1FA8645 
X-CRM114-Status: GOOD (  10.72  )
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
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SW4gcHJlcGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCwgbWFyayBz
d2l0Y2gKY2FzZXMgd2hlcmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2guCgpUaGlz
IHBhdGNoIGZpeGVzIHRoZSBmb2xsb3dpbmcgd2FybmluZzoKCmRyaXZlcnMvbWZkL214cy1scmFk
Yy5jOiBJbiBmdW5jdGlvbiDigJhteHNfbHJhZGNfcHJvYmXigJk6CmRyaXZlcnMvbWZkL214cy1s
cmFkYy5jOjE3OTo3OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFst
V2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0KICAgIGlmIChscmFkYy0+c29jID09IElNWDI4X0xSQURD
KSB7CiAgICAgICBeCmRyaXZlcnMvbWZkL214cy1scmFkYy5jOjE4NTozOiBub3RlOiBoZXJlCiAg
IGRlZmF1bHQ6CiAgIF5+fn5+fn4KCldhcm5pbmcgbGV2ZWwgMyB3YXMgdXNlZDogLVdpbXBsaWNp
dC1mYWxsdGhyb3VnaD0zCgpOb3RpY2UgdGhhdCwgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UsIHRo
ZSBjb2RlIGNvbW1lbnQgaXMgbW9kaWZpZWQKaW4gYWNjb3JkYW5jZSB3aXRoIHdoYXQgR0NDIGlz
IGV4cGVjdGluZyB0byBmaW5kLgoKVGhpcyBwYXRjaCBpcyBwYXJ0IG9mIHRoZSBvbmdvaW5nIGVm
Zm9ydHMgdG8gZW5hYmxlCi1XaW1wbGljaXQtZmFsbHRocm91Z2guCgpTaWduZWQtb2ZmLWJ5OiBH
dXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPgotLS0KIGRyaXZlcnMv
bWZkL214cy1scmFkYy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvbXhzLWxyYWRjLmMgYi9kcml2
ZXJzL21mZC9teHMtbHJhZGMuYwppbmRleCA5OGU3MzJhN2FlOTYuLmEwOWE4ZDA2MzAyYiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9tZmQvbXhzLWxyYWRjLmMKKysrIGIvZHJpdmVycy9tZmQvbXhzLWxy
YWRjLmMKQEAgLTE4MSw3ICsxODEsNyBAQCBzdGF0aWMgaW50IG14c19scmFkY19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQkJCQlNWFNfTFJBRENfVE9VQ0hTQ1JFRU5fNVdJ
UkU7CiAJCQkJYnJlYWs7CiAJCQl9Ci0JCQkvKiBmYWxsIHRocm91Z2ggdG8gYW4gZXJyb3IgbWVz
c2FnZSBmb3IgaS5NWDIzICovCisJCQkvKiBmYWxsIHRocm91Z2ggLSB0byBhbiBlcnJvciBtZXNz
YWdlIGZvciBpLk1YMjMgKi8KIAkJZGVmYXVsdDoKIAkJCWRldl9lcnIoJnBkZXYtPmRldiwKIAkJ
CQkiVW5zdXBwb3J0ZWQgbnVtYmVyIG9mIHRvdWNoc2NyZWVuIHdpcmVzICglZClcbiIKLS0gCjIu
MjAuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
