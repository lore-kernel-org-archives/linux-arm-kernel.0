Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B401C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:33:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B66B206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lTgDS4lZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hepqszla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B66B206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h1gWZpAv3oQy7D9hS0Yn1K/MRglY/Xt9av4tyXDeYNo=; b=lTgDS4lZUEco/b
	tCkMAgSFIsSKfODaN76olwgbEmLPX343oXtAv+hbZtNX5hmGB5quEGrOJYhPOlKlTZ77wPv5Xl6qU
	LmZOVnPtGKp1tQCuTXsiW5X0SCMPhvr/6xZS4F22CeDaq/0Nr/lzYCA41KGqNVba9xKwOaa+7xZkK
	SUJsOl1E4SVJSBKqh3ZiK1QjZ7FedieI0473fehBb14A3LYI1UMhVjxID6uJQUD3eif84Guw+hn78
	pqE5ErrOALdfy6Q9+lgWjNhZeDY5OvQuSFQiEMeCpilKPFL4nlf7fio+HRMC6kfcHDOQFNKNRxeZr
	IIwDQnYZdcF8Yak5e9Lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtx7-0001fm-Ho; Mon, 17 Dec 2018 14:33:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtx5-0001ed-59; Mon, 17 Dec 2018 14:33:00 +0000
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 496AB206A2;
 Mon, 17 Dec 2018 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545057168;
 bh=U3lJ6BneydpJBppucBLQPbsaaT46S5fpMxrOi3dnS5s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HepqszlaEMP64Nm+rnoLqwCkW2ORzS6Xlvc0jzE4+Q7WsoJ/TSzwUPvf6Z8lX9VCe
 0VAlGGVDGi+1KOZMBATBDoGm/VvvdkwE6IMazCj3sohexQHJ6w0kcLtikJmJN/mTX5
 XQg9bkFDLLNK/9QdtAq3ZZcTC5x9lURBuXw0vELg=
Date: Mon, 17 Dec 2018 08:32:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
Message-ID: <20181217143247.GK20725@google.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
 <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
 <20181213145517.GB4701@google.com>
 <1545034779.8528.8.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545034779.8528.8.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_063259_214545_FD61BA55 
X-CRM114-Status: GOOD (  13.44  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, ryder.lee@mediatek.com,
 linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 04:19:39PM +0800, Jianjun Wang wrote:
> On Thu, 2018-12-13 at 08:55 -0600, Bjorn Helgaas wrote:
> > On Thu, Dec 06, 2018 at 09:09:13AM +0800, Jianjun Wang wrote:
> > > The read value of BAR0 is 0xffff_ffff, it's size will be calculated as 4GB
> > > in arm64 but bogus alignment values at arm32, the pcie device and devices
> > > behind this bridge will not be enabled. Fix it's BAR0 resource size to
> > > guarantee the pcie devices will be enabled correctly.
> > 
> > So this is a hardware erratum?  Per spec, a memory BAR has bit 0 hardwired
> > to 0, and an IO BAR has bit 1 hardwired to 0.
> 
> Yes, it only works properly on 64bit platform.

I don't understand.  BARs are supposed to work the same regardless of
whether it's a 32- or 64-bit platform.  If this is a workaround for a
hardware defect, please just say that explicitly.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
