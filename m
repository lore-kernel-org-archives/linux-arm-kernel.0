Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D88C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:26:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5422084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qG+wEY0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5422084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YofV/I8JuxfRbBAHQ4FZTi1kxKb8UP0wJExw4fCvBhM=; b=qG+wEY0GUgOhfcOMM9Wawm06I
	UAOcvpSEzih7YUQnbo9GBRgDYM5RzS+2lLNSvPdZRqjSdVxym8HwYGtfg2VxdaYSlS101ovdz3aY+
	pXJIQBa9nBe07Sya13YYXB4m2NvJ4e7kzv0mFI+f2t9TIAIcYnujfXfmLg0aW3jcKqqz9MrqrbZEz
	rU72GeBVnu1Z5GxCkdFtUDWSd7i1NXKCmMMp8TUKZ8+h69QktcLv7E2jvZRLyEEk5fl10x3nwoCCN
	rUUVcH8DtY1GYmbczM6MtpUFPzW1CCYAKoyoa6Vs8q8/0qus9f01WOaMNeNtdEHtl62y2qvq3vXjF
	MLHD89SzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJhJ-0002jn-Ot; Mon, 10 Dec 2018 11:26:01 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJhC-0002ih-EZ; Mon, 10 Dec 2018 11:26:00 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 43D1390QWfz1qwC5;
 Mon, 10 Dec 2018 12:25:40 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 43D1382YG1z1qr94;
 Mon, 10 Dec 2018 12:25:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id jbKUrZJQOj6S; Mon, 10 Dec 2018 12:25:38 +0100 (CET)
X-Auth-Info: z0lFj7C6oZyZmg++IIKvSxpUa4Xy8+oV9DA/LG0muVA=
Received: from antares.denx.de (unknown [62.91.23.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Mon, 10 Dec 2018 12:25:38 +0100 (CET)
Subject: Re: [PATCH v2 0/4] Add Actions Semi Owl family S700 I2C support
To: afaerber@suse.de, manivannan.sadhasivam@linaro.org, robh+dt@kernel.org,
 mark.rutland@arm.com, wsa@the-dreams.de
References: <20181126185821.2480449-1-pn@denx.de>
From: Parthiban Nallathambi <pn@denx.de>
Message-ID: <5434a04c-a492-a7a5-9783-383947b6d1fb@denx.de>
Date: Mon, 10 Dec 2018 12:25:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181126185821.2480449-1-pn@denx.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_032556_538399_AAF07E3B 
X-CRM114-Status: GOOD (  18.05  )
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
Cc: devicetree@vger.kernel.org, linux@cubietech.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 thomas.liau@actions-semi.com, linux-i2c@vger.kernel.org, pn@denx.de,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ping on this patch series!

On 11/26/18 7:58 PM, Parthiban Nallathambi wrote:
> This patch series adds support for Actions Semi Owl SoC family S700
> I2C controller. S700 provides 4 I2C masters and with cubieboard7
> 2 (I2C0 and I2C1) are exposed.
> 
> Added pinctrl definition for I2C controllers in cubieboard7. This patch
> depends on s700 pinctrl driver support (yet to be merged),
> https://lkml.org/lkml/2018/11/19/514
> https://lore.kernel.org/patchwork/patch/1012859/
> 
> Changelog in v2:
> - Initial version https://lore.kernel.org/patchwork/patch/1011911/ only
> added the I2C nodes using s900 compatible property. Now, new s700
> compatiable string is added and used for S700
> - Device tree bindings added with s700 compatible string
> - pinctrl definition for cubieboard7
> 
> Parthiban Nallathambi (4):
>    dt-bindings: i2c: Add S700 support for Actions Semi Soc's
>    i2c: Add Actions Semiconductor Owl family S700 I2C support
>    arm64: dts: actions: s700: Add I2C controller nodes
>    arm64: dts: actions: s700-cubieboard7: Enable I2C0 and I2C1
> 
>   .../devicetree/bindings/i2c/i2c-owl.txt       |  2 +-
>   .../boot/dts/actions/s700-cubieboard7.dts     | 53 +++++++++++++++++++
>   arch/arm64/boot/dts/actions/s700.dtsi         | 40 ++++++++++++++
>   drivers/i2c/busses/i2c-owl.c                  |  1 +
>   4 files changed, 95 insertions(+), 1 deletion(-)
> 

-- 
Thanks,
Parthiban N

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-22 Fax: (+49)-8142-66989-80 Email: pn@denx.de

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
