Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024D6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:06:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02EB21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hieCetQR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5Oa3zfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02EB21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+0GRK//h3WL2Vd738Qr+u6hcI7EZ4HITEVbdp+Ynpjs=; b=hieCetQR12vCQh
	6O+XdIswrpYUO77BoG9xebdpJDfOEvErx1R71XnT8olbl51xSaMU7bxklxYAS0OEGljxilP5JEazw
	dvbgv3pNpx/B05cmVDbAL4ypeulme03c1O4ZkHrFpq7koSkd2rMmf+PO98zO1wQ8cdKSF1y7Zpyew
	giu9lHmManbOAy8xwSkTVDlNhGRYcwtE0f8xs9k6tV5c9rxuwvcD8NLV4Z8eW4f9q+YR8GMVPlVuf
	5REt5Bd+/5oaQwf+X3q/MJNnG86mMMvxPXtQkxknEjzNPFjuKiPN3DQR08RNO5d4imNKQuiOshOVH
	mgbbb8W6WbYNrTMsRW9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGxO-0004CM-OL; Tue, 18 Dec 2018 15:06:50 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGvH-0001GU-Vs
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:04:51 +0000
Received: by mail-pl1-x644.google.com with SMTP id g9so7935906plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0jyh8TbRs+ubBftXUDu/ZeKR3wTzPoQdZ/y0YGX+yt4=;
 b=D5Oa3zfVcAufguxSRzGRil09A8Zh04Xom2E0ByjblKOSRs6lYPjhNGtxmLEbRO8oJ3
 QavOgFqqqDHwTEuq3nNEwKyW9JQwbh/mVkv9xc4dp5uEqrjF+gIKN+eagAdqmqQwU4E8
 uLU/B9pKY5la5s/4V0EZATDJRZ05fEcF7qk8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0jyh8TbRs+ubBftXUDu/ZeKR3wTzPoQdZ/y0YGX+yt4=;
 b=QLnct/d7eOc+TDDdiYFqfXGBsWr0n084u0lmEq3LVPS1JjqCRqraHs6gLmXjv8sjG3
 9o50SH+AmDHjTRbqjSEv2reC4bKR1HW/9MIF+sTnlEeMYWLfP10bvInsDGyizX8KJncY
 NLQp0axfqIM1cKtqSGijZOrtmvtnTXFt7Ni2aT+fILbyzM9jkYAZ4iNPb3dnrekqTc05
 7PQLmuLl9N8dX6YT/h0dImGg1LVhAUSOc7ixZkiQ8+7EWXJtZZdwgvcU2Tsky7bDI2Wm
 bDOotm7U1bFAv0kWfogYY3JGh2TaiJ6DoOcl6YNar8E9I0wyDPVKvt+7k3CRMKPTAo/9
 ALSg==
X-Gm-Message-State: AA+aEWaTGl8fgrc854eN/l/7WWD8VPnUmvSeaEdsseLB0yO/9NHKgXLp
 U5JFPpleHGxVR8zkc2VTe+8c
X-Google-Smtp-Source: AFSGD/VyU784cM7cGnfB1aooBbjFAv1aJg6D7/Z6N2CMXMr5r5RAkWIl3cWKMw7FgKAckum2B5UzOA==
X-Received: by 2002:a17:902:ba89:: with SMTP id
 k9mr16974772pls.189.1545145469147; 
 Tue, 18 Dec 2018 07:04:29 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.04.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 07:04:28 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 11/11] MAINTAINERS: Add entry for RDA Micro SoC architecture
Date: Tue, 18 Dec 2018 20:32:38 +0530
Message-Id: <20181218150238.23010-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_070440_520905_BA67FB67 
X-CRM114-Status: UNSURE (   9.63  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 linus.walleij@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, afaerber@suse.de,
 zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QWRkIE1BSU5UQUlORVJTIGVudHJ5IGZvciBSREEgTWljcm8gU29DIGFyY2hpdGVjdHVyZSB3aXRo
IG15c2VsZgphcyB0aGUgbWFpbnRhaW5lci4KClNpZ25lZC1vZmYtYnk6IE1hbml2YW5uYW4gU2Fk
aGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+CkFja2VkLWJ5OiBBcm5k
IEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgotLS0KIE1BSU5UQUlORVJTIHwgMTQgKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvTUFJ
TlRBSU5FUlMgYi9NQUlOVEFJTkVSUwppbmRleCAzMzE4ZjMwOTAzYjIuLmRhMjE0OTk0OWZkNyAx
MDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTE5NTAsNiArMTk1
MCwyMCBAQCBNOglMZW5uZXJ0IEJ1eXRlbmhlayA8a2VybmVsQHdhbnRzdG9mbHkub3JnPgogTDoJ
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1z
dWJzY3JpYmVycykKIFM6CU1haW50YWluZWQKIAorQVJNL1JEQSBNSUNSTyBBUkNISVRFQ1RVUkUK
K006CU1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5v
cmc+CitMOglsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcgKG1vZGVyYXRlZCBm
b3Igbm9uLXN1YnNjcmliZXJzKQorTDoJbGludXgtdW5pc29jQGxpc3RzLmluZnJhZGVhZC5vcmcg
KG1vZGVyYXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQorUzoJTWFpbnRhaW5lZAorRjoJYXJjaC9h
cm0vYm9vdC9kdHMvcmRhODgxMHBsLSoKK0Y6CWRyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItcmRh
LmMKK0Y6CWRyaXZlcnMvaXJxY2hpcC9pcnEtcmRhLWludGMuYworRjoJZHJpdmVycy90dHkvc2Vy
aWFsL3JkYS11YXJ0LmMKK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
cmRhLnR4dAorRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1j
b250cm9sbGVyL3JkYSw4ODEwcGwtaW50Yy50eHQKK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zZXJpYWwvcmRhLDg4MTBwbC11YXJ0LnR4dAorRjoJRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL3JkYSw4ODEwcGwtdGltZXIudHh0CisKIEFSTS9SRUFM
VEVLIEFSQ0hJVEVDVFVSRQogTToJQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgog
TDoJbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnIChtb2RlcmF0ZWQgZm9yIG5v
bi1zdWJzY3JpYmVycykKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
