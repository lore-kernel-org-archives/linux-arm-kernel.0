Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB691C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:56:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845B720850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WNaCqy53";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H23gTANJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845B720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P0hSPXNZWpIzmknBub+TzQsFUreuskpJBLYz4UHMJcc=; b=WNaCqy5332RHLI
	cpqbPc+LoyGjMT0pvnNYF2bRUFaYpdQpbyirJ2M6ELmJOuu2gOj2dopONfIcbS0mCEmTkRLx0gkil
	nS30puBGNahmr2oR186xFrJPQ6Jn7hDhwCeB/IAnFhc2JxQMh8DwuXYLTvwO55bUyV0kQtp0VM+dP
	g0RjPloUWFs5wgeeDyC7WA7HDWz7/s7ilDn8irJDnLkgZXKIP498OBTkCCZyLxmohlZUixMcTaKhO
	VQ4r3pZt/MyI+NmyLLNUxPplFXhfb4FAp6tOifGA1kPEffzsZhWex2+/w951QfH2MF2HFigiO7gME
	sMPOuUJrCsWKJVrDdB+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUv4N-00065E-CV; Thu, 06 Dec 2018 14:56:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUv4I-00063K-DQ
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:56:01 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C458D20700;
 Thu,  6 Dec 2018 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544108148;
 bh=kijMMXAVBHwSbZFfaEhr9dGVp0zWsH+nCNlVb67TQ6A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H23gTANJz9CFjZMJFmCPvRI6lTAGnz4AOdsmIKkHLxSDJ4JQqYK2ys6Ft5n4kYWMI
 SEC5lC3j3GkdkF1dWjTqc8f+ZKU6dTNJZpLz6fpVYOCif0qzzMMIOQXsR4hdEvnOVj
 zffuLYwNE2B4thWY3MX85uwes4r4D57EMRGn11RY=
Date: Thu, 6 Dec 2018 22:55:05 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH V5 6/6] ARM: imx_v6_v7_defconfig: add imx7ulp support
Message-ID: <20181206145503.GG12929@dragon>
References: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
 <1541862478-7839-7-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1541862478-7839-7-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_065558_560591_FE3ADA2A 
X-CRM114-Status: UNSURE (   7.65  )
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
Cc: "dongas86@gmail.com" <dongas86@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Nov 10, 2018 at 03:13:16PM +0000, A.s. Dong wrote:
> Select CONFIG_SOC_IMX7ULP by default.
> Patch generated via make ARCH=arm savedefconfig
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
