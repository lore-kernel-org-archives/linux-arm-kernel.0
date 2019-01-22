Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4052C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:20:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75CE920879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f7UwVKAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CE920879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=74MDSOZsBhmOycz3ENhBP/oDmwPJ76Qu6//EtsJf6r4=; b=f7UwVKAKAKBvFF
	kBphmksMGo4h0mDR/nkzEtn2Q7SN0Xh1EF3yBmDdDitcYLktRBZa1Kvi2kvgcscfWEqv0WhpHt+is
	6eNwTz/BxwmBjPVWVBHmcBuLFyVza+4shYaqZEh6w7LTl9Ecs7dJLQBiSkLtdlr3uQLc7oSIJY75z
	lNl1Bn0hGJj8EwEOgteeZUV7G9YpVGzzVGjSGclaL2Qk1gsebJNr6ST0YCuuasNjYENO0I7ITdHnP
	lBXfaVb6pGvECpePbqF59xdhjGw8Coeti8Vcyi+hNNvtkK8Z8bht4lZdnDiR1cZ6wJZrdRtoWq86s
	PHQkyVM3ssu8jkv+MJPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glv2f-0007Wj-QQ; Tue, 22 Jan 2019 12:20:33 +0000
Received: from bastet.se.axis.com ([195.60.68.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glv2c-0007W8-0W
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 12:20:32 +0000
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 5628318415;
 Tue, 22 Jan 2019 13:20:26 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id u2I8OeMQMxBU; Tue, 22 Jan 2019 13:20:25 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
 by bastet.se.axis.com (Postfix) with ESMTPS id C0F37183BD;
 Tue, 22 Jan 2019 13:20:24 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADEF51A063;
 Tue, 22 Jan 2019 13:20:24 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0F011A05F;
 Tue, 22 Jan 2019 13:20:24 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
 by boulder02.se.axis.com (Postfix) with ESMTP;
 Tue, 22 Jan 2019 13:20:24 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
 by thoth.se.axis.com (Postfix) with ESMTP id 936BC19F7;
 Tue, 22 Jan 2019 13:20:24 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
 id 893D980B46; Tue, 22 Jan 2019 13:20:24 +0100 (CET)
Date: Tue, 22 Jan 2019 13:20:24 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host side
 Rshim driver
Message-ID: <20190122122022.ipn3jdfnxthhphrs@axis.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1541089538-175682-1-git-send-email-lsun@mellanox.com>
 <1541089538-175682-5-git-send-email-lsun@mellanox.com>
 <CAK8P3a2NRbEaS_EJNtBaZ3GCUtRiH2rUDRzJFjvcw2ZacZM1qw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a2NRbEaS_EJNtBaZ3GCUtRiH2rUDRzJFjvcw2ZacZM1qw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_042030_388956_837AEBC3 
X-CRM114-Status: GOOD (  26.05  )
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
Cc: DTML <devicetree@vger.kernel.org>, David Woods <dwoods@mellanox.com>,
 linux-pci <linux-pci@vger.kernel.org>, Liming Sun <lsun@mellanox.com>,
 virtualization@lists.linux-foundation.org, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>, linux-ntb@googlegroups.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 05:02:21PM +0100, Arnd Bergmann wrote:
> On Thu, Nov 1, 2018 at 5:49 PM Liming Sun <lsun@mellanox.com> wrote:
> >
> > An external host can connect to a Mellanox BlueField SoC via an
> > interface called Rshim. The Rshim driver provides boot, console,
> > and networking services over this interface. This commit is
> > the common driver where the other backend (transport) driver will
> > use.
> >
> > Reviewed-by: David Woods <dwoods@mellanox.com>
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> 
> Hi Liming,
> 
> I've taken a new look at your patch series for drivers/soc/ now,
> thanks for your continued submissions.
> 
> This is again just a set of very high-level comments, but I think we
> should resolve some of the fundamental questions first.
> Incidentally, Vincent Whitchurch has recently posted another
> patch series with a very similar intention, but for other hardware
> and taking a different approach.
> 
> In both cases, the idea is to use virtio based drivers to provide
> services from a host machine into another Linux instance running
> on an embedded system behind a PCIe slot or similar. Your
> Bluefield SoC patches are well written, but are intentionally
> kept specific to a particular use case and tied to one piece
> of hardware. In contrast, Vincent uses the existing code from
> drivers/misc/mic/vop/ that is equally hardware specific, but he
> extends it to be applicable to other hardware as well.
> 
> It would be good if you could look at each other's approaches
> to see where we could take it from here. I think ideally we
> should have a common driver framework for doing the same
> thing across both of your devices and as well as others.

As far as I can see the biggest difference is that Rshim appears to
support interfaces which do not have shared memory between the host and
the card, which means that it has to jump through a lot more hoops to
make virtio work.

For example, the card side seems to use normal virtio-net and
virto-console drivers, but the drivers/soc/mellanox/tmfifo.c driver,
also running on the card, appears to have to actually look inside the
virtqueues and shuffle the data over the TmFifo interface, and this
driver has hard-coded support for only network and console, since it
apparently needs to know the details of how the virtio drivers use their
virtqueues (see tmfifo_virtio_rxtx()).

And the host side appears to _also_ run the virtio-net driver and there
the drivers/soc/mellanox/host/rshim_net.c code instead has to look
inside the virtqueues and shuffle the data over the other side of the
TmFifo interface.

So to me this looks very different from a traditional virtio
driver/device setup (which is what mic/vop uses).  I may be missing
something, but I don't quite understand why it's even using virtio in
the first place.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
