Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3BFC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:29:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36632146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gpmPqZRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36632146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XZjkmoy8DvjERX8V0ECQlXAHhr5pgOlnIRBx8O9xKAw=; b=gpmPqZRAYDtCNJ
	mnIJkSTEbmFB7XV1frrOhqCPVOOKXt5ov5lRMyPzVRkk+UiR79HenfM97YGIs1BJNUTHmUjdgq4su
	wE/RukvMNZDupPPv+SUUlcvkP/6L2kzt5dn83CwsxTjVPVCi9T41s+8A6yuFLYKk+6SqxIkzRGOvw
	64X0Ex4wkjPPNdesHUtPdazJWlCRz2qP1U2ztn2XHwBQ3nzZ3QPdWvQiCRhDV0vrMTJGj3XpH2MMd
	JRIoogEzap+e2uzCBtNFXcIWU/E3qmoYDgn8veRS1lkJoOTZH3SbkpNjkXcQN+x2wTxgAA+IOTSEB
	M0h8GuEkIMy+6MBlgnKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOFz-0005FI-La; Thu, 29 Nov 2018 15:29:35 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOFv-0005Ea-Lv
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 15:29:33 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id A5F384191706F;
 Thu, 29 Nov 2018 23:29:17 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:29:18 +0800
Subject: Re: [PATCH 0/5] Add Pinctrl and GPIO support for HI3670 SoC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
 <CACRpkdbMSYt5aH9fwRijtO=VG1nLAnfxTsfxGza+_Z2iGj2+-A@mail.gmail.com>
 <20181112071708.GA6689@mani>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C0005C8.2020202@hisilicon.com>
Date: Thu, 29 Nov 2018 15:29:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20181112071708.GA6689@mani>
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_072931_892104_BFAE6EDA 
X-CRM114-Status: GOOD (  12.35  )
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
Cc: "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 linus.walleij@linaro.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amit
 Kucheria <amit.kucheria@linaro.org>, "open
 list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Manivannan,

On 2018/11/12 7:17, Manivannan Sadhasivam wrote:
> On Wed, Oct 31, 2018 at 10:43:00AM +0100, Linus Walleij wrote:
>> On Tue, Oct 23, 2018 at 9:07 PM Manivannan Sadhasivam
>> <manivannan.sadhasivam@linaro.org> wrote:
>>
>>> This patchset adds Pinctrl and GPIO support for HI3670 SoC from HiSilicon
>>> found in the HiKey970 developement board. Also, the remaining UARTs are
>>> enabled and GPIO line names are added based on the Schematics and the
>>> 96Boards Consumer Edition spec.
>>>
>>> Note: These patches are based on the below common clk patches pushed
>>> earlier:
>>>
>>> arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
>>> arm64: dts: hisilicon: Source SoC clock for UART6
>>
>> All looks good to me.
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> for the series.
>>
> 
> Hi Wei,
> 
> Any update on this patchset?

Sorry for the late reply!
Series applied to the hisilicon soc dt tree with minor changes
in the subject.
Thanks!

Best Regards,
Wei

> 
> Thanks,
> Mani
>  
>> Yours,
>> Linus Walleij
> 
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
