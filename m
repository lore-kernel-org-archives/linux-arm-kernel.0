Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D9DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:30:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F97221848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k7SUSYAL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aAqoAKQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F97221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vHMjQdDBKKb6Fx46SfUUp/PtuGAbqDed4jC/eVTX6Qk=; b=k7SUSYALoQfNJA
	n+RXEigmSjXF0VaFg80jKNZOvtbXOGPUGyQXhkGO/Zy+Wc95Jts6DC4JPLO6pg61mBfnZB/bkg2Qg
	aQK9LzjmZNW2Wm0XnMXGAyeQ95EHq+f9JcSiSIPlwtU2m5y7yLFUtcltj08Ve/EkNGY1yj4EMem8S
	WGPqNR83ZgLJHSxTRhZ9rPLWuQ4I3/2isn9sWd4t0302ygfLz1kLEhIiPU3p+679ITvBtVndmCi/4
	RHbAFEbRDm0O4RTBTXl3Qsmo06Wsc9c2bjKy6GF/Xgiz77TJUNfg7my1a6/csoqqq7CXdrIAQ34AR
	n8C01NJRS3I6VTisnprQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi1Z8-0006xI-43; Fri, 11 Jan 2019 18:29:58 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1Z4-0006wp-MA
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 18:29:56 +0000
Received: from zn.tnic (p200300EC2BCAC5004D300B3B2C1DD65E.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bca:c500:4d30:b3b:2c1d:d65e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D89BA1EC00E5;
 Fri, 11 Jan 2019 19:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1547231393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=M4kvsJBoIpQblbxqqZvWsHsb608huFCWoMTQeIOVn8g=;
 b=aAqoAKQ5VjX+7suC22kWCNvEZ6OA0IGkxczLnh2nNbA4dHd6gSL2S1X0I9yezDTwPjh83s
 fFy5/9S6jXVoqZp7Qnsvumj4UpnbzBDU4TIGf9HbHLSnaZ/QLz3jr7gwHISUYWqJT+TX3I
 8uTyEkXekaochKwbfvh8t9uV+9dd/fI=
Date: Fri, 11 Jan 2019 19:29:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
Message-ID: <20190111182944.GA24304@zn.tnic>
References: <AM6PR0702MB379953E130CC1E1DEE18B79BFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
 <20190108104204.GA14243@zn.tnic>
 <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
 <AM6PR0702MB37997C0FA1670DD1AF4C25C7FA8B0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
 <bba99e8c-5e3e-98a4-d0c9-9734216e66d2@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bba99e8c-5e3e-98a4-d0c9-9734216e66d2@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_102954_876476_BEEA7488 
X-CRM114-Status: GOOD (  11.43  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "Sverdlin,
 Alexander \(Nokia - DE/Ulm\)" <alexander.sverdlin@nokia.com>,
 "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "Wiebe,
 Wladislav \(Nokia - DE/Ulm\)" <wladislav.wiebe@nokia.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 06:11:04PM +0000, James Morse wrote:
> After I sent this it occurred to me the core can't know about errors in the L3
> cache (if there is one) or the memory-controller. These may have edac/ras
> abilities, but they are selected by the soc integrator, so could be per soc.
> This goes against Boris's no-per-functional-unit edac drivers. If we had to pick
> one out of that set, I think the memory-controller is most useful as DRAM is the
> most likely to be affected by errors.

We have similar "designs" already :)

Memory controller driver drivers/edac/fsl_ddr_edac.c gets linked together with:

mpc85xx_edac_mod-y                      := fsl_ddr_edac.o mpc85xx_edac.o
obj-$(CONFIG_EDAC_MPC85XX)              += mpc85xx_edac_mod.o

layerscape_edac_mod-y                   := fsl_ddr_edac.o layerscape_edac.o
obj-$(CONFIG_EDAC_LAYERSCAPE)           += layerscape_edac_mod.o

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
