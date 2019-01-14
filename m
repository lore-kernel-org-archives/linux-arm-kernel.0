Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1B5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:20:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C2A20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HPDAMP7D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHmbvrey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C2A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B4oybijkcszav7bczRgfXe2YA+K2ZveunpkIbY/RDUg=; b=HPDAMP7DNumi5j
	5LJgHHxVmjG/8TseUDPXW82LhOFmt3YHl2ihYLWa4E49ff8EXiElMkjnzyE95fJltxfAgJIx/KC1j
	daFwvSEZHv+VeL3ZoxTzB0znTuaYSEuZ6jq/cYiofGkLoY5dkg3ea3VrNEnq2D2eHmtOpXJhbLkao
	AeZumcHDmMV8ndov3tP9hshD0WndWn1lJfIC2Od0+ajIevMWNSYMxgSCjZ3k9rLIwcR/db0gXp2wA
	Fhx1aRocTaHLz74OkoPjx5zrhUWA7vqD0Ki521jXNCYnkn8Vc9vfL2dOV6Sl3Z39T0q2p2Z8WO8WA
	Hqs6x+nmagaRGJkp0uMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giqvT-0002AC-Bh; Mon, 14 Jan 2019 01:20:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giqvQ-00029u-4x
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 01:20:25 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E09EA206DD;
 Mon, 14 Jan 2019 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547428823;
 bh=2VE+Yd1rBpkVyREtFc1hKs8iO1zLBl/Emf4wCwd4tkk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uHmbvreywgxuzUTIiMpPQnU2unFnn/H1iZaCteGhM9t8tGG5AxHsIqKV/Nn5Wr2lm
 eOL17VaAAf5d3Oxtyfv902cTB8NPOrUBWSU4QHUNJN2nuRv5mFGNCk3/zHnk2KKzde
 1n+VBA0ORV2I7W2cM8XJqB6/irQNB3rO7GzJInYg=
Date: Mon, 14 Jan 2019 09:19:58 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V6 1/4] dt-bindings: arm: imx: add imx8qxp mek support
Message-ID: <20190114011956.GA15371@dragon>
References: <1547206279-26169-1-git-send-email-aisheng.dong@nxp.com>
 <1547206279-26169-2-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547206279-26169-2-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_172024_208522_A97285FC 
X-CRM114-Status: UNSURE (   8.23  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 11:37:24AM +0000, Aisheng Dong wrote:
> i.MX 8QuadXPlus is a quad (4x) Cortex-A35 proccessor with powerful
> graphic and multimedia features.
> This patch adds imx8qxp mek board support.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
