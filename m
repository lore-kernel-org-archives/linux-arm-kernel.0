Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536EDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:24:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223A1217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UOufuSJu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aHDlkJni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223A1217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zHVZOFAIb/ovuUUCiLu+2itYcNS7V+P/lR9w2FmO6yc=; b=UOufuSJuto8T249ANuMINmiWt
	4jeIQWAlK/a2FgWueXfNDetSyUTIbqr+w2JY3CsSGqqu+13PhSW5fx2ZcrOUS/yrxNOlmplbax+Wh
	NJ40lCrR8Z5WRvUZX9bqkK+DTP7pXFOdcDrIWZiudNgYRhFggvuevOHbnpK5ID99ZEro716y7Hq6s
	S9jWIIUTUxILywhErYnv99HugJsrV/9JgZxu9qb7rkoTjIqqAg/wkBkq9rSV3Ox6RCmS63WWqcQ7v
	3ukCFBosToZnTr3VBjZU8L71EbC5laESXwceL53xDVqTLSSl6qHTJTSzYqrQpVd3DnBA+hDyrMnxw
	JieZttJ0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZVHQ-0003Bn-27; Wed, 19 Dec 2018 06:24:28 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZVHN-0003Ar-Dw
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 06:24:26 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c19e4050000>; Tue, 18 Dec 2018 22:24:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Dec 2018 22:24:14 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 22:24:14 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 06:24:12 +0000
Subject: Re: [PATCH V3 11/20] cpufreq: tegra124: do not handle the CPU rail
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-12-josephl@nvidia.com>
 <CAJZ5v0h0n2AXERvXFX_dQWMUw_89ap_LgB6dUK0ThJgZ+unkkQ@mail.gmail.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <312ac6e6-0480-b638-a26b-311013929c2c@nvidia.com>
Date: Wed, 19 Dec 2018 14:24:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h0n2AXERvXFX_dQWMUw_89ap_LgB6dUK0ThJgZ+unkkQ@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545200645; bh=BiTYUVA34jkJLRtNX4un/pBfxSssEgZGF8EyExGhoVw=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=aHDlkJnieDuIkwJ9qagH6NB5QiCP30YcepD36J7sBHXeB8PUVGt4TNX0egTi3GxSn
 qZHweyBYit350zwNJjllL+iTVwhUlOTA9KrMEooLkzY7he+2hH8QwTXxH7vM8hnrAw
 PY+c5Bte52UfV9uKy+Khd/lxYhKwSAcdYLPL8sQw9mzfDp3DgpNPqykN7fsGNFaJJa
 +kCt+CPwYTFTK4vXnFwnhPiHCohFjO33kuoNyvswm0RNbG/UKbAwBTyJ9biOOQKPEc
 IM8bYAmtGo+StZ0uPkMvwxd9XWYbcJ7fuwHXyPzqr8LAqoEJz8+X1HjiYn6L49Hd7o
 Ai/48n/rk5A8g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_222425_480241_AC68A771 
X-CRM114-Status: GOOD (  15.65  )
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
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/18/18 5:37 PM, Rafael J. Wysocki wrote:
> On Tue, Dec 18, 2018 at 10:13 AM Joseph Lo <josephl@nvidia.com> wrote:
>>
>> The Tegra124 cpufreq driver has no information to handle the Vdd-CPU
>> rail. So this driver shouldn't handle for the CPU clock switching from
>> DFLL to other PLL clocks. It was designed to work on DFLL clock only,
>> which handle the frequency/voltage scaling in the background.
>>
>> This patch removes the driver dependency of the CPU rail, as well as not
>> allow it to be built as a module and remove the removal function. So it
>> can keep working on DFLL clock.
>>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> I'm assuming that this entire series will go in via arm-soc, so I
> won't be picking up the cpufreq patches from it.
> 
> Please let me know if that is not what you want.
> 
> Thanks,
> Rafael
> 

Hi Rafael,

Thanks, will check with Thierry.

Joseph

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
