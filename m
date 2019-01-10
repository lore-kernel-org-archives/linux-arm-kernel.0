Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AFBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC4920685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J1ZkR7VP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="somvAXwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC4920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QbUXoBbrEitkfVJ/96uv2wvfbpyi64odoGdm1KLKGgM=; b=J1ZkR7VPo7U2yn
	NT4BUtsnthGVUJyi0dDuzkZm1D+Rhtq0d8vv2AnXrHmFtQEwbdbZ1nqV7UgLdCFUYpuZ9WNXq6Mc0
	//FTdd4r0+exnEqsECPt9wp2PPiF7QLunJM2Zq7euqhRqtaR6E5g5PXJWGs1RBvRrCcEXB4iJcsem
	cKbAbVtbGmweIKHIveDtBzsgbtwh9oyJU7XrcobAUBLuK1IQekfMzj/Z9w32BEovi+arGYF0Nn7oJ
	VuFBxwDCULrnP3CcAJsVHR0rvLNre8fGNFLL57IqdZesnU4U5JDPOquJkMCLCza/TpATHYCAe1bG9
	cI+656YY0Nh7KelKXdbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghhKp-0002LS-0L; Thu, 10 Jan 2019 20:53:51 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghhKG-0001mS-VC
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:53:18 +0000
Received: by mail-lj1-x244.google.com with SMTP id x85-v6so10989648ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 12:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+SD/OC2mkph624S4bKD3nSN6vMhl6eg9eqmNC9NaBYg=;
 b=somvAXwFWVUInL8qU/Be8IdSbgDkR4UaG91kcTe3n8czAmA1mzk7gJ66uxFpI8hWx9
 IUOy9kXQtxiTGMzW4PAfI3Kpcvt5ANS99Gk6ImDv6q40PuVPxio/CBOsXUyxGG5xzdEy
 3qQv7zz38P83fi0E9RwOijcf7y2i6Rl0Fr8DJBSynNZ46gsWkSklwJA5736cB0Av8xoE
 +7gJoweqGrdbFWA/Yr2KVkfLxda8UUu+ROgf7FCrQIlD+0gVKta/xXMu5JGRl+xJtG0Z
 5qgFAKtnsuplwxD7Dpa/17EKWwaVCW6duIaY1XoVQ/h/uXMPDjMXz/9kyPJdLK09G1cW
 6q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+SD/OC2mkph624S4bKD3nSN6vMhl6eg9eqmNC9NaBYg=;
 b=nROznRN4yAetTjVSPRB/FaA+gf7JGPD99PZuUttvhiCmPfRWDhQr0IMDxJocD5wPSG
 UPvhm1NIiac4VUtmp44Izg1l4AX2lKsz3l9e49aztD5lKK9zILnZBCuMjfDoAhTrFWA7
 hvgs0M20fX2NNgAsgQTsqIGZMWTqQ1qxekuDRp8aEP85Av/nK9I59msgtUzRN57NCiLr
 DGypISCE6E2PN3ZQ3FCLusC0K0CxWlOr1ULpgy3B7SEE1VAF1cVnvPJcH+D4oKNYV7Za
 XZfA+ZF/pK61t63fYVKCDRK3vbhFqqHAo2BNQtQxLNoSQUW4AuVTyawGR9vZiV7bs6Um
 1Cgw==
X-Gm-Message-State: AJcUukePt6GNmYcPXKr7S8NWwWUqhGSlVk4Os+FN2ixrKX+jOhBYoy3m
 TqBCl7TikgIXpQReWsQNSe8=
X-Google-Smtp-Source: ALg8bN5OhNydl/YWlWYGi+wVoxty4MjReSUNdvKbqB3yWLq4KH0DXd1xC7lsMDC1i783piOK1c0mig==
X-Received: by 2002:a2e:9783:: with SMTP id
 y3-v6mr6788109lji.167.1547153594941; 
 Thu, 10 Jan 2019 12:53:14 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:5dc1:592c:c674:2869])
 by smtp.googlemail.com with ESMTPSA id
 z7-v6sm15389690lji.42.2019.01.10.12.53.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 12:53:14 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org
Subject: [PATCH v2 2/4] cpufreq: s5pv210: Don't flood kernel log after cpufreq
 change
Date: Thu, 10 Jan 2019 21:52:13 +0100
Message-Id: <20190110205215.22030-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_125317_002536_7643A779 
X-CRM114-Status: GOOD (  14.01  )
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
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org, rjw@rjwysocki.net, linux@armlinux.org.uk,
 krzk@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBjb21taXQgcmVwbGFjZXMgcHJpbnRrIHdpdGggcHJfZGVidWcsIHNvIHdlIGRvbid0IGZs
b29kIGtlcm5lbCBsb2cuCgpTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtv
bGFqLmNobWllbEBnbWFpbC5jb20+CkFja2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnpr
QGtlcm5lbC5vcmc+Ci0tLQpDaGFuZ2VzIGZyb20gdjE6CiAgLSBBZGRlZCBBY2tlZC1ieQotLS0K
IGRyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1
ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYyBiL2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEu
YwppbmRleCBkYmVjZDc2NjdkYjIuLmY1MTY5N2YxZTBiMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9j
cHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jCisrKyBiL2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNw
dWZyZXEuYwpAQCAtNDgxLDcgKzQ4MSw3IEBAIHN0YXRpYyBpbnQgczVwdjIxMF90YXJnZXQoc3Ry
dWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ksIHVuc2lnbmVkIGludCBpbmRleCkKIAkJCQlhcm1f
dm9sdCwgYXJtX3ZvbHRfbWF4KTsKIAl9CiAKLQlwcmludGsoS0VSTl9ERUJVRyAiUGVyZiBjaGFu
Z2VkW0wlZF1cbiIsIGluZGV4KTsKKwlwcl9kZWJ1ZygiUGVyZiBjaGFuZ2VkW0wlZF1cbiIsIGlu
ZGV4KTsKIAogZXhpdDoKIAltdXRleF91bmxvY2soJnNldF9mcmVxX2xvY2spOwotLSAKMi4xNy4x
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
