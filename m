Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEE9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:20:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0999720874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GRZopnqI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NonqxYOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0999720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=49VeNF1SCg6q0ntPoJPa3DxFtB39x/cyTWuxRer3Tig=; b=GRZopnqIYJffWz
	H0RBaMbs8TCOmIqxGLoA8rK8XshuybiAR6sNZusveLIAOyVrneN1f1rrqK8DHz5Bmr4tvLZr1t9gQ
	4LjJm/Nm69YVhhvLraZejkUZKluaDr3CuCjj2H7yPPh3i6bE3RNJfQFirKILwK22kKMZLxko57fsK
	Ff6f7/ZNIZFTXY4ZxUgaptJS2pxGSrcc8BdqD0fiPKGhswtmytJxdmMqZ/geWZpqF4ZcChh+FcJ6x
	uRwPmJw5NIVm0n7TFi8vRm5EPRmxb3l/r+LlGx/Sl7uRZAk+WukkdZ5NJguAF2w/BuoJhAq/LvyAd
	V03gqkIPOELXLlPhMJnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gctw8-0001xy-7m; Fri, 28 Dec 2018 15:20:32 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gctvQ-0008Vw-FK
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 15:19:53 +0000
Received: by mail-lj1-x244.google.com with SMTP id q2-v6so18930143lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 07:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CCV0gd3aGFNtHm5duNx7zwWOLB1bEFb5KSmmwZuypIU=;
 b=NonqxYOY0jKIFzhMoGY7dkjCJmzvDJftKvILDCjPm0bXr/Fuak2U5To/b2r5ahLqDH
 K82R0mrg+GlPc1UYKlzYHnj2LTlfWHPTXIBhSgM1E8iL+t8lw3WbmupnPzlVhmfVNwaU
 v/3XprdkB3DwxUWvPMysjG/MtMUdAnU+zBjjWAmBjOCt7d7CXwUsKUo8N0jIwx+3Kmcp
 YVHlAXRQk/9M9cuPc1hzIChsqjrDQQUI+MX0VuAcGptb45NInJf9VMQpV2V6JSL+7YlI
 AWNogyBuz06EhYppayP1iEd+5xElx90j1Ox2AJRiAAUg8M9OvZvJwrtFDdN4q3JV3dix
 QHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CCV0gd3aGFNtHm5duNx7zwWOLB1bEFb5KSmmwZuypIU=;
 b=fjjqaqWcOpB/bWQ/WKTaGW5h9qaMtUewoGg0QYqG/uP9lx17SOpBQdVkeVCVL8qNaI
 lxnbWQ20gARXMQNsJ5GxICMo4T96NrBt09BpelW3dNVpClTTGBBVo59Nj7/Ql8vXR5qo
 IzVmMKi5gPGmbmqCx+ckvk1Fpg2E9074Av9NMEE0KhFVF2z+XZp0UXy9BbUSa+qNhrfd
 Fph2+S738vt5qKLmcY88qQKQs0YTzY1UyhZITzjtL2zJsG0wXVkyqHAJUkDgHxuGtm4r
 6+K4bUZKY6D2Zj2aKLGROAvceneWrjjASUR6i/rV60Ihs3SOfyMr1/ZGq0kATEnRXAkr
 KDSw==
X-Gm-Message-State: AJcUukeIyFI4utpnfHEv7YqC7IddEHciQVt6mio6wxdG86ffVvEQUJzu
 jmrb66se+FucCJoE1UAb278=
X-Google-Smtp-Source: ALg8bN4WyJOu3IF4f2GY54hTI2FKFReGAyCTELDRufUayNhspyNowq4R4V7h/GGbDU490RpVuDC42Q==
X-Received: by 2002:a2e:9059:: with SMTP id
 n25-v6mr9252819ljg.155.1546010376468; 
 Fri, 28 Dec 2018 07:19:36 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
 by smtp.googlemail.com with ESMTPSA id s24sm7872704lfc.30.2018.12.28.07.19.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 07:19:35 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: inki.dae@samsung.com,
	krzk@kernel.org,
	airlied@linux.ie
Subject: [PATCH v2 3/3] ARM: dts: s5pv210: Add node for exynos-rotator
Date: Fri, 28 Dec 2018 16:19:04 +0100
Message-Id: <20181228151904.12079-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_071948_915299_A71C1D81 
X-CRM114-Status: GOOD (  13.04  )
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
 linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh+dt@kernel.org, kyungmin.park@samsung.com,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBjb21taXQgYWRkcyBub2RlIGZvciBFeHlub3MgUm9yYXRvciBkZXZpY2UsCnNvIGl0IGNh
biBiZSB1c2VkIG9uIGFsbCBzNXB2MjEwIGJhc2VkIGRldmljZXMuCgpTaWduZWQtb2ZmLWJ5OiBQ
YXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFpbC5jb20+Ci0tLQogYXJjaC9h
cm0vYm9vdC9kdHMvczVwdjIxMC5kdHNpIHwgOSArKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLmR0
c2kgYi9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLmR0c2kKaW5kZXggNzVmNDU0YTIxMGQ2Li5h
NTQ2MzAwM2M3ZjYgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAuZHRzaQor
KysgYi9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLmR0c2kKQEAgLTU0Miw2ICs1NDIsMTUgQEAK
IAkJCSNkbWEtcmVxdWVzdHMgPSA8MT47CiAJCX07CiAKKwkJcm90YXRvcjogcm90YXRvckBmYTMw
MDAwMCB7CisJCQljb21wYXRpYmxlID0gInNhbXN1bmcsczVwdjIxMC1yb3RhdG9yIjsKKwkJCXJl
ZyA9IDwweGZhMzAwMDAwIDB4MTAwMD47CisJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZ2aWMyPjsK
KwkJCWludGVycnVwdHMgPSA8ND47CisJCQljbG9ja3MgPSA8JmNsb2NrcyBDTEtfUk9UQVRPUj47
CisJCQljbG9jay1uYW1lcyA9ICJyb3RhdG9yIjsKKwkJfTsKKwogCQlpMmMxOiBpMmNAZmFiMDAw
MDAgewogCQkJY29tcGF0aWJsZSA9ICJzYW1zdW5nLHMzYzI0NDAtaTJjIjsKIAkJCXJlZyA9IDww
eGZhYjAwMDAwIDB4MTAwMD47Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
