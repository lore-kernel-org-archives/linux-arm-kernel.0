Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B186C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:49:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7734218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZnNBQZLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7734218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PO3q6e0+l3yQUrL8m1IUZ7DVCT7ZFQGZ2g4syMWSLhA=; b=ZnNBQZLpFDsOQ7
	9JwmhALy6keDoU3jGMpuDe9di4vUfZqEpf8jgIoo2EMXo4KO4VbkoT5mbzy/6hIDWOFzTt4GTPvl7
	xh8ddRm63bBEF53ORnep+D6l8dFYYlLbSRGEvn2KS2gWFgCxbqbfO5nDUvZIb/KgQs2XceNs0K2NR
	hwsSlDKQXr+qopVM2N0fnUh1rqognM1SblRa3kwaBVpvzd4dJhcfp1RPRmXW6hAzms/r3NBnqyW0m
	FCTTSXpBveUfB6S5za8+8WG7ZDbSuj9EgX2jAujc2Ha2szVsTcq4FNEwB+WKkhppu14gnNrOYeffm
	8dGK0ef/OuN7V3sreMgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpXJX-00088x-Fc; Fri, 01 Feb 2019 11:48:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpXJT-00088Y-RX
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 11:48:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3C0480D;
 Fri,  1 Feb 2019 03:48:49 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E40D3F59C;
 Fri,  1 Feb 2019 03:48:48 -0800 (PST)
Date: Fri, 1 Feb 2019 11:48:38 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V2] cpuidle: dt: bail out if the idle-state DT node is
 not compatible
Message-ID: <20190201114838.GA10042@e107155-lin>
References: <20190201021639.27245-1-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201021639.27245-1-josephl@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_034851_890856_BB81F5CD 
X-CRM114-Status: GOOD (  12.95  )
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

On Fri, Feb 01, 2019 at 10:16:39AM +0800, Joseph Lo wrote:
> Currently, the DT of the idle states will be parsed first whether it's
> compatible or not. This could cause a warning message that comes from if
> the CPU doesn't support identical idle states. E.g. Tegra186 can run
> with 2 Cortex-A57 and 2 Denver cores with different idle states on
> different types of these cores.
> 
> So fix it by checking the match node earlier, then it can make sure it
> only goes through the idle states that the CPU supported.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> v2:
>  * fix it by moving of_match_node earlier, so we don't need to match the
>    node twice like the v1 did.

Neat, thanks for the quick patch. FWIW,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
