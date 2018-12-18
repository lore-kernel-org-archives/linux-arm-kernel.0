Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA08BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:49:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8502F20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TZ2M4LJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8502F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=txLFRVfgM4vrHsh0NPvcVHu4KaLIOlSKZAdUL/E228g=; b=TZ2M4LJh0Zb2qLkYHexV7AAwV
	fCxPs0YnHX72keIbtoq6G1/HZNuNvLBUUNidvtg9uYhrsu+GTFjhUd42+gJrljvTaOXYRdVeXLY/P
	p2ILHzeP55PFbnfCCbgq8N55M8ZLlOI2FnyktMjjSg4qaPskayYwv2iusjvgyYVMbv+TeAdzYvmaE
	dR828heb3YyMM6XT+/JVgZtEXPhNNp6LxCuQVFdGM7ABL+Tb/Oe0KaQzzYVmu5zv6V83I2y9S0MWz
	JU20epwJlVPU1JC7z5Kof+wOowHEJFbe6sxY6Ir13APs3zIyOgD0wYkAbHvjoRq2BJo7SFc9IcQ6U
	Wh8C1hg7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDsB-0000rp-Hd; Tue, 18 Dec 2018 11:49:15 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDs8-0000qQ-5a
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:49:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E68BA80D;
 Tue, 18 Dec 2018 03:48:59 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 027E23F5C0;
 Tue, 18 Dec 2018 03:48:58 -0800 (PST)
Subject: Re: [bug report] bus: sunxi-rsb: Add driver for Allwinner Reduced
 Serial Bus
To: Dan Carpenter <dan.carpenter@oracle.com>, wens@csie.org
References: <20181218083613.GD440@kadam>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <869c2efc-5bc6-3433-6b41-ddb15c6421df@arm.com>
Date: Tue, 18 Dec 2018 11:48:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218083613.GD440@kadam>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_034912_210745_3E1E066B 
X-CRM114-Status: GOOD (  21.91  )
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
Cc: Olof Johansson <olof@lixom.net>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18/12/2018 08:36, Dan Carpenter wrote:
> I totally don't understand the sunxi_rsb_device_create() function.  It's
> basically a no-op.  There is a lot of code to deal with sunxi_rsb_device
> devices but there is no function to create them so it seems like dead
> code.
> 
> What am I missing?

By the sound of it, the considerable amount of stuff happening behind 
that device_register() call ;)

The general shape of this function looks like fairly typical bus code to 
me, however I'm not sure off-hand that it's actually correct to drop the 
initial device reference in the success path (I suspect that should 
probably be kept around to be dropped in the corresponding 
device_unregister() call), and AFAICS there's no reason it shouldn't 
just return a normal int error code.

Robin.

> drivers/bus/sunxi-rsb.c
>     198  static struct sunxi_rsb_device *sunxi_rsb_device_create(struct sunxi_rsb *rsb,
>     199                  struct device_node *node, u16 hwaddr, u8 rtaddr)
>     200  {
>     201          int err;
>     202          struct sunxi_rsb_device *rdev;
>     203
>     204          rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
>     205          if (!rdev)
>     206                  return ERR_PTR(-ENOMEM);
>     207
>     208          rdev->rsb = rsb;
>     209          rdev->hwaddr = hwaddr;
>     210          rdev->rtaddr = rtaddr;
>     211          rdev->dev.bus = &sunxi_rsb_bus;
>     212          rdev->dev.parent = rsb->dev;
>     213          rdev->dev.of_node = node;
>     214          rdev->dev.release = sunxi_rsb_dev_release;
>     215
>     216          dev_set_name(&rdev->dev, "%s-%x", RSB_CTRL_NAME, hwaddr);
>     217
>     218          err = device_register(&rdev->dev);
>     219          if (err < 0) {
>     220                  dev_err(&rdev->dev, "Can't add %s, status %d\n",
>     221                          dev_name(&rdev->dev), err);
>     222                  goto err_device_add;
>     223          }
>     224
>     225          dev_dbg(&rdev->dev, "device %s registered\n", dev_name(&rdev->dev));
>     226
>     227  err_device_add:
>     228          put_device(&rdev->dev);
>     229
>     230          return ERR_PTR(err);
> 
> We call put_device() on the success path and return NULL.  The caller
> checks to see if it is an error pointer, and prints an error message.
> NULL isn't an error pointer so it doesn't cause any problems but it also
> doesn't do anything.
> 
> The caller doesn't save the returned devices either so there seems to
> be a bunch of code missing...
> 
>     231  }
> 
> regards,
> dan carpenter
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
