Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1434DC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:02:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE07220851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WU5EqdEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE07220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k4clWfMGDJx7TLej8cd+r/Yrg/rKXAXJXbMvpIaN8oE=; b=WU5EqdEtPcOX/v
	XAmc/eczCEBmXXNMFl0oa3CqPscMpNzGh4s3UNb+fIrZSWNiRSR15UoYjaKrpIt/aj4ALSCSIdPLc
	RVaoKPpAguLxH3qU5cyujjFt/iP+CwB8+94JRq52BHq0o5d41zJHYXavBwFhQg6saxkKdFHuSnOgS
	OlPEIJ+sebVWs3q386BIAdRp2u0PmAXLRLMv9BjGHitUbWpL0ef6kjtvH04amqmiumYNlqFFnK+lC
	LFjYvZGCbzgTJ++H4eJOuIeNCXrW0RJxd2T6PodbqKCLnlDvJZPt+i3mof+4ycg+T/kyINnkGweEc
	jAWIPIFL5QeTJG/AOZlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXDWa-0007cO-W5; Wed, 12 Dec 2018 23:02:40 +0000
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXDWX-0007DS-5Q
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 23:02:39 +0000
Received: from darkstar.musicnaut.iki.fi (85-76-97-176-nat.elisa-mobile.fi
 [85.76.97.176])
 by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 9A046B0012;
 Thu, 13 Dec 2018 01:02:20 +0200 (EET)
Date: Thu, 13 Dec 2018 01:02:20 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap1 changes for v4.21
Message-ID: <20181212230220.GB5762@darkstar.musicnaut.iki.fi>
References: <pull-1544638322-89579@atomide.com>
 <20181212215917.yao2orsyr6qqagi2@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212215917.yao2orsyr6qqagi2@localhost>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_150237_374881_E471B620 
X-CRM114-Status: UNSURE (   6.88  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Dec 12, 2018 at 01:59:17PM -0800, Olof Johansson wrote:
> Cool, merged into next/soc now. Is the kernel about to outgrow these platforms
> due to binary size just slowly increasing over time, or is it still usable?

It's still very much usable. On currently actively tested OMAP1 boards
we have >= 32 MB RAM, and there hasn't been any issues. You might need
a custom kconfig however, depending on which board you are using.

On Nokia 770, the bootloader refuses > 2 MB kernel, so I'm using
chainloading (still with a modern kernel, but with minimized .config)
and kexec to boot a bigger kernel. But this has been going on for couple
of years already.

A.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
