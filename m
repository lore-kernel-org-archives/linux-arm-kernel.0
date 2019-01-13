Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35A1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:42:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF4C20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D3kkwPGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF4C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RZvQCr84PBMDhMNUWyzEkkb4uYygMEjAWEgkCqFOls0=; b=D3kkwPGRT73z7rZ9NF5snXUaS3
	gSmN6TaL/dY6m7hW+LafyMnJ86nkWB7PeXJ03teTtGSk9UUjaDRJ7kRlzbqQjFJxBt0rMbfickzw2
	kMjkIo5yWx7ICWsS8qvetBIpvlBBCmwh7TXKKfAXrCT5qT55LEyuc7kqdO8Ga0N7OntpxH6wjRzM1
	/uB9RneDpXSh925s09PdSSh5Tz7RrE2t/28IW9sx2KFKYxCLXUOX/a1/xxgSU1TiPD2UOGjIPuE1E
	xG55T9lxFCXDCX4TQ7m1ngiHvxN1RYNWFJIJw2i91MnN08QkH0lbK0GBNU8stpSqJ1BSh2lxQy5jH
	mtOKexkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gikig-0008DD-TI; Sun, 13 Jan 2019 18:42:50 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gikic-0008CZ-QW
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 18:42:49 +0000
Received: from tarshish (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id ACA5B4400E1;
 Sun, 13 Jan 2019 20:42:22 +0200 (IST)
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch> <8736q0irwy.fsf@tarshish>
 <20190110131912.GB29612@lunn.ch> <87zhs8h5ej.fsf@tarshish>
 <87pnt0vil3.fsf@tarshish> <20190113154028.GB4635@lunn.ch>
User-agent: mu4e 1.0; emacs 26.1
From: Baruch Siach <baruch@tkos.co.il>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
In-reply-to: <20190113154028.GB4635@lunn.ch>
Date: Sun, 13 Jan 2019 20:42:39 +0200
Message-ID: <87o98kv1pc.fsf@tarshish>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_104247_087859_A8535157 
X-CRM114-Status: GOOD (  12.60  )
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
Cc: linux-pwm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-pci@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew,

On Sun, Jan 13 2019, Andrew Lunn wrote:
>> Another look at this comment made me realize that we need comphy
>> initialization support in the kernel for PCIe reset to work correctly.
>>
>> The workaround that this patch proposes will not solve the problem for
>> v5.0, since the GPIO get_direction patch will only appear in v5.1.
>
> You could ask for it to be applied to v5.0 since a real fix depends on
> it.
>
> We have a bit of a balancing act to sort out. The revert will fix
> Macchiatobin. But i assume it breaks some other platforms which just
> started to work. Ideally we want the best of both worlds. So maybe
> getting the GPIO change into stable is the correct thing to do?

Support for that other board (Clearfog GT-8K) has only been introduced
in v5.0. The kernel never supported PCIe on that platform. So there is
no regression for CF GT-8K like there is for the Macchiatobin.

The issue is quite easy to deal with at the U-Boot level even for v5.0.
The workaround that this patch suggests is pretty ugly, as you noted. I
think we can live with no PCIe reset support in the kernel for another
release or two.

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
