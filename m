Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:10:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D65552081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cGiQG5Vr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="EALjCgjE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w2pdJkUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65552081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Date:References:In-Reply-To:
	MIME-Version:To:From:Message-Id:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o514/jIkgXkuJEuKOX7UdG+wGDQrQEmnM3yVTwbujoM=; b=cGiQG5Vrkasvxs
	5c5qUhzk4GJnbfaMvkdNPKw9tgAMtrfwce2dcPcnGaozVUifdVf8xqdBDixzQU5J+3wKady5XAjDf
	StkvZHAeR1GoilhJB/G01hjhktBexUUsL7uJe6NU9SXAKUb4ZhD2xzwtEDjdHiY9mX/AvWuaGUXlf
	M3yaF0aKUtTnGJOt5hzEZCCFiz6+r1ExzUloaWwBTGsBySvI3rF8HmOFM8wAgAiUXIx6ZDVfqmCbF
	bVuzNhAXWjpjS+KFxPfCIL41+cHhehN628Mjm1aJa3rfG9AatuircYS0XkfPGmGErGJfNx2AhFPWV
	wBMdbT6TYX7rRHb4uIBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWVd7-0000cE-2X; Tue, 11 Dec 2018 00:10:29 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWVd3-0000bU-Pc
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 00:10:27 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id A29A321A90;
 Mon, 10 Dec 2018 19:10:09 -0500 (EST)
Received: from web5 ([10.202.2.215])
 by compute4.internal (MEProxy); Mon, 10 Dec 2018 19:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 message-id:from:to:cc:mime-version:content-transfer-encoding
 :content-type:in-reply-to:references:date:subject; s=fm1; bh=tx+
 hCwzUrGyW7rgdf/IRZt6IwmVugK9fuCA7nltuc0A=; b=EALjCgjEtijU1zXmDui
 0ybRVO3+jiiWg8zkWNIkGthCbrTn5RRDumY4fF4pNlbY8kcrnnyEtaxF6SjQ68yH
 0Y0zDoezhlUrwBLdZpmf5GW2frhVPeg+tQqamBKOMTnOLAa5uuVUVAPQasCw/w81
 vYbw7SMd1t/LmB7W1QQPBaHJsYk6IPgyJwKjNvtQNagBtXsf2KLbt38tqhy+2KtG
 V4vVunBeQUk0wqVM/CcoUMrfPz7tr19h7XTFd3GP6+W7qnBLc88iJfkPWc28ckzP
 uESdU3Zj1t/Zn4yL9OAwV+VNwH7TC2rYD6Pt/nfvH4K/6eDDZQKr7XsFB/jcjAUa
 Ahw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=tx+hCwzUrGyW7rgdf/IRZt6IwmVugK9fuCA7nltuc
 0A=; b=w2pdJkUdA6VkbWC8UzTsdNtqXdVH2dv4g2rrMl45RVbm0Zy1XdkvmV9pM
 Ul3AKK4HYQp15I6LgySNhcL/g/M7nreIHEzRZdcSrkQHoSTxB0uK1rNRfFnF/BC6
 ni4mnjs2oz6jv0c0u7m/jf0dL5Xx7jXQLniw8aSsY/TrM2u57RzLgdNbW0Qs1DY5
 GiHFvTY9VVSownKMV8oK7WechBEQcRV8hy3Ba4MdEhADNl7UEEhqEKkZd+x+izMV
 qoFJ2dSFCBZUOiX4z9m1ltrMt+zgJEVaBfVP154iPbSJhcvhwmwjJVBu6Z5Nz4Ix
 uFrM9lYq19GpbC2nYiNLnsbAMingQ==
X-ME-Sender: <xms:XwAPXIN9VAJU_5JGKvxgsnP-HVDZkjYksZTOPIABAqDzMZz-EZsSLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudegiedgudekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
 tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkhffvggfgtg
 fojghffffusehtjeertdertdejnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicu
 oegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrghmpehmrghilhhfrhhomheprg
 hnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:XwAPXJioMMSh0KPjFFDuEkuXVkmpg_UgPVx1bqZla8au7xDDPByF9g>
 <xmx:XwAPXONOmbDz1NFjd9FKhhr89hhR_GzW9Ed-sIEiuN2oQmfO6Dhkpg>
 <xmx:XwAPXK7RRKnOQ4ujr8oC4r8vOVsE2FzA9jtUW1DZBaJ_h6qnOH2uDA>
 <xmx:XwAPXM0Y3gAPUiFy0AEE5S2xTKT25oeK2yCqnmPFIhHZasEbZqPxiw>
 <xmx:XwAPXLaobClMQlMIhVAG3WvjRbTv1jkTpQjv_sjMJLdI0cAW5eYI7A>
 <xmx:YQAPXD_9LmAnNUmSubr-jTnb4bmrbi7yf7L-NL2QC3wldADCpFwW3w>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
 id E6B2F9E149; Mon, 10 Dec 2018 19:10:06 -0500 (EST)
Message-Id: <1544487006.3301683.1605247720.567E9685@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
To: Nathan Chancellor <natechancellor@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface - ajax-2f590f9a
In-Reply-To: <20181211000506.7559-1-natechancellor@gmail.com>
References: <20181211000506.7559-1-natechancellor@gmail.com>
Date: Tue, 11 Dec 2018 10:40:06 +1030
Subject: Re: [PATCH] pinctrl: aspeed: Wrap -Woverride-init with cc-option
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_161025_980338_E37F34B1 
X-CRM114-Status: GOOD (  10.45  )
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
Cc: linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On Tue, 11 Dec 2018, at 10:35, Nathan Chancellor wrote:
> Clang does not support this option:
> 
> warning: unknown warning option '-Woverride-init'; did you mean
> '-Woverride-module'? [-Wunknown-warning-option]
> 1 warning generated.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/pinctrl/aspeed/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/aspeed/Makefile b/drivers/pinctrl/aspeed/Makefile
> index 191ed0fc1804..790b406aae19 100644
> --- a/drivers/pinctrl/aspeed/Makefile
> +++ b/drivers/pinctrl/aspeed/Makefile
> @@ -1,6 +1,6 @@
>  # Aspeed pinctrl support
>  
> -ccflags-y += -Woverride-init
> +ccflags-y += $(call cc-option,-Woverride-init)
>  obj-$(CONFIG_PINCTRL_ASPEED)	+= pinctrl-aspeed.o
>  obj-$(CONFIG_PINCTRL_ASPEED_G4)	+= pinctrl-aspeed-g4.o
>  obj-$(CONFIG_PINCTRL_ASPEED_G5)	+= pinctrl-aspeed-g5.o
> -- 
> 2.20.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
