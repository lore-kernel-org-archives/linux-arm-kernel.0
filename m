Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0E0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:20:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A7C20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T7Qx1nRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A7C20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ipMqNxgJLEaSMoroEhv2po/gEhYIP5JKXIHcGjS2uLc=; b=T7Qx1nRFNIEyE0
	eVvMVlescOl8OsV6keIbiWP2FUX/oYB4H9XF9d7OcyTHWgD3LiXRxWo5Qq34CLRD5dILi9M1VtQmv
	rq60mKzhAWmZ+2NOyUywIWGNHY8waFeIiS40oPDFKtTNQbq9gUhVyIBBRe98L/Dbn4gxWYPsNdhPy
	TmGhWem5Rl+1KgjhhCZx7LBkEZX2eswlCJWQRMHscWgKTFh0sWEIhnmA7TVRxq7Cl42he6AT2wAYH
	RTritBwBLTgtk5ITQ3j25uzH7kjX9TJAX0O5Gifq7wpT7Pc0ixnEXhXdriCLAO1uSHEPL3sBn/Fwr
	z5Ga6OywUEHSqzIkMkbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghAyL-0003ct-PU; Wed, 09 Jan 2019 10:20:29 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghAyI-0003bm-4f
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:20:27 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 80CD6139428BCF27773E;
 Wed,  9 Jan 2019 18:20:12 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 9 Jan 2019
 18:20:05 +0800
Subject: Re: [PATCH v2 0/4] add support for MBIGEN generating message based
 SPIs
To: Yang Yingliang <yangyingliang@huawei.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <08646b86-8228-4920-00cb-6c3f44c4484b@huawei.com>
Date: Wed, 9 Jan 2019 18:18:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_022026_354899_3244037B 
X-CRM114-Status: UNSURE (   9.43  )
X-CRM114-Notice: Please train this message.
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
Cc: marc.zyngier@arm.com, tglx@linutronix.de, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

Sorry for ping you...

On 2018/10/26 15:51, Yang Yingliang wrote:
> Now MBIGENs have pins that used to generate SPIs,
> with
> 5052875 ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller"),
> we can support MBIGEN to generate message based SPIs by writing
> GICD_SETSPIR. This patchset add support for MBIGEN generating
> message based SPIs and a bugfix for MBI driver.

What's you suggestion for this patch set? We would like your input
for next steps.

> 
> 
> Patch #1 is a bugfix for MBI driver.

At least this patch can be merged first as it's an obvious bug,
without this patch, the MBI dirver can't work I think because
the mutex lock is not initialized.

Thanks
Hanjun


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
