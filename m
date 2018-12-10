Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F154C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:35:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374E820672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mll5+i53";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6E2V11F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374E820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eU7S6NniHQXKfFtscCJxfKXZ1iQibrN3tbHE1Af4i9A=; b=Mll5+i53BAglE9
	Ed0jDZqfjIgWPNuHcTq8+iqk6S2W1d7iEF+fad9wa0PqMnvMmI7UkIzLx32zed6qPNVv43GOFqOVG
	0AJy1mOkUDeW/m6HbVGeERKc7GeZh7zuQdSGJUn3priIsdLUNbxfga5fYnNcpV5XTVS+ZdOBne2sg
	nVBEoZpK1PdKPX+OH52l7buwIPMNNtcKJulcgBHJM/YCcMHekSzkxQW6Yo0rd4nN09/YKR6r7Xq2y
	eEB6neYgsg7MKmnDcd694dSz9skW/O0fBo0gPOk974qpBhxCT3vxTrzEmzR7t27s9QY/HDSz+iAIa
	K/rQ/pesM1uVIrg/fU/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWRKv-0003Oc-Vq; Mon, 10 Dec 2018 19:35:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWRKc-0001os-Fz
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:35:23 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1BEEF20821;
 Mon, 10 Dec 2018 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544470496;
 bh=yeXlX/XZ7Cf3vKr9VT+19QjwSmppxiZce6jmBVjeYpY=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=t6E2V11Fyp3iwINPdNIeRdbSAt0oca4m3JAMCeO6R/8JuhHJEv/j9yiLTYevJ+WE0
 jemJOWTDaMYs9B11GyNvo+72Fuji2UQxEPGya2Dq9eIGqtEHQSADirVzBeD2ss2ats
 xSUB0DtMv5v/u0/uhsWjp15Zfmxu/j04YhJhQDck=
MIME-Version: 1.0
In-Reply-To: <1543559158-2891-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <154447049532.17204.8968924447056060225@swboyd.mtv.corp.google.com>
To: "clement.peron@devialet.com" <clement.peron@devialet.com>,
 "colin.didier@devialet.com" <colin.didier@devialet.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Anson Huang <anson.huang@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] clk: imx6q: add DCICx clocks gate
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1543559158-2891-1-git-send-email-Anson.Huang@nxp.com>
Date: Mon, 10 Dec 2018 11:34:55 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_113507_085506_7BE423C7 
X-CRM114-Status: UNSURE (   6.33  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Anson Huang (2018-11-29 22:31:40)
> On i.MX6QP/i.MX6Q/i.MX6DL, there are DCIC1/DCIC2 clocks
> gate in CCM_CCGR0 register, add them into clock tree for
> clock management.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
