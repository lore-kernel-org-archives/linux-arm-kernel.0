Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C75C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:24:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A190E2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FM0JhEa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A190E2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xo31odfDKMU62wwT7euCNe+3iP1KZZNXrjS6GIOmt1M=; b=FM0JhEa8/V2Xdc2UExECI3rez
	DALxvwqqvQZHyVq86DDCUHOEnjQx4ctcDj81S/0/nD4Sg7blHtrB4OgTQ9E8Qruby/3ffyVzE0x2y
	llcA2MmgbjaKEKyrTTJ8qmwugEOUeNqMgrtNFCAQ3F7K4C/EbWqn9lYHAysjlYj/6pr7if1ZpOcOh
	eBjAtQPOEPJx3HNaSinqqnOOCZ3+eqXh1mt+UixH598J+SaZp4uHutqz9paUlu1wTG5+38dGeg5kz
	sxrQWDpfNau6OyIVA4HGl7KlaTS6Sgxb4OIiwQw+JQjSuwjqP5a9zgTyVPgdAuzWLBNeThHI7t9AL
	Ncw+iedqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkpu-00022h-Ut; Tue, 11 Dec 2018 16:24:42 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkpr-00022K-Gl
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:24:41 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 19B075A09819F;
 Wed, 12 Dec 2018 00:24:20 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 12 Dec 2018
 00:24:14 +0800
From: John Garry <john.garry@huawei.com>
Subject: Re: next/master boot: 175 boots: 18 failed, 143 passed with 10
 offline, 1 untried/unknown, 3 conflicts (next-20181211)
To: Mark Brown <broonie@kernel.org>, <catalin.marinas@arm.com>,
 <will.deacon@arm.com>, Wei Xu <xuwei5@hisilicon.com>
References: <5c0fb738.1c69fb81.f62ad.3f45@mx.google.com>
 <20181211152311.GK6686@sirena.org.uk>
Message-ID: <e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com>
Date: Tue, 11 Dec 2018 16:24:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181211152311.GK6686@sirena.org.uk>
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_082439_721455_DDFA1065 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/12/2018 15:23, Mark Brown wrote:
> On Tue, Dec 11, 2018 at 05:10:16AM -0800, kernelci.org bot wrote:
>
> Today's -next fails to boot on D05:
>
>>     defconfig:
>>         hip07-d05:
>>             lab-collabora: new failure (last pass: next-20181210)
>
> It takes an oops during IPMI initialization:
>
> 09:51:45.224591  [   87.646247] ipmi_si: Adding SMBIOS-specified bt state machine
> 09:51:45.242352  [   87.652129] ipmi_si: Trying SMBIOS-specified bt state machine at i/o address 0xe4, slave address 0x0, irq 0
> 09:51:45.242646  [   87.661875] Unable to handle kernel paging request at virtual address ffff7dfffee000e4
>
> ...
>
> 09:51:45.429194  [   87.845965] Call trace:
> 09:51:45.429426  [   87.848400]  logic_inb+0x80/0xb8
> 09:51:45.429640  [   87.851620]  port_inb+0x18/0x20 [ipmi_si]
> 09:51:45.443075  [   87.855620]  bt_detect+0x40/0x250 [ipmi_si]
> 09:51:45.443320  [   87.859793]  try_smi_init+0x1a8/0x868 [ipmi_si]
> 09:51:45.443539  [   87.864313]  init_ipmi_si+0x190/0x220 [ipmi_si]
>
> ...
>
> 09:51:45.479097  [   87.910207] udevd[2569]: worker [2589] terminated by signal 11 (Segmentation fault)
> 09:51:45.501664  [   87.917863] udevd[2569]: worker [2589] failed while handling '/devices/platform/dmi-ipmi-si.0'


Hi Mark,

I have seen this issue previously. It would be specific to D05. I think 
that there is an issue with the FW in this board, in that DMI reports 
IPMI support incorrectly.

Could we add a kernel command-line to avoid IPMI detection from DMI, 
ipmi_si.trydmi=0

Thanks,
John

>
> Full details here, including bisection information and full logs:
>
>    https://kernelci.org/boot/id/5c0f88d259b514823d4925c0/
>
> Unfortunately it looks like the bug has actually been around for a while
> but wasn't stopping us getting to a prompt:
>
>    https://storage.kernelci.org/next/master/next-20181210/arm64/defconfig/lab-collabora/boot-hip07-d05.html
>
> and it might still be some unrelated hang there.
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
