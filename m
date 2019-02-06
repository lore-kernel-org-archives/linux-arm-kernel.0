Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C912BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:53:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BEF20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WIIzYGUv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsH58K6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BEF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=caxJSmQNBIaIjTFTxWuPELRgvYwXrQHrM/xgDE8U0HU=; b=WIIzYGUvJmSpwV
	3mHJtYb9j+LQ2OKOUzXdM5DgayziOICWUl6MT0KBJVqzRWK9axiebeBt+mHXKK/s61yqFDkNuJrZu
	i4pEUdwH1vm/EttKd6uLX2MaxUO/KLOVKDU+J8LkUN7hqdZErEPvbUuOBFNSgvIcESxrjzidIpK6p
	Gv+ykW7vf9qGKGeff9ZUAAJQO2pagkrCA9zSk8q4f5n+rgPrC4KNg3PETLaSToBiZGvbMsXD4Q7tn
	kMY4+GZ8XWBD1lw4yp/QzR3Oe9SDxEwoic4B+TYi7ccbT1H9z0QOoKJ5DXtrW8t3aLqqXJn+uqa8Q
	Y/RRBh+xmK2QabVtdoRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grFCm-0006tN-TB; Wed, 06 Feb 2019 04:53:00 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grFCj-0006sM-1A
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 04:52:58 +0000
Received: by mail-pf1-x441.google.com with SMTP id h3so2558992pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 20:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jXHb9lbYoSf/MPyXB+Nyl8mORi2qbkCDejL2LhD8OUk=;
 b=YsH58K6TkzUKdj07xj0Rc2v8PmOsoRwFTTVzbb2Dq6H4w5RhxrsRoK/NqkDyiAA2xJ
 rfQ0fFoRh1BjhTjarUnPlQrYfYsC7G/TbrLDUYaIkjc0pTb3VZnXSTAOjJ1IIs3pszKa
 G6WmgieTjHZGZ3Ci4sq3n33dzfyNwfAKFkwmtEP9pg6R7+KqdMhYYGBdyChgQfZS7Z8M
 Mk9deWaXaCVTdYiMLCkKAZ4mXZSf9ia6VeTQAwuJFYYilqc2G+iysV0Y0INXRy53resN
 qRKeTxPkwtk9CJnaJf4eFme8am1VVMq+vgmwpCqBi3k/X+OSSNL8+RBLdUJ4aF9ujQvS
 Q+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jXHb9lbYoSf/MPyXB+Nyl8mORi2qbkCDejL2LhD8OUk=;
 b=lJT+Lq4tUN4D8auAv1H+ZVzVZl+v0ovYM94QGSelAo6BgNnhb5L19vJ9hLiLRmZhC+
 2IER9DJJQkM8/xnFdWAKR5BYAW54bPGoKWBmWevdYvj5eoz767KtFk7oGODpZQnmHnbe
 +DNn2eoOfziRm213YeFoHj3mfElWJD6CDj+ZZthaGt+/8vKMboVJf0tV1mOdZYuZ3MvP
 yaj4xWXcjxzTm3+wAC9eZChVOx4C0BWPJCFw3gkimudbJL0nacTbrPvx1uMfAvswu8+l
 NY4l9G3PtANAjoDBt1jxCTDLVmnM1MyAfVc9tGL5zENuvrB6qf5DOQP5Re2mb5I7/ZJH
 uKeA==
X-Gm-Message-State: AHQUAuZrEoOD9jyh+mWD4v/gpD9bpm6LDlF3WRIiaha5P2f11Bo4TOIs
 nCZu8ZwxIWhlCcrLaQx4ZZZ4Cw==
X-Google-Smtp-Source: AHgI3IYpGFT/s/hAcjJT6Li9JPvX+6mYH3O1Nu2RrbRFA5CUBdTYVRqg/Mcabcd0H0y87BQY6mZ0fQ==
X-Received: by 2002:a63:4948:: with SMTP id y8mr7893639pgk.32.1549428775669;
 Tue, 05 Feb 2019 20:52:55 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id x27sm10175969pfe.178.2019.02.05.20.52.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 20:52:53 -0800 (PST)
Date: Wed, 6 Feb 2019 10:22:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/2] cpufreq: qcom-hw: Register an Energy Model
Message-ID: <20190206045251.23p4imsqlropssxl@vireshk-i7>
References: <20190205175225.25923-1-mka@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190205175225.25923-1-mka@chromium.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_205257_076414_A6A1483F 
X-CRM114-Status: GOOD (  15.19  )
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
Cc: Taniya Das <tdas@codeaurora.org>, Nicolas Boichat <drinkcat@chromium.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Quentin Perret <quentin.perret@arm.com>, CK Hu <ck.hu@mediatek.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05-02-19, 09:52, Matthias Kaehlcke wrote:
> Try and register an Energy Model from qcom-cpufreq-hw to allow
> interested sub-systems like the task scheduler to use the provided
> information.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index d83939a1b3d4c..a16b9dca7ea3b 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -205,6 +205,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  		goto error;
>  	}
>  
> +	dev_pm_opp_of_register_em(policy->cpus);
> +
>  	policy->fast_switch_possible = true;
>  
>  	return 0;

Applied both. Thanks.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
