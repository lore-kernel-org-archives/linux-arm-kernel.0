Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60EAC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:51:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60D220657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tXJpG9/p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WumqRMnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60D220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yZVaQyDq2afHusDt3IFqWk6kkSqvjCA6lp5i4wrzCCw=; b=tXJpG9/ptz8+Ah
	jdOtFL+N8Bb9djVpx4wSnrGao32D9a5vfcmOZIRA90cCStYmosKOUuMdXEEqlwZUXtqsTEswonOvx
	G5Yvdhollx6/IpnNU3Y+HFXKjhEk9ocDgGD8n176dX1PLjeRxOL66R60VARrzVFWjhW8mZf2mGbr1
	mIltEEAu6Zu6SrchSK0AjwZdR145ki/MlBdIM8v+5mEPYj9lA7vlqljn9w+XV51+QoOVsTpUq9i5X
	Rx8PacLM7K2CY/4HRv0RAygjUWNlAAnDtYxr3nZnwBD2VaEuRSvji02pvGmxYLT1eIb1JdjtbS1cv
	bT6etVcZAd4m/fUL1H+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjjiv-0004eV-Nw; Wed, 16 Jan 2019 11:51:09 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjjis-0004e6-36
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 11:51:08 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GBovwx062270;
 Wed, 16 Jan 2019 05:50:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547639457;
 bh=tYxDA4HmGnz/KpCENLcL9weSRRCin0yaGYKicFcaemM=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=WumqRMnPHIpAzO6PmLh+ftDQIdJlfWdlu15xDscX69kHRZ3SNQ2gYeYhFII6FQY/I
 sCY54YR3opZXjz+itkOFLN8OHi+i6SOHskWaJ4hb+LMdGrzTcEyQsyS//hrSr7KGqr
 jAoJti9dx966BcjACI8xtN+ykDD6QQcLJqGwxOjo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GBov0D093970
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 05:50:57 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 05:50:56 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 05:50:56 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GBoqdT000338;
 Wed, 16 Jan 2019 05:50:53 -0600
Subject: Re: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
References: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
 <20181228160546.GC25288@hector.attlocal.net>
 <839a30f7-b3fa-739a-52b4-5438e8573dc3@free.fr>
 <01b81f00-dc33-cc33-53e6-c937548aa7ab@ti.com>
 <94402bb7-2bc3-96fc-f37e-c0e57698cdc7@free.fr>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <482c70fc-859f-47c0-ec7e-d8e200294f1d@ti.com>
Date: Wed, 16 Jan 2019 17:20:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <94402bb7-2bc3-96fc-f37e-c0e57698cdc7@free.fr>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_035106_639178_3F54A1F1 
X-CRM114-Status: GOOD (  16.10  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, MSM <linux-arm-msm@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, Matt Wagantall <mattw@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>,
 Mitchel Humpherys <mitchelh@codeaurora.org>,
 Yaniv Gardi <ygardi@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 16/01/19 4:00 PM, Marc Gonzalez wrote:
> On 16/01/2019 10:24, Kishon Vijay Abraham I wrote:
> 
>> On 16/01/19 2:40 PM, Marc Gonzalez wrote:
>>
>>> Would this patch go through your tree or Kishon's tree?
>>
>> I've merged this in phy -next.
> 
> Thanks Kishon.
> 
> Do you mean here?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/log/?h=next

yes.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
