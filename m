Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A652C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:45:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EA82084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pDm2rvgw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8p/oGy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EA82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l3VKyQWDUlI5qNWk9cHB6BC8ShyvQ75usk8ZU5fqYGE=; b=pDm2rvgwNkxZY6
	GvPABcU5ujYINqGJl4g1jzpUMikQ7FCE3ttD8mdyrZ5F5XlO7clLckGycrPcDpuAOGSm9K5eMuFT4
	z6GOkyOrPbXi3VfMba4A2taKey2KTcnkE5E3AlBM6nAilG996PB2PSgCGZnYuABytd06HCIGbkZmH
	TIiPj+cLnbGWRnhS8vMiWC4Q2w1rbWfKsdMhiKvDyHxtMTUSIZ7trpmBydggYsmu0KJ9K5kAumbH8
	EjDjczKjlorvyJej55CUiLV8A+W+AHywImP+6rrwTBEIPrglv4T58cK9rjk31D+2bTazz8TDO0H7S
	e4bc4mLWiEffdWSY2p1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYR72-0002ef-Ku; Sun, 16 Dec 2018 07:45:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYR6z-0002AS-1r
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 07:45:18 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A5FB42084D;
 Sun, 16 Dec 2018 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544946306;
 bh=TWR85vNrMu4M6q7j3Qiy4mDxLIIpdTZdIDobq82MKQk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I8p/oGy5Cdi5axYsxzLyz5tjoBH9Ix+Xew+6OllIzAudVRS9wAq+nlUPlW5L2z6Lm
 rjyKBxBW9JHevK8AmK44PUGFNXzmZnXnqROzLkM12EN6CZo507PH0nFLnxIf8lAEsr
 Ifl/KHXVMsgzq/tZlPcb0xMmS4XFpKpay8sWPpwQ=
Date: Sun, 16 Dec 2018 15:43:57 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [PATCH 3/3] arm64: dts: ls1046a: add qdma device tree nodes
Message-ID: <20181216074354.GG13243@dragon>
References: <20181206111823.45985-1-peng.ma@nxp.com>
 <20181206111823.45985-3-peng.ma@nxp.com>
 <VI1PR04MB44313466C33A7BAD7167D4EEEDA10@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <VI1PR04MB44313466C33A7BAD7167D4EEEDA10@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_234517_113901_98AC8CD8 
X-CRM114-Status: UNSURE (   9.32  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Wen He <wen.he_1@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 10:30:15AM +0000, Peng Ma wrote:
> Hi shawnguo,
> 
> I send this series patch to http://patchwork.ozlabs.org/project/devicetree-bindings/list/
> But I did not find patchs on devicetree patchwork, could I send patchs again.

You do not need to.  I have sent the series for 4.21 inclusion.  I
forgot to reply and let you know.  Sorry.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
