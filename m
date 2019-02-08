Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40F5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:11:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E2DC20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TWy4NVB+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDysdZ6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2DC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p4xIEAQsLYXx5yYMu6s3QIMVdp35nsYtBkdGWA8DzDo=; b=TWy4NVB+zdiP5Y
	63cpFy6cARHPMiWoylezUemNmbRQreQ4D8z8wWSMLfRpPxx8pWvNLRVNMBk4Lrj7+8l6jqQRq3MzN
	eLvNVIsoZ7fbeH5VgU1mJFYe6+OLf6S1o5+xwSQeTQqbGDIQwhAY2bn9p8LvRbM7ibyMYqi+JqmIc
	H5nVheGW1gwX80GA75cq2W8akK72DWbrpjnrVA3iRmdA0+Q2anRmOcsqaJj/72xC1Jxt0LAebHfG7
	MBP0//emaRzl55iWqJByGQWX5q58gIGu2CHtSTnh9GttUGt/hPClNfI1K2xEPJEkK/U/hRIHmSrxI
	wrR1uY/iIirHZN85lgZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7or-0003iO-US; Fri, 08 Feb 2019 15:11:57 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7mq-0000PO-WF
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:09:57 +0000
Received: by mail-wm1-x32d.google.com with SMTP id v26so3715698wmh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 07:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=meo1+T0sFiXZ5NFO5s/6vTaA+ALuty7NGKUkyZ1vdds=;
 b=XDysdZ6C0Js2mted2n0R85Ey2CoaBgoiZ4GB4y/glDyq1xF6Dv0QVFAeppcfRDMLaD
 g0Lv4ZQ//RdWXwC8sWdt5ULj86QHGLBeHn+XsQf5eWy4oS0UMsXgIHgId85rowKVuTNe
 ZmI3DQ9cWCjEhRuPWlHM8Qmoc+7IgWsXQIhuZ8IYx36+n9arE/qser/gy7nA+Vk1je8s
 v2rHvGpUBnLxUi4OJ66KNu9wAhgplp88lwsKULJk/rBij4waV5V61+3nO0N/c1lrLwfr
 RFZPa3QECx6D5F74yv0e46NlOJenpu2eMKPUKtzhFnbpcsB6uApTd7XjMgIUCVrtVEFc
 Gz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=meo1+T0sFiXZ5NFO5s/6vTaA+ALuty7NGKUkyZ1vdds=;
 b=B7Yr9oJi6bGgxEp/StRW+TfIAj1W36Zj6Lyb6P+44oIFAtnTYYy46o7Lo+YNFlP/J5
 iQ7T1B5MhtBApNWTkDlo0Rl//KbwKtZXlp0rJerS+tfjogdTTaDNlRVrKPlYxes98ys1
 NrWdp08cVX5PjMeRyTRMOO3BWQIwepcwRSnLuOwb0ciZVNnUEC38XJIS0yHuAGRjAxBF
 BIL8ohl4FusgBoqrqvRPOxcoZHU/qzHA7ZtQqmERY0vTQZ87G4AH5QHy9GmQJChfgoaz
 5pppd5ZiU+hc6ej1VLu+QJb/EpbfcL5d5HgLfj//yfuGm9U40KXGXkkedAXgoLyeBZ5q
 6hTw==
X-Gm-Message-State: AHQUAuYmCYjNX9H7LuTcaHPmImM1X9gPdD2P/yrtCgMVrypV9IBZ/oNk
 vd2lZX/Al0OW1GZML4pppcU=
X-Google-Smtp-Source: AHgI3IaGCe+2xFF3JSK8d6GTX/d7qd3h5bGUH+jFzM5DbieKT1xhKPaRgz4BZ9vvAHaqK37+EQZ/9g==
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr11660350wmj.147.1549638591111; 
 Fri, 08 Feb 2019 07:09:51 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id f130sm6426881wme.41.2019.02.08.07.09.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 07:09:50 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 9/9] arm64: tegra: Default configuration changes for
 v5.1-rc1
Date: Fri,  8 Feb 2019 16:09:35 +0100
Message-Id: <20190208150935.32108-10-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190208150935.32108-1-thierry.reding@gmail.com>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_070953_621694_60E00780 
X-CRM114-Status: GOOD (  11.76  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.1-arm64-defconfig

for you to fetch changes up to bc72bed682a9502f5c8f5adf15107aef6237895e:

  arm64: defconfig: Enable Tegra TCU (2019-02-06 14:38:35 +0100)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Default configuration changes for v5.1-rc1

Enables the TCU driver to be built into the kernel, so that the TCU can
be used as debug serial on Jetson Xavier. This also enables the MAX8973
regulator driver that is required for CPU frequency scaling on Tegra210.

----------------------------------------------------------------
Joseph Lo (1):
      arm64: defconfig: Enable MAX8973 regulator

Thierry Reding (1):
      arm64: defconfig: Enable Tegra TCU

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
