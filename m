Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB7DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:12:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0077F21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E/HCPO3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0077F21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CSiUKpaf6Npi2kYUSoOKaVEyKj0NUapTQTQKL5foVzA=; b=E/HCPO3feCtwvj
	oq0Pd77tYrK+T+ggTf4zPhrCnK0SakLHg9prGjdfh+JK/EKS3YKT9z+zdQLVWvHUCQWBaVHfYsdlc
	dnRZjr89JeeoNJtdgXEA4fTcexwZw6+917iyoyTiVmYnmnFyhoImjugEngP+JMfk84Dh/db4jtMLH
	iRff984sSXvnqoCSy1YqncLKS18KGclBy/wts1HjTO455oD2E4HMo+QYvs/vk87V1fhFGeY1rmH/F
	uwFNlDco/ASpt82gM3KEhqDZlji6g+YCjTEf9LDu0RANnsFBxubcz3qwnKJOxxHVsWLaZhv+o4k/I
	V+6dAbGA5YDw5a8b3Axg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga00J-0006rP-5H; Thu, 20 Dec 2018 15:12:51 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga00F-0006qm-8z
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:12:48 +0000
Received: by mail-qk1-f193.google.com with SMTP id w204so1181763qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tTEXyISDAMX8AABF65r6XDonjN2FrmB78YROn7fNZ74=;
 b=QRu9etRCEOTSpCkxcMn5tg1iz7pmg2Wr8l14Oy9ucevB5nQwNREhtr7FV/YVLHi9IU
 EMFQ+iQVI1GHIafqGD5ywxMvO87/W2+kbftqWD2dcAyQe4+JUCtiok+Fvqyt3E6O5A06
 DuUYy9zF/zmMIWDkUlSugwAo1KAiNCEr44Tuvfh3lvknqhErXD2TNaMVfWqRND7822w+
 /l2O5fSNGga5UbNmEINUMsrFFB+6tY/rN5bvF/sWqrvo6QbMFzn2Zi/rK8bs3kqFdiKV
 0yXSVcwyqGwMabyZKpLM5Pk6TwbnUVz0f+1ZO4qWXBDrDEQPGPq662RkJazVCbQYe6A2
 8caA==
X-Gm-Message-State: AA+aEWa0+AOrU9NvZYCeCURHGlUAmd6BlaSQBLbt8//rpG1LjQZobc2j
 QiC1hShOlJl6Ws8ofkmDtWhiLw/PVzSKoMY1+t4=
X-Google-Smtp-Source: AFSGD/Uxh1lThNyNvaNRCFEsfNr0XIsynEkx6H1bGDZqhxIfGD+aO3VfpanE3FM2Rt0PvQSbdDJMClIaHZBA8w14DyI=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr23724766qkf.107.1545318756065; 
 Thu, 20 Dec 2018 07:12:36 -0800 (PST)
MIME-Version: 1.0
References: <1544802573-5898-1-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1544802573-5898-1-git-send-email-andy.gross@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 16:12:18 +0100
Message-ID: <CAK8P3a1zzqkL2ATRQrky6C1Hr=BTbEzX4riRL9S5vy9vFrDkMA@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm Driver updates for 4.21 - Part 2 - Redo
To: Andy Gross <andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_071247_322339_DEC8D4C5 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 arm-soc <arm@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 4:49 PM Andy Gross <andy.gross@linaro.org> wrote:
>
> The following changes since commit b601f73130a375c912d9f2ec93c5f3cea5d6a3da:
>
>   drm: msm: Check cmd_db_read_aux_data() for failure (2018-11-29 17:41:53 -0600)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.21-2
>
> for you to fetch changes up to 16ad9501b1f2edebe24f8cf3c09da0695871986b:
>
>   firmware: qcom: scm: fix compilation error when disabled (2018-12-05 16:44:05 -0600)
>
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v4.21 Part 2 - Redo
>
> * Fix SCM compilation error
Pulled into next/drivers, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
