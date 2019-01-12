Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D80C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:50:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D7A2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J9eGi13Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCQkPMZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D7A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CJ6nOfTJwBHUD3K2MVgv/BZ6XdDGy3NLPgAf36PshZI=; b=J9eGi13YX5bqa9
	wKxT9G/BiTh2+UdLet3pw2fRDhpJO7fOeuSxLvjw6ot57eM5yPdTaxSZUHOk+8sYk36Y/spMFmAa0
	KTqg/2dxYAFYDbA7lDRhoPLkC1Yo4qBWDuK9+rxWeWpzBN6qX9KSEaFLJw0Pb2CC+U/oluiZhRJFa
	F33yv2u+V96jh4BHfCKo8rOulxFs6t8x4Wsbfjn2ZZHa+PjX3tLLIuA6OtFeoVVus3FEhm3481mYd
	3ECjpYgXbFmYAmP/9aAGDdecM/reZUoONG3VTqgVKDz5e/NCTo4K4FdwHyjVDKNn8kLvMkeUilfVJ
	fffyxI4/BDmx2lq2N/Vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi9NI-0006NS-DY; Sat, 12 Jan 2019 02:50:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi9NE-0006N6-V5
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 02:50:14 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D52D62084E;
 Sat, 12 Jan 2019 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547261412;
 bh=M8j5Y4/14LIQi1r5hGjnnqWZbhgGbRwAxPvyhQQKg1k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UCQkPMZdO8sJs3+CqWMBOpydFjwxNsjKMPdjml8PcuUOdQUTja+L5Lz/8O+XnwqoB
 yos6+DOdOA4gDs1yL+6aJPeYIW2gzp4Wlw6Nz4syuiCX52NAiXGbCqbZta+VsmVtFN
 KXP6rwxsVBtpKoSPTwqPyuEr+XQmRz251f6x7RQc=
Date: Sat, 12 Jan 2019 10:50:00 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ARM: dts: imx: replace gpio-key,wakeup with
 wakeup-source property
Message-ID: <20190112024958.GP32649@dragon>
References: <20181221181203.6764-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221181203.6764-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_185013_019148_538A1754 
X-CRM114-Status: GOOD (  10.41  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 06:12:03PM +0000, Sudeep Holla wrote:
> Most of the legacy "gpio-key,wakeup" and "enable-sdio-wakeup" boolean
> properties are already replaced with "wakeup-source". However few
> occurrences of old property has popped up again, probably from the
> remnants in downstream trees. Almost all of those were remove couple
> of years back.
> 
> Replace the legacy properties with the unified "wakeup-source" property
> introduced in the commit 700a38b27eef ("Input: gpio_keys - switch to using
> generic device properties") and commit 0dbcdc0622ea ("mmc: core: enable
> support for the standard "wakeup-source" property")
> 
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
