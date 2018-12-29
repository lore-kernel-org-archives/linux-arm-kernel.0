Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4215AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:18:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110B220857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uk4U8c8c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EHDkEx6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110B220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mG7yiW4qPEcTPXRNacNKy+L6kSJ61+e4Z78YXCxyKcM=; b=Uk4U8c8csypBBR
	AGdh6SqMa8h5HDulAzMI+x/9cCv7Jh2xGYGa+zEr5DbRVYLd6YwyeRirxyVXpsuvrZCiXATXR44Oo
	Jd2dRVR981nLTJz2aV7uBFbNY6i0CVSw2RsTwLMcZPn2weOsR/+/C1GksfAHYUiu1Nr/x3vRgyVCg
	MUL1xSv5HSVavVE6OpYUSVTfavpAlF0aEwNWCYDPOLkk2Ej9R8cNWwImNrbgpwoIbm6U1dVN2YKM8
	MEckHK4sG+f4SSiTw3eFU1/O1TzrgyKqpYM6xx0zl5awOKaEfxLiOhrpgZTmJZbVKjcbF7iWxnZRV
	hOpUrtbYfFDXSsP5Rr4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd714-0000K2-Pi; Sat, 29 Dec 2018 05:18:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd712-0000JL-5S; Sat, 29 Dec 2018 05:18:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=76quiIRXNo94of8FwVdgBTWP6Ho7FAathenH62/uM80=; b=EHDkEx6JC26pw0VriaIEDPl4r7
 xFEoDxGqWUe9n1fZudBYoGWmQFZMBbUqm0czcsqZ9X+3ZWByPtz7p9gEqaw0l7VW7R7LV3I0SL6+S
 ZGzQ7lwj8KVYaNVuFhZ4NZ8cVwGJU3Aqow6+NDNo9fMRrS7aze1qENlCJXjS/iMDKJh5K7Ve//4m8
 OTurquYpCz8mCpNP4I+i/HaH3j1vBmXm/SzcTGTX7FlVJDQ1d5KRgqr4pKJqDdDG7BjKN5flFUIkV
 Afk+rgCYbnBRpCgM9cg0FPmgqcUOjYXq2tF3/rJgOpEmLcB0TMpLF9azktBoO0meSctSL00yDOaLc
 3UxfWfzw==;
Received: from mail-sh2.amlogic.com ([58.32.228.45])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd70y-0002s5-UI; Sat, 29 Dec 2018 05:18:26 +0000
Received: from [192.168.0.111] (223.166.104.240) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Sat, 29 Dec
 2018 13:18:04 +0800
Subject: Re: [PATCH v2 0/1] Meson8b RGMII Ethernet pin cleanup
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 <linux-amlogic@lists.infradead.org>, <khilman@baylibre.com>,
 <ingrassia@epigenesys.com>
References: <20181229000829.16571-1-martin.blumenstingl@googlemail.com>
From: Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <491fb35b-3e2a-89ab-94c6-c9e8d89a1b01@amlogic.com>
Date: Sat, 29 Dec 2018 13:18:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181229000829.16571-1-martin.blumenstingl@googlemail.com>
Content-Language: en-US
X-Originating-IP: [223.166.104.240]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_051824_971479_C83BE016 
X-CRM114-Status: GOOD (  15.32  )
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
Cc: linus.luessing@c0d3.blue, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin, 


PERIPHS_PIN_MUX_7: 
- register 7 bit 22: ETH_RXD3 (DIF_TTL_2_P)
- register 7 bit 23: ETH_RXD2 (DIF_TTL_2_N)

On 2018/12/29 8:08, Martin Blumenstingl wrote:
> Hi Emiliano, Hi Linus, Hi Jianxin,
> 
> could you please test the patch from this series on your Odroid-C1?
> I tested it on mine and Ethernet seems to be improve Ethernet transmit
> speeds greatly (at the cost of a small drop in receive performance).
> 
> Jianxin, can you please give us the description for pin mux register 7
> (PERIPHS_PIN_MUX_7) bits 22 and 23 on Meson8b (S805). The public
> datasheet doesn't mention them so we're missing the name of the function
> and the pin(s) which are controlled by each bit.
> 
> 
> Changes since v1 at [0]:
> - rebased so it applies on top of "ARM: dts: meson: meson8b: add the CPU
>   OPP tables" which will be part of v4.20-rc1 once the arm-soc tree is
>   merged into mainline
> - updated patch description with more details
> 
> 
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2018-May/007274.html
> 
> 
> Martin Blumenstingl (1):
>   ARM: dts: meson8b: drop eth_txd0_1 and eth_txd1_1 from eth_rgmii_pins
> 
>  arch/arm/boot/dts/meson8b.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
