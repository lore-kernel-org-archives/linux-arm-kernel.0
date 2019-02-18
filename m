Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C33C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:15:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55AF21901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hjy6Gkja";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="JzBb+s0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55AF21901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BS47RLxtuRDnjXFWtj6gsPb1z54jWkep8YzLICuBOcc=; b=hjy6Gkja1dFZgI
	ds4bacIqKbVK2oxYxi3WXWzU1OvOYFZkfiUmdmbevM1aHZE3vj8PevJSVIX22MeCJH1DGbUKZrkh5
	sT6Zo2wGsI36SpGBN8IsWmA5tbYOGf6eKiA674Cpw7WtNatStEu9eCx0pVEGv5a69FiyBvr+xMmfn
	nwwi3YUthoulQ2JKfazatu2Pbn1arLKCOtYmzaOBXXP3qKykk598YnAwf8szdLWmKXoHt+Ts88EoX
	9STlPZwKek2rtKRST93lGsyxYGBHN3xBSON0f6WZGDBuDK2zvZVehbLmJuW5llQcXkX528m0yogGx
	8+YeolOFQxOtGmOJqSEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjhW-0005hF-S4; Mon, 18 Feb 2019 14:15:18 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjhP-0005gE-RK
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:15:17 +0000
Received: from penelope.horms.nl (176-142-25-88.abo.bbox.fr [176.142.25.88])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 13E0025B740;
 Tue, 19 Feb 2019 01:15:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1550499309; bh=qkutETDZHUL1DLNiZ6cBUucYfY+T06CmND1M303xshA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JzBb+s0kWGFZO2Trf8+jPMAfddKeqQlOZz8B6BQ778Oz8c/chTpmpehMqy5pXY9sN
 T6FrqYzOe2pns2R0oc7l+I7NaFY//0DlsITZ+Wv41WHNH0Jf+oEDWi3ZN/o5Cj5R4+
 OCdx3JQpZcZD4Hr06u40v66HrMvkMNIkGeLIsRWM=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 0D666E218D3; Mon, 18 Feb 2019 15:15:05 +0100 (CET)
Date: Mon, 18 Feb 2019 15:15:05 +0100
From: Simon Horman <horms@verge.net.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Renesas ARM Based SoC Updates for v5.1
Message-ID: <20190218141417.7n6q5petp5oepd55@verge.net.au>
References: <cover.1549622472.git.horms+renesas@verge.net.au>
 <CAK8P3a0prd-4eyVOVUpp2Bhn1mGOVZwA_we79TNjSa4FF5DP6A@mail.gmail.com>
 <20190218112715.zufzr3knrhs37t6h@verge.net.au>
 <CAK8P3a1BrahyfrRD=1dSLNzc1mujh+rxdLoU8CtGruRSbo3JVg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a1BrahyfrRD=1dSLNzc1mujh+rxdLoU8CtGruRSbo3JVg@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_061512_108986_18A93FEF 
X-CRM114-Status: GOOD (  16.17  )
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 stable <stable@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 02:12:07PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 18, 2019 at 12:27 PM Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Feb 15, 2019 at 05:49:32PM +0100, Arnd Bergmann wrote:
> > > On Fri, Feb 8, 2019 at 12:14 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> > > > Renesas ARM Based SoC Updates for v5.1
> > > >
> > > > * Correct shared IRQ handling of R-Car Gen2 Regulator quirk
> > > > * Add missing dts files to MAINTAINERS
> > >
> > > Should the bugfix be marked Cc:stable and and Fixes:... ?
> > >
> > Sorry for missing that, I think that the bugfix should have had the following.
> > Let me know if/how you want to handle updating the patch's changelog.
> >
> > Fixes: 6d14d4d313d09dab ("ARM: shmobile: Rework the PMIC IRQ line quirk")
> 
> I think the easiest way is to send an email to stable@kernel.org asking for
> a backport of commit 5347a0203709 ("ARM: shmobile: Fix R-Car Gen2 regulator
> quirk") after that has hit the mainline kernel and asking for a backport.
> 
> I've added it to Cc here, but I don't know if that's sufficient.
> 
> If you'd rather have me pick up the patch for 5.0 as well, I can also do
> that and add the Cc/Fixes lines there. We will then have a duplicate
> commit in 5.1, but it should not cause any merge issues.

Thanks Arnd,

I'm happy to handle this via stable and avoid the duplicate.
If I don't hear back from them in a few days I'll make a formal
submission there.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
