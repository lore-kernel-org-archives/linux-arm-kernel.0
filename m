Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:38:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF382082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HNKCTEMP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3bOoblA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF382082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BgG44M9LFmqNamJizgu0fAXGYr7jgZByo0qzH4PH5/M=; b=HNKCTEMPD/Nb0P
	xUGQWxislkIvyvtkLi85YLIfPx/F2w3VJkIBktAZb+1Oozgqv/dOxmq5+WsBhd8BVThqMpHfO1BZo
	2O9poDdPqwW3VAu3rYmlYSUawM9ld2AJ+qbu7s7UCJDbU5wlSXHfJzzYNVGlM6SdrRqcmncu1AJF9
	0lczrshzhv/6qMlmnd831s+BfcX4cik9yQ0bJZAOrlgLNJcjwUY0XKVvGpLMmWRs3y1jCX1y6my2h
	8ZZWHuFNT5+9V610RMfeQ9i+3MGW8CmrQ5prd6TbHNtzxdSsS8PQLoGC/jAovp68duY6NlZi+ihiE
	+aDwQEkR/gk652+NtMEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPW3-0001fy-Pv; Mon, 10 Dec 2018 17:38:47 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPVe-0001Ir-Hd
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:38:39 +0000
Received: by mail-pg1-x542.google.com with SMTP id s198so5291498pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L2eV2hqdutu4ir5j3LLCjolH3gJjyj+3j8k2gdmQdYQ=;
 b=U3bOoblAbInzfGegDoqhu/9kzokD3qYrXQEvRqPoXjgdQbBSoVsM6t8qPvVWWB6d1e
 clFu4aY8URJegm/tiF/A5fS0ktOg9ojkNK/CJhdqLWmIHnO/bQxGidPqezZ5lq9g8kZ2
 phoYjERqhnlslQijiijN9QmD/PuLX2NhDcfsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L2eV2hqdutu4ir5j3LLCjolH3gJjyj+3j8k2gdmQdYQ=;
 b=KrJuERxHUTdXFk+kSl6+O850YRYnq91ZaSjQsW/n7R8GoOMdWzWRUGqJg3ha5Ln3U3
 yB10KyMN84Q1Roas9cu36GMtFL7N5n1qqlQ/74Mn+mwdeYYD81xz8YMAYpIXNqQVN4wj
 xOm7SI2g4F1fWbnqzLspJIAMv2xuiUGfnmO+JXRPrWpaeOYteRhqCpNm022IaAPzU5Ax
 I1eLo5EqUdfb3BGRZl+WcZSkzqKSvCTWdjbTGMeNQBEv2WARZdB0tORX+1L83bO9H7SI
 0eKxiPIbsokPCLEUuOInSokXedu+I7hF7JbwTwGLgOPoRMoZbzfC0yfskz5bBGIK+vvJ
 B7zg==
X-Gm-Message-State: AA+aEWaRTq7kXwNnwaVV2Vpm0swe/Pbss18FQrHXhl08xRoEhoOwzNI1
 mElRwqy7PxrQtr+xz6Uf+hoV
X-Google-Smtp-Source: AFSGD/XxM+bjkbXbopbHPNceRfGRUiDM+u2u1wyu/fT/vDmKU7El5RY98fcKsK+PHEMwlH0st05b8A==
X-Received: by 2002:a62:a99:: with SMTP id 25mr12973568pfk.121.1544463497072; 
 Mon, 10 Dec 2018 09:38:17 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.38.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:38:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de,
 jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v4 15/15] MAINTAINERS: Add entry for RDA Micro SoC architecture
Date: Mon, 10 Dec 2018 23:05:50 +0530
Message-Id: <20181210173550.29643-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_093822_706229_89226A0F 
X-CRM114-Status: GOOD (  10.04  )
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

QWRkIE1BSU5UQUlORVJTIGVudHJ5IGZvciBSREEgTWljcm8gU29DIGFyY2hpdGVjdHVyZSB3aXRo
IG15c2VsZgphbmQgQW5kcmVhcyBGw6RyYmVyIGFzIHRoZSBtYWludGFpbmVycy4KClNpZ25lZC1v
ZmYtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFy
by5vcmc+Ci0tLQogTUFJTlRBSU5FUlMgfCAxNSArKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJ
TkVSUwppbmRleCA2YzNmYmJiMzYxZjguLjY0MTFmYjIyMjU5MCAxMDA2NDQKLS0tIGEvTUFJTlRB
SU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTE5NDUsNiArMTk0NSwyMSBAQCBNOglMZW5uZXJ0
IEJ1eXRlbmhlayA8a2VybmVsQHdhbnRzdG9mbHkub3JnPgogTDoJbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1zdWJzY3JpYmVycykKIFM6CU1h
aW50YWluZWQKIAorQVJNL1JEQSBNSUNSTyBBUkNISVRFQ1RVUkUKK006CUFuZHJlYXMgRsOkcmJl
ciA8YWZhZXJiZXJAc3VzZS5kZT4KK006CU1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5h
bi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+CitMOglsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcgKG1vZGVyYXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQorTDoJbGludXgtdW5pc29j
QGxpc3RzLmluZnJhZGVhZC5vcmcgKG1vZGVyYXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQorUzoJ
TWFpbnRhaW5lZAorRjoJYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLSoKK0Y6CWRyaXZlcnMv
Y2xvY2tzb3VyY2UvdGltZXItcmRhLmMKK0Y6CWRyaXZlcnMvaXJxY2hpcC9pcnEtcmRhLWludGMu
YworRjoJZHJpdmVycy90dHkvc2VyaWFsL3JkYS11YXJ0LmMKK0Y6CURvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vcmRhLnR4dAorRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL3JkYSw4ODEwcGwtaW50Yy50eHQKK0Y6CURv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvcmRhLDg4MTBwbC11YXJ0LnR4
dAorRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL3JkYSw4ODEwcGwt
dGltZXIudHh0CisKIEFSTS9SRUFMVEVLIEFSQ0hJVEVDVFVSRQogTToJQW5kcmVhcyBGw6RyYmVy
IDxhZmFlcmJlckBzdXNlLmRlPgogTDoJbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1zdWJzY3JpYmVycykKLS0gCjIuMTcuMQoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
