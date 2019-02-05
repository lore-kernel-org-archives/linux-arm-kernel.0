Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD964C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:12:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990E520844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tQtRnf2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990E520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=58bCB78pRpUeiyRAw0sZovNozOaD+4W9Z2Ew7tkxVHQ=; b=tQtRnf2Ltq4oPV
	vG/4H0kPIilpsI7KqNRqAZ+BQkQ5ILRUmgacFP6UmSNrn6Mfy50uUMpISCV2E7hOPMXU+LFdi/E+u
	GvYuLq00UYhFRrY/jjMSB+98IRNLD14nyL+qYhYyR3oyMtQ6ZfmVK43CN51Ppy7j/KAyzD36c40bB
	GAsE2RKfC1P06ppwE4ryeVnH42wuTjNgZVT36V1QQo2xD1M+x1R7MUKjz8HmSppM+QtUbFToMFcpJ
	Lrt3/RAMc1W5y1Zxff+gyW6E8B6JKUm1AF2RIAxrv8x6KpVrf2oUx8nb6cPqCkFn9A9MSmaOWYfh8
	m6DCusRBZi4XnLn8zeTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr3KM-0005FK-KM; Tue, 05 Feb 2019 16:12:02 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr3KI-0005Ex-Ts
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 16:12:00 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 99B53809C;
 Tue,  5 Feb 2019 16:12:05 +0000 (UTC)
Date: Tue, 5 Feb 2019 08:11:53 -0800
From: Tony Lindgren <tony@atomide.com>
To: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: Update for dropped options
Message-ID: <20190205161153.GR5720@atomide.com>
References: <20190204203747.7376-1-tony@atomide.com>
 <CAMuHMdXFF938VWh5F8016nJs4mE4m-xbU1kuqZuX1BFdtFejgw@mail.gmail.com>
 <20190205105801.3eysznz63x3na4ui@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190205105801.3eysznz63x3na4ui@verge.net.au>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_081158_996016_EF9608F6 
X-CRM114-Status: GOOD (  18.25  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 "open list:TI ETHERNET SWITCH DRIVER \(CPSW\)" <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Simon Horman <horms@verge.net.au> [190205 10:58]:
> On Tue, Feb 05, 2019 at 09:07:38AM +0100, Geert Uytterhoeven wrote:
> > Hi Tony,
> > 
> > On Mon, Feb 4, 2019 at 9:37 PM Tony Lindgren <tony@atomide.com> wrote:
> > > These are automatically selected with make multi_v7_defconfig,
> > > except for SH_DMAE which is selected only by sound/soc/sh/Kconfig.
> > >
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Cc: Olof Johansson <olof@lixom.net>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Simon Horman <horms+renesas@verge.net.au>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Thanks, this matches similar changes to shmobile_defconfig in commit
> > 4162325afd0d553c ("ARM: shmobile: defconfig: Refresh for v5.0-rc1")
> > in next.
> > 
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> > 
> > I didn't update multi_v7_defconfig to avoid conflicts.
> > IMHO the arm-soc maintainers should handle the refresh of the common
> > config on a regular basis[*].
> > 
> > [*] When is the right time? I'd say it should be the last commit just
> >     before the release of rc1 (so all arm-soc submaintainers' trees will
> >     have the new base in their for-next branches for the next merge
> >     window), but that may be difficult to implement.
> > 
> > What do you think? Thanks!

Yeah I agree we should do it on regular basis just before -rc1
for multi_v7_defconfig.

The reasoning being that make savedefconfig is pretty much useless
otherwise for generating defconfig patches and the chances of
pointless merge conflicts and errors keep increasing until
something breaks :)

I can attempt to do a late branch of the dropped and moved options
refreshed against arm-soc defconfig branch if that helps.

Regards,

Tony


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
