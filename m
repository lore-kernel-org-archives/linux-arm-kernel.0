Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945CFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:27:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E75E20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FzrIqs8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E75E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0oshNck2Ol0Uaravoe0ZwaKarKe/S+63nrjQJ2cWjzM=; b=FzrIqs8mEk09fX
	xiAtoRVwOqkHweOiIBrxek2+GxZ/oruMZ/NKq35AgbD9/OS76/dcLhqZEFFyzg4vm15rH+M6czDNV
	It8E5gO8eMgAlTiGuEKQtW8kHBBS6QxFvJfNC0GLEqhgyxNe0v411l27AXViEUksuDo9IoMLUfxMV
	W+IBf68qT1zKNeEHuVZhEvTeOWvs1Mt4uQYEo2lVHbzJTJUW3jHiBI6grnV68qwxqPrDJoZolDwgv
	zUlP0JiAvr1100S4GCXVecs56a6fZIP+1F7vmorXYCSHRDnFujQH6E8TYl2YgBAgaKQpTj/TTA3Cq
	tYNOV63pYors28CVKpRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZETJ-0000kq-Um; Tue, 18 Dec 2018 12:27:37 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZETG-0000kE-HZ
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 12:27:36 +0000
Received: by mail-ed1-f65.google.com with SMTP id b14so13697136edt.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 04:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TXyWA/G9Iavq9N4hGO32KsWoybEp8TZYfpinRZPzLoc=;
 b=fSlEQ//oVgb0LVpHxohtznSMr69tgWm+gRXl5KDy+bGgECkzpV0E6sYxN/yKXrSLWA
 Uonc2lFFjxzCf8g/2Aiu3q5BJbUZddm7arMcAmbm0y1MQt3a/GvMo/sQoZEGbHs91r2t
 VV6c0/BcanZnzPQ0szIMSXeeDkz3b6PnKvihBcfA1NBbYF4/uTfaxDJSSMC7P8ZmI3Ui
 YfSVX6kvKWP7rHF+leQzX/hBkYHlhtHO8ggDskgn+Llwgxfxws7jYCb8UPKxy9XxXIGB
 IwQPYSjwb6lwce9cWq4Q3u0uaDs0JaZjs3K+WWvH1TG068be2iJ6ywFzHVqXBznilGPP
 1E0A==
X-Gm-Message-State: AA+aEWZR83bQJaK6K9Mj9ThFAn7sy1ar1K+y12pnDHwrA1C8tc4oTI4S
 SEFKlBkPdCGmypYtYzkPFori1HKA610=
X-Google-Smtp-Source: AFSGD/WdL50oY/los1uarebcEt/f2CxvHMzxrj6L2K9Xi0LwJ7XfR6k0GPGWMrafY9frkyZjwNSMHQ==
X-Received: by 2002:a17:906:be2:: with SMTP id
 z2-v6mr13076320ejg.170.1545136041946; 
 Tue, 18 Dec 2018 04:27:21 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com.
 [209.85.221.43])
 by smtp.gmail.com with ESMTPSA id l18sm4359647edq.87.2018.12.18.04.27.21
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 04:27:21 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id q18so15696870wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 04:27:21 -0800 (PST)
X-Received: by 2002:adf:b608:: with SMTP id f8mr13858128wre.120.1545136041219; 
 Tue, 18 Dec 2018 04:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20181218082800.GC440@kadam> <20181218083613.GD440@kadam>
In-Reply-To: <20181218083613.GD440@kadam>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 18 Dec 2018 20:27:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v64fM5rTm0t1MjC4f-r+_6YvgyD-ZSootix93nvZGQbuhg@mail.gmail.com>
Message-ID: <CAGb2v64fM5rTm0t1MjC4f-r+_6YvgyD-ZSootix93nvZGQbuhg@mail.gmail.com>
Subject: Re: [bug report] bus: sunxi-rsb: Add driver for Allwinner Reduced
 Serial Bus
To: Dan Carpenter <dan.carpenter@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_042734_581552_BC8D18AD 
X-CRM114-Status: GOOD (  18.23  )
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
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, Dec 18, 2018 at 4:36 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> I totally don't understand the sunxi_rsb_device_create() function.  It's
> basically a no-op.  There is a lot of code to deal with sunxi_rsb_device
> devices but there is no function to create them so it seems like dead
> code.
>
> What am I missing?
>
> drivers/bus/sunxi-rsb.c
>    198  static struct sunxi_rsb_device *sunxi_rsb_device_create(struct sunxi_rsb *rsb,
>    199                  struct device_node *node, u16 hwaddr, u8 rtaddr)
>    200  {
>    201          int err;
>    202          struct sunxi_rsb_device *rdev;
>    203
>    204          rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
>    205          if (!rdev)
>    206                  return ERR_PTR(-ENOMEM);
>    207
>    208          rdev->rsb = rsb;
>    209          rdev->hwaddr = hwaddr;
>    210          rdev->rtaddr = rtaddr;
>    211          rdev->dev.bus = &sunxi_rsb_bus;
>    212          rdev->dev.parent = rsb->dev;
>    213          rdev->dev.of_node = node;
>    214          rdev->dev.release = sunxi_rsb_dev_release;
>    215
>    216          dev_set_name(&rdev->dev, "%s-%x", RSB_CTRL_NAME, hwaddr);
>    217
>    218          err = device_register(&rdev->dev);
>    219          if (err < 0) {
>    220                  dev_err(&rdev->dev, "Can't add %s, status %d\n",
>    221                          dev_name(&rdev->dev), err);
>    222                  goto err_device_add;
>    223          }
>    224
>    225          dev_dbg(&rdev->dev, "device %s registered\n", dev_name(&rdev->dev));
>    226
>    227  err_device_add:
>    228          put_device(&rdev->dev);
>    229
>    230          return ERR_PTR(err);
>
> We call put_device() on the success path and return NULL.  The caller
> checks to see if it is an error pointer, and prints an error message.
> NULL isn't an error pointer so it doesn't cause any problems but it also
> doesn't do anything.

That definitely looks like a bug. I can't recall any specifics from the
time I wrote this though.

> The caller doesn't save the returned devices either so there seems to
> be a bunch of code missing...

There's no need for that as the code doesn't keep a separate list of
registered devices. All slave devices are direct childs of the bus
controller, and the only time the bus code needs a reference to them
is to remove them. For comparison, the SPI subsystem does the same.

Regards
ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
