Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE367C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:34:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B02320873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K11hf+WX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4DLA66O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B02320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W5H9ZTQPVt+AkXxs9oIi98aQD2x+7s4DlehtIc+3WTY=; b=K11hf+WXZbR5n6
	FAIqcT3qw6S2nawxJrxGs43TlrfI2ZkMh/nzFS+K76NiIx6LLsL8WsAU2ijY6vUV/4kIfjwHbDXCR
	2FePZ6e1EDSo5GRyyN0EKWD2bjkfmIY+P9lNwLFCXwKjeZ5e1H1eXR8/Y94m/l5tVAVVsXo2KEGFp
	LedYUy6ac0XvEhndt8SMjQA6HhUY1l8QutAJuUicLDVFFTFWSDeeqPeodDbANk4m5xdZFPhhxzznL
	3AZk0Kj+ii7PpcDjTk+sVep9DOQ98Q5EvxO/TOhYi4+jsWBhejZANP94UNMSZFGs7fguFxKM6m1Qh
	+ikTMDNEtnUqeU4DUsDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt1QL-0003mB-KY; Mon, 11 Feb 2019 02:34:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt1QI-0003lf-JN
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 02:34:19 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 756712083B;
 Mon, 11 Feb 2019 02:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549852457;
 bh=+5NT8/ehb27GV66nA+iPvLZOLl6sBksGOXOWY5/i8O4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l4DLA66Oqtartvj8JiOwaS+yjPOFnRGQqQENaqScTPzWsqbSy8bEQUVhlEpmSiiqQ
 Me55djeOfybQ/quurX7bnheXDm4wO3eNf/81LQeodrNZeQSZ5Slj8e1RVZrX3Vn1Fj
 hl39hzC14De4revLfXpR6b/Z6pgcPtFjDU0ia+aM=
Date: Mon, 11 Feb 2019 10:34:07 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6qdl-phytec-pfla02: add missing
 interrupt-controller property
Message-ID: <20190211023405.GF22487@dragon>
References: <20190204133333.13338-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190204133333.13338-1-m.felsch@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_183418_657175_378440F5 
X-CRM114-Status: UNSURE (   8.08  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, c.hemp@phytec.de, fabio.estevam@nxp.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 04, 2019 at 02:33:33PM +0100, Marco Felsch wrote:
> The DA9063 device need the required "interrupt-controller" property as
> documented by the bindings [1].
> 
> [1] Documentation/devicetree/bindings/mfd/da9063.txt
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
