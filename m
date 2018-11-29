Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DA9C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:36:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8400521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QM7q+NMJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9clXkQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8400521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YZmWcbORTyOhAUQr1XUQDh4haI7jB7nfehRlu+3nw3M=; b=QM7q+NMJynNLA2
	zwl87L+DfD3jDnK9pW+5O2cZu4uMRilrQIu3gSBoXRb7F0h4NGj9wHAYBygj5YQwct5IatuyqesOL
	J6Vvf45cAepnO2SbVQJSWpJ0lsDhYltZMi24OWBbMXO4x7yqDkncjpzJxKKjijBIGkYbohL5QHhYM
	OCkzukYty2dAr+6BuVJ2IHGIFd9c7JbgT4hYfT7vTwHVB9tw8OSkgSoxmrLwDKEotfWNhs23rM0x8
	s6ZNHW2VQLjNLY5BTacJMaYNbbMhzp5ptseT1CmWfiV1dVp2fbqG9GO3zh6DsZ+NgMqzdfm3MxHyj
	xTtLIWmeMRWKb19Q3LEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSUul-0003i3-U6; Thu, 29 Nov 2018 22:36:07 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSUuj-0003gy-4d
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 22:36:06 +0000
Received: by mail-ot1-x342.google.com with SMTP id v23so3344137otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 14:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3JW6B3D98u4etHJO+8n/AZa4bWpPMV0p1A76//BfEnc=;
 b=d9clXkQRKp7Vxx9axZUxcicoVAl6MEaYkfSMF/x1IKHHzbcNKeuXzRa8RZAM2T9yJV
 +ls6MbY5CGWw668MPt8/WXvtagbWLQsQSI1ghdrjkOxl8Oua2R9qcly7u/ldiUDIzfB/
 A/k7Jf8NreyWYYofMNmQv/KZhFM83Z0AIj0mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3JW6B3D98u4etHJO+8n/AZa4bWpPMV0p1A76//BfEnc=;
 b=uT25RbwbH/e4ry5p6XBAn8QOBIbpOwF3YVK0EBUD6fe8BMks0RfkIpIdxNOlhy0Xmv
 dgset4G/gpW3x6IGS8irTFxWgG7o3fKqq07rIugZyqyt6L0mgcL2s/o+VIM1Ihj6AHBI
 h+lGvg4H0UCcLW/TO9xKLu0dMe9tx9eWOtXS55AZezWW1H6A/MsM3KCYjJ3F53BAFxwZ
 Q5lfKoIEIwCWt2OfjlztTt2q3uwo3uUN5rMrBg5YIRlL+EPcKjVA33Vejgtl0g+yRJ8m
 lul9ckxVGyOGo9n5L9BgUkPvtUzvS79l7/JRc7+ktJwHCgcgJyIarhia0ERwDN/zxXE4
 IzkA==
X-Gm-Message-State: AA+aEWbo9mUEmhx+HN27Ru7EuFV0TLnHhXFFuQmW/Kr8RT+el471TZl9
 r8erQ4L9vTaNOtgYX8XOBunh2w==
X-Google-Smtp-Source: AFSGD/WO2I8ekTpFCi7HsNadZ8gApVd7jCph+HE9wWDZas8Y0VsclympBnWaKsTZDjVgBFCml3UwLQ==
X-Received: by 2002:a9d:6287:: with SMTP id x7mr2177701otk.304.1543530961916; 
 Thu, 29 Nov 2018 14:36:01 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:d408:b2c2:72bf:467a])
 by smtp.gmail.com with ESMTPSA id g138sm2698392oib.26.2018.11.29.14.36.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 14:36:01 -0800 (PST)
Date: Thu, 29 Nov 2018 16:36:00 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] drm: msm: Check cmd_db_read_aux_data() for failure
Message-ID: <20181129223600.GC32306@hector.attlocal.net>
References: <20181129163826.178670-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129163826.178670-1-swboyd@chromium.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_143605_186824_BEE497F9 
X-CRM114-Status: GOOD (  11.37  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <lkp@intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 08:38:26AM -0800, Stephen Boyd wrote:
> We need to check the call to cmd_db_read_aux_data() for the error case,
> so that we don't continue and use potentially uninitialized values for
> 'pri_count' and 'sec_count'. Otherwise, we get the following compiler
> warnings:
> 
>    drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_arc_votes_init.isra.12':
>    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count' is used uninitialized in this function [-Wuninitialized]
>      pri_count >>= 1;
>                ^~~
>    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
>      sec_count >>= 1;
>                ^~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Thanks for the patch.  Queueing this up.


Andy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
