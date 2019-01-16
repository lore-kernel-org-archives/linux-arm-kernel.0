Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543BAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:52:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D1320873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gyG5pShx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxhrLcXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D1320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QOwEH/qX5tRoW3QfCStR69WRj0LTPp0Wv20u421A2Fk=; b=gyG5pShxREidHI
	F49pAMk4YA3h6xpliItzQaSeCOOpirkZjAcvU01WxDWll8c8WDc5PrBiWdm31Wloct6hRz2S4x8md
	eRjDOc+4cTSUpbBNgzCnmlxkoLT2Ckf8s2oxINJDHiIpsBzQE6hKxBiTc40vUJDD1lQngz6AuOMPy
	Xmy527onM0VWzbUFtsnCq8B95oyGfAEzZvh3jK0usULJj52PdQUD3rTNIbsy5mHZLSP+PIx2Doute
	Jf7DDrrv2d4T09MyiLH196tT68OiI6UTucW1xaMBtbeknlsn2Dao1tMmXTd8fgAmPZQCYMcznOC/C
	mmiv9Z3AzhTvG2HIWkAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjinn-0006fo-Mi; Wed, 16 Jan 2019 10:52:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjink-0006fT-LA
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:52:05 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9234B206C2;
 Wed, 16 Jan 2019 10:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547635924;
 bh=+MIeS5cp+dF3O2DVVaY5LxQGGuWLcbMVGa6uazfjw/8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WxhrLcXULOQbBDaK56l106LOXYO7UXb3rDpsp1EsJbKO0SUkwX1WKmOKlYoq96/i0
 85hTcYvPNOde+sczgWu7DCJEfeF1vZWXQPiZxdxKlykQQVFZM8uhY/L7++uOsXpT/L
 E00w/yNpOOfllcVRS1NhrRAu7tXagRgQoJOsCZmk=
Date: Wed, 16 Jan 2019 18:51:39 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
Message-ID: <20190116105137.GL15808@dragon>
References: <20190115110446.19077-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115110446.19077-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_025204_717170_533F5C9A 
X-CRM114-Status: UNSURE (   8.40  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 12:04:45PM +0100, Lucas Stach wrote:
> The GPCv2 sits between most of the peripherals and the GIC and
> functions as a wakeup controller for the CPU cores.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied this one, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
