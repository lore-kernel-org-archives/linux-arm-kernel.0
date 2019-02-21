Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B665C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:36:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705E320823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sLKfXdJv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLpn343p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705E320823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cTbEgGHtLrHtvBH62NMP7FUT/sYQeFilZszJmN7/qMk=; b=sLKfXdJvVum+4x
	0MMMCVKh4IMAuPzaW6ayrE46U3mOAVqbeEHhZAvHVeSTJXBhXKTh0L8oTn2wW/V07pd1+BHnAoQLL
	mldb1ljsaELWgoPDhuoinSac0QdB4mTAh0j88pk91Kr4AAsnJ864LjwYZtBVJ9qb3UGpcy03lJ9/A
	4UsD81vzAHbWlW2yBgTU+6D4I0q4Mc6cBuZK8nAOWgKbCFsI6b1jm757JQd5qEK170YuWuUWBu5V+
	ZWzNiVmdK/pUWGOnOlECHamPyP84N7aQFo4+JSxZmOL58j+YZDBX4cQQrbAdKdk826EbN6JWHciqf
	D9OGY9XRkmxt2uASMofA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwv5N-0007yK-IS; Thu, 21 Feb 2019 20:36:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwv5K-0007xy-4a
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 20:36:47 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E2D7A20823;
 Thu, 21 Feb 2019 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550781405;
 bh=UDXgWOt3EyyNrFSp7bznujcCcbGhkS8IIR7+H+YW4mQ=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=nLpn343pJOJ0J6VECJ3/NttPsBzAPne3tGsUxQ5RzCzH5fyCaAc81+65Yj2ZtVOcJ
 5hQwEA9PTJUoD6EfgXSX+pbTpDwSwztKcitnQFc+bWwztq1OLl7kNQ7jxfsi4K1jqh
 z5D0qh1yAUSvBLUiJM5kakRddONc6R9RebD81onc=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: imx8mq: Add support for the CLKO1 clock
Message-ID: <155078140414.77512.3157214123340597508@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190131002056.12024-1-festevam@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190131002056.12024-1-festevam@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Date: Thu, 21 Feb 2019 12:36:44 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_123646_219486_1B7728DC 
X-CRM114-Status: GOOD (  13.44  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>, Carlo Caione <ccaione@baylibre.com>,
 shawnguo@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Bai Ping <ping.bai@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Fabio Estevam (2019-01-30 16:20:56)
> Add the entry for the CLKO1 clock.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---

Applied to clk-next but I had to fix the whole DT binding number because
I don't know what this patch is based on. In fact, please get everyone
involved at NXP and whoever else is working on i.MX clk drivers to
coordinate somehow. I just spent 20 minutes working through the set of
imx patches in my inbox and I see approximately 6 different authors all
sending out a few clks at a time for the same drivers with zero
information about what the patches are based on or what order they're
supposed to be applied in.

If someone wants to collect all the patches and indicate on the list
they've picked them up and will be sending them as a pull request that's
fine. Otherwise, I recommend working together to post a coherent patch
series that adds the things that everyone wants or working from a stable
baseline like an rc tag and letting me figure out how to do the merging.
Either way, it looks like if I ever get a patch for imx clk drivers that
doesn't have a cover letter or is just adding a few clks here and there
I'll have to assume it's the same story as always and just toss them
into a clk-imx branch without a topic.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
