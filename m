Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B60EC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:43:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6C92082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rEDGjKfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6C92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Plqe3V2ZPbuQTWGRWp6a8k8pdFpLn10DHAuQ5SpwTk=; b=rEDGjKflt/ENs7
	hFclgyMkRERiLQ0uLw9lFgdlAgO6M9ULeKVvPgMtZmT91LH3W8pwvjQv4lGKyRWUE+gxvT/QvhGSn
	SjrrickO7IOOW5ZIv+tNFeK+O1ZaIFeUsKOG6MbloyRztLosucVcgthdiyVR2/v8n5yFfwH0a3EeQ
	AhRBkliJP/yVNm/isOC5Mh660zzbYVsompvYjBQXKPpOjTxrh/f+7pNl6SOx8F6rZPTBk9oPDlYWA
	uYrk2DNMnUgCm1iQH+cWXh16wQmuKhglwFgLwQgeLEkJ+iSHK0XNFeFMf+0kLTX+vkag4K8YhIAit
	hVAJCJMS0Ih1lP96MB2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOSz-0001ZU-7C; Thu, 29 Nov 2018 15:43:01 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOSu-0001Ya-5l; Thu, 29 Nov 2018 15:42:59 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3C275AF74A7ED;
 Thu, 29 Nov 2018 23:42:40 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:42:40 +0800
Subject: Re: [PATCH v3 0/7] Standardize onboard LED support for 96Boards
To: Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <CACRpkdYThcGjdV9Ezs4qMr8K6_jH40SDUgt0Tps8d+_4sSESyg@mail.gmail.com>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C0008E5.5080401@hisilicon.com>
Date: Thu, 29 Nov 2018 15:42:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYThcGjdV9Ezs4qMr8K6_jH40SDUgt0Tps8d+_4sSESyg@mail.gmail.com>
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_074256_394432_CBCE3AFF 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: Rob Herring <robh@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>,
 =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org,
 "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
 Michal Simek <michal.simek@xilinx.com>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open
 list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Koen Kooi <koen.kooi@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>,
 Andy Gross <andy.gross@linaro.org>, ezequiel@collabora.com,
 linux-leds@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Manivannan,

On 2018/10/31 13:38, Linus Walleij wrote:
> On Mon, Oct 29, 2018 at 10:43 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> 
>> This patchset standardizes the onboard LEDs on 96Boards by maintaining
>> common labels and triggers as below:
>>
>> green:user1  default-trigger: heartbeat
>> green:user2  default-trigger: mmc0/disk-activity (onboard-storage)
>> green:user3  default-trigger: mmc1 (SD card)
>> green:user4  default-trigger: none, panic-indicator
>> yellow:wlan  default-trigger: phy0tx
>> blue:bt      default-trigger: hci0-power
>>
>> This standardization is required to provide a common behaviour of LEDs
>> across all mainline supported 96Boards and also making it easier to
>> control it using an userspace library like MRAA.
>>
>> For Rock960 and Ficus boards, the LED support is added in this patchset.
>> Rest of the boards are converted to adopt the standard.
>>
>> Note: Since there is no UFS trigger available for now, user2 LED trigger
>> is set to none on HiKey960.
> 
> This series:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> It makes a lot of sense to try to unify the userspace ABI so we get
> some kind of order here instead of trying to counteract it with
> per-device kludges in userspace. It definately makes things better!
> 
> Yours,
> Linus Walleij
> 
> .
> 

Applied hisilicon part(patch 3,4 and 5) to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
