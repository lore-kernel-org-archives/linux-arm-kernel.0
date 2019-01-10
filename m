Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC91C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:05:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0BB20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zz7GTF2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0BB20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3OUYN84ZE1miitl39uhTNhJC+v0FVQhkcEXlHSBtUQY=; b=Zz7GTF2okzo+2ncq+gJWVw75iX
	ChoOzh1tpRzsdi4p6BpGrJUWWk7gVrzeJnR6dla+2mMusUEb7RBs1OofDYQLQvCX4HCXuDhN7CveF
	pzo8quq4TMyXkDecV+gSxLlSiEX9/3SRuycGsbJZvtnrvg+kC7Q5MQI5dkmhoHp2cl7DKtE4gjjp8
	tVoJIKE34XuF6lozf/KDVscLyG/lDHHalfnIvj/wMCszZeQOE31f5d7uWLS5j53m78f1ZF7z8yLcJ
	4ACUexkuAx2fLzu9z67kFtiaDYYmj0juOe9vTNulf3jiy7pe/fetUJvI2aS2F36goSowdwcO71t5n
	sablhjNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gha21-0003cu-9q; Thu, 10 Jan 2019 13:05:57 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gha1w-0003cB-Jk
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 13:05:55 +0000
Received: from tarshish (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id 45E16440205;
 Thu, 10 Jan 2019 15:05:50 +0200 (IST)
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch>
User-agent: mu4e 1.0; emacs 26.1
From: Baruch Siach <baruch@tkos.co.il>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
In-reply-to: <20190110125548.GA29612@lunn.ch>
Date: Thu, 10 Jan 2019 15:05:49 +0200
Message-ID: <8736q0irwy.fsf@tarshish>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_050552_895025_F45F3031 
X-CRM114-Status: GOOD (  11.65  )
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
 linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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

On Thu, Jan 10 2019, Andrew Lunn wrote:
> On Thu, Jan 10, 2019 at 02:26:22PM +0200, Baruch Siach wrote:
>> Commit 3d71746c42 ("PCI: armada8k: Add support for gpio controlled reset
>> signal") added reset signal support. Reset is unconditionally asserted
>> and deasserted.
>>
>> Unfortunately, that commit breaks boot on Macchiatobin when a Mellanox
>> NIC is in the PCIe slot.
>>
>> It turns out that you can toggle the reset signal only once. Another
>> reset signal toggle makes access to PCI configuration registers stall
>> indefinitely. U-Boot toggles the Macchiatobin PCIe reset line already at
>> boot.
>
> Hi Baruch
>
> Is this double reset issue limited to just Mellanox NICs, or any
> device in the PCIe slot?
>
> This sounds more like a workaround than a fix. It would be good to
> investigate further and determine which end of the PCIe link has the
> problem.

Sven Auhagen reported the same issue with Intel NIC attached to
mini-PCIe slots on a custom Armada 8K design.

How would you suggest to investigate this issue?

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
