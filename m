Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE99BC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:31:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9EB20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="omAl4Of9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9EB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6hzH1DuKFHylQ5jz04goW3/fZopoKmAFotud7eDHTm0=; b=omAl4Of9Mc736PT0l2TrQlROH
	01DjQRLI7LV9IjHtnnZuk6ProDnlB5c7azhuO++sReBaRDn9sEI3Z/XyyL1txJ5Y2GEChqE41OYl7
	ju6LB7/bRi4HOH7t9NV578Ex1xrFLowyQkEmOrLzrxpghnHahG3YRhcXlYxfNKssa+isID+uo7oc3
	nL7jzjpMrVVehxJH0kHyWn63UxkqMkU6DjI3+6p9OHG6n2E1XWB+GRO4of9pGcB9LXd4DaSEUAObM
	5CW8kePlNc5ql9J1ijAQcsFjXw2aDxu3MdwDlgfjguSSS4I9UYTgXNpLb2mKxrRCdQ58NyilAjm4D
	d7IbCdFKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXR4w-0005Ku-Ep; Thu, 13 Dec 2018 13:31:02 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXR4t-0005Jz-BU; Thu, 13 Dec 2018 13:31:00 +0000
Received: from [10.28.18.96] (10.28.18.96) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Dec
 2018 21:31:13 +0800
Subject: Re: [PATCH v2 2/3] spi: meson-axg: enhance output enable feature
To: Jerome Brunet <jbrunet@baylibre.com>, Mark Brown <broonie@kernel.org>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
 <af721e7a752ca468046de0a4ad1ac4a0c220360c.camel@baylibre.com>
From: Sunny Luo <sunny.luo@amlogic.com>
Message-ID: <bc4b5951-7760-f927-653f-2c7afac1df46@amlogic.com>
Date: Thu, 13 Dec 2018 21:31:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <af721e7a752ca468046de0a4ad1ac4a0c220360c.camel@baylibre.com>
Content-Language: en-GB
X-Originating-IP: [10.28.18.96]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_053059_394152_E026E0C0 
X-CRM114-Status: UNSURE (   8.40  )
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
Cc: Jianxin Pan <jianxin.pan@amlogic.com>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Xingyu Chen <xingyu.chen@amlogic.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jerome,

On 2018/12/13 17:04, Jerome Brunet wrote:
> On Thu, 2018-12-13 at 16:39 +0800, Sunny Luo wrote:
>> The SPICC controller in Meson-AXG is capable of driving the CLK/MOSI/SS
>> signal lines through the idle state (between two transmission operation),
>> which avoid the signals floating in unexpected state.
>>

>> @@ -453,6 +474,8 @@ static int meson_spicc_prepare_message(struct spi_master
>> *master,
>>   
>>   	writel_bits_relaxed(BIT(24), BIT(24), spicc->base + SPICC_TESTREG);
>>   
>> +	meson_spicc_oen_enable(spicc);
>> +
> 
> Any specific reason for doing this in prepare_message() ? It looks like
> something that could/should be done during the probe

Yes, as replied in Mark's mail, i will move it into probe next patch.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
