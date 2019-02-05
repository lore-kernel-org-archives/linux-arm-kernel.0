Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9D3C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:47:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397072080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pA6Oy9ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397072080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Krw4tGj0LUilvnysiTwI5nYVowwVMpfnFt9UWgFSLMY=; b=pA6Oy9ev2ban8/
	L4jqSeR4IlfhN4SrZtwfOZCGETFol+JyjwhhU8W/WthJGR8nNQ/oK3wqwldbrRUBbgqZOei2OxRGJ
	K8h+UY9ZkGK4CokaFn4oXV5F4ACxOPDuTV3v0P/AFkKPpeM2tC9ye23JQAZGQIVWWZuRa9luhOMW9
	4ysiiN5j9CLQ4993ud4nQJrO6+wvssxY5LrU7r0GweUsl8lGL/LeCJ4uK1YQuSYQXlfGFfsarHz/4
	E3BcaeIIjFgtJDCllJZScMsHhVbYtqtFRDv2hZuHGJ4kA1IiTVtnP/4Q8AzxBysb7cfaNqDuvaIuu
	Tgnpw1dUteAHwN1aosiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxJv-0008VK-5U; Tue, 05 Feb 2019 09:47:11 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxJr-0008UI-Dp
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 09:47:08 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gqxJn-0002aD-Ui; Tue, 05 Feb 2019 10:47:03 +0100
Message-ID: <1549360023.2544.35.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] ARM: dts: imx7d: Add node for PCIe PHY
From: Lucas Stach <l.stach@pengutronix.de>
To: Trent Piepho <tpiepho@impinj.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Date: Tue, 05 Feb 2019 10:47:03 +0100
In-Reply-To: <20190205001721.18639-3-tpiepho@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
 <20190205001721.18639-3-tpiepho@impinj.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_014707_619581_61C2EFD2 
X-CRM114-Status: GOOD (  15.24  )
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
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRGllbnN0YWcsIGRlbiAwNS4wMi4yMDE5LCAwMDoxNyArMDAwMCBzY2hyaWViIFRyZW50IFBp
ZXBobzoKPiBUaGlzIGFkZHMgdGhlIFBIWSBhcyBhIG5ldyBub2RlLsKgwqBUaGUgUENJLWUgY29u
dHJvbGxlciBub2RlIGdhaW5zIGEKPiBwaGFuZGxlIHByb3BlcnR5IHRoYXQgcG9pbnRzIHRvIGl0
Lgo+IAo+IFRoZXJlIGlzbid0IHlldCBhbnkgY29kZSBpbiB0aGUga2VybmVsIHRoYXQgdXNlcyB0
aGlzIGRldmljZSdzCj4gcmVnaXN0ZXJzLCBidXQgaXQgd2lsbCBiZSBhZGRlZCBmb3IgYSBQQ0ll
IFBMTCBlcnJhdHVtIHdvcmthcm91bmQuCj4gCj4gU2lnbmVkLW9mZi1ieTogVHJlbnQgUGllcGhv
IDx0cGllcGhvQGltcGluai5jb20+CgpMb29rcyBnb29kLCBidXQgbmVlZHMgYW4gQWNrIG9uIHRo
ZSBiaW5kaW5nIGNoYW5nZS4gQWxzbyB0aGlzIHNob3VsZCBnbwp0aHJvdWdoIFNoYXducyB0cmVl
LCBzbyBuZWVkcyB0byBiZSBzcGxpdCBvdXQgZnJvbSB0aGUgc2VyaWVzLgoKUmVnYXJkcywKTHVj
YXMKCj4gLS0tCj4gwqBhcmNoL2FybS9ib290L2R0cy9pbXg3ZC5kdHNpIHwgOSArKysrKysrKysK
PiDCoDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14N2QuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDdkLmR0c2kK
PiBpbmRleCA2YjI5OGUzODhmNGIuLjZlYjk4ZTdjNTY4ZCAxMDA2NDQKPiAtLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9pbXg3ZC5kdHNpCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14N2QuZHRz
aQo+IEBAIC05Niw2ICs5NiwxNCBAQAo+ID4gwqAJfTsKPiDCoH07Cj4gwqAKPiArJmFpcHMyIHsK
PiArCXBjaWVfcGh5OiBwY2llLXBoeUAzMDZkMDAwMCB7Cj4gKwkJwqDCoGNvbXBhdGlibGUgPSAi
ZnNsLGlteDdkLXBjaWUtcGh5IjsKPiArCQnCoMKgcmVnID0gPDB4MzA2ZDAwMDAgMHgxMDAwMD47
Cj4gKwkJwqDCoHN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gKwl9Owo+ICt9Owo+ICsKPiDCoCZhaXBz
MyB7Cj4gwqAJdXNib3RnMjogdXNiQDMwYjIwMDAwIHsKPiDCoAkJY29tcGF0aWJsZSA9ICJmc2ws
aW14N2QtdXNiIiwgImZzbCxpbXgyNy11c2IiOwo+IEBAIC0xNzMsNiArMTgxLDcgQEAKPiDCoAkJ
CcKgPCZzcmMgSU1YN19SRVNFVF9QQ0lFX0NUUkxfQVBQU19FTj4sCj4gwqAJCQnCoDwmc3JjIElN
WDdfUkVTRVRfUENJRV9DVFJMX0FQUFNfVFVSTk9GRj47Cj4gwqAJCXJlc2V0LW5hbWVzID0gInBj
aWVwaHkiLCAiYXBwcyIsICJ0dXJub2ZmIjsKPiArCQlmc2wsaW14N2QtcGNpZS1waHkgPSA8JnBj
aWVfcGh5PjsKPiDCoAkJc3RhdHVzID0gImRpc2FibGVkIjsKPiDCoAl9Owo+IMKgfTsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
