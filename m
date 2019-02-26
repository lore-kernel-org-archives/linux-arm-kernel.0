Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AB1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:14:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB99221848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i1AlM040"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB99221848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IA6W6kK3eGH821XaDLr9e20vmADH7TzNkXseENdHD6I=; b=i1AlM040LEZ7PM
	fFBoyos2QCQG6PX2dEsaL0Ido3rO/uZ41LVfhfer5NkBINONpk5Q0XBfXyLrRdv9mClrb+7RDVwli
	a1pBrmu2kpMtFh4HxEBxWFdVbId41EJFQVK8Ve0z69dOioXOUO9G4wTvTDKCzUCdWrBUX6bJpk+Q3
	J+0vGD2YWDzomtAiff4DcTn2GNhPoedKnmcezYvB9yV1L6mywgct4cG8tI0gVzHlTEnz5eqi8u8l4
	FmKL3hpdLUukp1osX90Nyw0J2yvT8c3kQJS1JfMzejLJ62E8uJDgEh1cAGSEpFkwPmvJBuu10U/uA
	Q9+QrEiJE/qE12gNykhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygJ1-0004Eq-SC; Tue, 26 Feb 2019 17:14:11 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gygIy-0004EH-KC; Tue, 26 Feb 2019 17:14:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C573A80D;
 Tue, 26 Feb 2019 09:14:05 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 34B713F738; Tue, 26 Feb 2019 09:14:02 -0800 (PST)
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <CAKv+Gu9OOzOxx0rTAZqM8r4q_hRmOp3b=KP7fwgNeiu67FCApA@mail.gmail.com>
 <5310b73b-4821-6dff-b9c0-34c59fb7fd72@arm.com>
 <CAKv+Gu_=bQyVZqgUnJm9moCcaCcpDrag6NWGEpaR65=pMiTFJQ@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <0c433a70-27f6-76ad-c46c-6015de1ffaa4@arm.com>
Date: Tue, 26 Feb 2019 17:14:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_=bQyVZqgUnJm9moCcaCcpDrag6NWGEpaR65=pMiTFJQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_091408_675870_7FE2BDFE 
X-CRM114-Status: GOOD (  21.43  )
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
Cc: Ganapathi Bhat <gbhat@marvell.com>, Heiko Stuebner <heiko@sntech.de>,
 Devicetree List <devicetree@vger.kernel.org>,
 Xinming Hu <huxinming820@gmail.com>,
 "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
 "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amitkumar Karwar <amitkarwar@gmail.com>, linux-rockchip@lists.infradead.org,
 Nishant Sarmukadam <nishants@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 26/02/2019 16:21, Ard Biesheuvel wrote:
> On Mon, 25 Feb 2019 at 15:53, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>> Hi Ard,
>>
>> On 25/02/2019 12:45, Ard Biesheuvel wrote:
>>> On Sun, 24 Feb 2019 at 15:08, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>
>>>> For quite some time, I wondered why the PCI mwifiex device built in my
>>>> Chromebook was unable to use the good old legacy interrupts. But as MSIs
>>>> were working fine, I never really bothered investigating. I finally had a
>>>> look, and the result isn't very pretty.
>>>>
>>>> On this machine (rk3399-based kevin), the wake-up interrupt is described as
>>>> such:
>>>>
>>>> &pci_rootport {
>>>>         mvl_wifi: wifi@0,0 {
>>>>                 compatible = "pci1b4b,2b42";
>>>>                 reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
>>>>                        0x83010000 0x0 0x00100000 0x0 0x00100000>;
>>>>                 interrupt-parent = <&gpio0>;
>>>>                 interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
>>>>                 pinctrl-names = "default";
>>>>                 pinctrl-0 = <&wlan_host_wake_l>;
>>>>                 wakeup-source;
>>>>         };
>>>> };
>>>>
>>>> Note how the interrupt is part of the properties directly attached to the
>>>> PCI node. And yet, this interrupt has nothing to do with a PCI legacy
>>>> interrupt, as it is attached to the wake-up widget that bypasses the PCIe RC
>>>> altogether (Yay for the broken design!). This is in total violation of the
>>>> IEEE Std 1275-1994 spec[1], which clearly documents that such interrupt
>>>> specifiers describe the PCI device interrupts, and must obey the
>>>> INT-{A,B,C,D} mapping. Oops!
>>>>
>>>
>>> The mapping of legacy PCIe INTx interrupts onto wired system
>>> interrupts is a property of the PCIe host controller, not of a
>>> particular PCIe device. So I would argue that the code is broken here
>>> as well: it should never attempt to interpret 'interrupt' properties
>>> at the PCI device level as having any bearing on how legacy interrupts
>>> are routed.
>>
>> OpenFirmware says that this node contains the interrupt number of the
>> device (4.1.1. Open Firmware-defined Properties for Child Nodes). The
>> trick is that this property is generated *from* the device, and not set
>> in stone.
>>
>> DT, on the other hand, takes whatever is described there and uses it as
>> the gospel to configure the OS, no matter how the PCI device is actually
>> configured. If the two don't match (like in this case), things break.
>> This is the "DT describes the HW" mantra, for (sometimes) better or
>> (more generally) worse.
>>
>> What the DT code does is to interpret the whole interrupt specifier,
>> *including the interrupt-parent*. And that feels wrong. It should always
>> be in the context of the host controller. But on the other side, the DT
>> code is not in the business of validating the DT either...
>>
>> It outlines one thing: If you have to interpret per-device PCI
>> properties from DT, you're in for serious trouble. I should get some
>> better HW.
>>
> 
> Yeah, it obviously makes no sense at all for the interrupt parent of a
> PCI device to deviate from the host bridge's interrupt parent, and
> it's quite unfortunate that we can't simply ban it now that the cat is
> out of the bag already.
> 
> Arguably, the wake up widget is not part of the PCI device, but I have
> no opinion as to whether it is better modeling it as a sub device as
> you are proposing or as an entirely separate device referenced via a
> phandle.

It is not that clear. The widget seems to be an integral part of the
device, as it is the same basic IP that is used for SDIO and USB.

It looks like the good old pre-PCI-2.2 days, where you had to have a
separate cable between your network card and the base-board for the
wake-up interrupt to be delivered. Starting with PCI-2.2, the bus can
carry the signal just fine. With PCIe, it should just be an interrupt
TLP sent to the RC, but that's obviously not within the capabilities of
the HW.

Anyway, it'd be good if the Marvell people could chime in and let us
know how they'd prefer to handle this.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
