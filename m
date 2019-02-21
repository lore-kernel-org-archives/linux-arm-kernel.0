Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFD3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:23:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2C82077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VuRlZuu+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2j0FplgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2C82077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8pKTrRPpyBdKny9ICVSXhYxrdhMJrCeOt99pyk3NWAc=; b=VuRlZuu+kSrbuT
	jgD2NGOT1C0r/C1ild+mMlJG5hLbO1n3fYILO/A6e9yGpYAfx2O74NrbNa8meURy5AvpNaVFvaUpf
	ANO4z2VXsS3eqDLuvrj2WmjN37mF6HjR6bE3mAB15Z8u2YmlyJFUkTZ+cYNnOyGjRoBTkxz1jB7vq
	4wVjacnxG1v90X7qQxuBQTn3mol8aMRWaMvSGqR+HfNdHK8NuUNSzfDd9dsr1z85zgl/9UhzYqxST
	GN21fcBher3oekmfAIjwOmQmkdmSV7m/tc/h3J7PnTc47//+uE/pt0boTK975UJLacWjwNE416H3m
	hu6zUCy73Z/hsPe6OwNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwxge-0002vl-LB; Thu, 21 Feb 2019 23:23:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwxgb-0002v6-BR
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 23:23:26 +0000
Received: from localhost (unknown [104.133.8.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EBD1D20838;
 Thu, 21 Feb 2019 23:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550791398;
 bh=yAfyThOQRMPrqjQAjPnVKTvRkSiew9cnk1qwxbgFEsc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2j0FplgHYyNp9sD9rhPFHMcK936zGjydgron0x5bjSYZRTa0in/JekdlXB7SfdER2
 nqGrS1qyX4wydhXT4aD00FV7fDYV8QFtNofKOmdZWrfzd2w6Hw3l0L4RP/VPJW9Fv3
 s+kyiIpceD7mlRlY0D/r3KT+Bmjugrz0b9NfGutc=
Date: Thu, 21 Feb 2019 17:23:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common bridge
 emul code
Message-ID: <20190221232317.GB219879@google.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_152325_411304_C7DA04AD 
X-CRM114-Status: GOOD (  18.54  )
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
 Russell King <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>,
 linux-pci@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>,
 Leigh Brown <leigh@solinno.co.uk>,
 =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
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

Lorenzo, I assume you'll take both of these, so for both patches,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Maybe we should add a stable tag (v4.20+)?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
