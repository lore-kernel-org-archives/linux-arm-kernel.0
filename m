Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AA9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:55:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4DB21721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jq1Vli1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4DB21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gI96avGWQC6ufgyOjwRjDBPvBXD8Yl1VrobZvDTP7nU=; b=jq1Vli1FqlcGYfzFYxL89lScZ
	KMHaFsTgG+xRYDblAAoKTlxc3inlCntg5lqy07LpGgSy5dopGl1iC/qTjer9Td9nbkrfDkw3M1FXx
	7g7MqXtSsKIMeNX7YwY+rrLWvs0C8LQhpcf7mrSDKdxCyCcKskkM6EzifDTX0bJvNdm3kFj+XR5y1
	TCoXmaDZZWWSOsjKmSBeNz2oRbEnpdqtg4IA2JP0hS2g+NzjmjyxwwaHDybLkwaiWLjotgzm67LOh
	l1cKegMbIh+teqX9rWVaravprJAxEg+/xZEr9DfPGUwSr6sLYeY577YQS9kQgvYmk90k24r1kcBlH
	HYpAC3Jfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbM1i-0002Al-Ti; Mon, 24 Dec 2018 08:55:54 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbM1d-000291-MI
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 08:55:52 +0000
Received: by mail-ed1-f65.google.com with SMTP id y20so9615716edw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 00:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uvgDl0zaRclmAWSUoyGF73jp9Q0y9utqlwKPLMiDedM=;
 b=OMml9SeK5eFYXVMPFufYLlKa5F/hQnsQNK88wzq51j9U2RgACJPA/fRy3eIUzvWzAJ
 5IWbb9tNkYww62zvcQn1r26EUgUJM0GKO6bCLJk+w84Xpiz35v1k7JHQruSVSk2nEBb1
 9I7pC1ZY6CCyqBG9kV+YKV0cLFcFhMnFGjCPJ3GPC56CtKwLeXtZFn6Br4NrGCgAu3PH
 iFEfolEdHrWDdaSVO6cok01w//3xlnuLi4uFDTGZA2Ueck9IgXw7KV3yGaJEmGvthdl5
 WW41o7QolPltvnfgG6vXJc/RUPfNcJTfj0Yemt0Lsn4SOObIH491hzwjQtruYrunMjMN
 ljFg==
X-Gm-Message-State: AA+aEWarBJa99VvjfDeCq5zwBzo8EI1MYFVJ5F1jVbcWAPpWCQpXQgrS
 xuzVwYbIjjG/iP5v6Yil5EvA4g==
X-Google-Smtp-Source: AFSGD/VdcA83vWXu0jMmWjRNqba1ITVqBs2MmDfWz/ohdeUlnho4PEFvTfAvWkoqONjY+XO9fYZuDA==
X-Received: by 2002:a50:8e16:: with SMTP id 22mr10057084edw.269.1545641737689; 
 Mon, 24 Dec 2018 00:55:37 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl.
 [84.106.84.65])
 by smtp.gmail.com with ESMTPSA id s19-v6sm4713219ejz.2.2018.12.24.00.55.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Dec 2018 00:55:36 -0800 (PST)
Subject: Re: [PATCH v2 0/9] i2c: move handling of suspended adapters to the
 core
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <7fd31445-6cf8-5094-3cd8-d6ca5c059541@redhat.com>
Date: Mon, 24 Dec 2018 09:55:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_005549_724859_ACE1B491 
X-CRM114-Status: GOOD (  23.60  )
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
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 22-12-18 21:26, Wolfram Sang wrote:
> Here is the new version without specific I2C helpers but using the
> 'is_suspended' flag from the PM core. I didn't like messing with the
> flag directly, so I did a helper in patch 1. So far, I like the
> approach. The diffstat looks nice, and i2c-rcar.c and i2c-sh_mobile.c
> rejected rightfully too later transfers without further modifications.
> Tested on a Renesas Lager board (R-Car H2).
> 
> I dropped a few Tested-by tags because I think this approach is too
> different from V1 to keep them. I hope you guys can have a look again.
> Thanks for all the testing, so far!
> 
> A branch can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/reject-when-suspended
> 
> If this series is acceptable, I'd suggest to take it via my i2c tree
> after rc1. And then I'll provide an immutable branch for the PM tree to
> pick. Let me know if this works for you.
> 
> And thanks to Renesas for funding this work!

Series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
> Thanks and kind regards,
> 
>     Wolfram
> 
> Wolfram Sang (9):
>    PM / core: add helper to return suspend status of a device
>    i2c: reject new transfers when adapters are suspended
>    i2c: synquacer: remove unused is_suspended flag
>    i2c: brcmstb: don't open code to reject transfers when suspended
>    i2c: zx2967: don't open code to reject transfers when suspended
>    i2c: sprd: don't use pdev as variable name for struct device *
>    i2c: sprd: don't open code to reject transfers when suspended
>    i2c: exynos5: don't open code to reject transfers when suspended
>    i2c: s3c2410: don't open code to reject transfers when suspended
> 
>   Documentation/i2c/fault-codes      |  4 ++++
>   drivers/i2c/busses/i2c-brcmstb.c   | 22 +-------------------
>   drivers/i2c/busses/i2c-exynos5.c   | 10 ----------
>   drivers/i2c/busses/i2c-s3c2410.c   |  7 -------
>   drivers/i2c/busses/i2c-sprd.c      | 32 ++++++++++--------------------
>   drivers/i2c/busses/i2c-synquacer.c |  5 -----
>   drivers/i2c/busses/i2c-zx2967.c    |  8 --------
>   drivers/i2c/i2c-core-base.c        |  3 +++
>   drivers/i2c/i2c-core-smbus.c       |  4 ++++
>   include/linux/device.h             |  5 +++++
>   10 files changed, 27 insertions(+), 73 deletions(-)
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
