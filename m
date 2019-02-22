Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80431C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:22:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3F020700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZCyo0Kd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3F020700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HYDrQV7iCeBLM0Bab14N5/Ce08ZrJnC31vaJCoBhO1o=; b=ZCyo0Kd8UVSdFw
	zP40xybge/elEOa+wKxo980/F4reoeUYv/ozd51pJTlaHI6RY88QSySuvmi9wM9U2FIJ395FJJh/F
	jrg/DKj3L88glzGcBcnjABulNjhVMN2AWOMXR3af40My8mwFtC3jCG53veUG6pZU40ruuahls3ZeZ
	TwJLPnAIqGXPlzWL7D7cquUwpQqWJuL7mxlt1BmAQu8S/6/G5AxWbSqP8u6+yllg2MEQ+rSPmbJLF
	+e0byFjA3E44qSq0gwIOlBVcmpNiSwNeEYUk8vWsrZvauRdK34KNHDn/l4g7fGunWovlj6H6UWExx
	5K/j6M4xKxCTMwGOjfPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx8un-0008PX-Ow; Fri, 22 Feb 2019 11:22:49 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx8uk-0008Ou-4y
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 11:22:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFFCCA78;
 Fri, 22 Feb 2019 03:22:44 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F05EB3F5C1;
 Fri, 22 Feb 2019 03:22:42 -0800 (PST)
Date: Fri, 22 Feb 2019 11:22:37 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common bridge
 emul code
Message-ID: <20190222112237.GA630@e107981-ln.cambridge.arm.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_032246_199931_B789B899 
X-CRM114-Status: GOOD (  18.73  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leigh Brown <leigh@solinno.co.uk>,
 Lu??s Mendes <luis.p.mendes@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 10:48:39AM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> This set of two patches aim at fixing some regression reported by two
> users (Luis and Leigh), that were introduced by the conversion of the
> pci-mvebu driver to the common PCI bridge emulation code shared
> between pci-aardvark and pci-mvebu.
> 
> Due to this conversion, some registers of the PCI configuration that
> used to be read-only are now read-write, making the Linux PCI core
> believe that some features are implemented by the PCI bridge. Namely
> in the case of pci-mvebu, the prefetchable memory base/limit registers
> were read-only, while they are now read-write. Due to this, the Linux
> PCI core now believes it can configure a prefetchable memory area, but
> this is not supported by pci-mvebu, which does not have the logic to
> create the appropriate MBUs windows.
> 
> This set of two commits allow PCI controller code to tell the PCI
> bridge emulation logic about their capabilities. Because we envision
> that other capabilities than prefetchable memory support might need to
> be communicated from the PCI controller code to the PCI bridge
> emulation code in the future, we introduce a "flags" argument, even if
> for now only one flag is supported.
> 
> Lorenzo, let me know what you think about this approach. I am open to
> suggestions if the proposed approach is not satisfying.
> 
> Both patches have been confirmed by Luis and Leigh to fix the
> regression, but I'll let them give a formal Tested-by.
> 
> Best regards,
> 
> Thomas Petazzoni
> 
> Thomas Petazzoni (2):
>   PCI: pci-bridge-emul: Create per-bridge copy of register behavior
>   PCI: pci-bridge-emul: Extend pci_bridge_emul_init() with flags
> 
>  drivers/pci/controller/pci-aardvark.c |  2 +-
>  drivers/pci/controller/pci-mvebu.c    |  2 +-
>  drivers/pci/pci-bridge-emul.c         | 86 ++++++++++++++++++---------
>  drivers/pci/pci-bridge-emul.h         | 13 +++-
>  4 files changed, 73 insertions(+), 30 deletions(-)

I have applied the series to pci/misc for v5.1, thanks.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
