Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BDEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:25:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF59E2075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L77JtBBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF59E2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zb1GzhUztZ2G6B5wpKptuhJerYy9lDb1+2Q1aLgnR2s=; b=L77JtBBUMY5Djb
	tYDet5XczGIUAg/4d+KgeNG8A+8WL27D1Tt1GquQV1YJDoV7y4NQVMFjFsFK5yzci+YoanzXZ34Av
	IHs/9ESQ4dL37ktcDQselw15Y8O1Ooe5r4PE9bo5Sqgh0dRBmv+QTIPyFvvFO/jPfXJhOPSDwwI3S
	ls4EwGCfy5T83u2lbzZbykFdefL36ShMmRAEHy8bQ3Qe0r+Hi96JnlG5WlGnwrQ3EKX58gAe+Br7v
	QdTV/ipmnR8HLFwOkzr6ISzYeUX8aAhyn7lGDvSaqg8JNPrdXpadeWai31qWOtrbPk9ErRSXpyXyj
	j8mgX4rGFYqQQtbRf8CQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxKBw-0005SQ-77; Fri, 22 Feb 2019 23:25:16 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxKBs-0005Rm-9r
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 23:25:13 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 6E39380AA;
 Fri, 22 Feb 2019 23:25:21 +0000 (UTC)
Date: Fri, 22 Feb 2019 15:25:07 -0800
From: Tony Lindgren <tony@atomide.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] deprecate old cpsw driver phy mode for v5.1
Message-ID: <20190222232507.GG15711@atomide.com>
References: <pull-1550848332-146231@atomide.com>
 <CAK8P3a24M=ACfyLWfOHQ8qfen=L+xAAGb0JsPf-Q9sXmyS7APA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a24M=ACfyLWfOHQ8qfen=L+xAAGb0JsPf-Q9sXmyS7APA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_152512_382819_9B9687F9 
X-CRM114-Status: GOOD (  14.61  )
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
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
 linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [190222 21:12]:
> On Fri, Feb 22, 2019 at 4:15 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > From: "Tony Lindgren" <tony@atomide.com>
> >
> > The following changes since commit bae2bf97939aebd74dfd8f0b76b4902a19e63eef:
> >
> >   dt-bindings: net: ti: deprecate cpsw-phy-sel bindings (2019-02-20 08:14:04 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/cpsw-signed
> >
> > for you to fetch changes up to dba235fa70cbedf7dd64d5763299451be4b9de16:
> >
> >   net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver (2019-02-21 07:33:51 -0800)
> >
> > ----------------------------------------------------------------
> > One change to deprecate old CPSW Ethernet PHY mode selection driver
> >
> > With the device tree changes configuring CPSW with a proper PHY driver,
> > we want to deprecate the old driver to avoid new users for it.
> >
> > Note that this driver is based on the related dts changes.
> >
> 
> I've added this to the arm/late branch, which seems to be the best
> way to deal with the dependency on the DT changes. I expect that
> we can send this in the second week after the merge window, together
> with any fixes that have come in until then.

Thanks that sounds good to me.

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
