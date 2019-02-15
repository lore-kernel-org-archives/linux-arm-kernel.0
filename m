Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D09C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:25:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AEC21929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rrnGRNS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AEC21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nnb6I9musnqg2TGkMfLicjFj9+yqaUSgn/RWGDqdCr4=; b=rrnGRNS3adubOk
	oYJsUUMDxFkf9zsG/kOlmfEiUsjD6vfzsJRzhEU538B1nfAI8jYSQzU3uQTneGxLMaNKSrnaYbCrS
	WqpfXXCWqqVnrGv6ASYixMuQSFhijloqgrAZFD5pMAMS5aVUUp4UcFUjsfs/rHebkKHxu/PqzKd7t
	wEjIDjnrYx2AIhhpZ2blGWWx+uz+lZrILfkitYXmx1p8sqdPRk0hjdA0Iv5tK/C9gLHVVjeJjEm6G
	+w+DpIGM+GnKqB9ovcPny10IMRkUFx4O8S8d4nfnc6x3KHNDQzdTy50QdNuQJ0l/U02xpa8iNgxzX
	DL2FB4GFu49E+pcq+I7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guhEd-0000Xv-4z; Fri, 15 Feb 2019 17:25:11 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhEZ-00008h-IY
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:25:09 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 56EFC80C0;
 Fri, 15 Feb 2019 17:25:16 +0000 (UTC)
Date: Fri, 15 Feb 2019 09:25:03 -0800
From: Tony Lindgren <tony@atomide.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/2] more dts changes for omaps for v5.1
Message-ID: <20190215172503.GL5720@atomide.com>
References: <pull-1550167958-188990@atomide.com>
 <pull-1550167958-188990@atomide.com-2>
 <CAK8P3a0y5FYYOvqPqhDSmR1Jxgx3AJzHtEkuku+_s-1vV_a8Lg@mail.gmail.com>
 <CAK8P3a0kZhJppsFzaTZL+PVCDP8BHwiquF6et3=i6MwA8YNpAg@mail.gmail.com>
 <20190215154742.GJ5720@atomide.com>
 <CAK8P3a03C15BJY4Z884-suceVZYO=kAzzLbjMUQukQV+xDvJWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a03C15BJY4Z884-suceVZYO=kAzzLbjMUQukQV+xDvJWQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_092507_665461_A7C2C425 
X-CRM114-Status: UNSURE (   9.65  )
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [190215 17:23]:
> On Fri, Feb 15, 2019 at 4:47 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Arnd Bergmann <arnd@arndb.de> [190215 15:44]:
> > > On Fri, Feb 15, 2019 at 4:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > During routine checks, I came across these gta04 warnings:
> > >
> > > ../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
> > > (graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
> > > node unit address error, expected "0"
> > > ../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
> > > (graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
> > > node unit address error, expected "0"
> > > ../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
> > > (graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
> > > node unit address error, expected "0"
> > > ../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
> > > (graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
> > > node unit address error, expected "0"
> > >
> > > Can you have a look and send a fix?
> >
> > Hmm sounds like that's because the branch is based on v5.0-rc1
> > that is still missing already merged commit 5b90df44fd9b
> > ("ARM: dts: omap3-gta04: Fix graph_port warning").
> 
> Ok, got it. Everything's fine then, sorry for my confusion.

OK good to hear thanks,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
