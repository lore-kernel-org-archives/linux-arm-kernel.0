Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F95C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:13:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC08820892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h3Y7VzIi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3tqsUp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC08820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QANxB7Ej1migBBJwjQu68fdmewONDWFhsmjsftxfDNg=; b=h3Y7VzIiYcPqULw6f5wvU129I3
	UQzNMBI9q0/usRIvaV45J2isGfroIc0ukiuUMsLYhWb5spp+nIBaJAsytNgnliBLpZ9/yDLoYIuID
	QvaadcBDaqPJXhgWFNuMPUB0mB+obPpxRA8jj5N4ZQhZlqjwRzCM5q17bikorJv0UlFRKOjWR9RUL
	FVUZPs7Mx0n7BpEnpv6lY6BFasZiTAUOO85KycQ9nCDTjVlKUe2cGzN6uCnaCI02EKLcDweKcmSO9
	kAmkeVw/i/IyRcm+3vN6ADpmEAbU8HQBHjA51EqHpweIlTG2HLt7lvfS1cAWMTKYviWboO9C5vZh/
	luITUsVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVUvs-0001v9-30; Sat, 08 Dec 2018 05:13:40 +0000
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVUvh-0001n3-J6
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 05:13:30 +0000
Received: by mail-oi1-x22d.google.com with SMTP id x202so5082773oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 21:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=d9EM6OLmL5jq+R/me+WDLFLeNaotPlwD/W2/1haHTk4=;
 b=Y3tqsUp9IqgExw2BNgMp9G9Nz+xzvHIwTY4vPuuHt2VJtCZn3WOv7kL7Osdd2aBOeQ
 DgXYjLKlINA5yX8sqBj5IQsyGij9yrQePoa/LHWnvq0wcA9xFCIs8NqcMlycKUl/MSSV
 hrTksLtf079rvK1jfIQfdEUPrMEci0e11gHI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=d9EM6OLmL5jq+R/me+WDLFLeNaotPlwD/W2/1haHTk4=;
 b=NN0zJq0t4JeJzAPgliuPKAEFGIyrWF1DfKTh0BYxGqYq8fiWw/rV18EZt7/WEc5lqL
 L+srUYNuWLEqb4Dec/cgvyYhwygYODgOq7JORfZY/hDbl2+1SAvPXttlS9fcBiMqG0Nq
 VA1veHMGR1cwXTCZaNzyYDGJFp1GMSjR1v3dop88b/ng+ufF+J9UivI7IKk4uJuhyMus
 kwDhsD1wDwxJCdwEMyocowWJVVZ5EfaTkbYyVsyFUAT3VkzAaE4vondB5F5yATNlxJvm
 tpyL8HkguxWV0ZAsWDU3m41JZ6+eJ1xgv57XHHqPhfhE6+mjX+czNEno2NTwVaRzaE+V
 Sp8Q==
X-Gm-Message-State: AA+aEWZfkMD5ESF3xk0XlieC3DaDkgEetUbVT3NkO0YZnYM72ykiZ/33
 5IwNaRvi+mtgQcxWs4iapeX0Yg==
X-Google-Smtp-Source: AFSGD/Um6iO0gmu6JUsaZiaW32lwo+7nBbhWygxpQpuki5m1YKYSohdMs+30rXp/7IuAmrXmVMTJsg==
X-Received: by 2002:aca:b707:: with SMTP id h7mr2654690oif.89.1544245997730;
 Fri, 07 Dec 2018 21:13:17 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:1524:ebd:d530:a61b])
 by smtp.gmail.com with ESMTPSA id y2sm2194556oto.49.2018.12.07.21.13.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 21:13:17 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm Driver updates for 4.21 - Part 2
Date: Fri,  7 Dec 2018 23:13:14 -0600
Message-Id: <1544245994-4228-2-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
References: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_211329_623176_D7AC3D80 
X-CRM114-Status: GOOD (  11.34  )
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
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit b601f73130a375c912d9f2ec93c5f3cea5d6a3da:

  drm: msm: Check cmd_db_read_aux_data() for failure (2018-11-29 17:41:53 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.21-2

for you to fetch changes up to 92def04bd7b46f5b186f985d5c9d3804858c3c2f:

  MAINTAINERS: Change Todor Tomov's email address (2018-12-05 16:45:34 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.21 Part 2

* Fix MAINTAINERS email address for Todor
* Fix SCM compilation error

----------------------------------------------------------------
Jonathan Marek (1):
      firmware: qcom: scm: fix compilation error when disabled

Todor Tomov (1):
      MAINTAINERS: Change Todor Tomov's email address

 MAINTAINERS              | 2 +-
 include/linux/qcom_scm.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
