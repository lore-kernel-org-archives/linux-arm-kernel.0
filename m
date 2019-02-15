Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC96C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:00:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E4C21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LHLImu/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E4C21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IdYvEkGJiv3/ORs9TC47gK4JvmIAi+O5+P7rjdC/lkI=; b=LHLImu/w1f+LXo
	qt/QSuIgVN2+YLM46D8sLKVkUzx7wPH0ody6eQEnapQ0K1MWVyWyzJpInOPgsTCsQqiMxgzyFgoKq
	8X6IaJJnlRiNP9tm6IRwQkY4gAAkiUk9VRYtCnkaId7DLLPpi6HbnF8+SemjbDLReGeIS9QGc4xuA
	nltvmOLYodj12ZXy23ihGTN6N+QgoCBuUre7mopqHjtZHYO/I5Jls0RfVYlp+jJ4VWNimt48TG28L
	AxHbcqtHi1pQh8FgmPwSd+2WfASLtQrcer03gb1A7GVFlbGncz742OkomXn4E1gTjYUsrv2GPhiCV
	GxqTMtqAoP2m1+HJkNlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugqx-0002Cz-Da; Fri, 15 Feb 2019 17:00:43 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugqu-0002CN-HN
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:00:41 +0000
Received: by mail-qk1-f193.google.com with SMTP id o125so6105234qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 09:00:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rKSV/1aGqCX5VkWxOgycdQ/IPOcGG769GPa/YIco05g=;
 b=WoOkvrR3PY9YSeh1O6KQXATZY3mrjhoI7nYbxU9brPdp57KHFG6ahGgOM4gfGGAlfo
 FzJ+zPnx7kcQFG8gmCMISWBiZuHtLEME+FEd1GB4RQ8diEt4u03Y3zF53plm8tGL6O/w
 KVp6tsf3eV8QCqZ+KvO8cScgb43VOj2ObQSsZAu8CEFvo8llSZgVgiS/S6Cm4vZ98VfL
 OxcPQYE+FK39cPkaLZ4zztteGk57zZqdD1t6SrVT+FAEU0NahIotyYF7ajpuNkFbWZs+
 OEpCz0qGD3eTYWmVc0Rs3DOJrOtX+HyflrUg+Iv/8eqk0Ub5Cga34D2naryJI91FEYIU
 9P6Q==
X-Gm-Message-State: AHQUAuaZRUBzOpnAoOwzrDunbEOmZkjOpHHzjudV8UVfPeZYDPybrNCn
 IZWKKBFFQsIilKqzLlpFMtVHiKcb1L9uVqG3bP4=
X-Google-Smtp-Source: AHgI3IakXn6H6Gv1TVp6CxaFPmEVeC+4QZFVxoX41RoBK/bXrL7JsYcuIsBqgEvFVeeXWWdPbh7DzYyU0CjB5lRwf2E=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr7578286qkf.330.1550250039542; 
 Fri, 15 Feb 2019 09:00:39 -0800 (PST)
MIME-Version: 1.0
References: <1549254680-1282-1-git-send-email-andy.gross@linaro.org>
 <1549254680-1282-2-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1549254680-1282-2-git-send-email-andy.gross@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 18:00:23 +0100
Message-ID: <CAK8P3a0ooqY6Y2m+DFrNMWtP687CyCGg9=0kGZ6T6u1typPY2g@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm Driver updates for 5.1
To: Andy Gross <andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_090040_577700_AA077A7E 
X-CRM114-Status: GOOD (  11.99  )
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

On Mon, Feb 4, 2019 at 5:31 AM Andy Gross <andy.gross@linaro.org> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-5.1
>
> for you to fetch changes up to 4e2256d31f0f24107c36dae35a1d84dff0fced30:
>
>   soc: qcom: smd-rpm: Add sdm660 compatible (2019-02-01 16:08:58 -0600)
>
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v5.1
>
> * Add Qualcomm RPMh power domain driver and related changes
> * Fix issues with sleep/wake sets and batch API in RPMh
> * Update MAINTAINERS Qualcomm entry
> * Fixup RMTFS-mem sysfs and uevents
> * Fix error handling in GSBI
> * Add SMD-RPM compatible entry for SDM660
>


Pulled into arm/drivers, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
