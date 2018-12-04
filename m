Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B622C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:52:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF4B2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NCzsQpbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF4B2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jt7kIkb6PTZImbgVYBv+/yc2Ecew9u4/jXuLJbKKMXA=; b=NCzsQpbfEqByxG
	5e+5XRXE72l4WAhJ7DZE9J//Z61Mi6BmCkVkYyxT2sz/H7JlG/TXFMry9Nv6LH7alv+rJBn3VOYhk
	WYQcPR7iwyjjFukZv+nWwx7w0CH7PdPYEs4WzKU9jOF6xgvlS1jzKXj6GcEWM3VN9llN/p2eeBCCF
	YJKVMEtVg4MXfHmX4/O+LVcPzqwakl/9xFrbcolmFfac5tCVcWVHGPORuaMzKlf5VgNplqBVfGm2v
	fq+/nEK7kPMMnBK7T33uIr+XWI9cLzZakkuD5AxiTM/rV5ATU1CpdD5C5muz/dct2BH78dQysvXGt
	KYIYOCU5O3BX3rdCZ29w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUIcZ-00079I-JM; Tue, 04 Dec 2018 21:52:47 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUIcV-0006cE-SH
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 21:52:45 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id F055280FA;
 Tue,  4 Dec 2018 21:52:34 +0000 (UTC)
Date: Tue, 4 Dec 2018 13:52:29 -0800
From: Tony Lindgren <tony@atomide.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: add networking over USB device
Message-ID: <20181204215229.GE6707@atomide.com>
References: <20181204205901.14620-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204205901.14620-1-michael.opdenacker@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_135244_009385_A437CA73 
X-CRM114-Status: GOOD (  10.22  )
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
Cc: linux-omap@vger.kernel.org, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

* Michael Opdenacker <michael.opdenacker@bootlin.com> [181204 12:59]:
> This adds support for networking over USB device,
> which allows boards such as the BeagleBoneBlack Wireless and
> Pocket Beagle to boot on an NFS root filesystem. Such boards
> have no Ethernet port.
> 
> This is for consistency with CONFIG_ROOT_NFS=y
> which makes no sense if there is no networking.

Hmm well this has few issues though:

1. We've had USB as loadable modules for years now to
   cut down on bloat and try to make things more
   distro friendly

2. MUSB has never worked well with PM and enabling
   it almost certainly would break PM for multiple
   devices

3. The USB gadget configuration should be done using
   configfs as it's device and policy  specific and
   Ethernet gadget may not be even desirable

So I suggest just doing what distros do and use a proper
initramfs :)

BTW what works quite nicely for devices with Ethernet
controller is to have u-boot load dtb, kernel and
modules.tar.gz over Ethernet and write it to mmc. That
way the loaded kernel and modules are available on
boot as long as some init script untars modules.tar.gz
first thing when init starts.

Regards,

Tony





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
