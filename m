Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4C7C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:42:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D0721855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WU4FPYxT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWCG39jA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D0721855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VnMwZNYOisROiCMf6MsfBpPodBv+49pJV6DmwnXZGN4=; b=WU4FPYxTEWfNY+
	c/PhngCUIoYdBeqK105bdXRPHSFZTRJzBVgd/h6yIO2bWYDYqxg0YN9wq32vkBZkixr4yMPPVVORt
	hW84ZShO3sMZk0FGabWS42TqLHv5pL42WUxVd9xe1Ti7zGWsHYSXglkmMBNmLOBB6JRbh35HueeWk
	6OHBc8A8K2AECDs0Bo5ZSmvhpRnmlHDXIJ4H3qu86Pm1mU0Yfmq/N5o4B64ICLYkDfFyw5no5+I3T
	/2O6nevsOrF5yRXrmimoSsGNI+UJaa+bcxd+/s6ld1xrUXxAUveDUc8Tx6s9QlChs8VcULb4yJnDi
	s4rv0uyNZae6xZMIF1PA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmj0w-0001JG-6e; Thu, 24 Jan 2019 17:42:06 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmj0s-0001Is-KZ
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 17:42:04 +0000
Received: by mail-oi1-x242.google.com with SMTP id y23so5534829oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 09:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zVlpwDq2bUYnqIcPuWsHMoDWtsRGpomjGG4g/5R0dM8=;
 b=QWCG39jAFAo8Aun5eByoOu1JO+eGYtbyKiP2A6UOv+pkO+0VEKEh2k2i9Wxx3I+0bP
 Egu2eFS2/W4LhmRN/Vk6ks+QqX5o9uwJfxUcOgUX17egvNaIIZmOtm3gng+TtXIAJq/A
 2ZX4FrGd0zxErUGecbeAOAG9XTx+6RZWT/ugdR3cwoVArr9rAil59I95uPy11qpD+hrs
 b5AmE9KfhN+kC0frlRG2EWLfyCdPrYZErdM9FEUZv/jmuAJZzl6pX8MqBWtlgR0ThEnV
 bzXvU3yPbcnS/jEr5RjnS39UNfDSZqQTeMHbQ5ypEo/hcfNBXHTy0WLSOAU2nXJkqnLu
 ib1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zVlpwDq2bUYnqIcPuWsHMoDWtsRGpomjGG4g/5R0dM8=;
 b=g7W30XUFNQ89OnOIkZ5Sti+Smk7vVev4f2tAEIjQeCyQDegZ0oNKMAIA6PN8oSz27+
 UiN6LWBTiKyWyZm1HE05rNSv21F3Aw2xQZX2h7v8XQMtqM9cP+c6rONhBa9u9r+jC0b/
 384IElocLziIGGidyPcWQIZVGslinUQjikAO4aRpJp38a90QAfPyYll61tCc8Wl48koP
 oi7ZuGm7e5ln+hjYydfSdGLszn/C6sSys+snROKpmH44+oOaqQjzgVXlnw+x+3Tz1bar
 x6C2dXcACHp9yM8q0k6YyDA2jWiDPCxdESuD6dCpaZw+QB4jHNtQtmhPOP5T3G90aOyt
 N/Bg==
X-Gm-Message-State: AJcUukf4Kx7AsemxOZ+R4c/R9g9Tn9xoN512U54bvu3L5FdkyMmfE7xU
 f9sPXX4XIz9E4sRyyMAr4CuFGBYH+SG2auFHUf4=
X-Google-Smtp-Source: ALg8bN5Ae0yBuSPvHzI1NMaHXmffRwpfsRkd70RgSDyd7KaTnwYQrCP5qswpKSgSwC8l8naacCSgJVgynAdXv7VFpdg=
X-Received: by 2002:aca:6155:: with SMTP id v82mr1815489oib.259.1548351720991; 
 Thu, 24 Jan 2019 09:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20180912152702.14640-1-l.stach@pengutronix.de>
 <20180926023937.GD22238@dragon>
 <CAOMZO5CeOxzyEG0tTKHfrNjY8WRKs=s5nBvxqZuFuJjR62eXOA@mail.gmail.com>
 <1548340471.28802.23.camel@pengutronix.de>
In-Reply-To: <1548340471.28802.23.camel@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Jan 2019 15:41:58 -0200
Message-ID: <CAOMZO5B8mAvziRdUdsddpPvH9=kHk4VQe5_J7Uq8t000aPiveA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: gpc: set DMA mask for PD platform devices
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_094202_679558_4E64F7A4 
X-CRM114-Status: UNSURE (   7.89  )
X-CRM114-Notice: Please train this message.
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
Cc: patchwork-lst@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lucas,

On Thu, Jan 24, 2019 at 12:34 PM Lucas Stach <l.stach@pengutronix.de> wrote:

> It was dropped due to discussion in the pull request:
>
> https://patchwork.kernel.org/patch/10621589/
>
> It seems we are stuck there and I don't have the bandwidth to follow up
> with this currently.

Understood. Thanks for the clarification.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
