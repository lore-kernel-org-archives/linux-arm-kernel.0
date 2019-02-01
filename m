Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83892C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:23:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F15218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i0LSeqCr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G7brSxd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F15218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=++9IFXETdyc2fRLbBn8wNPhKx63im3gxQWu6qEftls8=; b=i0LSeqCrgoWZxe
	l/f5i46byuVBX9d1AzLEh2dMdwqTF/yNOwpF7pd2UuiiDbJA2GplwuAllbePEDy7nPDX9xRf84hDk
	qNB/5qbBPd7hiThrYrYTRp0wBr8FkGXrkiWwGZBu1rMzd+GKcr921uy9mPey4v4u64UMVCoEVAiz9
	mJbtoOuActQZqiHjrbMFBRTfNWweLxNs5TmvAFuUCsBhDWV9HV1tI4+l0zRlWZK8lyNI9vrblZAzt
	mSqLvI/FpJJ3qqmPPZtbS3D+UyGuZbI8ZX4u9SIWxIm7j3y36JPTpaCAHwKhUWUEeNM4Z1eNeF1i5
	77HEgLQoDgznvokCVlLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpaeo-0008O6-F2; Fri, 01 Feb 2019 15:23:06 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpaek-0008NG-9R
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vmNfR5piJKQZqeLblilTWDy2ED5oDQO6iZk9PGqFI74=; b=G7brSxd3X8bpJUM5v/sVpuWUo
 VJPJxXzEGuqndggdsOBCZBIq06AVmQB5c8URG8ZHeFHprhyYkVgb32t8HFGEPfaQcp6IDBHAyjmNE
 5IloeXB7JotkZHNmlUWPN5FKvDGgVkL02pFl5mWVBdaU+nZ8krBJoPkooIhgBDUPLbi8c=;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50792)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gpaeY-0007ND-Md; Fri, 01 Feb 2019 15:22:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gpaeW-0000sI-88; Fri, 01 Feb 2019 15:22:48 +0000
Date: Fri, 1 Feb 2019 15:22:48 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: 
Message-ID: <20190201152248.qqmeaosgo6j4ivto@e5254000004ec.dyn.armlinux.org.uk>
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
 <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
 <20190117112803.GC3710@rapoport-lnx>
 <CAFqt6zb-+hmF-zOrs-_J=m+YZO-R-VdwWKErYVHqtNcShk7sPA@mail.gmail.com>
 <10982a2f-8ff0-50f4-cdce-d028808d188f@arm.com>
 <CAFqt6zYE9Mv0Y+pfOtbOWeT5+AxPaJWB9_pkD5VO+pZVs-dF3w@mail.gmail.com>
 <001c1195-fe06-fc78-b8a9-ec96f44aef32@arm.com>
 <CAFqt6zae+8-TLaWEmgyLEVCbsy2cbeFg35SxH5r1kHYu6rrybw@mail.gmail.com>
 <20190201151511.ywwem3bd65n7n37e@e5254000004ec.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201151511.ywwem3bd65n7n37e@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_072302_334166_DAF3D312 
X-CRM114-Status: GOOD (  17.59  )
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
Cc: Vladimir Murzin <vladimir.murzin@arm.com>,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
 rppt@linux.vnet.ibm.com, Brajeswar Ghosh <brajeswar.linux@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 03:15:11PM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Feb 01, 2019 at 06:11:21PM +0530, Souptick Joarder wrote:
> > On Fri, Feb 1, 2019 at 6:06 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> > >
> > > On 2/1/19 12:32 PM, Souptick Joarder wrote:
> > > > On Thu, Jan 31, 2019 at 6:28 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> > > >>
> > > >> Hi Souptick,
> > > >>
> > > >> On 1/31/19 5:54 AM, Souptick Joarder wrote:
> > > >>> On Thu, Jan 17, 2019 at 4:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > >>>>
> > > >>>> On Thu, Jan 17, 2019 at 04:53:44PM +0530, Souptick Joarder wrote:
> > > >>>>> On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > > >>>>>>
> > > >>>>>> Remove duplicate headers which are included twice.
> > > >>>>>>
> > > >>>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > >>>>
> > > >>>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> > > >>>>
> > > >>>>> Any comment on this patch ?
> > > >>>
> > > >>> If no further comment, can we get this patch in queue for 5.1 ?
> > > >>
> > > >> I'd be nice to use proper tags in subject
> > > >> line. I'd suggest
> > > >>
> > > >> [PATCH] ARM: mm: Remove duplicate header
> > > >>
> > > >> but you can get some inspiration form
> > > >>
> > > >> git log --oneline --no-merges arch/arm/mm/
> > > >>
> > > >> In case you want to route it via ARM tree you need to drop it into
> > > >> Russell's patch system [1].
> > > >
> > > > How to drop it to Russell's patch system other than posting it to
> > > > mailing list ? I don't know.
> > >
> > > https://www.armlinux.org.uk/developer/patches/info.php
> > 
> > This link is not reachable.
> 
> In what way?  The site is certainly getting hits over ipv4 and ipv6.

Ah, I see - the site is accessible over IPv6 using port 80 only, but
port 443 is blocked.  Problem is, I can't test IPv6 from "outside",
so I rely on people *reporting* when things stop working.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
