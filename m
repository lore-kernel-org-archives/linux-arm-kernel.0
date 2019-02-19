Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5EDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:52:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E35EE21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nt6XAgr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35EE21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wFH61kjLh8cBeG1ZwhYBPy0QD6Fcwkg/xZjNrLaozKs=; b=Nt6XAgr+nInSz+
	wCCwOX7i2GggZULUgbLEu1S81+O7DcaHotHfzkdy6+qGCWTg66vikUwFTzyqB5KLk9EOZqCGrs9/5
	LQB8rglmT63TEF5j6N35wv2Hzaj9KT4z7Y0DDUJ9EuUVpxRciH5JakiB2kWLWt4Tch1R+pIb8QrkQ
	garjy4QiWZq6onvhl0KCzv33rPwHietwCMUKzLZLCoEfT6Owaly0earS0+uOUh5wSs70bJVTYFnbR
	dUX83GAsm58hLmYIZ5A7S30GJIMD5lzeV+ooED6hHUEYAF5G2BuUD6N6ia7716Abe4WG8hU9D9rZy
	FnfgqYf2+mbx5AH2SUMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8dL-0004nG-Eq; Tue, 19 Feb 2019 16:52:39 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8dI-0004mq-Pi
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 16:52:38 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 5805780B6;
 Tue, 19 Feb 2019 16:52:45 +0000 (UTC)
Date: Tue, 19 Feb 2019 08:52:31 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: am335x-evm/evmsk: Fix PHY mode for ethernet
Message-ID: <20190219165231.GK15711@atomide.com>
References: <20190218143629.28392-1-peter.ujfalusi@ti.com>
 <20190218144430.GE15711@atomide.com>
 <a9eea4d0-88d4-e903-8a9f-7f1b8b276c21@ti.com>
 <20190218162613.GH15711@atomide.com>
 <c35030fb-9107-1919-5c18-1a39ace8c036@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c35030fb-9107-1919-5c18-1a39ace8c036@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_085236_866923_AECFB1AF 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: devicetree@vger.kernel.org, grygorii.strashko@ti.com,
 marc.w.gonzalez@free.fr, netdev@vger.kernel.org, nsekhar@ti.com,
 vkoul@kernel.org, f.fainelli@gmail.com, bcousson@baylibre.com,
 niklas.cassel@linaro.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [190219 08:02]:
> On 18/02/2019 18.26, Tony Lindgren wrote:
> > OK so sounds like these are OK to wait for v5.1 merge window
> > then as the dts changes alone won't fix anything?
> 
> I think it would be better to send these to 5.0 to avoid the regression
> siting in linux-next.
> 
> The patches are actually doing to the correct thing (we need rgmii-id,
> not rmgii-txid for these boards).
> It was just a matter of luck that it worked with rgmii-txid as the
> driver was broken and did not disabled the rxid when it should have.

OK applying into omap-for-v5.0/fixes-v2. I'll send a pull
request on Thursday most likely then, let's see if it makes
it for v5.0.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
