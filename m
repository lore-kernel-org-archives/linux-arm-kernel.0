Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D717EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:28:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1422081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AVnNPGTK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2wbqaKRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1422081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/VkELfPoTV7FYxQWKwPFJWvnNwLh45PhrRX3c3GQJxQ=; b=AVnNPGTKAbd8Rw
	cs21pytOtbsBFm2VMuui87N1a5qq3Oliu3Nyji7HYshdH84Wavq1h2Yxj/3VrS1/sL+XWtH0C05zo
	LFvAwc/pVirCANH6I337HeQcKnAiw3dd7BMlmg+1Tip5mEjFVMvgKj0RutxD3yeqCsc2a5kChlA3u
	rjKl6x++mP8rn7Zhk+RBgzNV/OMEI3fugVAY1GF+KMOEGnxAuvSbnrT+8sFvVNb0cJ7yYI9TgITL0
	wmd2oQvo2b1cQUI3v4X4yyXCy6/DcV4pFrBekbOsjb1AE7wzg84/e1PWOm6Fywi+1oNcUY44FlQti
	ZvwHUU2bKBs416QP+aZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSWfy-0003hj-Ra; Fri, 30 Nov 2018 00:28:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSWfv-0003gw-8L; Fri, 30 Nov 2018 00:28:56 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8A0E72081C;
 Fri, 30 Nov 2018 00:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543537724;
 bh=1tV5SDAr69cUs1iDQjfHJLRQ6J6D7Js/d801NobftGg=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=2wbqaKRJzdFhGgTm3xX3QHwUPHJXBvCnhDUHHlgd8ov4irUpPejrWTxU8DNS8ACOP
 xUyWwgLO2myyrMsjyDG+Sv2I3/KgFW2BBr0EOWzPKD9cZoejSA9+BQA1c98tEndPIk
 ecBPUp4sY20CAoLdBPwy0LokzegYfZxRHZ+oBzAA=
MIME-Version: 1.0
To: Rob Herring <robh+dt@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
 <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
 <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com>
Message-ID: <154353772392.88331.16937191244549721858@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
Date: Thu, 29 Nov 2018 16:28:43 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_162855_449805_0FAEFEB7 
X-CRM114-Status: GOOD (  10.13  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>, linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Stephen Boyd (2018-11-07 10:37:31)
> appropriate structure with to_platform_device() or to_i2c_client()?
> 
> So the example would become
> 
>   struct of_driver_probe_func {
>         int (*probe)(struct device *dev);
>   };
> 
>   struct of_driver_probe_func mtk_probes[] = {
>         mtk_probe1,
>         mtk_probe2,
>         mtk_probe3,
>   };
> 
>   struct platform_driver mtk_driver = {
>         .driver = {
>                 .name = "mtk-foo";
>                 .of_match_table = mtk_match_table,
>                 .of_probes = &mtk_probes;
>         },
>   };
> 
> And the probe functions might need to container_of() the device pointer
> to get the struct they know they need. The probe function could also be
> added to of_device_id and then we would have to look and see if that
> pointer is populated when the device is matched in generic device code.
> 

I guess I'll go down the path of extending the of_device_id structure?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
