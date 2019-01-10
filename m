Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AD8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:38:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5755214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="akbScedu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW5jSal0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5755214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Ej+1/fZsAeA9m6iqh/qXVNFX3kwKp3VQ53gYtMnT2I=; b=akbSceduqYu+z+
	M7Lazt3BK+Q/1wGscemh9XogcO8n2lgYQ2oWnlSLbwSUHTPyQSsIFJjoYmMtDyz2/8R7MUEbhCwBS
	0DgaoBgmqgAcoBzIIOW9xU1SuNFsrIQyGxVJe+1wTbqfxkPczGLOtqDiksPdpA/XqQaPQ9skuS7D/
	o5IOk2bYqwqecbhP1LvznOHRE+SVjgv3ZDbG3GRUypPEr05v2UoVb34vxVmXQIs9CIIWrb9rDfuZh
	jBHcdbzoGGwYAN7gQfwZNQeTP+kW2mmGgpzvctnz3cuTJjmSaD81grP9WY+4Ix+jqWM/GtNO5nZBh
	NyR81Y7GhvKiypiaQ8fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghbTV-0003v3-6k; Thu, 10 Jan 2019 14:38:25 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghbTH-0003kK-B3
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 14:38:12 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so11642494wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 06:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I9JX4lnp24pp2ECN0iq8tzDj0oFUsykbFZAVqf68+10=;
 b=JW5jSal0EP3ZSQELqs5XX+lnsaCEf7CUQNrV/FDUrRgo3ZuJogzQWtEpGLMiE5CW/q
 z0qt48n40R62b3ZQPsbXMGNBUYEexNeRTO/vN5IQRa4+gjt7oLRIBT3ulGc9FM/O43T7
 9b5uZC6bi+s2Q7OiNsVObQqMzMvOlvkyWJiIUJlUMb75WxnDs2X/Z/8dvPlPrDn8EIsu
 O1LCxNBi2KdUAIdaGf2USOxSq5hNPZQro4cRbEFTZctIMT4WoJWLy1eo0p991xSxO8QG
 srkHNu+lvMdRNN3tgc7vlXALG8Otjc0Sb4h/Oa03UG/x128igppMlaxSwVMsTw/cZfLr
 hDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I9JX4lnp24pp2ECN0iq8tzDj0oFUsykbFZAVqf68+10=;
 b=XrlEWqC1xPkO6DBeOre3dgzEh/s2Ev3qk745OoYfGp9YnxsotNnMbn44HheHu2w+O8
 o0K0xrPSv9CZ6Y4dITZhf1lqdt09pUXrf+LWYPA00cqY2hD0B+rGAz2NWOkstZhUSe2H
 uUksy8Fzvw0DUw2kMUkXnJPP+5vAFsX8XpageVlYXpyprfk9Aomj/Y0bcLSOIiLvsNwD
 WhnnZ8OgOAd5R2ZAQ1l+V/ZBkvkvWBwdjdznf3XmAPtsDUkyAb6QdncsAshlfQhqyYvH
 28rlq6h5ddX+BNG3jM5W1650WuGv3O+phRTICYutzeB99CJ9ckDgJqQmdihihS3UJoZz
 IryA==
X-Gm-Message-State: AJcUukecSTq3/XaDXO/0egVltYuxQ2Aku2qv/rer5TAkQZrRbXKVsJrR
 0+bDq7o3XoS/SJBcX7hJsTH0qyau
X-Google-Smtp-Source: ALg8bN4Naanc64TZzoKrRPjDJXSu4t3ohP6+XcAv+fY5z+WTZ3VvrFnaKWgIvTDoWm9PThekZHDjIg==
X-Received: by 2002:a5d:63c3:: with SMTP id c3mr9377928wrw.215.1547131089609; 
 Thu, 10 Jan 2019 06:38:09 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz.
 [86.49.110.70])
 by smtp.gmail.com with ESMTPSA id l19sm17084065wme.21.2019.01.10.06.38.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 06:38:08 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Fix backlight
 regulator numbering
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simon Horman <horms@verge.net.au>
References: <20190109140045.17449-1-marek.vasut@gmail.com>
 <CAMuHMdX3bP_WCYNRRMmVRPwV52e72NOZMtW8cf29Fo+E9_CvcQ@mail.gmail.com>
 <20190109165822.tmj7qbho46f7clvg@verge.net.au> <1690279.yngTTxF0vm@avalon>
From: Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <0d08d3c1-94ec-dcbe-ad3d-b079ab2ad17e@gmail.com>
Date: Thu, 10 Jan 2019 14:40:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1690279.yngTTxF0vm@avalon>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_063811_376297_DB117A99 
X-CRM114-Status: GOOD (  17.16  )
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
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/10/19 1:59 PM, Laurent Pinchart wrote:
> On Wednesday, 9 January 2019 18:58:23 EET Simon Horman wrote:
>> On Wed, Jan 09, 2019 at 04:26:25PM +0100, Geert Uytterhoeven wrote:
>>> On Wed, Jan 9, 2019 at 3:01 PM <marek.vasut@gmail.com> wrote:
>>>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>
>>>> There are two regulator1 nodes in the Ebisu DTS right now, one 3.3V for
>>>> the eMMC and one 12V for the backlight. This causes one to be
>>>> overwritten
>>>> by the other, ultimatelly resulting in inoperable eMMC, which depends on
>>>> the former. Fix this by renumbering the backlight regulator to
>>>> regulator2.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>> Reported-by: Simon Horman <horms+renesas@verge.net.au>
>>>> Fixes: 9d16c4a10e07 ("arm64: dts: renesas: r8a77990: ebisu: Add
>>>> backlight")
>>>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>
>>>> --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
>>>> +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
>>>> @@ -191,7 +191,7 @@
>>>>
>>>>                 clock-frequency = <24576000>;
>>>>         
>>>>         };
>>>>
>>>> -       reg_12p0v: regulator1 {
>>>> +       reg_12p0v: regulator2 {
>>>>
>>>>                 compatible = "regulator-fixed";
>>>>                 regulator-name = "D12.0V";
>>>>                 regulator-min-microvolt = <12000000>;
>>>
>>> Perhaps the node name should get a more descriptive suffix
>>> (e.g. "regulator-12p0v"), like is already done for some of the other
>>> regulators?
>>
>> I think I would prefer that addressed in a follow-up patch.
> 
> Agreed, but it would still be a very good idea. I think we need to standardize 
> names for regulators, otherwise this is bound to happen again in the future.

Isn't the YAML DT schema validator supposed to catch those problems ?
I'd even expect DTC to be able to catch such duplicate nodes and warn
about them.

-- 
Best regards,
Marek Vasut

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
