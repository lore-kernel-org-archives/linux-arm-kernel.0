Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7AAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:58:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F95217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I6Xp308H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t9axPbdl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRDtvfB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F95217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hSCjhrngpsn6WcvCETUSiYa2CbYjHnLRCSqZa7Xvr5I=; b=I6Xp308Hnso8oW
	xrAAPK1lgbV/rul27D2b5SQ87JXx/1H2/2ifVAAwtrTnjHYlrXTgQ8Z2mp/7b55wlJPgN4MrrC8pM
	twSB8Ar6RxP7/x3GB2pIaCmw3Z+bmIBvJmhHZa1QadmADEg90p/JJ9lqMKallWSwBAncfwMdao/QB
	jW/z6d3dfTQwhAPw1XoiA7ew4jcp7G6q0RxaidnFlgfIaBdTEFfpZqad+Nw1Lz8zS/s2m+MOP6+3y
	EO5R9qtAQP7fQrPthDOR/DprSTAXvI0EM2I9ptUCWxxSGZ7/cPtoP9/K6JQUP3KKEwKgz+GC83Ifp
	coXu14tVp1JEnG44tzYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ6Wn-0004yr-Sg; Tue, 18 Dec 2018 03:58:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6Wl-0004vb-MB
 for linux-arm-kernel@bombadil.infradead.org; Tue, 18 Dec 2018 03:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=luzeqSOhSz7LYRGlTw2LYlPWG9a6KoSdnr5RovVM/to=; b=t9axPbdlap8/lttJetPnv5Qj/H
 ikOnP+Fh7HGKYEoxPeiY8BufZFWJO5rOpiFQ/79oiZZSub5GXDrCuLFzzK+cSn0wMGLHlm/7taOeS
 ppL5SiihySPm1P2ulY4cE2HEHsOB7LSJnb+7aAwQemOCoYYh7dgxNSRU4ukcEf+2A/uNOGLF06ijD
 fOYTaYWRoyjfTmbrVZNy/uKOhyB+kFrtwS20N3TjwSzXkGcsMe7EPbxZMkw4+rIv5BhvKAC4qV7Xy
 AD3P5ZQKFPvnrhIz1DosaOgzup5ikx0nxOEuviPUwDciN1oAK3CNuJhCPCi5IVuZWHRNnX8B+up4A
 0oL91I0Q==;
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6IE-00071o-9V
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 03:43:39 +0000
Received: by mail-pf1-x444.google.com with SMTP id b85so7435830pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 19:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=luzeqSOhSz7LYRGlTw2LYlPWG9a6KoSdnr5RovVM/to=;
 b=ZRDtvfB3uhSv6h0cB9LFJGhrkynV4iY8BLNaMUu0bkctqgIhSLeizpJKXsy/I//wFe
 VfTlsgIxborkZpjV7uA7asoLYvWgS6Nco2Frn2WwmfTUkWnxx8sVirPez3cmQqKKB4qE
 isB3WpQDFc6/aLXEuc33fKb1SbtPz02N6UF9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=luzeqSOhSz7LYRGlTw2LYlPWG9a6KoSdnr5RovVM/to=;
 b=MjtEa9njRdrtr8b7u8AhQpJY36rt+BELdpjpHFOJL3kWe4rJXz3xRdmrhVOlo5eDkR
 Bj3ATqWuk8fd6mClneH8yaXjXf5EF/K+RInSWJD0x3qJJu8iiBEXYponkLzeBM9csaYR
 E4k4/4+eEB0NR4NB3ZWMHrkjeefCT/k/Vsc02lwnS7exSDjOIWaeLvfJ87w6U5w117Gk
 wpIXkZKGoF43VDKvgoUmdZzBDaz7nug5ehrLBkfyhbN2YpXOKiTwPVnUNDhQdNXtObJO
 +Av6zIYaoRPWJmEKokwme+iqyZR1Y/LcHf8rzvdTqXf5OI4DaqMgAV3584swCKo1ZatP
 z/aQ==
X-Gm-Message-State: AA+aEWYQe4MdS0eFwpxIO+2xM0qrlh56OeF7GIauaNvD1mq5hGE+m8JA
 uM6TbB/uGE1ViRXIor7VrOyO
X-Google-Smtp-Source: AFSGD/VR/eT+K8K8dsUFr/AOsZY1so87nVuE+POJjIu9WSSzGCQuIU8gNWIjEhXN2el2I6LdGv0TAQ==
X-Received: by 2002:a63:6604:: with SMTP id a4mr8658608pgc.118.1545104606620; 
 Mon, 17 Dec 2018 19:43:26 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.43.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 19:43:26 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v5 11/11] MAINTAINERS: Add entry for RDA Micro SoC architecture
Date: Tue, 18 Dec 2018 09:11:32 +0530
Message-Id: <20181218034132.5070-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_034338_331210_76D95974 
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
by5vcmc+Ci0tLQogTUFJTlRBSU5FUlMgfCAxNCArKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlO
RVJTCmluZGV4IDZjM2ZiYmIzNjFmOC4uN2YyYWUyZWQ1M2Y0IDEwMDY0NAotLS0gYS9NQUlOVEFJ
TkVSUworKysgYi9NQUlOVEFJTkVSUwpAQCAtMTk0NSw2ICsxOTQ1LDIwIEBAIE06CUxlbm5lcnQg
QnV5dGVuaGVrIDxrZXJuZWxAd2FudHN0b2ZseS5vcmc+CiBMOglsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcgKG1vZGVyYXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQogUzoJTWFp
bnRhaW5lZAogCitBUk0vUkRBIE1JQ1JPIEFSQ0hJVEVDVFVSRQorTToJTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4KK0w6CWxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZyAobW9kZXJhdGVkIGZvciBub24tc3Vic2NyaWJlcnMp
CitMOglsaW51eC11bmlzb2NAbGlzdHMuaW5mcmFkZWFkLm9yZyAobW9kZXJhdGVkIGZvciBub24t
c3Vic2NyaWJlcnMpCitTOglNYWludGFpbmVkCitGOglhcmNoL2FybS9ib290L2R0cy9yZGE4ODEw
cGwtKgorRjoJZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1yZGEuYworRjoJZHJpdmVycy9pcnFj
aGlwL2lycS1yZGEtaW50Yy5jCitGOglkcml2ZXJzL3R0eS9zZXJpYWwvcmRhLXVhcnQuYworRjoJ
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9yZGEudHh0CitGOglEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvcmRhLDg4MTBw
bC1pbnRjLnR4dAorRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9y
ZGEsODgxMHBsLXVhcnQudHh0CitGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dGltZXIvcmRhLDg4MTBwbC10aW1lci50eHQKKwogQVJNL1JFQUxURUsgQVJDSElURUNUVVJFCiBN
OglBbmRyZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+CiBMOglsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcgKG1vZGVyYXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQotLSAK
Mi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
