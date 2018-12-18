Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375FFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:43:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064AA20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kS8+WtRy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVAh7JL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064AA20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OH7gHtOaz1b8Lvb0uAR5cDm2RWN4Iu/BhQpA7CezRM8=; b=kS8+WtRyzFeAYs
	ujLLCYXLgSDssx7xvrNDT3lgvFpg4yeImk98OVCcBHTaGYR6YuWhue5QKktgSrrQ8pGQoM/ENbG0h
	z1LfAYrIoUam89LxYeEx87+5OercbPPa8zhm1NjUyze2n/hkj8KRI8c0DPX5Gr0BrY3+ONLGjj0r6
	MMr9sFdDVWFJnA8mGxlwIntxdqU47fgWbisCNjIaf4DnDpM2ygX4JbfCQ9FAF1hr5CxU/NvqPAVDO
	vCuje3cIG5CEdKJiLGhx133Zuo/HDMl2lA1qEQ5G2EE1pYQE/qBIZidNmuTkaEoTcU41fO7c3+mAs
	GCRkTnS+vh15r2bWSX7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ6Ho-0007Nh-D3; Tue, 18 Dec 2018 03:43:12 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6HB-0006ax-JG
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 03:42:49 +0000
Received: by mail-pf1-x444.google.com with SMTP id u6so7418764pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 19:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UfYvMyUASU0SktOneqY893l+ivwuHLJC4IjYGuuzrdU=;
 b=gVAh7JL4w5/QOJxDUswDGvBXkidVWZzZDpWSujaKogLRWBLhKOHr8Lb+sx/BjM+wzf
 PCkSrYZP98FcGGRJJKGhhfTKY8mnFnfrhnPRz4Vx+aVobXcxNfgyFqZETAqAGdo92CV6
 ozFApD5vTfn8XnfI06VJ1WxGr3tdPoQ24e7Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UfYvMyUASU0SktOneqY893l+ivwuHLJC4IjYGuuzrdU=;
 b=Vd5ux6/fRY4pzfFbxTH9t0JXeHwzecT3IRkgUeP5mPkFPwpyIN4lfbAvWXR8KL9aBl
 rND6QGm//FvJSLbGlfqNJGuOcC/TCAR3WTxJpm0RkTOF1Tza3xhmnJ5KYHUnDDcXCk93
 Nrt3sPoCpcar3QshIcHE9MYTBNFJHXDXI909uFS+fDjeDm6W/SUldWy41749QARY0tfH
 IGX1IQuzy1/52O7uatN8QiOv7EUmRV6EE7lqK5G7Vs7JaP8APArUdNsVCtV50iZ8MLEs
 TRVyN1zfZDdMXYMuMAcS/OtQG7sbYD6ItCsl0kow+DnyOipv2rKW7zCu9XWS/NzbmEjQ
 XuOg==
X-Gm-Message-State: AA+aEWa/BgFoRdet/iCh9yqJ9HWfbezeeuji2Er3edWvdtFdc6MXAc7w
 PB4tbn5cZVcB2uLaYhDoT2yI
X-Google-Smtp-Source: AFSGD/X8y4EN7pjdYPLHwzHhbJRvH6d30hXBqOEQ8Twoaag5VlT0ecI+DIH084YQ0TqA+XdqevRxOA==
X-Received: by 2002:a63:5d55:: with SMTP id o21mr14119004pgm.92.1545104542854; 
 Mon, 17 Dec 2018 19:42:22 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 19:42:22 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v5 03/11] ARM: Prepare RDA8810PL SoC
Date: Tue, 18 Dec 2018 09:11:24 +0530
Message-Id: <20181218034132.5070-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_194234_163578_C960C32D 
X-CRM114-Status: GOOD (  14.74  )
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

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKSW50cm9kdWNlIEFSQ0hf
UkRBIGFuZCBtYWNoLXJkYSBmb3IgUkRBIE1pY3JvIFNvQ3MuCgpTaWduZWQtb2ZmLWJ5OiBBbmRy
ZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6IE1hbml2YW5uYW4g
U2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+Ci0tLQogYXJjaC9h
cm0vS2NvbmZpZyAgICAgICAgICAgfCAyICsrCiBhcmNoL2FybS9NYWtlZmlsZSAgICAgICAgICB8
IDEgKwogYXJjaC9hcm0vbWFjaC1yZGEvS2NvbmZpZyAgfCA5ICsrKysrKysrKwogYXJjaC9hcm0v
bWFjaC1yZGEvTWFrZWZpbGUgfCAxICsKIDQgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtcmRhL0tjb25maWcKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL2FybS9tYWNoLXJkYS9NYWtlZmlsZQoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL0tjb25maWcgYi9hcmNoL2FybS9LY29uZmlnCmluZGV4IDkxYmU3NGQ4ZGY2NS4uMDg0ZjA5
ODNlNmIyIDEwMDY0NAotLS0gYS9hcmNoL2FybS9LY29uZmlnCisrKyBiL2FyY2gvYXJtL0tjb25m
aWcKQEAgLTgwNCw2ICs4MDQsOCBAQCBzb3VyY2UgImFyY2gvYXJtL3BsYXQtcHhhL0tjb25maWci
CiAKIHNvdXJjZSAiYXJjaC9hcm0vbWFjaC1xY29tL0tjb25maWciCiAKK3NvdXJjZSAiYXJjaC9h
cm0vbWFjaC1yZGEvS2NvbmZpZyIKKwogc291cmNlICJhcmNoL2FybS9tYWNoLXJlYWx2aWV3L0tj
b25maWciCiAKIHNvdXJjZSAiYXJjaC9hcm0vbWFjaC1yb2NrY2hpcC9LY29uZmlnIgpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vTWFrZWZpbGUgYi9hcmNoL2FybS9NYWtlZmlsZQppbmRleCAwNWE5MWQ4
Yjg5ZjMuLjEwMDU2Y2NkYjhiZSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vTWFrZWZpbGUKKysrIGIv
YXJjaC9hcm0vTWFrZWZpbGUKQEAgLTIwMiw2ICsyMDIsNyBAQCBtYWNoaW5lLSQoQ09ORklHX0FS
Q0hfT1JJT041WCkJCSs9IG9yaW9uNXgKIG1hY2hpbmUtJChDT05GSUdfQVJDSF9QSUNPWENFTEwp
CSs9IHBpY294Y2VsbAogbWFjaGluZS0kKENPTkZJR19BUkNIX1BYQSkJCSs9IHB4YQogbWFjaGlu
ZS0kKENPTkZJR19BUkNIX1FDT00pCQkrPSBxY29tCittYWNoaW5lLSQoQ09ORklHX0FSQ0hfUkRB
KQkJKz0gcmRhCiBtYWNoaW5lLSQoQ09ORklHX0FSQ0hfUkVBTFZJRVcpCQkrPSByZWFsdmlldwog
bWFjaGluZS0kKENPTkZJR19BUkNIX1JPQ0tDSElQKQkJKz0gcm9ja2NoaXAKIG1hY2hpbmUtJChD
T05GSUdfQVJDSF9SUEMpCQkrPSBycGMKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcmRhL0tj
b25maWcgYi9hcmNoL2FybS9tYWNoLXJkYS9LY29uZmlnCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAwMDAwMC4uMWVhNzUzZjU3YjJkCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9h
cm0vbWFjaC1yZGEvS2NvbmZpZwpAQCAtMCwwICsxLDkgQEAKK21lbnVjb25maWcgQVJDSF9SREEK
Kwlib29sICJSREEgTWljcm8gU29DcyIKKwlkZXBlbmRzIG9uIEFSQ0hfTVVMVElfVjcKKwlzZWxl
Y3QgQ09NTU9OX0NMSworCXNlbGVjdCBHRU5FUklDX0lSUV9DSElQCisJc2VsZWN0IFJEQV9JTlRD
CisJc2VsZWN0IFJEQV9USU1FUgorCWhlbHAKKwkgIFRoaXMgZW5hYmxlcyBzdXBwb3J0IGZvciB0
aGUgUkRBIE1pY3JvIDg4MTBQTCBTb0MgZmFtaWx5LgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFj
aC1yZGEvTWFrZWZpbGUgYi9hcmNoL2FybS9tYWNoLXJkYS9NYWtlZmlsZQpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjZiZWEzZDNhMmRkNwotLS0gL2Rldi9udWxsCisr
KyBiL2FyY2gvYXJtL21hY2gtcmRhL01ha2VmaWxlCkBAIC0wLDAgKzEgQEAKK29iai0gKz0gZHVt
bXkubwotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
