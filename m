Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D4FC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6C821904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ttoi3W88";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tXw4YQG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6C821904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=psmvQ22zfuL9d6q6Gw2xtv54W9FxbptLALBxP0EL8jc=; b=Ttoi3W88WFIh8k
	7Ped7xq64Fl6tNTgi6DmxId0RlwdIO4FS1w5ywuRTrt050oC9u6LVabAmUBvs95UxLrK4Gb0cLzxU
	x32OZglHJmNqkUvotsnq8ICDv0pUAkwJR0z8//DyNv2KSe9yqhgD7jLlB/hEINPRptZf97ciIDyO2
	SQHjSbN2fX8gFTNyQ0WMy/v78rjtDRm0tB8m0eu3b7sxJWJpUQhfEtF91O6dWhuGyes0QCNahuwj+
	oDk4XQ347Eu+6ZDIwo79LjOwt7P4pnj8MFJk2N+8DazzS47fJvQIyeONoS1a8nPxBsGxFW2SjsVD0
	66L+m+1xc+Xkht71H1sQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjJv-0000JG-4i; Mon, 18 Feb 2019 13:50:55 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjJq-0000I8-Pn
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 13:50:53 +0000
Received: by mail-pg1-x544.google.com with SMTP id r11so8513801pgp.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 05:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=1kOm+Qg84+1S1syVx9EGqgHA0WnfXLqudF1FwKNmOHQ=;
 b=tXw4YQG+Eq8PxkANhwsGdvRe0Vg23FekEI0iaQFpvtYeNbkrZmAl1sanFY457bG+Ux
 lRx/dWuBq+77CZNfb5VYhIpUxvZvcjwM3Wf9H/3zgP0wjcF/z5qelNmky7ttEaIINzOg
 VT+pHMxUk2IeuAjnazD7Mvb96PnaV+WRTzhqbUkQN07VOpA46yluiJ9YrYuOJblvoARQ
 xb6iWBckBAUfcMCvS/sTuVl1BCkepSJNABGfMGnb8CPBYUtt52fXFv0R2SKD2GTNvtMk
 2D/Ny9u1asF2vkkziAtoNakhLrPxwJiYyy4gKQcTGipYf46RvUCuw9ADiI1//e4UcNHy
 o1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=1kOm+Qg84+1S1syVx9EGqgHA0WnfXLqudF1FwKNmOHQ=;
 b=KDQx6aDSd9sCp84vmldz92nno2MDf2tQlxyRHRlTOSa09nJVqf6BLarxaqdC/LJ8Sj
 uubhXUwmO7jpfFbU+fBT8pFMOwekFE6ShikDV0aKOWd0QtgKwnz0MCbB/cHbI9NyI55x
 igBWuqefsqm9sIE++Wsj6W103tr5WDqhAL/s6X/vlEDWTAsY6is8VuiIXVBR84ojHRl/
 T1QUYjCizOvSz8W5LN3V+tlpqdDs2ceOsNc+tdiqWPX0cKFGEgfBF+9Lk1uvot1V78x6
 z/TDByutJyiu85IxR3FANrAa93ruF+9iSb3uFi628vLeiBB7eG/7f04joaG8WdlQDy7q
 A/CQ==
X-Gm-Message-State: AHQUAuYur0q4jxVF1uqtJUiCHvs4Fb+/9KId+U/YvaxoFmFAZL4hbq9M
 uF9CRAoUZLUXBLKpfTKZ3pI8
X-Google-Smtp-Source: AHgI3IYFbNMIf2NxJrXs6aBGHbBk21aqoPdHV5Bqt15K25ne5WG5M3yHI1x8ChpgZJx2G9zjG7ecBQ==
X-Received: by 2002:a17:902:930b:: with SMTP id
 bc11mr25785799plb.101.1550497849798; 
 Mon, 18 Feb 2019 05:50:49 -0800 (PST)
Received: from mani ([103.59.133.81])
 by smtp.gmail.com with ESMTPSA id b197sm20864007pga.89.2019.02.18.05.50.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 05:50:49 -0800 (PST)
Date: Mon, 18 Feb 2019 19:20:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Actions ARM64 DT updates for v5.1
Message-ID: <20190218135042.GA13218@mani>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_055050_861757_579E77F3 
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
Cc: linux-actions@lists.infradead.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Olof,

Please consider pulling the delayed Actions ARM64 DT updates for v5.1.
Since Andreas is busy, I'm doing the PR this time (with his agreement).

Thanks,
Mani

---
The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mani/linux-actions.git tags/actions-arm64-dt-for-v5.1

for you to fetch changes up to 9175a8116f452a515cea734c6fedee6788e6bc33:

  arm64: dts: actions: s700-cubieboard7: Enable I2C0 and I2C1 (2019-02-16 11:32:46 +0530)

----------------------------------------------------------------
Actions ARM64 DT changes for v5.1:

- Add interrupt properties to S900 pinctrl node
- Add Reset controller support for S700
- Add Reset controller support for S900
- Add pinctrl support for S700
- Add I2C support for S700
- Enable I2C0 and I2C1 for s700-cubieboard7

----------------------------------------------------------------
Manivannan Sadhasivam (3):
      arm64: dts: actions: Add interrupt properties to pinctrl node for S900
      arm64: dts: actions: Add Reset Controller support for S700 SoC
      arm64: dts: actions: Add Reset Controller support for S900 SoC

Parthiban Nallathambi (2):
      arm64: dts: actions: s700: Add I2C controller nodes
      arm64: dts: actions: s700-cubieboard7: Enable I2C0 and I2C1

Saravanan Sekar (1):
      arm64: dts: actions: Add pinctrl node for Actions Semi S700

 arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/actions/s700.dtsi            | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/actions/s900.dtsi            | 10 ++++++++++
 3 files changed, 121 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
