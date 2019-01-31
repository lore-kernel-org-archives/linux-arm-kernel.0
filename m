Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F382C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:00:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D26D2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cOsxPl1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D26D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wy8gGGWq5v5zwvPi7nCuxyrUOXtbBskFBKijr5b2IJ4=; b=cOsxPl1Z91VZWx
	eRZPAsmcBN8pS5OtIlb07yC2lE23l3d4p6gWJPrJXLXVkktVbexacHcwGVOc+V778D5vcjW+VV9r3
	sO7p+bzTYRXI7PZQ35lsOaMeD2pb6soWvN+XqUcMjOsJf5Bi7YR0D7LfcHIEm54k0fFVjzbzkpDvc
	A0AuMGovk8dths0Qs3oBmduW+pRzTQ3SBE055m1b/+J7XvwvmJdqUTbhIhghMfOjEg7u9VwwLD4CV
	zBD7n+ZxHKtR8ZbCwFxiPNsDpOHdZszg/H10Z6MqGrqXPAMbV6qJKYuy9ddNlscKVZSyMPIJu12vg
	a68AMv2wvzWxluhxXX2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp7HM-00043T-O8; Thu, 31 Jan 2019 08:00:56 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp7HE-00042d-LZ
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 08:00:54 +0000
Received: by mail-qt1-f193.google.com with SMTP id y20so2455301qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 00:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wBNBDT1LiiLRanuMOG7grYKDhg9zCn26KY0jpTT73kI=;
 b=OhQMMGMzOwBh8KJsZWDBF5paHvhCt7f997VdME19Yh64C/oZi3o8phrdkfnfSYiRXl
 8vA3mVrmJup8g+aXVaeHU9UhEa0yxZ+xkqn8Cs9rT2bIF7eQiAByjv6BdsnI3RvsKwG/
 WT3QJhm5owOJbgIwxKQ1kUtnzNn0sAp/KNnKN+Ydnzfu0Kn6XG8zJ3O6tb5WPd46uo9x
 mdv0+UMFuPjvw+hdibiiPJKNpQuikUxrne9FRd8qtvEpch/l87FF3ZExLQJ83062jet2
 J1mkuaeJa/LCwH6Sdv2SVluoqXRJ7LAvjBl/9EBxxWSsR+kn8MpIUdPujJTS4oCiXAOC
 6oGw==
X-Gm-Message-State: AJcUukedFfmRJS5+n7ZiCeRbbnFOWIwLFgJaREMHvWrCZVsHouKS2DaW
 iv1KOrFEVkKvdjwv9OyQdpCwy02ZlieMbwi+HOA=
X-Google-Smtp-Source: ALg8bN6FefpahWBFSjDrFIrH4tu4OMDtIQmPbNKO7/+Ob/8mVyRl4d6H9o2RN5faLFkN8Pl1dLVtPiGfKkVinrA9smw=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr32585171qtr.319.1548921647369; 
 Thu, 31 Jan 2019 00:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
 <20190124115656.GA23362@e107981-ln.cambridge.arm.com>
 <47437c58-d7b3-f77c-7bc7-973373f1e78e@ncentric.com>
 <20190124162759.GA28871@e107981-ln.cambridge.arm.com>
 <CAK8P3a2ftPvdBnVacbGcxDpCW6CvBj3ZGBXuVQE46JocXewvgQ@mail.gmail.com>
 <20190130230604.GM229773@google.com>
In-Reply-To: <20190130230604.GM229773@google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 31 Jan 2019 09:00:30 +0100
Message-ID: <CAK8P3a3tLtCee6p38iXNp5Amktguucgb23UcQFF-Z8Vn8zTgZg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm: cns3xxx: fix writing to wrong PCI registers
 after alignment
To: Bjorn Helgaas <helgaas@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_000048_748493_8458FA74 
X-CRM114-Status: GOOD (  19.00  )
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

On Thu, Jan 31, 2019 at 12:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jan 30, 2019 at 11:08:04PM +0100, Arnd Bergmann wrote:
> > On Thu, Jan 24, 2019 at 5:29 PM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > On Thu, Jan 24, 2019 at 04:23:05PM +0100, Koen Vandeputte wrote:
> > > > On 24.01.19 12:56, Lorenzo Pieralisi wrote:
> > > > >On Mon, Jan 07, 2019 at 02:45:09PM +0100, Koen Vandeputte wrote:
> > > > Purely for my information:
> > > >
> > > > Testing on a lot of devices here shows a huge improvement towards stability.
> > > > Is it possible to get it merged sooner?
> > > > Does "queued for 5.1" also mean that backporting to stables only will happen
> > > > at 5.1_rc1 release?
> > >
> > > Yes, I will ask Bjorn if we can send them for one of the upcoming -rc*
> > > (so effectively you will get them in v5.0 and propagated to stable
> > > earlier), I do not think it is that urgent either though, let me handle
> > > that.
> >
> > We can take them through the soc tree if that's easier, but
> > going through Bjorn's tree is also fine.
>
> I have the following on my for-linus branch and I'll ask Linus to pull them
> this week, so they will appear in v5.0:
>
>   b8b592a3a8d1 ARM: cns3xxx: use actual size reads for PCIe
>   b3a32f359397 ARM: cns3xxx: fix writing to wrong PCI registers after alignment

Ok, thanks!

> Neither is currently marked for stable, but I'll add that if you like.

Yes, I think that would be good, along with

Acked-by: Arnd Bergmann <arnd@arndb.de>

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
