Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063F5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:40:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD30220870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZaevTdzm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KG3A3Ye0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD30220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=25auAUsDwPYXifdXRHILev6ws3ZOuPuYwTSUbedorXQ=; b=ZaevTdzmNDeX4yyPRlxn0rfT0
	6GoaAcF2BI8MsVJsTzH05Ws7rFWFwW0nrHu6q8FhpDLoHbqagOB/en26Qd1i6JTjucsLdpxJoZdHa
	pQomHhkJlGaRN9do6keEwB6EyLtGYJ2vi+h4o4d8igbYXGyuR/8W9ljWQ8UziQG8RkrBhRnUlgKY1
	/kw0CzV7SW7XJC3GfxZlCHlJjbhl48ARX1pywv2NcnWYFiR0fVwj0E50j2ZVEtJ8A9/bEd9vUVg3d
	7bPRBHjzubOHfY7UfA8tamOam3NNjnFqK8uLtAYEPwfqGV+yG2BNu9/j8X8y+rg6RJldGbOmvn9B+
	KhQM6TsdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gofnU-0005yD-Nd; Wed, 30 Jan 2019 02:40:16 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gofnQ-0005rS-Ms
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 02:40:14 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c510e6e0000>; Tue, 29 Jan 2019 18:39:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 29 Jan 2019 18:40:10 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 29 Jan 2019 18:40:10 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 02:40:08 +0000
Subject: Re: [PATCH V2 2/6] clocksource: tegra: add Tegra210 timer driver
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>
References: <20190128091815.7040-1-josephl@nvidia.com>
 <20190128091815.7040-3-josephl@nvidia.com> <20190128150908.GB31317@ulmo>
 <20190129084155.GX7714@pdeschrijver-desktop.Nvidia.com>
 <20190129102912.GC28850@ulmo>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <8d5b6a61-8fb8-2f83-5378-9b1a1e5bd03d@nvidia.com>
Date: Wed, 30 Jan 2019 10:40:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129102912.GC28850@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548815982; bh=FrciTN+redRE/lCiDp/HTROkP++nJMtJ9d9VV4lPFqM=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=KG3A3Ye0Sb7XAUGr538f8B6znelawNhxh7Sr36OfdmyBYXqHsPxVloNC41l79e1Dp
 QD1Hi8WvPF1anHlwPa6an9XA0NfCArJuFja6XMeKmQO54qsKI/jR/y4tBHHA5n1hw/
 xf+QWgdlDb/RZAVXNsy0Ru3HAH1pfeaLVfmJRHzfbQqvdnxsTZZTAaCEkPLQQmnTzk
 6ClMBbfF30v7MjlQ/azBhzyRseDtTJ6mezMqeQLXfNwPlkYz+Fv3eI23AD/Y8pYtm9
 9Z3jyHG2BJ5XF954uRjLrxq5sHjoV9/cP6eaCI3qzHgv9h6c0UI2Sp0asQ+xJjlf+w
 VvOEdZ1CdYhjQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_184012_774664_D39045CF 
X-CRM114-Status: GOOD (  15.58  )
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
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/29/19 6:29 PM, Thierry Reding wrote:
> On Tue, Jan 29, 2019 at 10:41:55AM +0200, Peter De Schrijver wrote:
>> On Mon, Jan 28, 2019 at 04:09:08PM +0100, Thierry Reding wrote:
>>
>> ...
>>
>>>
>>> Up to here this is a duplicate of timer-tegra20.c. And a lot of
>>> tegra210_timer_init() is the same as tegra20_timer_init() as well. Can't
>>> we unify the two drivers instead?
>>>
>>> The power cycle restrictions of the architected timer, do they not apply
>>> to chips earlier than Tegra210 either? So don't we need all of these
>>> additional features on the timer-tegra20.c driver as well? If so that
>>
>> No. Chips prior to Tegra114 do not have an arch timer and the arch timer
>> does work correctly on Cortex-A15 so Tegra114 and Tegra124 can use it.
>> It's broken on Cortex-A57 though, so we can't use it as a wakeup source
>> on Tegra210.
> 
> If chips prior to Tegra114 don't have an architected timer, then we
> can't remove the timer-tegra20 driver, because we still need it on
> Tegra20 and Tegra30, right?
> 

For Tegra20/30, it's Cortext-A9 with TWD timer. (arch/arm/kernel/smp_twd.c)

Originally, I thought the functionality of timer-tegra20 would be fully 
replaced by TWD timer driver. But from the log in the kernelci test 
farm[1][2], it looks to me the timer-tegra20 driver still works as 
clocksource driver for Tegra20/30. I cannot confirm if the clock event 
device has been replaced by TWD timer in the log. It could be replaced 
in the background. And by looking into the driver, it should be.

Compare to the log of Tegra124[3], it has been fully replaced by arch 
timer driver.

Note, "timer_us" is the name of Tegra20 timer.
[1]: 
https://storage.kernelci.org/mainline/master/v5.0-rc4-1-g4aa9fc2a435a/arm/tegra_defconfig/lab-baylibre-seattle/boot-tegra30-beaver.html
[2]: 
https://storage.kernelci.org/stable-rc/linux-4.9.y/v4.9.153-43-g6674590d15d2/arm/tegra_defconfig/lab-baylibre-seattle/boot-tegra20-iris-512.html
[3]: 
https://storage.kernelci.org/lsk/linux-linaro-lsk-v4.9/lsk-v4.9-18.09-1494-gde3059d32f93/arm/tegra_defconfig/lab-collabora/boot-tegra124-nyan-big.html

Thanks,
Joseph

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
