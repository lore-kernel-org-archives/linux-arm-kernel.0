Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B47C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:19:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F18D2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dI6Wlvs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F18D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i8YdDKOgY8vWw2fmz3mozlDqPqGVkbTYyVcB7f69ry0=; b=dI6Wlvs0VjiJe1
	B+3EZZO28ISOWPMHY9wmElCXsVamgP35XecRTVcmNdOBqOLrgq+vwKoac2YGbcl5mwaeTzYo7/IxY
	lSycOY6TD29GYVL1R249wpF120ExCpizkxlzoWhm/PjIlGIwqRRsPY3kNyzPLZaXpKLjF75kiVeeP
	63ZPeaU7Ny0s3F6jQoqxGAyTeu79nKpG5Z50QcijFkmx8OJ3wW5fax5gnRatnhr8YU7DAVIJr34m7
	R47U3W/Btho5pv6OL3swYV9db3HLduUVHeK/DRSofoKjPogBjCBxhp7X7z5nd2C7GiamYsd52BB/V
	8g1qz2KKw6lZrNj1Dimg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giwWm-0008Nf-4P; Mon, 14 Jan 2019 07:19:20 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giwWh-0008MU-Lf
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 07:19:18 +0000
Received: from sapphire.tkos.co.il (unknown [10.0.4.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id 14ED44405BD;
 Mon, 14 Jan 2019 09:19:11 +0200 (IST)
Date: Mon, 14 Jan 2019 09:19:09 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
Message-ID: <20190114071909.5cz4pg4bsdo7htob@sapphire.tkos.co.il>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch> <8736q0irwy.fsf@tarshish>
 <20190110131912.GB29612@lunn.ch> <87zhs8h5ej.fsf@tarshish>
 <87pnt0vil3.fsf@tarshish> <20190113154028.GB4635@lunn.ch>
 <CACRpkdY6UPcWds3swtRM_OMu3hCJcdicbo29b5JEcRBNC4L+vg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdY6UPcWds3swtRM_OMu3hCJcdicbo29b5JEcRBNC4L+vg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_231915_946304_1951D2D8 
X-CRM114-Status: GOOD (  18.16  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>,
 linux-pwm@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

On Mon, Jan 14, 2019 at 12:35:01AM +0100, Linus Walleij wrote:
> On Sun, Jan 13, 2019 at 4:40 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > Another look at this comment made me realize that we need comphy
> > > initialization support in the kernel for PCIe reset to work correctly.
> > >
> > > The workaround that this patch proposes will not solve the problem for
> > > v5.0, since the GPIO get_direction patch will only appear in v5.1.
> >
> > You could ask for it to be applied to v5.0 since a real fix depends on
> > it.
> 
> If it makes a piece of hardware work that was working before and
> now is not working as a result of other kernel changes I would
> definately apply it because that is a clear cut regression.
> 
> I am under the impression that this is the case?

The gpio-mvebu get_direction support enables a workaround for a regression 
introduced in commit 3d71746c420c1 on the Macchiatobin platform. An 
alternative solution is to revert the offending commit. The revert will not 
break any known platform that has been previously supported in mainline 
kernel. I tend to think that revert is a better course of action.

It is up to the PCI maintainers to decide.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
