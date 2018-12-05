Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:33:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE742082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CD5g5Z4S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRiLvd6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE742082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=akj3HFqP8GrOGtceEZ09fJZpLoYOEi5u0kjJwnur46A=; b=CD5g5Z4SbDMoJk
	7fPUr1fqq+Qulvwdfi+Xvx8HZYP1J6ciQks79iFq3CV40SPdWpYo0fKH5JPGGGtT4tRaxXqE6MZhz
	djQq1Z7NGgE3aNx9FzBS6VxIByf7Ki9z4mH2t1+UF17jeyjphUpdM/D17VGwx76G2jnqE7pl7C3IT
	VdvbWpPFZDS+Rcnx3GmC3cO8KBz0mH6ygxDxa1dMENQ4V1san+4uyIsQ1MQrQuEJYRK07oxdgF5OT
	j9iz+TuhltkHJCd5NjniQubuw9zxq9byUg+yha8IYth+6E29m/GH9eBqnNnLxi+1FgxI9ebD3B2Js
	sFNtmLU7W07ABJaUkRMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUNw1-0000eu-QR; Wed, 05 Dec 2018 03:33:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUNvy-0000dD-Um
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 03:33:12 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BB3852084C;
 Wed,  5 Dec 2018 03:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543980779;
 bh=X2dhGeNvGsZq9gpHTQErYe1QblIjdd+7ymDvkxeVapE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JRiLvd6FIOVaTT5zIEQVfho5hYa0mDI8FpcLVT8m4quMaPsB83C72IkwXfFLmDGD8
 HSik6KOvmuEdO1jhOwHTatLYjLRB8WbhEJ9Zn6s6jl3Y9TwVqvaJ3SVnfRv6TVidLf
 HvVycn/ghziU9NZHu5F4852X+YSE065TLo5pU/Uo=
Date: Wed, 5 Dec 2018 11:32:24 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] ARM: dts: imx7d-nitrogen7: Use mmc-pwrseq to activate the
 Wifi clock
Message-ID: <20181205033223.GG3987@dragon>
References: <1543483679-1100-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543483679-1100-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_193311_084923_1EF1AD1C 
X-CRM114-Status: UNSURE (   8.38  )
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
Cc: gary.bisson@boundarydevices.com, linux-arm-kernel@lists.infradead.org,
 troy.kisky@boundarydevices.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 07:27:59AM -0200, Fabio Estevam wrote:
> In order to turn on the Wifi clock the correct location for describing
> the CLKO2 clock is via a mmc-pwrseq handle, so do it accordingly.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
