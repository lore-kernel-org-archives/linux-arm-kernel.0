Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C98C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:23:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A495E20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NLi2imJX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CySMebx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A495E20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T6yj01Da3dKH914hfoqOh9bZP0dM6/uPT54RRm5T2uo=; b=NLi2imJXCJAVj2Zq3ETv6SlDU
	YJiiLYq0OXgtAChBDHymhEWrtdA7GvGvf6y4A6ULa/8WYkjfSRtpxnoftDzbaiby0MVFykcR/3vgQ
	V4B/1nZeHCFk2xVLcKWge3YiRfocs3EdLd1yBm33LQghqyZ63LWAZtqBd/4YgsXK2LIQFf7Gq2qOR
	d1LOwV2GrRpS/Hi81rlWaPcyJyw91WFkxczNbK489eNUHSeYQNe4hg25t8FpJLTD9Cv5TC/yPL6M8
	BzoK5Mjpx7S4ZPNkFKr2o9GqEcRw4T7xYwadjs/24CqlUSx6+lTcr+sEvxhM5IHaBPk4E5nE4ukPa
	Uwpm6mn0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpOUc-0001GE-3f; Fri, 01 Feb 2019 02:23:46 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpOUZ-0001Fs-U1
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 02:23:45 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c53ad920000>; Thu, 31 Jan 2019 18:23:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 31 Jan 2019 18:23:43 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 31 Jan 2019 18:23:43 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 02:23:42 +0000
Subject: Re: [PATCH V4 3/7] soc/tegra: default select TEGRA_TIMER for Tegra210
To: Thierry Reding <thierry.reding@gmail.com>
References: <20190131092410.28222-1-josephl@nvidia.com>
 <20190131092410.28222-4-josephl@nvidia.com> <20190131112655.GC23438@ulmo>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <75c1b971-849f-de43-9ecd-c67c221ee062@nvidia.com>
Date: Fri, 1 Feb 2019 10:23:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131112655.GC23438@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548987794; bh=EGNVXd0AuckklOlOdRI7wNf5niMGkPks6TQM2LznlxA=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=CySMebx1E9qjHv+OGolIQj/F2ZLYnKDdq1MCA0hnIbTQUjOnBGYrcFo5bdsRLcG1C
 TSrzKfC6ONInxFLLkX7MHB/q2MeY7nEXR1239z/3LHdrBeuhzt3PSgaiuKmR9vFJSw
 U1xi68Tecz7RZauhJcbIThzsDKmJswJ6Bzl1ZS8Ohg/TRVGWSgB4vVkk+/A1WiU9j+
 Dp3K5Fo0uWPLK8sZ2v3TGnfrkGXNOANeVo2TW6VEzuijyDrbWW9VVN3IthHp5+57Cm
 J7D9ssM+9gJYGtqxggcGdXVipnIvmuFTCzR2jGAQz9yO+96O4Q7qnhs0Q7XEt9MhP6
 th1cegiLEMANA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_182343_971420_A939C6A2 
X-CRM114-Status: GOOD (  17.02  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/31/19 7:26 PM, Thierry Reding wrote:
> On Thu, Jan 31, 2019 at 05:24:06PM +0800, Joseph Lo wrote:
>> The tegra timer is necessary for Tegra210 to support CPU idle power-down
>> state. So select it by default.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>> v4:
>>   * new added in this version
>> ---
>>   drivers/soc/tegra/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
> 
> So this technically depends on patch 2/7, so it would make sense for
> Daniel or Thomas to pick this up along with 2/7, but you didn't Cc them,
> so they're not aware of this.
> 
> I think you need to either resend the series and Cc both Daniel and
> Thomas on all the patches in the series, or we have to make sure that
> this patch is not applied before patch 2/7, otherwise Kconfig will
> complain. If you decide to resend, this patch is:

Okay, will resend this series.

Thanks for your review,
Joseph

> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> Thierry
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
