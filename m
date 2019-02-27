Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AE4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:38:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E77218E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bK7KB4rK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2jV0OBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E77218E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=4HXHrKIf3ZVnq07eAfk4I9u8ZSbxgm9QU28NZ01iWlw=; b=bK7
	KB4rKtggUy1upQRAqIvRaJfQIxyB+mMg6QmlFDNlIU4J182f560yyMy4OpGLGoHsNAclWRjhiSKqB
	aQLdGnVsM1TtFLM5Io7yVF283PQNH5gy3vWbPPM+bI7ndhwdHKb81LjihQ3CVHQTXWhjxyHGn8iQo
	M+yS2RC/Op2Vayyu4vq/EiD9N6qP7Z//OJnyKOkodLMm/pO9WpKFi5pM22JKrsIVz82GDjGq4kLXg
	Mp1bwKWAaw4QmYTihbJsfpvPet0S4k9MPpJXHzNnm6/ZqZUwOPOSA0MhKI2nWeWIa6zDWqod/VAHr
	LTYDswPa7kEghRbgcPKv+6QH4XyLUKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyrvA-0002Fm-2k; Wed, 27 Feb 2019 05:38:20 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyrv6-0002FQ-FC
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 05:38:17 +0000
Received: by mail-ot1-x341.google.com with SMTP id t7so13312944otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 21:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=xQq8ancmwZOdWsnLfrZLoOxW+Ve5gITnToEpTX3vkAY=;
 b=f2jV0OBaEcUFsUDN+EvYbWi0GCVsZPlvmcx1YP6oINMndBO/ePNv9RrG7bqUJFJmGD
 s03TZm2ZesuBXd+Kda+AQpX180aGv+UnsZmzJbkBKH5gWZfWtErHzfFLK1JmwJwmLBg0
 bP24Vgem4UVEK3smMi6W5ZCMz+vfJnWIS0+08TaIxDGEM4P15MxY22GusjCl5+B7fej2
 D6dQVUBJJRY8HPdawd1TiFPh0RVfAXiyk0EGbvjdBgQxUFna7D5p3JRW9FfuG6u2mYGZ
 XVPV9vB+lue5IiCnSptINKTs7F9hMgQkKaHhq6DXa3pQFPJOkT3lIjk0xb2fsQDp3NeY
 tCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=xQq8ancmwZOdWsnLfrZLoOxW+Ve5gITnToEpTX3vkAY=;
 b=UTHZcXGjwJgFNDcDSPHyN8b/RSaaOeZdLTu4U1yuujROuCckMsqtMGdONjtljT6tKu
 t4cXaOpzOfihYf4QKmsufAquWyDNlNdQR5SR4RSh8a90ej6mqYDtgjCuOXRiw0JIDOvs
 S54M0Uo23pLEmjaGTXrSrTWgUOBgGdtTRwPc2eGzdwqpk3N2/ExwWsv8BRU8U0QxLNKw
 TrCXj9xs7OPI0Qi3I/AqxQK0i1dhyeKnLrXdLRwFHBYaYizo/1TQ/1GN7+E7M5ptsbv4
 k6N7P0Oj8copbnyr6G9PeGFjtP1ZHw86dEAOZ4SO4F6UWnOSo1nuxRyeYHLWufaKEuno
 LuOg==
X-Gm-Message-State: AHQUAuaNMKaQzPgLpDU5DxGzSgArn9oCTWeEpSK6gC0p4nMRLNliihH/
 wu4HqTTCh06li2qRrlsi6q5m+A==
X-Google-Smtp-Source: AHgI3IYmWeMWxYSDc2N3lN2vhwmXNQHfBXkMdLF60rslfYkTW4517S4OGHGSpRSuxQ7lXOdl7kI2yA==
X-Received: by 2002:a9d:6012:: with SMTP id h18mr999584otj.341.1551245894373; 
 Tue, 26 Feb 2019 21:38:14 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net.
 [107.207.74.175])
 by smtp.gmail.com with ESMTPSA id z6sm6082837otq.68.2019.02.26.21.38.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 21:38:13 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm ARM64 DT Fixes for 5.0-rc8
Date: Tue, 26 Feb 2019 23:38:09 -0600
Message-Id: <1551245889-15219-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_213816_517534_17CADCE6 
X-CRM114-Status: GOOD (  12.84  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-arm-msm@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Arnd/Olof/Kevin,

I know this is late, but can you apply this single patch to fix boot issues on
MSM8998 platforms?

Thanks,

Andy

The following changes since commit 2a81efb0de0e33f2d2c83154af0bd3ce389b3269:

  arm64: dts: add msm8996 compatible to gicv3 (2019-01-24 21:16:16 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-5.0-rc8

for you to fetch changes up to 6e53330909672bd9a8c9f826e989a5945d9d9fdf:

  arm64: dts: qcom: msm8998: Extend TZ reserved memory area (2019-02-26 23:32:11 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Fixes for 5.0-rc8

* Fix TZ memory area size to avoid crashes during boot

----------------------------------------------------------------
Andy Gross (1):
      Merge tag 'qcom-fixes-for-5.0-rc3' into fixes-for-5.0-rc8

Marc Gonzalez (1):
      arm64: dts: qcom: msm8998: Extend TZ reserved memory area

 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
