Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4448C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:43:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7189B20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HnkqtwWU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gvkDC5Ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7189B20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5EzwHFxVc2BP/lZh9KNPZBjHghjsqO/dDIAKEXI8eEw=; b=HnkqtwWUlYarrjgUYeVIu+XLQ
	33TSqwCJYBo/D8+fUJ/TUpykpCQ/m+p8OxnOs/sJfHX3V9+AEirwTqrLBnPp7OsO9cgG1ZftKUn7O
	QgDXitKlhsgdeToHhJhkU7YJy/ZEUDtHUcEtjyH28m1iovECm3T2ZjQIE/brrGcDLKa3HckMyIria
	A2oyKbdgcYwI85K48MUBg5e79UwVRQxcYqNADzFdkDVnBXMtxHBdHx/F98FGFpnPJF3GrJI488F/v
	AZXyfZ2XrATuLuAU2y5u83Nj7zLO3EBqaoN9p6osvfEAmoYIpt4EZ+yx2MxHAxNWL8E13mTnLOrzX
	s/Qt2rPaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXi7h-0006lw-FB; Fri, 14 Dec 2018 07:43:01 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXi7f-0006lU-3B
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 07:43:00 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c135ef50000>; Thu, 13 Dec 2018 23:42:45 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 23:42:48 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 23:42:48 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 07:42:47 +0000
Subject: Re: [PATCH V2 09/21] clk: tegra: dfll: add protection for
 find_vdd_map APIs
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-10-josephl@nvidia.com>
 <a56194ce-ce96-8b3a-99e8-b4348db39f42@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <acaf37e4-e581-597f-fdcf-5f627e396b88@nvidia.com>
Date: Fri, 14 Dec 2018 15:42:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a56194ce-ce96-8b3a-99e8-b4348db39f42@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544773365; bh=OrQUM3be3WcahHbDG/ZNOWjAsJ+aRcov11+lbOsMCCg=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=gvkDC5Ax/CYc1QS61wB17ySRavM49apV8AfQ2gj3TFOrz6B/+9VgeB0huTOFwawLM
 CwmkfdJL2X8c2F+AlrkTj6wCPOyXdG1F4LaWjDMFgqbjw7hXaoUED/pIQERcpa5ZTn
 2bdERgPsQKQNPFoMEIJbDxY+uHCTw5ZPxbaz3RuSDYwf4etppORDck6a68+5k0327/
 6Yqqd/ENVaYf7s75TKK156Pd158Oy7WdKtXI8cSSNKkdzNF4cbL8KCbQiYq6i2Hsk3
 /o2qmwOpqyW6HOdPkb4Vas1g2ilFg5D3HHxQYuJi+9gMheKFTVk7Y/LYYv0hXPNxxN
 EIKdHTmGD8Wyg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_234259_142061_48A6B36B 
X-CRM114-Status: GOOD (  16.56  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/13/18 8:46 PM, Jon Hunter wrote:
> 
> On 13/12/2018 09:34, Joseph Lo wrote:
>> The DFLL hardware supports both I2C and PWM based regulator. SW driver
>> only touches I2C regulator when generating LUT. And shouldn't touch it
>> anymore once the DFLL is enabled.
> 
> I am not sure that the last two sentences are above are relevant and
> confused me a little at first. I would be tempted to drop them.

Indeed, they are irrelevant. Just want to describe that once we created 
LUT table, it means we cached the regulator output table in driver. Then 
we don't need to query voltage data from regulator again. This is 
specific to the I2C mode only and happens in driver initialization time. 
Which means the two APIs we add the WARN here maybe not really 
necessary. Because this is suggested by Peter.

Hi Peter,

Just want to double confirm again, do we really need to add a WARN here? 
Since we don't and shouldn't access these two APIs once the driver is 
working, all the voltage query should be via LUT. So I think add WARN 
here is not really necessary.

Thanks,
Joseph

> 
>> This patch adds the protection for the APIs that only work with I2C mode
>> to avoid they could be called accidentally.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> 
> Furthermore, I would be tempted to squash this into patch #7. I am not
> sure another patch is warranted here.
> 
> Cheers
> Jon
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
