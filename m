Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A5AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 12:38:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA24206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 12:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E7iAZNCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA24206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=+RhZ6KTwBrcQgvgyjx17H4RwvfnUcqkba+UwStW++Rg=; b=E7iAZNCgxwYUEjd2LG2HKxFI1G
	WuWe2pAun8vVun0jHZvTZfo5PJji7sst+zTZKMRV7JjMxK0zBAPVJtkwLGfs7cv9Cs8/LHaKUcqdG
	B2oGmo17grSKTp8QBXDYdp08vvsekqtF0fYG+J/6h25GYaWxT1kB7INz4LC3vSE3n/bT9AVuKzK5O
	FKxAh8BhpWRc1RqBnnBOZfiyxR5YsTcQjmO4IMoukSXsXK7cYwGxdpACV4MtpNy+cyhsULUlrvsjH
	0umbdzTxvpuKz2zd0rl9ehUdIYzmv/3ukUUVNWQEUSF6lxaaRf3VbOwkEnKFaueQLgW/LWRWB+2Qv
	5zh4EC3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gif1n-0001YV-0N; Sun, 13 Jan 2019 12:38:11 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gif1f-0001Xy-9R
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 12:38:05 +0000
Received: from tarshish (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id 1469B4400E1;
 Sun, 13 Jan 2019 14:38:01 +0200 (IST)
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch> <8736q0irwy.fsf@tarshish>
 <20190110131912.GB29612@lunn.ch> <87zhs8h5ej.fsf@tarshish>
User-agent: mu4e 1.0; emacs 26.1
From: Baruch Siach <baruch@tkos.co.il>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
In-reply-to: <87zhs8h5ej.fsf@tarshish>
Date: Sun, 13 Jan 2019 14:38:00 +0200
Message-ID: <87pnt0vil3.fsf@tarshish>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_043803_576559_7F3FCCE2 
X-CRM114-Status: GOOD (  15.35  )
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
Cc: linux-pwm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-pci@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew,

On Thu, Jan 10 2019, Baruch Siach wrote:
> On Thu, Jan 10 2019, Andrew Lunn wrote:
>>> Sven Auhagen reported the same issue with Intel NIC attached to
>>> mini-PCIe slots on a custom Armada 8K design.
>>
>> O.K. so that suggests the issue is on the Armada side.
>>
>>> How would you suggest to investigate this issue?
>>
>> I presume reboot works O.K? So it is possible to toggle the reset
>> multiple times, but reboot must do something additional which makes it
>> work? Do you have sources for the bootloader?
>
> The bootloader is current U-Boot master as BL33 of Marvell provided ATF
> version 18.12, current latest.
>
>> Are there status bits in the comphy about the state of the link? Maybe
>> comphy needs to be kicked to reestablish the link?
>
> Maybe. The U-Boot comphy PCIe initialization routine
> comphy_pcie_power_up() is long and complex.
>
> The ATF code also carries PCIe comphy initialization with this text:
>
> https://github.com/MarvellEmbeddedProcessors/atf-marvell/blob/atf-v1.5-armada-18.12/drivers/marvell/comphy/phy-comphy-cp110.c#L1170
>
>         /* In Armada 8K DB boards, PCIe initialization can be executed
>          * only once (PCIe reset performed during chip power on and
>          * it cannot be executed via GPIO later).
>          * This means that power on can be executed only once, so let's
>          * mark if the caller is bootloader or Linux.
>          * If bootloader -> run power on.
>          * If Linux -> exit.
>          *
>          * TODO: In MacciatoBIN, PCIe reset is connected via GPIO,
>          * so after GPIO reset is added to Linux Kernel, it can be
>          * powered-on by Linux.
>          */
>         if (!called_from_uboot)
>                 return ret;

Another look at this comment made me realize that we need comphy
initialization support in the kernel for PCIe reset to work correctly.

The workaround that this patch proposes will not solve the problem for
v5.0, since the GPIO get_direction patch will only appear in v5.1.

So the only viable solution for v5.0 is to revert the gpio reset signal
patch (commit 3d71746c42).

Thanks for your review.

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
