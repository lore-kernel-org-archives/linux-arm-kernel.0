Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471C0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:58:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC9E20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="imK+gyma";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OMBHAIB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC9E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FTQLXp1s86UxRcX9/h39bSZGSfmxu4y6oQOyOyAvbkk=; b=imK+gymaDA7T7T
	vdhLIu3laaZvDazpHePvKV/NM0btogNsFqWwNFXO7tZM2IFdmSDmqSAUg/Yt5Ia5WXiS4KEi8bbaI
	QBw7ofATAZ7wKFT7EQoNkYxmppnaBiJzqwb8s/tYO8BCG8VIuNVBoO1qdEg81gpjGPN7U6HOCgrAS
	gJ6Y+WpMoscPzZqAOk5csKwSMjP1EG7kUNAl+25MXRCICdg380eekiUFGUXHXvc1n9E/TWhLfYujU
	YQ/mwGX3stf77IupF8vVUaFsCX660hevWtVIBg1/eTvEJ2ax/dzDknfLxoJQU/tmfqon7CteRzQY8
	C6BxBPgojMpduYDT2azA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfA4T-0000Sk-9W; Thu, 03 Jan 2019 20:58:29 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfA4P-0000S5-Me
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 20:58:27 +0000
Received: by mail-pf1-x443.google.com with SMTP id 64so17208677pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 12:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xj1FOSiudFmalrR2wY+7f+uAqQy/CjMmPlp0FFA3l0M=;
 b=OMBHAIB6sKrg5Wh8YPS0s0BQxv9a0QXzMSOMibK/+V3kfALVC9ws1C9tCtjr7KaVqc
 s1OyS5LYa7dPewCZjYfJQFlUVA0end2U83Aw5w3qQ7ecLZd5qPq+X+hmMk9pn0wfOmVo
 Ej1rgeZFByXMhXylBs7C3GfXGbDb8hN0gI8UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xj1FOSiudFmalrR2wY+7f+uAqQy/CjMmPlp0FFA3l0M=;
 b=mLQBSReaBdu9rlxTVb4ca/z2JhCNDN8Ziki+UqTOvlPpfmyavisZR1KAh/XQ7YbzIc
 9gPosASGTsLa2cs0bdn/TVqSlVLQCbdmHxkWVoZg0bukFeQeHcbPBMQETyGN90Qzaf3i
 m9cO6aN5OthNNpr5soe0XtFz2edDgoPimab8udRii0riPrXblA24HibavPcT3k8jTUzi
 HRvY9fRAud2NcHOJhtkTjRzRaqPWKBll875WACcIXJ1ms/yhNtR+NZQBFOQ+4NrjQ6kG
 MD/HPT9rSU/65bWXWSsAlvDRUFURkLvyvRzFIWmOE56zMZ3pBDzyd/YGxmNBVQHvRoL3
 m5+g==
X-Gm-Message-State: AJcUukcVeS7CADfElNy91U+4m7XXcYfRK7f/ZvyOF1DVu0XQZRdwSMUW
 kZZndRF2k1yO/fMno9hWybeuGx0bs6ROwt7JnPs3bHK/j9drsQWdaO2BfJZt3pMG7LtzaQLTQIR
 LJbtCT0FnVxLTSFiMlJFNX8por5WsoSbjV626xMO84x+2KUvqbO9Dys+dCmIB8k3lpjmnjeZaLJ
 0IH2rWNpV+wLo=
X-Google-Smtp-Source: ALg8bN7Bdwai9QkfHzEJ+w6G963g9rSvoBDqxQkFmCytuBbKXHObFgrK3gp6sTnjTj/euhQVjL3Jzg==
X-Received: by 2002:a63:1e56:: with SMTP id p22mr18300531pgm.126.1546549103506; 
 Thu, 03 Jan 2019 12:58:23 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id g185sm77373916pfc.174.2019.01.03.12.58.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 12:58:22 -0800 (PST)
Subject: Re: [PATCH 1/6] PCI: iproc: Update iProc PCI binding for INTx support
To: Arnd Bergmann <arnd@arndb.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-2-git-send-email-ray.jui@broadcom.com>
 <CAL_Jsq+ac6dmHKS6m0h5N3bv=VseKVL8XLU5K7j1Rn=mgFNLsA@mail.gmail.com>
 <20180918134152.GA31440@e107981-ln.cambridge.arm.com>
 <CAK8P3a3cWHK=DNCFn+p_NjSyXhoLQw07EVedVf5-UFdz4V4OPA@mail.gmail.com>
 <20180925105027.GA29857@red-moon>
 <CAK8P3a2nn9+8NEz8MqD_oVS9O+pb8L9ookVVkukDJXtNNRYk7g@mail.gmail.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <cdeb8270-0583-4ff9-4d34-94e467d05595@broadcom.com>
Date: Thu, 3 Jan 2019 12:58:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2nn9+8NEz8MqD_oVS9O+pb8L9ookVVkukDJXtNNRYk7g@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_125825_754494_C9C30C55 
X-CRM114-Status: GOOD (  23.50  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 9/25/2018 3:55 AM, Arnd Bergmann wrote:
> On Tue, Sep 25, 2018 at 12:49 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>>
>> On Mon, Sep 24, 2018 at 10:53:13PM +0200, Arnd Bergmann wrote:
>>> On Tue, Sep 18, 2018 at 3:42 PM Lorenzo Pieralisi
>>> <lorenzo.pieralisi@arm.com> wrote:
>>>>
>>>> On Mon, Jun 04, 2018 at 09:17:49AM -0500, Rob Herring wrote:
>>>>> +Arnd
>>>>>
>>>>> On Tue, May 29, 2018 at 4:58 PM, Ray Jui <ray.jui@broadcom.com> wrote:
>>>>>> Update the iProc PCIe binding document for better modeling of the legacy
>>>>>> interrupt (INTx) support
>>>>>>
>>>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>>>> ---
>>>>>>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 31 +++++++++++++++++-----
>>>>>>  1 file changed, 24 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>>>> index b8e48b4..7ea24dc 100644
>>>>>> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>>>> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>>>> @@ -13,9 +13,6 @@ controller, used in Stingray
>>>>>>    PAXB-based root complex is used for external endpoint devices. PAXC-based
>>>>>>  root complex is connected to emulated endpoint devices internal to the ASIC
>>>>>>  - reg: base address and length of the PCIe controller I/O register space
>>>>>> -- #interrupt-cells: set to <1>
>>>>>> -- interrupt-map-mask and interrupt-map, standard PCI properties to define the
>>>>>> -  mapping of the PCIe interface to interrupt numbers
>>>>>>  - linux,pci-domain: PCI domain ID. Should be unique for each host controller
>>>>>>  - bus-range: PCI bus numbers covered
>>>>>>  - #address-cells: set to <3>
>>>>>> @@ -41,6 +38,16 @@ Required:
>>>>>>  - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
>>>>>>  address used by the iProc PCIe core (not the PCIe address)
>>>>>>
>>>>>> +Legacy interrupt (INTx) support (optional):
>>>>>> +
>>>>>> +Note INTx is for PAXB only.
>>>>>> +
>>>>>> +- interrupt-controller: claims itself as an interrupt controller for INTx
>>>>>> +- #interrupt-cells: set to <1>
>>>>>> +- interrupt-map-mask and interrupt-map, standard PCI properties to define
>>>>>> +the mapping of the PCIe interface to interrupt numbers
>>>>>> +- interrupts: interrupt line wired to the generic GIC for INTx support
>>>>>> +
>>>>>>  MSI support (optional):
>>>>>>
>>>>>>  For older platforms without MSI integrated in the GIC, iProc PCIe core provides
>>>>>> @@ -77,9 +84,14 @@ Example:
>>>>>>                 compatible = "brcm,iproc-pcie";
>>>>>>                 reg = <0x18012000 0x1000>;
>>>>>>
>>>>>> +               interrupt-controller;
>>>>>>                 #interrupt-cells = <1>;
>>>>>> -               interrupt-map-mask = <0 0 0 0>;
>>>>>> -               interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
>>>>>> +               interrupt-map-mask = <0 0 0 7>;
>>>>>> +               interrupt-map = <0 0 0 1 &pcie0 1>,
>>>>>
>>>>> Are you sure this works? The irq parsing code will ignore
>>>>> interrupt-map if interrupt-controller is found. In other words, you
>>>>> should have one or the other, but not both.
>>>>>
>>>>> Maybe it happens to work because "pcie0" is this node and your irq
>>>>> numbers are the same.
>>>>>
>>>>> Arnd, any thoughts on this?
>>>>
>>>> To start with, I think the destination IRQ number is wrong, what the
>>>> mappings actually do is mapping the PCI interrupt line (ie #INTA, #INTB,
>>>> #INTC, #INTD) to input {0,1,2,3} of the PCI host bridge (pseudo)
>>>> interrupt controller.
>>>>
>>>> I really want to clean this up since currently there are different
>>>> DT bindings defining this in different ways which resulted in
>>>> non-consistent kernel code.
>>>>
>>>> AFAICS, the Aardvark PCIe controller bindings define the mapping
>>>> as I expect:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/aardvark-pci.txt?h=v4.19-rc4
>>>>
>>>> but I would like to get Rob and Arnd viewpoint on this so that
>>>> we can close this topic once for all.
>>>
>>> It seems ambiguous at best, as Rob suggested it may only
>>> work by accident. Since there is only one upstream interrupt,
>>> could we simply list <GIC_SPI 100 IRQ_TYPE_NONE> as
>>> the destination for any IntX?
>>
>> I think that would not be correct from an HW description standpoint
>> since there is some logic in the host bridge that behaves as an
>> interrupt controller (eg registers to ack/mask IRQs).
>>
>> AFAICS the aardvark (it is an example) bindings below should be correct,
>> with an interrupt controller node within the PCI host bridge:
>>
>>         pcie0: pcie@d0070000 {
>>                 compatible = "marvell,armada-3700-pcie";
>>                 device_type = "pci";
>>                 reg = <0 0xd0070000 0 0x20000>;
>>                 #address-cells = <3>;
>>                 #size-cells = <2>;
>>                 bus-range = <0x00 0xff>;
>>                 interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>>                 #interrupt-cells = <1>;
>>                 msi-controller;
>>                 msi-parent = <&pcie0>;
>>                 ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
>>                           0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
>>                 interrupt-map-mask = <0 0 0 7>;
>>                 interrupt-map = <0 0 0 1 &pcie_intc 0>,
>>                                 <0 0 0 2 &pcie_intc 1>,
>>                                 <0 0 0 3 &pcie_intc 2>,
>>                                 <0 0 0 4 &pcie_intc 3>;
>>                 pcie_intc: interrupt-controller {
>>                         interrupt-controller;
>>                         #interrupt-cells = <1>;
>>                 };
>>         };
>>
>> Thoughts ?
> 
> Yes, I think that's better. We probably still need to move the
> interrupts, msi-controller, msi-parent and interrupt-parent
> properties into the child node.

Okay thanks for all the feedback. In my case, I think I just to need
create a dummy 'intc' subnode under the pcie node and declare it as a
(dummy) interrupt controller).

I'll make the change in my next revision.

> 
>         Arnd
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
