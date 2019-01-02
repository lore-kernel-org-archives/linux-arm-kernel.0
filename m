Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A312C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:41:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057532080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="suWOPG05";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNLaQ4Ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057532080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3ZKDwWg0Or5Wc4ufK9PkZdR0Oc9YoPNZp4GxOPRLS5A=; b=suWOPG05VOaCug
	/7RW4T8s38fqPSiDBdXB7zzlzavw085WJH/zVFEuY3oXbv1cmc7BlQnVNPL2i0u7ALMkgs9BFNXyb
	TKhJRKFcG8o1RtKfNGajS2cABBITVQqKC3aKWVzmb9j8+q999qpycf+xFYWOeZ7HYrbBr/vlBHNC/
	rs4XRnTasXBpXKrZKxieF/4MPwL8x0PcG0yby4ZU1C6YIQyuF+D08wCOJyS02GQCULBsfp9m7tmGX
	9SZCDqJorslBaYlIQfo6KhC5MQ8hNOvbAVluViG4q/dwfGNZGeDjyL47yIzEAVDmIgZev4J2541Gd
	iqS4PABYbGjoe1DpbFQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geUbO-0005UU-56; Wed, 02 Jan 2019 00:41:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geUbK-0005UA-FS
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 00:41:39 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 87C9A2080A;
 Wed,  2 Jan 2019 00:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546389696;
 bh=PoU6cMoIU1fgEwIKz1kZlYFZx9FWqx5V6DdIPomWo+Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NNLaQ4UieS/2NLGkq7nWKtfcELZlIWJz9kT/JWuic1QvMzEiuAPOx29KFsC/IEFRv
 lfJrZAAsqxNi1bKF94WfPym5bsc4xSzdOygcqU4X1kqS8OkZt1ybibLINbRhJZCHdG
 mbU5+KEx6SPRMa2e2wlWLjLJvtKm3EBv01CZmN40=
Date: Wed, 2 Jan 2019 08:39:52 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] i.MX8MQ device tree support for 4.21
Message-ID: <20190102003951.GA12098@dragon>
References: <20181217133036.GA24973@dragon>
 <20181231210841.sg3vqzs6dujvnaz3@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181231210841.sg3vqzs6dujvnaz3@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190101_164138_535561_DCED82F1 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, arm@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 01:08:41PM -0800, Olof Johansson wrote:
> On Mon, Dec 17, 2018 at 09:30:37PM +0800, Shawn Guo wrote:
> > Hi,
> > 
> > It's the initial device tree support for the first ARM64 i.MX processor,
> > which has been floating around for a couple of release cycles.  Due to
> > the last minute discussion on fine-grind SoC specific option, it comes
> > late.  But we appreciate that you consider to pull it for 4.21, as we
> > have more development lined up based on this initial support.  Thanks.
> > 
> > Note: the pull request is based on tag imx-dt64-4.21 (already pulled)
> > with one stable commit from clk tree merged in to resolve dependency on
> > i.MX8MQ clock ID.
> 
> I've queued this up as a next/late branch, and will try to send it in before
> end of the merge window. It's been a quiet merge window so far, but there are
> no hard guarantees that we'll get it merged.

Noted.  Thanks, Olof.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
