Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD78C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:16:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C2E218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qmfR+P1w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKSJuxU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C2E218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e9BhN6sgAMOL1fKEGMzUNKcIEyT3XJnQX/Wz5zP99bw=; b=qmfR+P1wquO6wO
	dFLjG5REWHYtAvkbt1QEh/YOelGvk6nHVbPYKCoGQLJ49DascwNoLrMW9O/tVllsuTLX3tZGlXy+p
	k8urBgojMNY8OYW3YcRPuBa1M5iRvopyP0ExzQ4QNsDfqe5uJkRnK0QpOI+YPv8QwyXKxg0tPIt8V
	2sEMgizs3WcgBeBBxkcRNI88uICcokRFiDbhxhXKvt0vZg/6aoN2lvqJEelt+5oTvjgI5mYgdi8oD
	vQT2bFta3qt6YAxd474A20BDmMOW7EZz4kVJSYdRrVF7FKpiTp59f/W/mW2d0AWxKZTanz2QqxN7v
	fXOhA4tvaZzWSwcvyIlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn61I-0003rn-Ee; Fri, 25 Jan 2019 18:16:00 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn61E-0003r5-TW
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 18:15:58 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so11281272wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 10:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kOpQQPF+GTC1JNEf2ih6Ffc+WAOYfMu6X3eN5bqi0Cc=;
 b=IKSJuxU4yX4Lt6i5fEp7iyE2hXmrzLijUHKJ6+so09W2M6ilW4H4S5cMEEZx0d5iUU
 iSqOmmyjmmcBENUwS2iwABDhZkgyYfm/++FNO/WB9tnRpys0cKVbssBoQMSbMm770lq7
 Rq8YkL1D7zlKdedEJujpZ7x9bkHgIURfJubpZDE045sYUL7CoGJgtbhIjcyHvd9YvD3t
 1cuAlmEcPnnww2WL8vYM//4MBJw0+JyX8TaTHHk4ZlPOI6XqqNQYVEDSGHTrVaYPpcu3
 kdt4D2Zi6fkDtF7aEGGvK4x/3E7gURd6SYG1PBVadJBmoYCFbABUmgLKn9EISa6BV4mc
 yMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kOpQQPF+GTC1JNEf2ih6Ffc+WAOYfMu6X3eN5bqi0Cc=;
 b=CRRL24rRTnFPwqzLP2WuxMluMvNbUMShTRxLRz3xqKYj0UmCoO+ccGwiieFZDeHoQt
 xO3XihgbR9lwWIIp0KdOOdUgtw88EwdkCxLKQIeWDfe5D7tHPFepays0/zbi6RCsr6S/
 8Zn9Wa54JYWlrBkvprRUBf3yuq7D5Ft4mlmRvbO3Eeo1oNyfvvBZu/G3jGK1JF9VfdpA
 eTmJCw7M54lVFOmdEjPKW6U35uGuwWVXcaeu/QIrrAgwlGDOSTbI3RJ2ctLxQG4hy1AO
 hWu9e1IHENE6ceFTsURNp8OgWe9PWYxmW71VGHTDg99UP4LEOyATA0hAnvp25almqhJ1
 15vw==
X-Gm-Message-State: AJcUukc2Mthd5uliwZC6r/eQWNe+5xLsy/AegMR1MiQm8Fwgw7HFEmeN
 ubv94zMFqcrcAXCd9zuICf97jsn2
X-Google-Smtp-Source: ALg8bN6sa0TN30A7zO1ZfyOoXGnrjNLL5qdt6b4LtEBHOXjHUy4DyJ9VZrx09DTqgw5/NQgjKST9OA==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr12051201wrm.328.1548440154765; 
 Fri, 25 Jan 2019 10:15:54 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:fc07:c732:1a36:65ad?
 (p200300EA8BF1E200FC07C7321A3665AD.dip0.t-ipconnect.de.
 [2003:ea:8bf1:e200:fc07:c732:1a36:65ad])
 by smtp.googlemail.com with ESMTPSA id
 v12sm132476499wmd.27.2019.01.25.10.15.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 10:15:54 -0800 (PST)
Subject: Re: [PATCH 0/3] at803x: Add quirk to disable SmartEEE
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 Carlo Caione <ccaione@baylibre.com>
References: <20190125125513.23656-1-ccaione@baylibre.com>
 <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <7d43e158-bfbe-4b30-4298-426ea9f71bb3@gmail.com>
Date: Fri, 25 Jan 2019 19:15:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_101556_956182_1304A41D 
X-CRM114-Status: GOOD (  16.16  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
 devicetree@vger.kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
 linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
 shawnguo@kernel.org, aisheng.dong@nxp.com,
 linux-arm-kernel@lists.infradead.org, abailon@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 25.01.2019 14:06, Russell King - ARM Linux admin wrote:
> On Fri, Jan 25, 2019 at 12:55:10PM +0000, Carlo Caione wrote:
>> SmartEEE, compatible with IEEE802.3az standard, is designed to include
>> legacy MAC without EEE capability into the power saving system. SmartEEE 
>> is enabled by default configuration on AR8031 after power-on or hardware 
>> reset.
>>
>> Unfortunately this is proved causing issues for certain hw 
>> configurations.  We add a quirk to optionally disable SmartEEE.
> 
> It may be a good idea to detail what "certain hw configurations" are
> and/or what the "issues" are, so it's easier to find this if/when
> others encounter the same issue.
> 
Question would also be whether the issue with SmartEEE occurs also
if EEE isn't advertized and therefore not active.
Then we could use the existing DT properties to flag broken EEE
modes, see of_set_phy_eee_broken().

>>
>> PATCH 3/3 depends on https://patchwork.kernel.org/patch/10781297/
>>
>>
>> Carlo Caione (3):
>>   net: phy: at803x: Introduce quirk to disable SmartEEE
>>   dt-bindings: net: at803x: Document at803x,smarteee-disabled property
>>   arm64: dts: imx8mq-evk: Disable SmartEEE
>>
>>  .../devicetree/bindings/net/at803x.txt        | 18 +++++++++++++++
>>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  1 +
>>  drivers/net/phy/at803x.c                      | 22 +++++++++++++++++++
>>  3 files changed, 41 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/at803x.txt
>>
>> -- 
>> 2.19.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
