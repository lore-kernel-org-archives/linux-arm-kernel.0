Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F753C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55E520879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HSbxGg+a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zBDqUh0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55E520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c/vkmjDXOAz4ns05GCZ8g/PKA4ujNc7vv5qONHWbMw4=; b=HSbxGg+a4r2vvF
	/kxy4xYWEFu+R4Q5v7xJtJtRUO2BvllQZJ67YOhAxaBSxy+5Vg1nuUhrqPZtjVKshbcU5XX6a5q7S
	UQJvQ8aDNsuZe4ZBX0YUefE2rp8u/xZfO/mpK7zzmHq7j7Rfp6JFdGaIhordH+HlNd2GbVu4HESDL
	+dMEM8bOwxOmxjwEPLZbY0wTgoGWEEf7nwHdL9auvfmL1ko+TAyQPj6iN99D4z+ivUC+BWfWu9ZD2
	pNpybk9LGkrLy/GkZGfJom2qKE02eXoc34U9MrkQt32oyV4liGQTOE9mWeTBet+/iD+zzm0ba1L5M
	mGTFD4SkMxyBNySFvV8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giWpx-0005XJ-FT; Sun, 13 Jan 2019 03:53:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giWpu-0005X1-JC
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 03:53:23 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 45D592086C;
 Sun, 13 Jan 2019 03:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547351602;
 bh=K/wC+6KBvxN0YWMJdJBBZvGzbkZbo9M3BRgy9NEwbFc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zBDqUh0sk0wTSr6o7Gc90y7eu6mJ+Hyz+Cl0gEVdX32MCxZcMGusAiD8NmJ7AU3dM
 Ke/uGc+xhpOV9HT/noRt8EM+YxxPcgyxmiNq4RR8VmcDwXKADvrLB7iMHkZli1QR08
 WG4zPfPDnIYh5J3nQsc28MkbV3mdjEx8eielohnI=
Date: Sun, 13 Jan 2019 11:53:06 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] MAINTAINERS: add all files matching "imx" and "mxs"
 to the IMX entry
Message-ID: <20190113035304.GK11426@dragon>
References: <20190107195908.3298-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190107195908.3298-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_195322_649122_25BCD200 
X-CRM114-Status: UNSURE (   8.71  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>,
 kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 08:59:08PM +0100, Uwe Kleine-K=F6nig wrote:
> This way also the spi, i2c and other drivers are covered. There are some
> x86 specific chips in media/i2c that include imx in their name which
> don't have anything to do with the NXP platforms and so are explicitly
> excluded.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
