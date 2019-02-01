Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF6CC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:49:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4153121872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aFtzqf2M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="E4aHoFW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4153121872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q9qtcIsPwmv18DSIp9mML/Yr0VAcDj9cG/0Z3B0iNrA=; b=aFtzqf2MJt8mDAJwWS+gVLAOR
	T3OVxoZxxwzH5WdYjecH7c/UAyDBZwfqQEE9R1dLHwu3obDeiK70748CiEO6QdZcpp34RPKvCkDGD
	qmDlaApzJ7ld7hidPfcErZB1fhXMFNbTGIVSQus643s8BDGFjFW1IINX4C4GHcs4NWeKnRRaedh97
	JdFy5sHw7BNSB+j/yMc7VtjmjEuMwk7MSJguZZ0E3NM6g6EnsohHEMxBdW3k6ZFfwMVwHVpIEi2Gu
	ySu7hYgo5BKPIkmaKxzqWCttzki7QVU+RqdHvlC/0n0IPSdI54PqpbnjFPjHJnqBGs7Y2y02CrIbB
	cKELiRhog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpOtn-0002Fe-E6; Fri, 01 Feb 2019 02:49:47 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpOti-0002FJ-Uu
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 02:49:44 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c53b3c80001>; Thu, 31 Jan 2019 18:49:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 31 Jan 2019 18:49:42 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 18:49:42 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 02:49:40 +0000
Subject: Re: [PATCH V4 00/20] Tegra210 DFLL support
To: Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>
References: <20190104030702.8684-1-josephl@nvidia.com>
 <20190125134617.GE22565@ulmo>
 <0a7abeee-1b78-4f90-e94f-43c19eddb9b1@nvidia.com>
 <20190128075442.GA18124@ulmo>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <a2cf3ccd-658a-e004-1e66-d4f9cf1026f1@nvidia.com>
Date: Fri, 1 Feb 2019 10:49:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128075442.GA18124@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548989385; bh=/FBDcfoeMx/+oM04WRXhXoapZLNfebKUcVEPlQV7+gU=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=E4aHoFW9rShupo4AeqJ3XIaDQKtgvhIEFR1ddGp9CDOG4BmW6rnYNlUz0kJx7Eg44
 2lb3uInpk5PuAgztJbPDLt144B+oTXE3Zt3dNv6DGnAYYNGGLszJJnlm3RAwiNiRyo
 DfYxIGEyFpa3yTjwN/mvxJC0MLnPnDKcaMdUOfXYNfj3clgM3ZdmhkyIGItSoH5Evo
 VrjfJt5sGlge+7Bx/ZrkQPsCsp2cEj1kp+zsfmbjN8bfrYscALO03C0PDtYoW8MXB7
 MXFG7Ck1y7PJnW5qNs7Byx+Omd71+6Le2j6S5J1paetK0qQ1bPbQ2WQyAP5Qr1i6ib
 gRh4ooRnyrHiw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_184943_002476_F7B51DD3 
X-CRM114-Status: GOOD (  23.31  )
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
Cc: linux-pm@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/28/19 3:54 PM, Thierry Reding wrote:
> On Mon, Jan 28, 2019 at 09:43:00AM +0800, Joseph Lo wrote:
>> On 1/25/19 9:46 PM, Thierry Reding wrote:
>>> On Fri, Jan 04, 2019 at 11:06:42AM +0800, Joseph Lo wrote:
>>>> This series introduces support for the DFLL as a CPU clock source
>>>> on Tegra210. As Jetson TX1 uses a PWM controlled regulator IC which
>>>> is driven directly by the DFLLs PWM output, we also introduce support
>>>> for PWM regulators next to I2C controlled regulators. The DFLL output
>>>> frequency is directly controlled by the regulator voltage. The registers
>>>> for controlling the PWM are part of the DFLL IP block, so there's no
>>>> separate linux regulator object involved because the regulator IC only
>>>> supplies the rail powering the CPUs. It doesn't have any other controls.
[snip]
>>> Joseph,
>>>
>>> can you detail the dependencies between the various patches. From a
>>> brief look the CPU frequency driver changes are completely separate
>>> bits and it should be possible to apply them to the cpufreq tree.
>>>
>>> The clock changes also seem independent of the rest.
>>>
>>> Are there any dependencies at all that we need to be mindful about?
>>> Or can individual maintainers just pick up the subseries directly?
>>>
>>
>> Yes, no dependence with each other. We can apply them separately.
>> Please let me know if I need to inform cpufreq or clk maintainer to pick
>> them up.
> 
> Rafael,
> 
> the three CPU frequency patches in this series were acked by Viresh
> already, but unfortunately you don't seem to be Cc'ed on these. Are
> you okay with me picking these up into the Tegra tree and send you
> a pull request in a couple of days? That way we can get the whole
> set tested a bit in linux-next. If you'd prefer to pick these up in
> the PM tree, here are the corresponding patchwork links:
> 
> 	https://patchwork.kernel.org/patch/10747943/
> 	https://patchwork.kernel.org/patch/10747947/
> 	https://patchwork.kernel.org/patch/10747953/
> 
> I'll go and give my Acked-by on these patches if the latter is the
> way you prefer.
> 
> 
> Stephen, Mike,
> 
> the same applies for clk patches. Stephen's acked all of them and I
> think all of the series is good to go. How about if I pick up these
> up in the Tegra tree and let this all cook in linux-next for a week
> or so and then send you a pull request with these? Stephen already
> picked up a couple of fixes for clk/tegra, but I don't think any of
> those would conflict with this series.
> 
> All of that said, Joseph confirmed that there are no dependencies
> between these subsystem subseries, so if you'd prefer to pick up the
> patches into your respective trees, I have no objections to that.
> 
> Thierry
> 

Hi Rafael, Stephen,

Gental ping. Please let Thierry know if the cpufreq and DFLL clock 
related changes can go through Tegra tree.

I know Rafael did say [1] it's okay to go through Tegra tree in earlier 
comment.

Thanks,
Joseph

[1]: http://patchwork.ozlabs.org/patch/1015181/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
