Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C75EC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:46:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2D820870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iI3Oo5FT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pan41BJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2D820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A3RVNDfj6NUG1uF3QjyPnLfNd0jBATPbNlnkZ53Z7bM=; b=iI3Oo5FTD8gsI3
	RzjhggDOtMKx9A23BiFuDtfCyK3gjeEbBjlqyQfPLfNWIOo6LTKFOMMK5GgB8spEf0GZYoxLgT7Vs
	n1B1R7lUrqyWPO0vy7pPOHgpPTAQSMDoYUQt9J6/WPmsfsut0pBvVn4jG5YGLfNRYITyTZlP1JNlw
	r0B0ga3chbcjULb85BmRK8uQTmReLp0ScHJwtXklB3qIQ5eyx52t4g6fG4J+4OLlJlirOARcbYQov
	os2qvOSGKFDU/vD2lv2fPhis12UKFXaZ5VePHHAJVagKDG6bgHtxxSZIHivOXPAu5uMIPpoWacQtC
	DMKpDfpcQM4wF8uJ9dNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQNp-000889-7H; Thu, 13 Dec 2018 12:46:29 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQNl-0007sG-Ug
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:46:27 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c1254940000>; Thu, 13 Dec 2018 04:46:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 04:46:15 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 04:46:15 -0800
Received: from [10.26.11.125] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 12:46:13 +0000
Subject: Re: [PATCH V2 09/21] clk: tegra: dfll: add protection for
 find_vdd_map APIs
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-10-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a56194ce-ce96-8b3a-99e8-b4348db39f42@nvidia.com>
Date: Thu, 13 Dec 2018 12:46:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213093438.29621-10-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544705172; bh=istd5PyqoqSD9GFMlhdGxaATejw3fr6zPuMcfyTuq3w=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=pan41BJrn7tPR5gaT9tGKTrCOFU7ZFkuTEBVMrL3x2sbpVkAKWP/yj0+np5r9FAGa
 GR2yDlwLoJGUIDrQId5jQLG6A5dDgJ+WdNKDBkwb/r1BJ/lsCPj7LM5PQZ0oEMgOQT
 iTklFugnbIDhC2Q5wqr8J5cQke7FIwGZyrX/uEbNaxvOuZfUvhv4oE40OJgZP15by7
 0iCMq2zOsAQNnI7lNPsibbyeJ1pCNSLqGW1LQj2/w4jd+rG1aZPp6/alQgRqrs+vcK
 nKR7g/6gOJ0eQNLkcGsZ7kjOiFukTdmQBpVBC6Ro2M+rQ98GZLAbVA5BeiI4rwETNm
 vgaPMKKmE6GVA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_044626_001009_2901D7EC 
X-CRM114-Status: GOOD (  10.36  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 13/12/2018 09:34, Joseph Lo wrote:
> The DFLL hardware supports both I2C and PWM based regulator. SW driver
> only touches I2C regulator when generating LUT. And shouldn't touch it
> anymore once the DFLL is enabled.

I am not sure that the last two sentences are above are relevant and
confused me a little at first. I would be tempted to drop them.

> This patch adds the protection for the APIs that only work with I2C mode
> to avoid they could be called accidentally.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>

Furthermore, I would be tempted to squash this into patch #7. I am not
sure another patch is warranted here.

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
