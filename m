Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28137C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD8220883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pEdCrunK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpltlmxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD8220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oBMnn3WRAhdziwcTwDOUzHIML8FAajRSpYbc/g9O5wM=; b=pEdCrunKcHvzTg
	Celir99CzdfaFhTsotYNcVkuUtyEsbA6BRNioGGrHqbtexV1IkyzA+5PUPqoUvEIr5NYiEAbMbktB
	bvI/19u2PVYgsA3I6UgviKX1wWY4mWaHWMgAndSPvzaRzM1NSdmrpOvsrOsTQJYIcocPlgDiEcj3d
	Pg9LQRzdVrki1TA66TiMBwvpezbpae6nHBBOOR7c8LDP6pjTFWGhEudZuQUeTBIYiuZScWt779e4E
	C9y4B7ccg1OrnVZPri6FpIJxgSiB67KlcvKdqNH97yAcH8H66+tw6qOGoJF6F7aWRhfSda713+qhJ
	8fd5PqbRXVs0WOkkURqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggufn-0003IM-LA; Tue, 08 Jan 2019 16:56:15 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggufh-00039c-CK
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:56:11 +0000
Received: by mail-lf1-x143.google.com with SMTP id b20so3426085lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 08:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RrC5TbkM7ooSeY1gmY25cHG+Xb4rV68ii2Clgc+hyVg=;
 b=SpltlmxDe1/qv4NwrTcqa96yZqYlpC5J/0wPhg89FJmH+mu2uOJZiBx4MdHNTHdkNn
 VeQLRPyR3MP6GYugfrGyj8+H0YM0P/B03hZcjY19hl7ufxKUjmol2pV9dDWeF6q+B4Lo
 R9OyN1qQejV+TBT11pESrH9YTFjqsDggbYorsL1uLpSgg6q2oMv+nsEH6F0AohWxb/LM
 4WuY5tA+QiRtBOVXRQRS5atI45RPuc8hOdgn0FfFn964vAgbwBWV/tjbeLXLTzfDXAZ9
 PUcn/vJ4EUOa2ivieJF1SDKVa9e3mZwtVQa57UwNHAkfz6DW2zx9piNqxJyt8NHEdJkd
 OXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RrC5TbkM7ooSeY1gmY25cHG+Xb4rV68ii2Clgc+hyVg=;
 b=Xo8j2vJg7GBGAQipUdOtEyp3nZ59/zJelCh7gpCJTUmmkNvoLIDE6YBIThpKA7n81e
 Uw2BGNFeWhwrU+TFHuZOchltb0OeJ06DRxUIfI2mHJhbr9VSTqMCVkA+D8p+8Mf2+0XQ
 8J4+WRdC0YJaEmXkca0tNuaFqDT45aw9a9W7KX6xsOxJfzOlRVb62vyllS+XZn4CqSnD
 xkW64iX/q/sgbmpZL3xbhpducYftRZvicZF3TTnwewO7LEBmg1WBMvc6vX0c3sHGxc68
 BN4DCVICenJdplTJy9yd4tpT+QeHSQbazGAonB/baEuhRp82Z0WH+1HYaguOZbxiF+lq
 UcBg==
X-Gm-Message-State: AJcUukdJLwwx6wA+mnSLYJv/tSXekn6BbU2SlpcG9o6yr69pP3ZIO2ca
 jzmnUo9D5mLDCE9q7JELaoQ=
X-Google-Smtp-Source: ALg8bN6M3Gd0kPYa9j9AQFE1qNP5Qra/Fr13PN2WFE4WNWuQlDYjzfl2K2VkssnNHzvKcudU8YNSqQ==
X-Received: by 2002:a19:645b:: with SMTP id b27mr1512410lfj.14.1546966567298; 
 Tue, 08 Jan 2019 08:56:07 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
 by smtp.googlemail.com with ESMTPSA id f8sm14687989lfe.72.2019.01.08.08.56.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 08:56:06 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: krzk@kernel.org
Subject: [PATCH v2 0/4] ARM: dts: s5pv210: aries: Enable more drivers present
 on Samsung Aries based devices
Date: Tue,  8 Jan 2019 17:55:57 +0100
Message-Id: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_085609_829961_3C8F28B1 
X-CRM114-Status: GOOD (  10.84  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, xc-racer2@live.ca, linux@armlinux.org.uk,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org, pawel.mikolaj.chmiel@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaHNldCBlbmFibGVzIG1vcmUgZHJpdmVycyBmb3IgZGV2aWNlcyBwcmVzZW50IG9u
CiBTYW1zdW5nIEFyaWVzIGJhc2VkIGRldmljZXMuCgpDaGFuZ2VzIGZyb20gdjE6CiAgLSBSZW1v
dmVkIGFscmVhZHkgYXBwbGllZCBwYXRjaGVzCiAgLSBGaXhlZCBuYW1lIG9mIG1mYyBtZW1vcnkg
cmVzZXJ2YXRpb24gbm9kZXMKICAtIEFkZGVkIHNlcGFyYXRlIHBhdGNoIHdpdGggc2F2ZWRlZmNv
bmZpZyByZXN1bHQKICAtIEZpeGVkIGNvbmZpZ3VyYXRpb24gb2YgdG91Y2hzY3JlZW4KCkpvbmF0
aGFuIEJha2tlciAoMSk6CiAgQVJNOiBkdHM6IHM1cHYyMTA6IGFyaWVzOiBTdXBwb3J0IGZvciBt
b3JlIGRldmljZXMgcHJlc2VudCBvbiBBcmllcwoKUGF3ZcWCIENobWllbCAoMyk6CiAgQVJNOiBk
dHM6IHM1cHYyMTA6IGFyaWVzOiBBZGQgcmVzZXJ2ZWQgbWVtb3J5IGZvciBtZmMKICBBUk06IGRl
ZmNvbmZpZzogczVwdjIxMDogUnVuIG1ha2Ugc2F2ZWRlZmNvbmZpZwogIEFSTTogZGVmY29uZmln
OiBzNXB2MjEwOiBFbmFibGUgbW9yZSBkcml2ZXJzIHByZXNlbnQgb24gU2Ftc3VuZyBBcmllcwoK
IGFyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAtYXJpZXMuZHRzaSB8IDkwICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysKIGFyY2gvYXJtL2NvbmZpZ3MvczVwdjIxMF9kZWZjb25maWcgICB8IDQx
ICsrKysrKysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTIwIGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQoKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
