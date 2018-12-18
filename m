Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56093C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:56:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2582C217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i036yaR9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="CdPnfuYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2582C217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J8Rp9HRaBeensbHgecj7JNFLUdMSaDLkPiLCGctd41o=; b=i036yaR9wocdmT
	wSDqbhIn0l04nzQlr3pR7Pe8s1R5W8BLcfsmNKFidUSjpe8QU5AfaO051Eht2vKnZCFvYb+XymxH9
	aJj8hrni0FYHYLxx59S3y5B5+y7F/IZHV/HBEb7g4/k161/V3CfrHaGv+CU4pOVJYyXYyE4/X55gk
	/hMHHLYngRe+wA5hOy5DRKobe+hhrlxkdnJJvJT2yDrG63BlE8Z+1Lf5ctztx2xmePnUARz/Njuv7
	6INETzAtEN5Oy0j+HAjQlcL2NeEujKdmJUjO4pvU4iUYAGP5hqVz8WEdW0YbYawOD/8KmijDltgrI
	hbOJJkXiz/xS9gHE1orQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZD2l-0000JV-Fs; Tue, 18 Dec 2018 10:56:07 +0000
Received: from rere.qmqm.pl ([91.227.64.183])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZD2U-0007td-An
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:55:52 +0000
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 43Jvz42wWdz1f;
 Tue, 18 Dec 2018 11:54:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1545130449; bh=aTbPfe/TGM5rBaOy067UU2nhfMhktctmcjT1UlxMoh8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CdPnfuYcqyy+ueAc1a4DKA61A0nSX3kBdTB+IOGqmVWHJoEhRrUirsMVl2YCgOaro
 TPxiXvCFGnTSC3N/4bPjgu86TwvMolQo9kavK7LFAoeKIoOIIDEKiKSYiZdM9CiXYm
 1NhFf6NcPn4eWZjIejZmBgxPHCpMfny9gPiMYcLrvZuJYUIUYBLWrsxNV7ly4lnJix
 WeLd6NW6/KB2ah44L858hr2i9LW7NCwWYeVEylb3fEKlzqFBoyGCDnFIlZ5GmjOsyl
 Fiey6pz8OpFQoBTM0g2SdTv1cZs+Hp/MEmiHHXaOWb1YdQu5Oz43Zk+t1E6UmXFjI8
 eV8Rwgh6B8Yog==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date: Tue, 18 Dec 2018 11:55:33 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: at91: optimize clk_round_rate() for AUDIO_PLL
Message-ID: <20181218105533.GA3362@qmqm.qmqm.pl>
References: <772b3869cc992d894d8c1b4296f21100bcbed30d.1545075103.git.mirq-linux@rere.qmqm.pl>
 <154508897026.19322.14961293619238289668@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154508897026.19322.14961293619238289668@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_025550_897282_70A628EE 
X-CRM114-Status: UNSURE (   6.62  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 03:22:50PM -0800, Stephen Boyd wrote:
> Quoting Micha=B3 Miros=B3aw (2018-12-17 11:37:05)
> > This makes for 3 clk_round_rate() calls instead of 64 of them on
> > SAMA5D2-based board when searching for 12.288MHz clock.
> Ok, but is that better? Worse? Can you more clearly describe what you're
> doing here? And it's not breaking some other corner case?
> > =

> > Signed-off-by: Micha\u0142 Miros\u0142aw <mirq-linux@rere.qmqm.pl>
> This got all broken. Something on your end?
[...]

linux-clk archives got it right:

https://lore.kernel.org/linux-clk/772b3869cc992d894d8c1b4296f21100bcbed30d.=
1545075103.git.mirq-linux@rere.qmqm.pl/T/#u

Best Regards,
Micha=B3=A0Miros=B3aw

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
