Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E1EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:08:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7272133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NuJHoKlq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3h/8Wro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7272133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rYWAUV2vC/gOY6G4hnwLFzLU5Yq0RPT2nM0BqQafTaw=; b=NuJHoKlqFBLGtD
	u+6DBPraR+ygJPbfuJgyQ+Jswy8paNrBFFe/5jie0fK9kCY4jXuS2k+ahQ2UHolALqQbGvjle2Zis
	0M3u98pbAoZV3CeZzHBEFE6YqHGBiF3wzYumwD7JOYDp200DvdNQbPF0j8YEivaxwSo7SWIUTD0Z7
	EVDCkv2GdsUt9AuVXLX76fYljz3K3lxwjalrwGUPt5qyVSLJfXVGeJruz2fnreMOAHWxBW/97LWKJ
	fTldVizUZ81uJ03NV7rb+7wEE15u4avFcqFx6C0sYwYiJkz+0ln+DYrhzhGISrMPCmX7opd84ji5w
	ozFlHHbGzdykfunnrMXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAPz-0000k3-Nj; Tue, 18 Dec 2018 08:07:55 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAOf-00083B-GW
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:06:55 +0000
Received: by mail-pf1-x442.google.com with SMTP id i12so7752090pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 00:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jBeXaJXIkgLTVAea7CD+4QY6FweZRNu6qTHTVAB8x/Y=;
 b=O3h/8WrootvgLo6iq19RENYMSgRZXgcAimJmVbJ1apvTl0v088S7GX4+j8W4I1AWTU
 d6QGZUDdXG8lODI4a2XlfM9kWxlSZ1mfYCxShhmwuUDpJ8n+lIfjad/tMyTDmHaZoPqt
 oCcK89JeiKGxtLVa8rx5HzDxbciCXatzC81ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jBeXaJXIkgLTVAea7CD+4QY6FweZRNu6qTHTVAB8x/Y=;
 b=X/sSEfiXfsDkMSqy+GJbeZr0kEY+QjCDD9byq4OkdJzRcHU2irkVqpRwnK/t65flg/
 1LEDf6zvrtd4v9omTDUnDnwq+CcvqkJ/oPMP+Ign8g5/3QVDfY1y+zql4coqRGfdz6uI
 3EkeO1VY0HnpG4NE5lkl4COPFssIlEl2bEI0HxWN6mPNKtQkazH6JSNa09r5H455EUm0
 sIWcFXZnFSQo6eDhFoof2rb5jQxMPs0KmgP6EEIqi28ZxdgoyKcmbYOwgSCkCpoHgqcF
 4l3iXafEMNmpnaD99ga4Ua96V2m/hvMQbEMVFKLJTDFBaNEbM/g2hTaMgrBSh7xEYhFU
 D2Bw==
X-Gm-Message-State: AA+aEWYVVHLuGY3GWYCuurk0Cu3/yv0CWeObMix0VDTEUYM35o9SQzwX
 fuSdeL9k6vLKsAEk5755l9XB
X-Google-Smtp-Source: AFSGD/WBh09Nz1b5fu1kid9HelfFVw/BVqdKmZUoUY3UtqyX1OnuV3yltB+DYa7g07SVikdPvhg26w==
X-Received: by 2002:a65:55ca:: with SMTP id k10mr14788239pgs.448.1545120382887; 
 Tue, 18 Dec 2018 00:06:22 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.06.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 00:06:21 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v6 05/11] ARM: dts: Add devicetree for OrangePi 2G IoT board
Date: Tue, 18 Dec 2018 13:35:21 +0530
Message-Id: <20181218080527.10801-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_000634_080077_6C585648 
X-CRM114-Status: GOOD (  14.24  )
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
Cc: devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QWRkIGluaXRpYWwgZGV2aWNldHJlZSBzdXBwb3J0IGZvciBPcmFuZ2VQaSAyRyBJb1QgYm9hcmQg
ZnJvbSBYdW5sb25nLgoKU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBz
dXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4u
c2FkaGFzaXZhbUBsaW5hcm8ub3JnPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlICAg
ICAgICAgICAgICAgICAgICB8ICAyICsKIC4uLi9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGkt
MmctaW90LmR0cyAgICB8IDUwICsrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwg
NTIgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL3Jk
YTg4MTBwbC1vcmFuZ2VwaS0yZy1pb3QuZHRzCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvTWFrZWZpbGUgYi9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZQppbmRleCBiMGU5NjZkNjI1
YjkuLmEwZmRhZDhmMTBkZCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUK
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUKQEAgLTgwNiw2ICs4MDYsOCBAQCBkdGIt
JChDT05GSUdfQVJDSF9RQ09NKSArPSBcCiAJcWNvbS1tc204OTc0LXNvbnkteHBlcmlhLWNhc3Rv
ci5kdGIgXAogCXFjb20tbXNtODk3NC1zb255LXhwZXJpYS1ob25hbWkuZHRiIFwKIAlxY29tLW1k
bTk2MTUtd3A4NTQ4LW1hbmdvaC1ncmVlbi5kdGIKK2R0Yi0kKENPTkZJR19BUkNIX1JEQSkgKz0g
XAorCXJkYTg4MTBwbC1vcmFuZ2VwaS0yZy1pb3QuZHRiCiBkdGItJChDT05GSUdfQVJDSF9SRUFM
VklFVykgKz0gXAogCWFybS1yZWFsdmlldy1wYjExNzYuZHRiIFwKIAlhcm0tcmVhbHZpZXctcGIx
MW1wLmR0YiBcCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwtb3Jhbmdl
cGktMmctaW90LmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC1vcmFuZ2VwaS0yZy1p
b3QuZHRzCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uOThlMzQyNDhh
ZTgwCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLW9yYW5n
ZXBpLTJnLWlvdC5kdHMKQEAgLTAsMCArMSw1MCBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IChHUEwtMi4wKyBPUiBNSVQpCisvKgorICogQ29weXJpZ2h0IChjKSAyMDE3IEFuZHJlYXMg
RsOkcmJlcgorICogQ29weXJpZ2h0IChjKSAyMDE4IE1hbml2YW5uYW4gU2FkaGFzaXZhbQorICov
CisKKy9kdHMtdjEvOworCisjaW5jbHVkZSAicmRhODgxMHBsLmR0c2kiCisKKy8geworCWNvbXBh
dGlibGUgPSAieHVubG9uZyxvcmFuZ2VwaS0yZy1pb3QiLCAicmRhLDg4MTBwbCI7CisJbW9kZWwg
PSAiT3JhbmdlIFBpIDJHLUlvVCI7CisKKwlhbGlhc2VzIHsKKwkJc2VyaWFsMCA9ICZ1YXJ0MTsK
KwkJc2VyaWFsMSA9ICZ1YXJ0MjsKKwkJc2VyaWFsMiA9ICZ1YXJ0MzsKKwl9OworCisJY2hvc2Vu
IHsKKwkJc3Rkb3V0LXBhdGggPSAic2VyaWFsMjo5MjE2MDBuOCI7CisJfTsKKworCW1lbW9yeUA4
MDAwMDAwMCB7CisJCWRldmljZV90eXBlID0gIm1lbW9yeSI7CisJCXJlZyA9IDwweDgwMDAwMDAw
IDB4MTAwMDAwMDA+OworCX07CisKKwl1YXJ0X2NsazogdWFydC1jbGsgeworCQljb21wYXRpYmxl
ID0gImZpeGVkLWNsb2NrIjsKKwkJY2xvY2stZnJlcXVlbmN5ID0gPDkyMTYwMD47CisJCSNjbG9j
ay1jZWxscyA9IDwwPjsKKwl9OworfTsKKworJnVhcnQxIHsKKwlzdGF0dXMgPSAib2theSI7CisJ
Y2xvY2tzID0gPCZ1YXJ0X2Nsaz47Cit9OworCismdWFydDIgeworCXN0YXR1cyA9ICJva2F5IjsK
KwljbG9ja3MgPSA8JnVhcnRfY2xrPjsKK307CisKKyZ1YXJ0MyB7CisJc3RhdHVzID0gIm9rYXki
OworCWNsb2NrcyA9IDwmdWFydF9jbGs+OworfTsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
