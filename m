Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A402AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:52:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8BC2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fEUtTPPW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyLgN6UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8BC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h6pXCASFd8nMRBmi1J6Dpfpy4EpQOLrSHl7eRHxbTTk=; b=fEUtTPPWCbvs4J
	GM8OOmLFWONWCe2954gkTj9BQzbv6G4rGtMC+YUxRayuKP/FwC8iareDI8LgGNkjZKhvheoq4Hp9v
	2jOeCbSnE4yfpODx8h8onCtxrFxSgbRbs/VKU9Z6jy6aXKLvRGSIecGjmRFLMq9rv3Mfsq+CQGUE2
	Ev+VfvT1LIHOuqvsrEzNtEyXPpXSAQqlyE7qTsiDLJpKi948e98irngLNxIgO0TDHLXh4F2c4WSgT
	IlKPywAoeB9sWRRBREL6yCU8Vwv4fozroqzd2lQKr58lQvRPGzwbykpVv5EJ0sdyfOSKOoOczRjkX
	BYP6bMrSHJM0BHZOckEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi1uN-00076O-6V; Fri, 11 Jan 2019 18:51:55 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1uI-00075j-K8
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 18:51:53 +0000
Received: by mail-ed1-x544.google.com with SMTP id f9so13854236eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 10:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YP4uxDsiLRApWR0cklfLsBOWvl3cEdFyUCBLar8QYq8=;
 b=OyLgN6UFqu8yMHrnsyYAGhu6fjuz68ZBgyxqv2Irbu0yXEzWxNMi/6UsAvrSXmp+Qi
 QRZwPskepHOY7WU4UJSJhNWa3b1VlgSntMGEMBLr4hatdM//o3R8aO5PwqZV3OH5WCDC
 oA30AlYiFBN96b2OTGekJecT4zUMyhx4AQ10Zd0wpIDyTB9bcvN06dkzajY6tcBBjy8y
 99dVlpey5VfEHTc9hb97gBekGBU7PmgduzDmGx55RJK++1qd+JchmxQR1hteaKbT5uKO
 18+09/B9DKJT2RyfBiJKFJ7nCmMDVAKpj2049SmbHF6Ucl3ndJWYKpupg2gzVp71X+6O
 Tqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=YP4uxDsiLRApWR0cklfLsBOWvl3cEdFyUCBLar8QYq8=;
 b=f4cs7pxt8QD/2S1ZILgv3975nPJDL1BJf02xoWWOwe8wpua3BgdpUc+AnUZ8ta20CX
 8ptjwGtej4hVoulZ0846BqmhMi+5nk8HaTkSkXgJiK2o/r1aXSEVpORrqBvoFEe7rpt7
 f7FL0D/MamwvqH8fwCKwATwAkQrNsz1vGEj+gNkZC4gbV9VwX/AP1criu0z01q3xTx90
 oajZMNXeLISV58BUYQ+eXMblLjC1IQ9JMwIh09n3MkQJvgFQI+KlfbHR6OZE9UUXvRm+
 P4tv/INNAK0EVm/7pkOtopv7wqzgJZMGCnVwjpgpZZOrvkqVYjdATncXYyvTmdPdZMtX
 C7RA==
X-Gm-Message-State: AJcUukf8xPRejmNjsxHpKx62/p9sR9Cf2lQSw0obo4S+VzkER63Wy5a/
 rbI16sm+AY1cyWci0qC9Rh4iFqPa
X-Google-Smtp-Source: ALg8bN7D76vtY5n8HqmpB0KBha3FEaFcdwwjUqcztQO4OC57EjgJwggrPEQ3lcNQ6evDvC+wJV3smA==
X-Received: by 2002:a50:8eea:: with SMTP id x39mr13785312edx.177.1547232706731; 
 Fri, 11 Jan 2019 10:51:46 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id n10sm2455315edq.33.2019.01.11.10.51.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 10:51:45 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add document for Broadcom STB
 reset controller
To: Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
References: <20181221013409.14324-1-f.fainelli@gmail.com>
 <20181221013409.14324-2-f.fainelli@gmail.com> <20190103174117.GA6613@bogus>
 <2a54c2cf-5595-ade5-fb29-40e8b6d3133e@gmail.com>
 <20190103191915.GB6613@bogus>
 <bcfe4df0-8928-90e2-6460-1391320af9be@gmail.com>
 <CAL_JsqKpFYnnAY-feAeJ-Va5yS7JH34FOzvBmTi4gMV=kjbCVQ@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <6d2183a3-ec16-70a4-8cc8-ca7640dba387@gmail.com>
Date: Fri, 11 Jan 2019 10:51:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKpFYnnAY-feAeJ-Va5yS7JH34FOzvBmTi4gMV=kjbCVQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_105150_687674_D14DABC6 
X-CRM114-Status: GOOD (  26.84  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/3/19 2:54 PM, Rob Herring wrote:
> On Thu, Jan 3, 2019 at 1:31 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 1/3/19 11:19 AM, Rob Herring wrote:
>>> On Thu, Jan 03, 2019 at 10:53:25AM -0800, Florian Fainelli wrote:
>>>> On 1/3/19 9:41 AM, Rob Herring wrote:
>>>>> On Thu, Dec 20, 2018 at 05:34:08PM -0800, Florian Fainelli wrote:
>>>>>> Add a binding document for the Broadcom STB reset controller, also known
>>>>>> as SW_INIT-style reset controller.
>>>>>>
>>>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>>> ---
>>>>>>  .../devicetree/bindings/reset/brcm,reset.txt  | 27 +++++++++++++++++++
>>>>>>  1 file changed, 27 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,reset.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/reset/brcm,reset.txt b/Documentation/devicetree/bindings/reset/brcm,reset.txt
>>>>>> new file mode 100644
>>>>>> index 000000000000..6e5341b4f891
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/reset/brcm,reset.txt
>>>>>> @@ -0,0 +1,27 @@
>>>>>> +Broadcom STB SW_INIT-style reset controller
>>>>>> +===========================================
>>>>>> +
>>>>>> +Broadcom STB SoCs have a SW_INIT-style reset controller with separate
>>>>>> +SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
>>>>>> +reset lines.
>>>>>> +
>>>>>> +Please also refer to reset.txt in this directory for common reset
>>>>>> +controller binding usage.
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible: should be brcm,brcmstb-reset
>>>>>> +- reg: register base and length
>>>>>> +- #reset-cells: must be set to 1
>>>>>> +
>>>>>> +Example:
>>>>>> +
>>>>>> +  reset: reset-controller@8404318 {
>>>>>> +          compatible = "brcm,brcmstb-reset";
>>>>>> +          reg = <0x8404318 0x30>;
>>>>>
>>>>> Based on this address, should this be a sub-node of something else? Or
>>>>> not even a sub-node and just make the parent be a reset provider?
>>>>
>>>> The reset controller is part of a larger "sundry" node which has a
>>>> collection of functionality, from pinmux/pinctrl, reset controller,
>>>> spare bits, chicken bits, anything the designers forgot to put somewhere
>>>> else and decided to put there.
>>>>
>>>> If there is one thing consistent though is that given a set of 32-bit
>>>> register groups, they have a self contained functionality such that you
>>>> can break up the larger "sundry" space into smaller sub-blocks which
>>>> have one an only one functionality. Do you think this warrants a
>>>> different representation in Device Tree?
>>>
>>> With pinctrl in the mix, you're going to need sub-nodes anyways. So just
>>> define what this is a sub-node of.
>>
>> pinctrl is not necessarily something I want the kernel to control, since
>> we have a high level scripting language without our bootloader that
>> makes sure pinctrl is properly configured from early boot on all the way
>> to the kernel, and preserved across suspend/resume states.
>> pinctrl-single does work, and was occasionally used. Everything else is
>> typically muxes that the kernel does not need to touch/see/be aware of.
> 
> That's good. I'd rather see more platforms do that rather than have
> the kernel handle it. OTOH, bootloaders often use DT too, so maybe who
> handles pin muxing is irrelevant.
> 
>>> Also, I'd prefer to have complete example for the "sundry" node and
>>> child nodes than partial examples spread across the tree.
>>
>> I am afraid I can't provide that example because the sundry node is
>> really changing from chip to chip, and there is a gazillion of things in
>> there that the kernel typically does not even touch, like
>> pinmuxing/pinctrl, various mux selections etc. I could provide the
>> following example if that is what you are requesting?:
>>
>>
>> sun-top-ctrl: simple-bus@8404000 {
>>         compatible = "brcm,brcmstb-sun-top-ctrl", "simple-bus";
>>         reg = <0x8404000 0x708>;
>>
>>         reset: reset-controller@318 {
>>                 compatible = "brcm,brcmstb-reset";
>>                 reg = <0x318 0x30>;
>>                 #reset-cells = <1>;
>>         };
>> };
>>
>> Would that be what you expect to see?
> 
> The problem is with this alone, you should just move #reset-cells to
> the parent and remove the child node. That's all you really need from
> a DT perspective. But if this is really a separate block that's reused
> from chip to chip, then a separate node is fine. Typically in these
> situations, I just can't tell whether it's that or just the
> convenience of creating nodes for every kernel driver.

I found a couple of occurrences where the same HW block is used outside
of this sundry register block and also got confirmation from the
designers that the same block gets re-used from chip to chip, and
happens to get "wired" into the bus address decoding logic as part of
this sundry block for convenience and principle of least surprise.
-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
