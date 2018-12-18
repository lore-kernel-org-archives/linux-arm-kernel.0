Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F361C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:05:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B89B21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nz6c3vbT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="1vLlvAvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B89B21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6gZKvKy1B5EvduM40oMC9PJL3DrnZ+nxXlChkJql5Ik=; b=nz6c3vbT0/+qMu
	GnGX5A9pYPq5IKflUMIEvls6uXrr8dBmvOK+BJuWDTdFW2tud0R2JKYT+t3ZK8GvoJqDsoAQ44mRr
	phe10ao9zLn/ASrcWqJYChf1kUJR8kelPZo4O6lW8iSVlDHv4mXDJNZ0decca3Zbmuf6BQcso14jG
	E/ewmQ/y2vtC4fqV3wGGNYGkvldEJYsgk+k8/7ZO4ohn633rjUVwY9ZOw4iDOwQWsFRlVtz1WXAPB
	MXvexq80BFu6g1EEN+azgN4QEUqSu3+4rvV3UFlSAPPGHokSCBh/bbsG0QRBXvMq2bMnxdERfyzID
	66kil/wKTFOfLCH2niMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHs1-0000jO-Vn; Tue, 18 Dec 2018 16:05:21 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHrz-00084T-39
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 16:05:21 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so16469259wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8//VzQEv052T/cNvKLsBw1ZQw7s4aGq/pX1LlSzIF4g=;
 b=1vLlvAvD9pyBaQyyNb5Oln3J/Sr4+S2hlQJGzNNSiirFXiMsfkcBJzSD3/2mI1ixPY
 5k6sQd7SINx4q2xz22pYPHz6THQf58fAxpIXD2Y5gtmod7RoBxAqXLF/AKvRedwBmoO0
 HPX/VdDV0Nwzl+FtEUMNFUXArAMKnDt8vfYvRA3Oi7uUOtVlcwgjztyE08BB4CiNs1t9
 3ZIwkKGPp+cDsok75d2D5vnyj21KguMFjHGzIjsWsD4mC2eIpif+3VsaPYJEDDgI+ObT
 lziacJhdq9hZFuH0np9MoiR+oj3iLpkX4TXRq29Dp78ioqlPHy71oJhujerzS5YdWiUA
 Cp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8//VzQEv052T/cNvKLsBw1ZQw7s4aGq/pX1LlSzIF4g=;
 b=bv2LHEKvhOa1RZR6iyMXtHkB5gk7K6XtRlspUPxgDfTu3QlTI1kcL3XsbWoip/DcN6
 8UZqOfnT3NrRCU6QRJ4Finvd88BPQ0D4TIkxcH40jSLC4GfaYDejW/hXWoUAz+t5iVug
 0YIfo5Us0WPHfphF95kso6uoW9oyk6ezkNNr1A6+6ddx5zWHDGmW06RGG76yOojS24Zj
 UmSQw5JelzWH+TkCp+1dR27xqywyKSdz7oOUV0zK4/rMZyBAg/tyOnLgT1QvtlBeVZLq
 AbE/jsiinFxIj1MsZJtd4GLMOQ8NFnVOFTDsRPqy9OwcfuTz20A62LfXMvuU32bd9JHF
 afWw==
X-Gm-Message-State: AA+aEWY/9kKcLJmhGfoyWi55xH39o+qfNyLh0xhuQl72CLJ0VAyLold4
 joi9c1BMpo6RIgbhITfSMgma0Ka1OYuchbUQxA7GLw==
X-Google-Smtp-Source: AFSGD/UZ3R1xxKyQLzZ4Jn2rFvBf2QsIoL3GnhRNfQWtY6aYE2hFftGJT0HHQx0+TmdsU3/kqt9eImQBFPOspdzmYQc=
X-Received: by 2002:adf:be8b:: with SMTP id i11mr15910423wrh.235.1545149103748; 
 Tue, 18 Dec 2018 08:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
In-Reply-To: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 18 Dec 2018 08:04:44 -0800
Message-ID: <CAJ+vNU2OrZgBkr8OGfi6jysSHeXh_jAvb7eqaHDURXjMAnbD1w@mail.gmail.com>
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
To: Koen Vandeputte <koen.vandeputte@ncentric.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_080519_282320_76472A2A 
X-CRM114-Status: GOOD (  21.35  )
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
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
 Robin Leblon <robin.leblon@ncentric.com>, Olof Johansson <olof@lixom.net>,
 Krzysztof Halasa <khalasa@piap.pl>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 3:19 AM Koen Vandeputte
<koen.vandeputte@ncentric.com> wrote:
>
> Originally, cns3xxx used it's own functions for mapping, reading and writing registers.
>
> Commit 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
> removed the internal PCI config write function in favor of the generic one:
>
> cns3xxx_pci_write_config() --> pci_generic_config_write()
>
> cns3xxx_pci_write_config() expected aligned addresses, being produced by cns3xxx_pci_map_bus()
> while the generic one pci_generic_config_write() actually expects the real address
> as both the function and hardware are capable of byte-aligned writes.
>
> This currently leads to pci_generic_config_write() writing
> to the wrong registers on some ocasions.
>
> First issue seen due to this:
>
> - driver ath9k gets loaded
> - The driver wants to write value 0xA8 to register PCI_LATENCY_TIMER, located at 0x0D
> - cns3xxx_pci_map_bus() aligns the address to 0x0C
> - pci_generic_config_write() effectively writes 0xA8 into register 0x0C (CACHE_LINE_SIZE)
>
> This seems to cause some slight instability when certain PCI devices are used.
>
> Another issue example caused by this this is the PCI bus numbering,
> where the primary bus is higher than the secondary, which is impossible.
>
> Before:
>
> 00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
>     Flags: bus master, fast devsel, latency 0, IRQ 255
>     Bus: primary=02, secondary=01, subordinate=ff, sec-latency=0
>
> After fix:
>
> 00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
>     Flags: bus master, fast devsel, latency 0, IRQ 255
>     Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
>
> And very likely some more ..
>
> Fix all by omitting the alignment being done in the mapping function.
>
> Fixes: 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
> Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Krzysztof Halasa <khalasa@piap.pl>
> CC: Olof Johansson <olof@lixom.net>
> CC: Robin Leblon <robin.leblon@ncentric.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Russell King <linux@armlinux.org.uk>
> CC: Tim Harvey <tharvey@gateworks.com>
> CC: stable@vger.kernel.org # v4.0+
> ---
>  arch/arm/mach-cns3xxx/pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
> index 318394ed5c7a..5e11ad3164e0 100644
> --- a/arch/arm/mach-cns3xxx/pcie.c
> +++ b/arch/arm/mach-cns3xxx/pcie.c
> @@ -83,7 +83,7 @@ static void __iomem *cns3xxx_pci_map_bus(struct pci_bus *bus,
>         } else /* remote PCI bus */
>                 base = cnspci->cfg1_regs + ((busno & 0xf) << 20);
>
> -       return base + (where & 0xffc) + (devfn << 12);
> +       return base + where + (devfn << 12);
>  }
>
>  static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
> --
> 2.17.1
>

Acked-by: Tim Harvey <tharvey@gateworks.com>

Thanks Koen!

Tim

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
