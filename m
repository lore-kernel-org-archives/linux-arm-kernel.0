Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C556C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:53:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9562054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WpnRWfYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9562054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wYsG9kcQV/WlRieLjNw8paHNPIHPKpzDl9437epEv8Q=; b=WpnRWfYc0HKXWg
	vxfgc2uKjOolDcTIEsZRIqu5RFphevj96CmPjKPCWeJXnV9sZ9coTIyO5ZPG5pPT1Ug9ygNzk4fON
	Uei61FTIFVxLzsXD9DIQhfe/cmfPGYQLBOkCtAXzuDfkQ286SGPOYKg0zwceK46Wj6Z8AA6CABSMy
	OignOb/1qmK62rc2epr667WU067ZNGypqA0HwotGBH+Lvsccgfx4EP2MYF8Gakh+qPKrqKifs+Ssp
	sLZ30dtQ7UwcyihaZQSsAPoKmu0O/vf2fiRpI4ZXA0oiF3jMLPU+h3IKo5RlOCxQ0Lc824+E9Z/2e
	68ZS9Wz0Od/zs+r5DLIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXbj6-0001J5-VN; Fri, 14 Dec 2018 00:53:12 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXbj2-0001HL-6H; Fri, 14 Dec 2018 00:53:09 +0000
X-UUID: a68450dd5630445e8730c001cbd621ca-20181214
X-UUID: a68450dd5630445e8730c001cbd621ca-20181214
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
 mailgw01.mediatek.com (envelope-from <miles.chen@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1323402994; Fri, 14 Dec 2018 08:52:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 08:52:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 08:52:35 +0800
Message-ID: <1544748756.29110.2.camel@mtkswgap22>
Subject: Re: [PATCH] arm64: kaslr: print PHYS_OFFSET in dump_kernel_offset()
From: Miles Chen <miles.chen@mediatek.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 14 Dec 2018 08:52:36 +0800
In-Reply-To: <CAKv+Gu_40M=JO+P3GOJogXfm=x0JXYjHs=rHWAtR-6QNxjSYvA@mail.gmail.com>
References: <1544612209-13660-1-git-send-email-miles.chen@mediatek.com>
 <20181213181317.GD18185@edgewater-inn.cambridge.arm.com>
 <CAKv+Gu_40M=JO+P3GOJogXfm=x0JXYjHs=rHWAtR-6QNxjSYvA@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 70A9EDF891D9D6D7AAFE0303FF6817EEDD6BB97A58C57E96600C0DDB7294ED932000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_165308_361617_E75B6040 
X-CRM114-Status: GOOD (  17.65  )
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
Cc: wsd_upstream@mediatek.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek
 SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2018-12-13 at 19:15 +0100, Ard Biesheuvel wrote:
> On Thu, 13 Dec 2018 at 19:12, Will Deacon <will.deacon@arm.com> wrote:
> >
> > [+Ard because I'll basically go with his preference on this one]
> >
> > On Wed, Dec 12, 2018 at 06:56:49PM +0800, Miles Chen wrote:
> > > When debug with kaslr, it is sometimes necessary to have PHYS_OFFSET to
> > > perform linear virtual address to physical address translation.
> > > Sometimes we're debugging with only few information such as a kernel log
> > > and a symbol file, print PHYS_OFFSET in dump_kernel_offset() for that case.
> > >
> > > Tested by:
> > > echo c > /proc/sysrq-trigger
> > > [   11.996161] SMP: stopping secondary CPUs
> > > [   11.996732] Kernel Offset: 0x2522200000 from 0xffffff8008000000
> > > [   11.996881] PHYS_OFFSET: 0xffffffeb40000000
> > >
> > > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > > Tested-by: Miles Chen <miles.chen@mediatek.com>
> 
> Fine with me, but I would like to see an ack from Miles Chen :-)

Can I ack my own patch?

Acked-by:Miles Chen <miles.chen@mediatek.com>
> 
> > > ---
> > >  arch/arm64/kernel/setup.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > index f4fc1e0544b7..4b0e1231625c 100644
> > > --- a/arch/arm64/kernel/setup.c
> > > +++ b/arch/arm64/kernel/setup.c
> > > @@ -388,6 +388,7 @@ static int dump_kernel_offset(struct notifier_block *self, unsigned long v,
> > >       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && offset > 0) {
> > >               pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
> > >                        offset, KIMAGE_VADDR);
> > > +             pr_emerg("PHYS_OFFSET: 0x%llx\n", PHYS_OFFSET);
> > >       } else {
> > >               pr_emerg("Kernel Offset: disabled\n");
> > >       }
> > > --
> > > 2.18.0
> > >



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
