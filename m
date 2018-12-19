Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AE0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:05:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2912218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C4NbxG51";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE3UVjaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2912218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=49VeNF1SCg6q0ntPoJPa3DxFtB39x/cyTWuxRer3Tig=; b=C4NbxG51jMqljI
	5YlhfWCLbSi/8QesEyCRbW6cWTWjGILOGAG565YLdlUesMJqiSkARL5x2qEui1ofr4t8GG7+K7HLh
	5hMhGLIajcOa53oe1v/if9+noUm20EEVf1hXgZ3zgpEvxZcnHCwm4Fpe7OEjCOnQKZsgqYnBEY0sP
	/BO3tihqlzYwwFFDWfDC6fVwGTDO+xuLjiDYE/SqYF9eCeJL6wkciMadbYcPi1ODHaFijc4q5vFev
	+THr6Pw0puwcxWEiA1K7285Cvwr0b64ek8yfuLyA6WgXxehXPvzGuEKGgXMJsLsVkiMdkSqQgJMlG
	nYL8njhP9SNNfcJpHcZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZeLM-0001eZ-OA; Wed, 19 Dec 2018 16:05:08 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZeKu-00010U-Ip
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:04:42 +0000
Received: by mail-lj1-x242.google.com with SMTP id k19-v6so17840454lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CCV0gd3aGFNtHm5duNx7zwWOLB1bEFb5KSmmwZuypIU=;
 b=YE3UVjaLtXB4jlrdgiTLlTN3GOZmzbTqdaPHe0KTUgMWc2v5IffHsVZc29O2biLpIX
 WZvLuyaZutOkgYxZb9L3E1LCjdAiVjPYC7UhFeEM33Ke5wB/c7WYziASOnkKPN2UybNj
 +JI/RUEWlK1MfFWCnn1LnRNSVbzICqzdxvBCDs0JvDTL3tdDRqYGNExeX6gGKAa2fk8S
 GVvPQ8LAtCmY/nTLTot2EoV9Bae6stzHbdpOuP5b0B6KAklQ1QsJua7pOaWt3U8HIcpu
 wJnQ+J0FGETZUSg09xmZjqIaQ0ORgjsBM705ToS3hULwCDZgNByBYAVC5NYvztGF9ydl
 XWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CCV0gd3aGFNtHm5duNx7zwWOLB1bEFb5KSmmwZuypIU=;
 b=V7o88p1KhykqrSp7XdGHBryMCiQ1lkMCrcoaUcZXv+Hl/kD1FOldz9vGmevGrYmJtF
 HPo8IToROdiQ9hLQnbs3m/+JnYr3d0HGIv/odHsdlErg0GcIaEuYth3JYec0JhA5YZb3
 rJLU/9PBzeZkklJXoveguJa77rZxX3TFAoJfNzRL6TFT/tYHEZZuxNdpVX9GB0lZ1ieX
 KlHjMhfBTDmm4Xq+HQ6owUv5R9KimSv83l3F5nr9cT8Q6uJMA66pFtYO0PChS8hfjCeQ
 EKyHYyC7DePu5Kgu0Y4ROkcb4sCGDwzKvq3MvqsS9BEnLWFFwkKJitEnfX5WqK6t9NHz
 Ipww==
X-Gm-Message-State: AA+aEWYiE3kQ1MFEdwBY49VyMt5UBfaIJZx0pLzA+yZ3M9lwMFOHcd98
 3Y/PwGICEPAGsJNgyxPisqM=
X-Google-Smtp-Source: AFSGD/X1pPhIvldWPsmxYIMED/sUdTu62KEYCaOUA2sly555DBs0sX0MnEaVUuSAFj2LEI3aFQmFbg==
X-Received: by 2002:a2e:9dcb:: with SMTP id
 x11-v6mr5082837ljj.158.1545235470038; 
 Wed, 19 Dec 2018 08:04:30 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:253f:4197:555d:bfba])
 by smtp.googlemail.com with ESMTPSA id i75sm3943979lfb.58.2018.12.19.08.04.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 08:04:29 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: inki.dae@samsung.com,
	krzk@kernel.org,
	airlied@linux.ie
Subject: [PATCH 3/3] ARM: dts: s5pv210: Add node for exynos-rotator
Date: Wed, 19 Dec 2018 16:57:04 +0100
Message-Id: <20181219155704.15264-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_080440_624459_7986A8DE 
X-CRM114-Status: GOOD (  13.74  )
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
