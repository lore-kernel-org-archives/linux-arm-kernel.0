Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E009BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:12:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A765D213F2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C3zbLY+4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gl6kCbyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A765D213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=SqbLKfvS7q7NGhEWPv9Qlq58dLZz9IpOLuRZdukwXho=; b=C3z
	bLY+4z7+FBYYCsi57AS638qgCBUCxR8HMXlOjHPKW4jKEZCMq41w7p57Y/iCt3oYK69vZxCp5Enib
	xAjQDwqGWnq8SgolJ3VT6q3lF42E6/HK5klscau/VGR7wV/fQJYdKolpyej6dVh4DjUL99EJ2lhBx
	bCqe0vnZHZ7alwFc8jgvOUinmlM7DuJqDZBdDAtNujuMhsDdW3FysnKY2oPDmQ9ntr5DdEU/EzhgL
	Cwo/1hzSB2i9j1OcF4HlQaRneig3veFkIrfWWsnWCm2NVBiY8DL+/cknVamtR+cvKKbBX0MtnAMse
	lZBo8pAjqFQpjHUWDYi4sPar4yr931A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghjUi-0003X8-P1; Thu, 10 Jan 2019 23:12:12 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghjUf-0003Wf-SD
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 23:12:11 +0000
Received: by mail-ot1-x342.google.com with SMTP id i20so11575882otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 15:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=P7cGoCPe9QMEyafb2GT0Ht8UKP6ezcUJ9AN6Y3AHrIw=;
 b=Gl6kCbyBWvBrPPXb0d+uuvx33Zpbw/2OI3zXUdIFR5s9jmhf6jwfz4gle90Tc6QyAS
 M3rbpV6XXwhSHmD8Abh2o71meFcvnZJHafRpIPl/klUhW3BOBny1o36kiy3YZmXYSDny
 bB96EYKBE9PsddEk3odSDhhwXzAcJ8MOINiMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=P7cGoCPe9QMEyafb2GT0Ht8UKP6ezcUJ9AN6Y3AHrIw=;
 b=JboFu50msuHm2gz+1emkF8fGEqSM1KeOMThXt3OhHlNig9n+n/dnie8XGJUpZXL8TS
 TuPRS3LoRV/RmX2mKR5XoujpZSSdKz42uvKDePbjBJMhJEkrd+vXmAQjiw8b5+JTqXRl
 SGBqvZXLg4OhjBcrhcET5813Y/QecPOCNJkUjYZbW+Gr5n7p6lLFwKMVbMEVOWvKQj7B
 A5+oJLFNsADaEqEFlOGJovT8PBgCs19CSBUC4fGzp0Pbk8HSG8xzfu/ISltgP4q9JzL2
 JLb67JMjiAr9mwzCCV38maptJgrfS2oYN0/xZZDazzUwA4uHaJgClzPEy8/QRCSuwQYt
 QAgw==
X-Gm-Message-State: AJcUukd6o/zF2zTaZWoodS1CZtVSP+CQGxLqgD4kmJR3r+osp8IWN0Xr
 Xz/Ac6MDxSUuYO+nPYQc4nH12w==
X-Google-Smtp-Source: ALg8bN6yn5Iyu1n92kVgg69lakk3N/at7Jw+F6Kohc04FHsEM/ilGJDrVDlStsqq44rfqVoPCzziEw==
X-Received: by 2002:a9d:60b:: with SMTP id 11mr7812448otn.200.1547161926558;
 Thu, 10 Jan 2019 15:12:06 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net.
 [107.207.74.175])
 by smtp.gmail.com with ESMTPSA id i7sm31832448oth.57.2019.01.10.15.12.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 15:12:05 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm Driver Fixes for 5.0-rc1
Date: Thu, 10 Jan 2019 17:12:01 -0600
Message-Id: <1547161921-32078-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_151209_914976_75DBE5D1 
X-CRM114-Status: GOOD (  10.66  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-5.0-rc1

for you to fetch changes up to 2076607a20bd4dfba699185616cbbbce06d3fa59:

  qcom-scm: Include <linux/err.h> header (2019-01-10 17:04:45 -0600)

----------------------------------------------------------------
Qualcomm Driver Fixes for 5.0-rc1

* Add required includes into qcom_scm.h

----------------------------------------------------------------
Fabio Estevam (1):
      qcom-scm: Include <linux/err.h> header

 include/linux/qcom_scm.h | 1 +
 1 file changed, 1 insertion(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
