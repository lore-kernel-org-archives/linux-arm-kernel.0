Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDC9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:38:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38BB0218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DaPCU788"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BB0218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W0EcP/1loJjMtlzcnnMx4phSv5zpZ1RROblJVS79fIY=; b=DaPCU788EHEDru
	ZSChZGqXsVr1fwHRj/VUhZGzj0xNzrSXKavFAj+mwg+R/AmRcfyCktfd5wcQiKZq2GAIQmMD0VSTO
	PFPG+FfYAX6NEEPgpf90glln+WWb+Ud9aPNzsAY1rqC3taQvjBIxdX67tGpd6RFXQKRr0ilUGihEH
	6j+5OgpMdWCitYlb6oMabYOlzdUX5OId6ri53i4yZLMvsBW5+UAUH/G5KT/xouhCg0uLV6+jJHCrx
	5tJIpOLg8AEbYqxh+RMAc7m7qICU6fOWi1Kz4BT/3FkFRYjTyElE0x02dpBf1XIUMvSA9Go7u917o
	21wrxc6p2pGaUFTucHPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp9jv-0005uO-Ip; Thu, 31 Jan 2019 10:38:35 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp9js-0005tx-2L
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 10:38:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21BFF80D;
 Thu, 31 Jan 2019 02:38:30 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF03F3F71E;
 Thu, 31 Jan 2019 02:38:28 -0800 (PST)
Date: Thu, 31 Jan 2019 10:38:23 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH] cpuidle: dt: bail out if the idle-state DT node is not
 compatible
Message-ID: <20190131103823.GA19907@e107155-lin>
References: <20190131022749.19046-1-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131022749.19046-1-josephl@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_023832_116168_8FEF6BCF 
X-CRM114-Status: GOOD (  18.80  )
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
Cc: linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 10:27:49AM +0800, Joseph Lo wrote:
> Currently, the DT of the idle states will be parsed first whether it's
> compatible or not. This could cause a warning message that comes from if
> the CPU doesn't support identical idle states. E.g. Tegra186 can run
> with 2 Cortex-A57 and 2 Denver cores with different idle states on
> different types of these cores.
>
> We fix it to check the compatible string before the parsing procedures.
> So it can make sure it only goes through the idle states that the CPU
> supported.
>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  drivers/cpuidle/dt_idle_states.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> index 53342b7f1010..4a528908abb3 100644
> --- a/drivers/cpuidle/dt_idle_states.c
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -180,6 +180,11 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
>  		if (!state_node)
>  			break;
>
> +		if (!of_device_is_compatible(state_node, matches->compatible)) {
> +			err = -EINVAL;
> +			break;
> +		}
> +

Does it make sense to use of_match_node to get the matching device id and
just pass that to init_state_node instead of the complete array to find the
match.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
