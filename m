Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737FAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:13:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB48204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D+IOf7K4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH1vqpnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB48204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AGI5GCQlvQtRN4oO3THB5OsyTn33cFqHPBAjRTwymKs=; b=D+IOf7K49fm+1j
	AWycHP4Ne544j4wu+NwsFQxuiBFMZqsWesKX98COZ1AnN/S1KYTrKY8txfwDWrJUwGIcyobUynvr9
	ZDsGKhyaXfVm+HXuufF/ueckZS7y04v7GlqxDnYEzHRrMNxfr0OU2JnOwJSLCslR23JoWbcRMA4EV
	AwJTZ5ELdMQOyVQSII+gtnnB0UzKFfGB4t+F03N0n3EIFdU97Bldj8YmzUiosv9kPq5UKBYA8vSrr
	Ry44lYYUEwu4alwjQfYgMaOgq9HXohCAlzHNF2f1kB+MFLS4h+Wq0/dArPsDigeRNP/TReNJ4d/Dw
	5jDSkjXgeYdrcXco7cOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQP4-0000o6-Ko; Tue, 15 Jan 2019 15:13:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQP1-0000nb-JJ
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 15:13:21 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F058D204FD;
 Tue, 15 Jan 2019 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547565199;
 bh=Kn8ZXTa5Nz7EX2NWpPLtlirqIVUmk5Nw2RgTFr9vVwA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jH1vqpnHRg+Cou1aDdC9bjQmWBVe5Hjtfd+7n1rwUQ3ATT6gw+TqONesIaqMomDMU
 7wEiqx+cFbaHYZC1JMMjUTQ4ObAi9fPeCqiwfxLDKsn89yVuFsjggEbyzdGg1K7sQN
 mHfl4K+rhi2g+r2B3nw7Lv32OOFrfA0Tq6ji15Cw=
Date: Tue, 15 Jan 2019 23:12:52 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH V2] ARM: imx: add i.MX7ULP cpuidle support
Message-ID: <20190115151250.GC13895@dragon>
References: <1547185955-2395-1-git-send-email-Anson.Huang@nxp.com>
 <20190114005600.GN11426@dragon>
 <e892304bde543b86a9d0ad4409d0c6a1f509a312.camel@nxp.com>
 <20190116001043.69529b90@canb.auug.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116001043.69529b90@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_071319_661701_5CA12527 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: Anson Huang <anson.huang@nxp.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 12:10:43AM +1100, Stephen Rothwell wrote:
> Hi Leonard,
> 
> On Tue, 15 Jan 2019 12:30:23 +0000 Leonard Crestez <leonard.crestez@nxp.com> wrote:
> >
> > On 1/14/19 2:56 AM, Shawn Guo wrote:
> > > On Fri, Jan 11, 2019 at 05:57:30AM +0000, Anson Huang wrote:  
> > > > This patch adds cpuidle support for i.MX7ULP, 3 cpuidle
> > > > states supported as below:
> > > > 
> > > > 1. WFI, just ARM wfi;
> > > > 2. WAIT mode, mapped to SoC's partial stop mode #3;
> > > > 3. STOP mode, mapped to SoC's partial stop mode #1.
> > > > 
> > > > In WAIT mode, system clock and bus clock will be enabled;
> > > > In STOP mode, system clock and bus clock will be disabled.
> > > > 
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>  
> > > 
> > > Applied, thanks.
> > >   
> > 
> > Hello,
> > 
> > I'm not sure if anyone else already noticed but it seems the
> > arch/arm/mach-imx/cpuidle-imx7ulp.c file was dropped?
> > 
> > It's not in your tree:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/soc&id=cf2d2d392906f5603cf0d0f3630f6386babf7e4b
> > 
> > This causes build failures in next-20190115 with imx_v6_v7_defconfig.
> 
> That file does not exist in Linus' tree either.  And there are no
> commits in linux-next that add it.

Sorry.  That's my fault.  The patch doesn't apply to my tree and I had
to use 'patch' command.  However, I forgot to add this new
cpuidle-imx7ulp.c file.

Just fixed it.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
