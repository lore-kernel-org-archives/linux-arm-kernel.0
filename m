Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A79C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:37:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E80206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GdXJSUHV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="kQbZxL4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E80206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BQe1CXEDCUNL6gmY/5GyOkMdGia6ib1A2q9amc4Wxsk=; b=GdXJSUHV8zHsml
	Zcedh8rXce3PF30+V0mA696ugVo6nt2VzRTrQ28g7YrDaw6eLtlrw+kXAxEPgbgOdWJd3q7yvjJW2
	KuiptLhWqUsuetJ/52AyZYxGHyPxs8eljp45ITAnVrMf41E4dwRG6WPIAySZ5lrgRVnhXnqbEgvP8
	2JnX/ABJK4c1ukv9ag6lz5zE7Y7X7kDZGTUUrR/43MriP1qQrnwGEEkTywimDj9faVa3nu1UbtLBW
	rBJDd7h/tEMm8xreEkGkCPheNTMkodWiIOsfaB10fdKt+Rn1/LLkN6DydF6JxjnLsHvcIWb1PR1JB
	5deVescTlygYrBtj8uWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUAtM-0002UG-QX; Tue, 04 Dec 2018 13:37:36 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUAtI-0002TW-4i
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 13:37:34 +0000
Received: from penelope.horms.nl (96-64-203-130-static.hfc.comcastbusiness.net
 [96.64.203.130])
 by kirsty.vergenet.net (Postfix) with ESMTPA id BABCA25B71D;
 Wed,  5 Dec 2018 00:37:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1543930637; bh=cQtNPCu/I+UcD4LoGC4EqNkutpechaiae81ZtPH/XTU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kQbZxL4QR5Ji0niVf5q8v1qHdpDcyjHSv2qjvxPV78wRe9aHPis9KFMix1skYp0r5
 2onm7RmK1hwrIQWaJAX95JrA8hXFeET1TlucBcNcn0Kba60HeG1n+707QLBg9AgTD8
 Xmqh4jMCtPxhCmiuXtvH4SGQxhSlnRNNwJpyxUg8=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id C64ADE217D1; Tue,  4 Dec 2018 05:37:14 -0800 (PST)
Date: Tue, 4 Dec 2018 05:37:14 -0800
From: Simon Horman <horms@verge.net.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.21
Message-ID: <20181204133710.quietvso7c7bblbv@verge.net.au>
References: <cover.1543409901.git.horms+renesas@verge.net.au>
 <20181130230826.5kjtfyq2wdr73iwl@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130230826.5kjtfyq2wdr73iwl@localhost>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_053732_833189_C0CD0D27 
X-CRM114-Status: GOOD (  26.03  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 03:08:26PM -0800, Olof Johansson wrote:
> On Wed, Nov 28, 2018 at 02:02:12PM +0100, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC DT updates for v4.21.
> > 
> > I am sending out this pull-request at this time as there are a number
> > of patches queued up in my arm (32) DT branch and I hope that this
> > will ease the burden later on in the development cycle. I expect to
> > send a follow-up pull-request for this branch at the usual pre-rc6 timing.
> > 
> > Changes since v1:
> > * Correct garbled Reviewed-by tag in
> >   "[PATCH 01/16] ARM: dts: r9a06g032: Add pinctrl node"
> > 
> > The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> > 
> >   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> > 
> > are available in the git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-dt-for-v4.21
> > 
> > for you to fetch changes up to 673df60a880f060e3e94920c7b5f7a9ed8aa65f2:
> >   ARM: dts: r9a06g032: Correct the GIC DT node name (2018-11-28 13:55:30 +0100)
> > 
> > ----------------------------------------------------------------
> > Renesas ARM Based SoC DT Updates for v4.21
> > 
> > * RZ/N1D (r9a06g032) SoC:
> >   - Correct GIC DT node name
> >   - Enable pin controller
> > 
> > * RZ/G1C (r8a77470) iWave g23S single board computer
> >   - Add QSPI flash support
> >   - Add pinctl support for EtherAVB
> >   - Enable CMT0 (Renesas R-Car Compare Match Timer)
> >   - Enable RWDT (Renesas Watchdog Timer)
> >   - Enable uSD and eMMC support
> > 
> > * RZ/G1C (r8a77470) SoC:
> >   - Describe USB-DMAC and I2C devices in DT
> > 
> > * R-Mobile A1 (r8a7740), Emma Mobile EV2 (emev2) and
> >   SH-Mobile AG5 (sh72a0) SoCs:
> >   - Include SoC name in DTSI
> > 
> > * R-Car H2 (r8a7790) based lager, and
> >   R-Car M2-W (r8a7791) based koelsch and porter boards:
> >   - Disable unconnected LVDS encoders
> 
> Hi,
> 
> If you revise a previous pull request, please do it as a new tag (and
> delete the old one so our pull will fail), or at least please reply to
> it so I see a "please don't pull this, I've respun a v2" threaded reply.
> 
> No harm done in this case, since you rewrote with the previous tag,
> but it made me scratch my head when I saw the previous one and the hash
> didn't match the email. ;)

Thanks Olof,

next time I'll create a new tag.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
