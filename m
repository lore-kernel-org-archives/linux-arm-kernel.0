Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1E2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:36:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7B42081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dab4iRW2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfNrVCss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7B42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YA4BXrSB1vDofz+ueZSM7IKkTuUV6hzdF4ryWwmTDlk=; b=Dab4iRW2uTBssc
	1qLrK9O8YRb5uJ+cW+AL6tYrTD2OgsrjExZ27Jmk1682nztJsDXi+dVnTvzSqVUrRH0+QWlkLyIm0
	vzighnW4fEU2mpCnzvZ9hD4sSaM4GiY2Whx1Z7vrN+M+urhjRGANRoW4YcaWzwd9inaY9HSL8KqNG
	kjbRdndJqGj4p7HVPVszYDOUyEbHHhtKYqY86vZNNYLKtGSZwTkduW2GWlzKQ3QUacK+cwoSON9Sq
	1xw6mHWIvVEkWUpwW64Odx21lW52mGNpLElBK12s/K5bdEgQ0EyTBKPdea++XzoYbJTBwrnNn2Vvj
	o9K5iyFZ1lFIjdSiALEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUNyy-0002bS-NK; Wed, 05 Dec 2018 03:36:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUNyv-0002b3-Ta
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 03:36:15 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F3B9A2081C;
 Wed,  5 Dec 2018 03:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543980963;
 bh=tz9U8zYR6EQP6PZSTmYV5sNZ0RLDUZ3IVwH8Ey5SHPU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LfNrVCsstQyV7i8KKXHdH46eF2Wy+fmDnz2PoSKpLMj1r65GJOEMk3jH6tzWfqadR
 cZTEknY/GVWjs87iQa6wvLFeZk9fTv5TlmMOtyGW5Rirn6MLMo9aNnlwd7LK8rOPZD
 WVwH56JTl8YOVNgwfC7YQ6N/O4L+Ey68eREhGVTQ=
Date: Wed, 5 Dec 2018 11:35:25 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC 1/2] ARM: dts: imx6ul: Correct mask for GIC PPI interrupts
Message-ID: <20181205033523.GH3987@dragon>
References: <1543257955-8910-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543257955-8910-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_193614_094973_2FA32256 
X-CRM114-Status: UNSURE (   8.94  )
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
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
 liviu.dudau@arm.com, linux-imx@nxp.com, kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 26, 2018 at 04:45:54PM -0200, Fabio Estevam wrote:
> The GIC_CPU_MASK_SIMPLE() macro should take as its argument the actual
> number of CPU cores the interrupt controller is wired to.
> 
> i.MX6UL contains a single Cortex-A7, hence the second interrupt specifier
> cell for Private Peripheral Interrupts should use "GIC_CPU_MASK_SIMPLE(1)".
> 
> Tested on a imx6ul-evk.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied both, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
