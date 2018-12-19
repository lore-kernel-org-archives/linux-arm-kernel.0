Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A06BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:09:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D6321871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dtzudLys";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZFG1AOYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D6321871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tgvKIWKVmr8JZWdJgbGzzHv6REd6i6FtsIY5rIWlgqQ=; b=dtzudLys3FN35BmoPuW+K+1Sp
	wwpKcffNRY9yXkhZE03myRvBuzZ84aHQpFZ/WeZ8blegBwfZKCPDpbxvrPELEx1q17xF8XAHRMtKn
	gZFzHjpUbi7gEPfDIRFEqcL203/uukUUsFh21M1id+Ku8IjirD2hfqE2IdJ4WcDwB2rvg21xBM0sf
	lNLfFKGh4+zgLjTcEvQQjcGq91FQY8YLjeiaqulse2mi7/hn/Wf5zCR6gukXQHCwsb7rqT9aLYGcP
	NLLCfLQfU3dPN7X+cB57xPfz0+lshyNCPxQMZ31/TtAOQfc83uaNdhKDdgEoQhyfgVy6+4m9OblkJ
	1qdJI2Nfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZVyT-00012c-VW; Wed, 19 Dec 2018 07:08:57 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZVyP-0000vd-SM
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 07:08:55 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c19ee750000>; Tue, 18 Dec 2018 23:08:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Dec 2018 23:08:43 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 23:08:43 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 07:08:42 +0000
Subject: Re: [PATCH V3 10/20] clk: tegra: dfll: build clk-dfll.c for Tegra124
 and Tegra210
To: <linux-arm-kernel@lists.infradead.org>
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-11-josephl@nvidia.com>
 <154515602466.238328.7202899555618997431@swboyd.mtv.corp.google.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <df7945b1-cbf2-e7bd-fce0-8fdb24f1f7d2@nvidia.com>
Date: Wed, 19 Dec 2018 15:08:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154515602466.238328.7202899555618997431@swboyd.mtv.corp.google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545203317; bh=yCGFXkYZ3MAdvYKk7+/7j55ywZFpM/HO3SgIQxZeGhc=;
 h=X-PGP-Universal:Subject:To:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ZFG1AOYbeSRy/s/CpZyrsiMacAtvuogf7YY9vqeW2UYgfa46Bjz6xMbPGgpGVRrqj
 x7CNf5VBf8Z2+rKHzHESY6W1T3kj4gWYndOxQcdh9WwrBquakhuF5OXjz0dtiqON1S
 FQcbi2gFg/O7d50cJNLI+NTRvA3Na59jcayZAa/i/fZjwgx0Ljf/tY3/lhQZEKWbB4
 SfTbXJgS0pk/7jGXQ1GJkwxvSUJpre19AVTDL5monTdCTvzppBqLfvrMUApyDUHdjy
 SkXSpKw0Z5jbSGLYD/iQdIXRKEwE4m6DeKZvZLn3wvTSVRgr8h4hlIMCeqgoMsrbl/
 SjAbt/Aur7zhw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_230853_924156_AE6E4759 
X-CRM114-Status: GOOD (  11.54  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/19/18 2:00 AM, Stephen Boyd wrote:
> Quoting Joseph Lo (2018-12-18 01:12:22)
>> diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig
>> index 7ddacae5d0b1..57902ab43f4a 100644
>> --- a/drivers/clk/tegra/Kconfig
>> +++ b/drivers/clk/tegra/Kconfig
>> @@ -5,3 +5,8 @@ config TEGRA_CLK_EMC
>>   config CLK_TEGRA_BPMP
>>          def_bool y
>>          depends on TEGRA_BPMP
>> +
>> +config TEGRA_CLK_DFLL
>> +       depends on (ARCH_TEGRA_124_SOC || ARCH_TEGRA_210_SOC)
> 
> Nitpick: Drop the parenthesis please.

Hi Stephen,

Thanks for reviewing. Will fix that.

Joseph

> 
>> +       select PM_OPP
>> +       def_bool y
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
