Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D5CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:14:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B348121773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fyfXvhYW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB1MIHDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B348121773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G6DJTaL5mtUkagtw96tB9UHSQN6tTGjNewa7UVlnJog=; b=fyfXvhYWOTNWD0
	xe1M8CZ40TbS9qTx1tdAbrDyiiqsbUHkB2VfWnm/JtrB8uIjO03yIVfPpWnhnuQC1TnfIgnPP6GG3
	cBfrV0b/d5lcIX6dU1PpwI9U2FIKgvurEiTOjltGUnyjlJtK2ELqXPeDoGKa85Bo/J5gbnyl8nFo/
	UtmaWRk/CRcnVJwPP5KmzsNaoHzpjNNzN1fjQ1zokjOCPBR07NN+YJw5f16ORsKpMtJS25uYzRkEm
	jkoGoSuMezKnp5/x7hKZ6wz3LgSjPYrWwYP+A2OyNkIDx54eOMYp/B3ezmqadWyESXBEURbZCvyDB
	ElnlS/MzJx6Z0R+NhMFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZwHT-0003BV-3M; Thu, 20 Dec 2018 11:14:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZwHP-0003AR-Vo
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 11:14:17 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 31EE22177E;
 Thu, 20 Dec 2018 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545304445;
 bh=qkcBJQcK9EzKTNvCn2J3Q56O1CSgbtK7TIpoj0Cd1MQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NB1MIHDtKAO6S3NbbT/7Muqq1uORKJnYiv0l928izLYYVbo4Z7jlbMQFJRsrK7oG/
 JGZ12MMEB5E1MM0HKOr6GU6sN2Z2J3j8LSVx9afVTFLLrSvHhK8hmZ7FN8cvM6P6+S
 JD6dkxejLlXwKRQbupoarJZxBbGNPPWYwIVv6JZw=
Date: Thu, 20 Dec 2018 12:14:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v4 1/3] driver core: add probe_err log helper
Message-ID: <20181220111403.GB10978@kroah.com>
References: <20181220102247.4911-1-a.hajda@samsung.com>
 <CGME20181220102259eucas1p2f748c68e01cd4e09a266da879722e218@eucas1p2.samsung.com>
 <20181220102247.4911-2-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181220102247.4911-2-a.hajda@samsung.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_031416_042881_7ACC0689 
X-CRM114-Status: GOOD (  11.72  )
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 11:22:45AM +0100, Andrzej Hajda wrote:
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code sequences with simple call, so code:
> 	if (err != -EPROBE_DEFER)
> 		dev_err(dev, ...);
> 	return err;
> becomes:
> 	return probe_err(dev, err, ...);

Can you show a driver being converted to use this to show if it really
will save a bunch of lines and make things simpler?  Usually you are
requesting lots of resources so you need to do more than just return,
you need to clean stuff up first.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
