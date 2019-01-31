Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEA4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:16:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92E620869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rd90Gb57";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq1lwA7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92E620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FQO1o9jeuH6imhEPoB0tYwZ/CirSjEyPAbwmBchEcwU=; b=rd90Gb57EZVw5A
	U+t8BYf6PPNMJ+ai+WALsKpQK0iDf1KPMH3BCbwGbcCxHiSVwulasl828egXozpPm6U2zTLcVhclq
	ZsBVdgebZziGFFaRKEWfKxDdRdwf7ThuguiZHfj1MKOumn0gZWjWkJrLyXi1BApE1k+f1SnH1R2i0
	vxLfLJVVRv2OL9siamKgFWG82KOscdI2+jtE29Dx36VoeuOyT6vV+M85qGqBD5GJcwOZTGsRJ56Uv
	dfgTsd2k2z6i/lXsjUesIbY/q55SIdjP5IDCDAGXK+Gn2lGWkTHdwTa9XqLChbttZ8B0M/x+fNf5I
	u1P6lwalhjvkNRTkEA8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpJhO-0007XR-KU; Thu, 31 Jan 2019 21:16:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpJhI-0007Wc-4e
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 21:16:36 +0000
Received: from localhost (unknown [64.22.249.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 53F6A20869;
 Thu, 31 Jan 2019 21:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548969391;
 bh=jzfhq+lSjx8bHSJViXbezFk2cruXD6qur/HQy+p+k08=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qq1lwA7/rv/dH8gS71OKn7mLY3mDDUZ70jpkLNP4TXp1PmlswVNFAXKbDbciQEYkb
 Z2jlCCQVyLOdw3D6uNgQvewj9rB/I+hx4GOWImfomJTnAsxEu4CVvUrSD0TEj2tKla
 X/2WaCWiFj4KSqtKVf8VTYm44iMPzpyRsDDRw+TI=
Date: Thu, 31 Jan 2019 15:16:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/2] arm: cns3xxx: fix writing to wrong PCI registers
 after alignment
Message-ID: <20190131211629.GO229773@google.com>
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
 <20190124115656.GA23362@e107981-ln.cambridge.arm.com>
 <47437c58-d7b3-f77c-7bc7-973373f1e78e@ncentric.com>
 <20190124162759.GA28871@e107981-ln.cambridge.arm.com>
 <CAK8P3a2ftPvdBnVacbGcxDpCW6CvBj3ZGBXuVQE46JocXewvgQ@mail.gmail.com>
 <20190130230604.GM229773@google.com>
 <CAK8P3a3tLtCee6p38iXNp5Amktguucgb23UcQFF-Z8Vn8zTgZg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a3tLtCee6p38iXNp5Amktguucgb23UcQFF-Z8Vn8zTgZg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_131632_208915_D5C0ED37 
X-CRM114-Status: GOOD (  23.07  )
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
Cc: Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
 "# 3.4.x" <stable@vger.kernel.org>, Robin Leblon <robin.leblon@ncentric.com>,
 Koen Vandeputte <koen.vandeputte@ncentric.com>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 09:00:30AM +0100, Arnd Bergmann wrote:
> On Thu, Jan 31, 2019 at 12:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Jan 30, 2019 at 11:08:04PM +0100, Arnd Bergmann wrote:
> > > On Thu, Jan 24, 2019 at 5:29 PM Lorenzo Pieralisi
> > > <lorenzo.pieralisi@arm.com> wrote:
> > > > On Thu, Jan 24, 2019 at 04:23:05PM +0100, Koen Vandeputte wrote:
> > > > > On 24.01.19 12:56, Lorenzo Pieralisi wrote:
> > > > > >On Mon, Jan 07, 2019 at 02:45:09PM +0100, Koen Vandeputte wrote:
> > > > > Purely for my information:
> > > > >
> > > > > Testing on a lot of devices here shows a huge improvement towards stability.
> > > > > Is it possible to get it merged sooner?
> > > > > Does "queued for 5.1" also mean that backporting to stables only will happen
> > > > > at 5.1_rc1 release?
> > > >
> > > > Yes, I will ask Bjorn if we can send them for one of the upcoming -rc*
> > > > (so effectively you will get them in v5.0 and propagated to stable
> > > > earlier), I do not think it is that urgent either though, let me handle
> > > > that.
> > >
> > > We can take them through the soc tree if that's easier, but
> > > going through Bjorn's tree is also fine.
> >
> > I have the following on my for-linus branch and I'll ask Linus to pull them
> > this week, so they will appear in v5.0:
> >
> >   b8b592a3a8d1 ARM: cns3xxx: use actual size reads for PCIe
> >   b3a32f359397 ARM: cns3xxx: fix writing to wrong PCI registers after alignment
> 
> Ok, thanks!
> 
> > Neither is currently marked for stable, but I'll add that if you like.
> 
> Yes, I think that would be good, along with
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Added, thanks!

Actually I was mistaken: the "use actual size reads" patch *was* marked for
stable, but the "fix writing" one was not.  I suspect this was intended to
be the other way around because AFAIK the "fix writing" patch fixes
problems and it makes sense to put it in stable, while the "use actual size
reads" patch is more of a cleanup and I don't think there's a benefit to
putting *it* in stable.

So I added your ack to both and marked only the "fix writing" patch for stable.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
