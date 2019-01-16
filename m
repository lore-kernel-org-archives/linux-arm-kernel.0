Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC88C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:26:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B2D20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dmzaa25y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRQie5cQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B2D20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kPDkgdmHqHihDM5qKKI+Ia2Q20+sXGiPcDvoPp6pjn4=; b=Dmzaa25ySt0J/z
	I0nKdHiHWNndnjJmDAoPESsOvw8+UI8MXxIyXcaocX3cZcBHDtOEP9+MSsD51JJ4e0FiFcf5IJtOG
	DtlKKhjOek4Qly4v18BuV5lLRaHTYhIT6Hw3XJHA0VHurUNTOwSXkCCXoLkifXwbBJwzkxQq6WK7d
	N2a3r4XjjtzfIUN/Ul4Z256m5JeP956H+0Jvn5Rrk4kUQmERIYe0LbZxcdvyuK+qBX0E0v/uu1bLu
	t9XuUBHDmj36nSThV3xbuMchfEP+pkka3wp/ZTk31rIzmEuZwtHvPQfZZLVzlm+VdBFDOuhJOwlmF
	8vkJoPaBLpWgbUOcKOXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjlD9-0002RP-Nh; Wed, 16 Jan 2019 13:26:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlD6-0002R0-Hb
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:26:25 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5BA3920651;
 Wed, 16 Jan 2019 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547645184;
 bh=opnxPWfcl8lROKcOERNn51KMVYIbbdUZt/fNQMzRB1c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lRQie5cQpLa3QXBPAm7bqOWcMmb7z6Gwx5uFZhP5mW3mzcMwscQk+/5EVfOXGuKq1
 KngOW/3YBc+RPPT9fRxnJV1ja3kF+2j5NlNNsX4jGZ0xxU5bV/GLQdZz7fYBfvT5Ol
 5hyoq5y5nwRnuLtng5LPx5eY6GSgBqmxbBqoh+pA=
Date: Wed, 16 Jan 2019 21:25:55 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: imx8qxp: Fix MU4_INT number
Message-ID: <20190116132554.GB17702@dragon>
References: <20190116132124.4383-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116132124.4383-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_052624_603642_BF1DBDB6 
X-CRM114-Status: UNSURE (   8.02  )
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
 Anson Huang <anson.huang@nxp.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 01:21:36PM +0000, Daniel Baluta wrote:
> MU4_INT correct number is 180, while 179 is for MU3_INT.
> 
> Fixes: 3d91ba65fec ("arm64: dts: imx: add imx8qxp support")
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
