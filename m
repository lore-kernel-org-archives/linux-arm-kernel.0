Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C57C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0655F20857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r0wJfO2N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc86h83X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0655F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DOhYzvGXzE9/kmIOE1q5nje7pqObAgG6zBJB58VjDzc=; b=r0wJfO2NHMpZqE
	tCgduVufm3EXbLFkv7n70CtqtYuOyvz1j8RdTHRvF0HwcnukZgIyoK3Y6GHBe87CFXKqa4/wRYD4J
	8s1ezC199mUB6Skv4Tal2T4k0Euul3ZesvwobxBwgON98NweuQmxGou7Nmg47Ua3GtpZNjKCCmx6U
	XHK+BBbpPCKwvX5txplAnW7NpuOar1fxzk7iheE6ZnfoW+dC9nTnXZ3qURUBxo0cGNyQBIx7nyC2D
	NNc6P/1w1ud72VYaaZXPBU+rUD4xchQZUW7qSM3jw2OUiQlzlD5IKFSWtzCrsoSQh++k7tPJ/Kvae
	jH7FlRSvR31y1KbpvYnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs6mV-0004kz-3D; Fri, 08 Feb 2019 14:05:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs6mQ-0004jz-MU
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 14:05:25 +0000
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D32020857;
 Fri,  8 Feb 2019 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549634720;
 bh=DsU+0hlCk7sbsBOJm1lgVHUBCpUoH/G+M2w3qlCNprM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yc86h83Xw4f4Ghd3Af2SfEhnV2zh5oxPFkiL8SccQf4tG/rEmrrlqc0cvITOxMTgF
 IouXvYzSbA50AR5lSlYkLYGljrnWlcs5rDNeIuHervafjrwpGtOPv7KeHztuli93Qe
 z1x2XMo6/rRdiHSJZXEsAuZVgbfCyw+DkJYG5JMQ=
Date: Fri, 8 Feb 2019 08:05:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 8/9] PCI: dwc: Remove Keystone specific dw_pcie_host_ops
Message-ID: <20190208140517.GT7268@google.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-9-kishon@ti.com>
 <20190207212622.GO7268@google.com>
 <2b839b2f-d792-069b-b45f-4a455335f016@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2b839b2f-d792-069b-b45f-4a455335f016@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_060522_753005_A0753CAC 
X-CRM114-Status: GOOD (  14.51  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 08, 2019 at 10:43:40AM +0530, Kishon Vijay Abraham I wrote:
> > I don't see the whole series on linux-pci (I only see patches 2, 6, 8, 9),
> 
> I do see all the patches here
> https://patchwork.kernel.org/project/linux-pci/list/. Maybe it arrived little late?

For some reason Gmail decided many of your recent messages were spam.
Sorry for the noise.

> > but I expected to somewhere see the removal of assignments to these
> > pointers.  It would be easier to review if the removal of assignments and
> > the removal of the function pointers from the structure were in the same
> > patch, but maybe that's not really feasible.
> 
> The removal of the assignments are in 7th patch of the series (PCI: keystone:
> Use Keystone specific msi_irq_chip). It's feasible but just wanted to keep the
> keystone changes and DesignWare changes in separate patches.

OK, makes sense.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
