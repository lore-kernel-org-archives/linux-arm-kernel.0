Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823DDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:08:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373582081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fvt0Bn26";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZZdetjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373582081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PVjsm0YNM9zgVUrRcimIi/NBGZvVHG/P/pBF2Av3hpk=; b=fvt0Bn269+u07k
	3Bm5wIem4G03Hdy9vq+4dm00LRjd2zRWOBdpByxAEl6y3AfKiUUvEaknERbeq3W57UvE3kVsXk4PQ
	l/jGD/HGAJqKjVaOoKiKE+QUeCkQiEaJ9maRn7lQLx40+FF2YZEva4XmUcRZFzuOOk0uv/yXfEstp
	zZxy2mhqp11Faj29YfhBaRF7LDtRrLgXk92AQxrz1CsNzVc1huqQiepD/F6tGU7eqcF0XaWgyEEqd
	EFdPzQyfYcRWuk+pRV/iag6nrpzldTn7DnQ0x7Ul96SayOP0QUn0nzLLQL5yzVTv+B5xBMJrPed5m
	fVZ7gCF5x59bndBXRfdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUOUM-0005IV-Ju; Wed, 05 Dec 2018 04:08:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUOUJ-0005I3-DA
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 04:08:40 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 866162081C;
 Wed,  5 Dec 2018 04:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543982907;
 bh=6C8mLiev9+WKE+LMfMH2z5eI6anN6AsnMhI+U47f3ac=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iZZdetjjhM+lqX3XU+hSZXAFhm4UrxfUMdOQ36JbB1qUD3rJF2agw27b7zDFzNSsr
 X4MSIqpIdQdEYNVGtkekiFyOdUPY+EFR1iSlKtziDaaoOfZg3s2nB0adKUmvFPjrG4
 rp5OqMM19I126k+z1S+2u7Etapq/lSelRpw9DnMk=
Date: Wed, 5 Dec 2018 12:07:49 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx7d-pico: Describe the Wifi clock
Message-ID: <20181205040748.GK3987@dragon>
References: <1543573889-8355-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543573889-8355-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_200839_576221_603FB87C 
X-CRM114-Status: GOOD (  10.36  )
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
Cc: cameron@paloaltoinnovation.com, arend.vanspriel@broadcom.com,
 otavio@ossystems.com.br, vanessa.maegima@nxp.com,
 linux-arm-kernel@lists.infradead.org, john.weber@technexion.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 08:31:29AM -0200, Fabio Estevam wrote:
> The Wifi chip should be clocked by a 32kHz clock coming from i.MX7D 
> CLKO2 output pin, so describe the pinmux and clock hierarchy in the 
> device tree to allow the Wifi chip to be properly clocked.
> 
> Managed to successfully test Wifi with such change. Used the standard
> nvram.txt file provided by TechNexion, which selects an external 32kHz
> clock for the Wifi chip by default.
> 
> Fixes: 99a52450c707 ("ARM: dts: imx7d-pico: Add Wifi support")
> Suggested-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Tested-by: Otavio Salvador <otavio@ossystems.com.br>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Okay, replaced the RFC patch with this one.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
