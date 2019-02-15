Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1DFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:27:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FF7222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oSVm4mW3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fr8wMETk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FF7222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=zcvGJ1k6hRK+m0BADnGLafnCfMViVzkAaFa0abQo+R4=; b=oSV
	m4mW3XN/DCauMeODW0za2lAzQ56AIxtrr/u6gyKJ5kjsXlc1qeecSU/DSalSibfVwgq4YJ4DACjeY
	oBYz+EYStR7r6k0C6KAXnqb5Jgoe48dDc9BC0ed4ADcj95jcSYbDxcBclMC80SB6yc6kS/zFOW4qR
	bnOsdpWRRQvX2UOOendFHQtJtiImotPboT5rPgLzNEh7cyCqrAP4Ct2oiVix78FOSmXrevKSyCMRO
	GZHvBZ/0l3YXItvu3OmfSuOy703z6BW7jwGTexy/TLbYc6rwAAzFn4MhzrZZYJqY556XV82pJx9z3
	o3/9sLUxmTKDHxtUsQR58m6EOaOERkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guj8m-0003Xi-4h; Fri, 15 Feb 2019 19:27:16 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guj8h-0003XL-11
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 19:27:12 +0000
Received: by mail-ot1-x343.google.com with SMTP id n71so18365829ota.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=65JAevc8mxDOG6CC07TQhTtd+OgiM4I185c5XHeIqQk=;
 b=fr8wMETkQ2n+KWW/uXcT99/k1qVMk0cndH7nGCxmwXSV6NvkD3lqicEw7mxeuJr+s9
 UcpL8ZlWQBM0+LsrWpXcruDYr8v+dMy0G22h/jPruAAdqIVcfnibRll2TQZVvK14kKFj
 T2lli7EDzj6ehcGMri1/WDzsgYfiwbT+GrvsAt96C2A+xFgqIHp3wdh1si8/Yx4dySHP
 YCfhIEBghWD8N73RoX0y0oyDn6M/m48xexyylxRHyrfTO/xCM9UqspXwSjYGofKEJ4sv
 8RJ66nyRu5T6CXm2PHxejAzraF915CHvacceiZ0hIAvODfqjPfWkkKtC6n9cUwAAwzqA
 C0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=65JAevc8mxDOG6CC07TQhTtd+OgiM4I185c5XHeIqQk=;
 b=Vc1wtieyork6kzkZfO8FiC68pVfNA/WpOMWMAs8zbLaAFxK5agXzkrKfH4GQrnGViw
 aqbi+7WgGkxZhYG2sR4EZwP14mk9mL0315MSmfCLkUWy+4NKNDb1Ir0nuLQdDvhc3Rgy
 s7D5HpNZdijBOFxhW7hwYdlWE7YJEB+KCj89bLfraNW3i4k6Gk5GWDnsXrts3lh6ANzl
 u/3AG7qVz5p5VkUErLIpuNbywLBB1tIr6HvZRyZx0mkUnZl/B3WhJrnBu94nW1hevmOy
 DlYCmBntH7kswo8VEyao0+sf78EpQZ+W5hGU5Ah1NPI3hjSvFhe/+1nO8zXUFEQidGR/
 /gbA==
X-Gm-Message-State: AHQUAuZZfeeO4EDoseKJ9metaaOQHFXnlLNPPWpQ05FTQTXFwK/3j/bG
 veuuDR1Mx3MTrZwhU81LSHxgcg==
X-Google-Smtp-Source: AHgI3IaMomvI+ekzRiuErbcfPg/xyFwCyTs4AwBT9/AsA9N6oOh21qhZhsTEItXq4yqlLH81WGTBFA==
X-Received: by 2002:a05:6830:154b:: with SMTP id
 l11mr4691313otp.356.1550258829920; 
 Fri, 15 Feb 2019 11:27:09 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net.
 [107.207.74.175])
 by smtp.gmail.com with ESMTPSA id m84sm2027875oia.16.2019.02.15.11.27.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 11:27:08 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm Driver updates for 5.1 - Part 2
Date: Fri, 15 Feb 2019 13:27:05 -0600
Message-Id: <1550258825-20696-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_112711_234656_075C13F6 
X-CRM114-Status: UNSURE (   9.68  )
X-CRM114-Notice: Please train this message.
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

The following changes since commit 4e2256d31f0f24107c36dae35a1d84dff0fced30:

  soc: qcom: smd-rpm: Add sdm660 compatible (2019-02-01 16:08:58 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-5.1-2

for you to fetch changes up to ed10a259faa1bbdf77b8c2153b274b70c90cbb35:

  qcom: soc: llcc-slice: Consolidate some code (2019-02-12 15:27:17 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v5.1 - Part 2

* Fixups/Cleanup for Qualcomm LLCC

----------------------------------------------------------------
Jordan Crouse (2):
      qcom: soc: llcc-slice: Clear the global drv_data pointer on error
      qcom: soc: llcc-slice: Consolidate some code

 drivers/soc/qcom/llcc-sdm845.c     |   6 +++
 drivers/soc/qcom/llcc-slice.c      | 101 +++++++++++++++++++++++++------------
 include/linux/soc/qcom/llcc-qcom.h |   6 +++
 3 files changed, 80 insertions(+), 33 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
