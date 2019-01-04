Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B9BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:08:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209B22184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aR0XYjQt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v54FwiM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209B22184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=T/vYPpgUcsq0G3EsWpMnPIJN0LdmUUos9b32K2DqXoQ=; b=aR0XYjQtu8Xo2X
	kP8gO1sbCfHe5gHDDzdQRs/gIjP/+dByCYJyVS943ddAbhiXFYijbFmJ10vbF2TgxQRbZPOIZo0FM
	CmIS7dmyHMkgJPFjPO3yCx0eT9ZKOC0OQ5PfQJNPQBML4VWzJ1B4G/7sVu35f0mxqol6mfRAahNWY
	lmCX2f86jwZdRJeXg5c1rfdpzBmlBxHQAWj8wByW2niE51HrwM94pCf+pKvZurhZLTPAwsSTON0/+
	XRkPm5cGxDgDNzkNr8oJFkpZ4B7RWBjCAFlfLvcdTYoCpcZl4EciWyGfINyUNtxWiLzFKEE+ZMByc
	+DJpykjqQsWcWWmXLOng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLTK-0006MF-VJ; Fri, 04 Jan 2019 09:08:54 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLTE-0006KQ-6O
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 09:08:50 +0000
Received: by mail-ed1-x541.google.com with SMTP id h15so31180383edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 01:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rro8edKkspDsyyMgwTCAKGZP90S23S8Mpy2HGaolC+U=;
 b=v54FwiM+HJcwereFzem42m0Q+PUWYc4Qmcn7F742Drr8zKDSFetWKWaIS8mNrC4hCd
 JA0z4EdreTPJSu9d/t9SMUCZFh+XNi2hD0eQNk/fqiis9v3HXjE72gbSDszWY/cPlvIB
 w5vnVZHNn4AbopXwoWVJocDQVE76agb8d1OHVujkRpnhvcpWinQ0vR2/JhVDYy+UeeTv
 /jewQ02JTz0ueomyhWOqlOxdk6s4ztjabHbM1mluh5SEurEtF53+yBn/Hrke2iS1XERy
 E/8AvLWa7Cni+3LCcHr9KiqbFjPHOUK2W89RxNZ9ojWRERkGI9pMKE4REJVTe3fm/4ny
 /KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rro8edKkspDsyyMgwTCAKGZP90S23S8Mpy2HGaolC+U=;
 b=XtRktKF0ugFfth6dPVUWitCVrDE8CpkzKmz20hlFE4gW/cjyOYCdWk84m0MH1dzwQv
 M/ry+9L7c3+czFwXCIRS+TYpTCk5AfklgQHaMTZhOARlsmXO/czMURX0X/Qd9KCpGx0G
 Mym1/nSWxkrnETG2eDEAzYOwjprezQbB61++b+6yf/S/Y51o4V7hXA3bFKUyQLH7chrL
 BcJfAAyEe/s+0tBucNQryF217vy6lGkLzbLsxiWR+e8m62kGtK+4Am+CpvhWjnkCTj6T
 SBa9IUeDLPBxE+vRHR9WB3v3xSYZqdyTJPi88suxvI2PQh/kCqK3YFfJLBF2Ains+mWH
 YrFw==
X-Gm-Message-State: AA+aEWYZhm+nG4PHL4Jm0UheEZoRcLRmNRDeaQy1fxOYCNIesh6S68W+
 dqPzHxJW/Y478CQe4/ITzuBXWjsI5K4=
X-Google-Smtp-Source: AFSGD/UmoQlwTyOTfvgUi0Sh3vYYxytT7a1XJGMaK3OTpwLWlOcSUl+erzLqGAnERmwCnAgXqCMZTg==
X-Received: by 2002:a17:906:f04:: with SMTP id
 z4-v6mr38740333eji.106.1546592924349; 
 Fri, 04 Jan 2019 01:08:44 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
 by smtp.googlemail.com with ESMTPSA id o37sm24706587edc.32.2019.01.04.01.08.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 04 Jan 2019 01:08:43 -0800 (PST)
From: Corentin Labbe <clabbe@baylibre.com>
To: bhelgaas@google.com,
	khilman@baylibre.com,
	lorenzo.pieralisi@arm.com
Subject: [PATCH] PCI: amlogic: fix build failure due to missing
 linux/gpio/consumer.h header
Date: Fri,  4 Jan 2019 09:08:37 +0000
Message-Id: <1546592917-27846-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_010848_301863_42B9C8B0 
X-CRM114-Status: GOOD (  11.68  )
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
Cc: linux-amlogic@lists.infradead.org, Corentin Labbe <clabbe@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

V2hlbiBidWlsZGluZyBvbiB4ODYsIEkgZ290IHRoZSBmb2xsb3dpbmcgYnVpbGQgZmFpbHVyZToK
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLW1lc29uLmM6IEluIGZ1bmN0aW9uIOKAmG1l
c29uX3BjaWVfYXNzZXJ0X3Jlc2V04oCZOgpkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2kt
bWVzb24uYzoyOTA6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKA
mGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcOKAmTsgZGlkIHlvdSBtZWFuIOKAmGdwaW9fc2V0X3Zh
bHVlX2NhbnNsZWVw4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0K
ICBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAobXAtPnJlc2V0X2dwaW8sIDApOwogIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fgogIGdwaW9fc2V0X3ZhbHVlX2NhbnNsZWVwCmRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1tZXNvbi5jOiBJbiBmdW5jdGlvbiDigJhtZXNvbl9wY2llX3Byb2Jl
4oCZOgpkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbWVzb24uYzo1NDA6MTk6IGVycm9y
OiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhkZXZtX2dwaW9kX2dldOKAmTsg
ZGlkIHlvdSBtZWFuIOKAmGRldm1fZ3Bpb19mcmVl4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5j
dGlvbi1kZWNsYXJhdGlvbl0KICBtcC0+cmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0KGRldiwg
InJlc2V0IiwgR1BJT0RfT1VUX0xPVyk7CiAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+
fgogICAgICAgICAgICAgICAgICAgZGV2bV9ncGlvX2ZyZWUKZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpLW1lc29uLmM6NTQwOjQ4OiBlcnJvcjog4oCYR1BJT0RfT1VUX0xPV+KAmSB1bmRl
Y2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiDigJhHUElP
Rl9JTklUX0xPV+KAmT8KICBtcC0+cmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0KGRldiwgInJl
c2V0IiwgR1BJT0RfT1VUX0xPVyk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgR1BJT0ZfSU5JVF9MT1cKClRoaXMgaXMgZHVlIHRvIHRoZSBtaXNz
aW5nIGxpbnV4L2dwaW8vY29uc3VtZXIuaCBoZWFkZXIKClNpZ25lZC1vZmYtYnk6IENvcmVudGlu
IExhYmJlIDxjbGFiYmVAYmF5bGlicmUuY29tPgotLS0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1tZXNvbi5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbWVzb24uYyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1tZXNvbi5jCmluZGV4IDI0MWViZTBjNDUwNS4uZTM1
ZTllYWE1MGVlIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbWVz
b24uYworKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbWVzb24uYwpAQCAtOCw2
ICs4LDcgQEAKIAogI2luY2x1ZGUgPGxpbnV4L2Nsay5oPgogI2luY2x1ZGUgPGxpbnV4L2RlbGF5
Lmg+CisjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPgogI2luY2x1ZGUgPGxpbnV4L29m
X2RldmljZS5oPgogI2luY2x1ZGUgPGxpbnV4L29mX2dwaW8uaD4KICNpbmNsdWRlIDxsaW51eC9w
Y2kuaD4KLS0gCjIuMTkuMgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
