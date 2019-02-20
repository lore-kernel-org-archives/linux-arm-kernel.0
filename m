Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BEAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:28:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387D8206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bqNLzMMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387D8206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tLREIoCjRo6XRzS3AdcFFp4/ayv/OA1n+sompEb3Cdc=; b=bqNLzMMxFE8/U/QTZ2c4LtFU4
	314EJwe7GydhV0EHlD4il2qdoynWx1ZvzSUGc4PQU6rfVmmO6vGEVOuTZJBh98cll4KVQu8BjIC6S
	Mzvf99G0oxV3UU72I/wXj9fpTVCiJpj/1NqKLEOd90SzLQ00v/LsAJYKJsh9/pkEVORTO+pQyhM+2
	jBuFrpiXxPufjuSx+Gw+EFTJmMNV2jdJCOAs9QBvWli9U60OIu4lyfc3o2mYtJoTj9zI1QLpEOy46
	VgzwN+/0DBaRIZj5ogvu3R9EvDb9SYe42VZY7QbzQirONdkFQFkEEfAsDOPF8WMuT2cse1zj6sKKv
	iIziIzE8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQ3X-0007y1-1b; Wed, 20 Feb 2019 11:28:51 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQ2K-0006dH-LV
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:27:40 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 20 Feb 2019 20:27:34 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 3722D180097;
 Wed, 20 Feb 2019 20:27:34 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Wed, 20 Feb 2019 20:27:34 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by kinkan.css.socionext.com (Postfix) with ESMTP id 093ED1A04E0;
 Wed, 20 Feb 2019 20:27:34 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id E7492120459;
 Wed, 20 Feb 2019 20:27:33 +0900 (JST)
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To: Arnd Bergmann <arnd@arndb.de>
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com>
Date: Wed, 20 Feb 2019 20:27:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_032737_028686_E20DC130 
X-CRM114-Status: GOOD (  25.62  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi

On 2019/02/20 18:28, Arnd Bergmann wrote:
> On Wed, Feb 20, 2019 at 8:44 AM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
> 
>> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
>> new file mode 100644
>> index 0000000..a263211
>> --- /dev/null
>> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
>> @@ -0,0 +1,175 @@
> 
> I no longer see anything here that should be turned off, but you
> might want to run 'make savedefconfig' and use the output of that,
> to make it easier to keep it up to date.
> 

I got it, I use the output of 'make savedefconfig'.
One question, is that OK to add some options on it?
  -Because "CONFIG_ARCH_MILBEAUT" was not listed.


>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 5bee34a..6753805 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -54,6 +54,8 @@ CONFIG_SOC_VF610=y
>>   CONFIG_ARCH_KEYSTONE=y
>>   CONFIG_ARCH_MEDIATEK=y
>>   CONFIG_ARCH_MESON=y
>> +CONFIG_ARCH_MILBEAUT=y
>> +CONFIG_ARCH_MILBEAUT_M10V=y
>>   CONFIG_ARCH_MVEBU=y
>>   CONFIG_MACH_ARMADA_370=y
>>   CONFIG_MACH_ARMADA_375=y
> 
> I'm surprised that you don't need to enable any drivers. Does this actually
> boot on your hardware?
> 

Yes, but not exactly.
The series has not serial driver, so I add the driver temporarily and 
confirm the boot log through earlycon.
The timer driver is selected by "CONFIG_ARCH_MILBEAUT_M10V", no need to 
add the the"CONFIG_MILBEAUT_TIMER".

Here one more question.
Is this OK to submit a core support patch without any serial drivers?

Thanks,
Sugaya Taichi

>        Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
