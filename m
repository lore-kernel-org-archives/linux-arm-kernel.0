Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB60C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:51:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19FFB222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ijs0czBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FFB222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vbfrtDq1WH2Vw7REB454S9ioibiJLPgX/EaQcrQvAYs=; b=ijs0czBw/1I+kH
	dwUUHJXx4Q1HQz59/6jMJ6SMs4cagzN4Yr3bQzuGH9Cf75SCmPbQcNNC5i7/YtuNFEzTAcgCREVWz
	xu37+a46I9pSomH4rstUQmXHpxEbKNvmy+JqsjyV5zVxM8fSLY3dNTyv3iwJ+cSxlyXNwn7sDt8PF
	q7XAJ0uHVBdwMl6a1NLvTwiLZbQypZhrGsQUvc72PCA/22YH8eAMyJa01cFn8v/fyJuTJ2KsMxX4V
	AfE3KnScmOrIN5e0InfJ3phS4rFYq0WPVlozLdYyC82aqX/070gsL3zoiV9yJzEiAI5VRKdgL8F8Z
	zOjIAbxot6CWFR78XOyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujVk-0005W3-Az; Fri, 15 Feb 2019 19:51:00 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujVh-0005Vg-2M
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 19:50:58 +0000
Received: by mail-qt1-f193.google.com with SMTP id p48so12307749qtk.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wKn40GLsi0eMNZbiz6oSXx7zrIm9awv1fncQgXJ5Eow=;
 b=Gs9Pjg4FYGGFwm4AQ1ZRz5r9Fe+a8psYRmAgkvDRpLuV5SpuenE3UsswbCdX51q8u8
 z+2vSTfcJLrbqxwG/f0s5V51okdYdPmoudrfgV7tl1ne4XYxIeayJHCEyTqIodvEvy3v
 gDGUsDD3rPp8oOm1yAmLO/Fo5PwC5QrnfF5eBSqo4Bf1matVuUzEVhtKhutZ8yA2BF1S
 1Dgzb8KzVhwYdZxqBsARMERE6QsMLs5P6c2m83C6uejHZfMUV2xDMOeSgbEyeuOeGTeK
 fQo7pF+zYvKXB3XvMFmT+9fCWIv/fIjbW82rTsOA6PYIiqyfgRgd/cnWXjF9yaCi9Kw7
 +nFw==
X-Gm-Message-State: AHQUAuZzkXBjCzWwFGLuV4sWDeXPP9c+VNKQvDyGep/EtzRRKdMhvZV+
 IBiJyLWKJpiOicagMQnNk8q+SJH//phpFp8cY+A=
X-Google-Smtp-Source: AHgI3IZE94XjWI92GCwP9krgD7hXQe9j79hzOhQ/VRk2p2pJmp5I7h7YpQmayZCr1FIiHW3Vi3GGn+nfRmB10UKbEdY=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr9043380qta.152.1550260255986; 
 Fri, 15 Feb 2019 11:50:55 -0800 (PST)
MIME-Version: 1.0
References: <1550258825-20696-1-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1550258825-20696-1-git-send-email-andy.gross@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 20:50:39 +0100
Message-ID: <CAK8P3a0qSN8KKPzAm_pYnW7TWEq6Y9xBp394caZwvPPrDvCjqQ@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm Driver updates for 5.1 - Part 2
To: Andy Gross <andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_115057_104211_266F106E 
X-CRM114-Status: GOOD (  12.04  )
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
Cc: Kevin Hilman <khilman@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, arm-soc <arm@kernel.org>,
 linux-arm-msm@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 8:27 PM Andy Gross <andy.gross@linaro.org> wrote:
>
> The following changes since commit 4e2256d31f0f24107c36dae35a1d84dff0fced30:
>
>   soc: qcom: smd-rpm: Add sdm660 compatible (2019-02-01 16:08:58 -0600)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-5.1-2
>
> for you to fetch changes up to ed10a259faa1bbdf77b8c2153b274b70c90cbb35:
>
>   qcom: soc: llcc-slice: Consolidate some code (2019-02-12 15:27:17 -0600)
>
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v5.1 - Part 2
>
> * Fixups/Cleanup for Qualcomm LLCC
>

Pulled into arm/drivers, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
