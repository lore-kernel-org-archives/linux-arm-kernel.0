Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F287DC37122
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:48:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14D32085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HOj2IWuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14D32085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tfOsIrV9Bm42DfjROddDWJJtppWFOmMYiOjQXauD9oA=; b=HOj2IWucZIj9xm
	wlRJvgdpreUA7eE0pnEsU2ROSihrsdAz29Wspf2ZULElFRVZfpNirUUtpNxQVx01XYjR1zlbCUYj5
	gyKqsmds9Munb6lquagSK8MVS1jlazgWskbL+kNd83Y5Cnmo4LIvMyqTG7Sj1Td9w9sE6ciDtAUpG
	YXaWymyIqt+lZlWd31Zql66FJR3PDqMlEsx/mHPZN3fV2w4bV1FzE6Lkvd6pp9n0VxUbck8QJyodE
	kfvgZQ4qrE0fUs21jJxkvSS8rF6NESD36R1EAeg4NL8J8nV8OX6jKlb7tfp/fKEoGSMWZvAjCfKlG
	LJFPE3C0iLkJVjYsn0jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glkEe-0005hT-6a; Tue, 22 Jan 2019 00:48:12 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glkEa-0005h8-TT
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 00:48:10 +0000
Received: by mail-oi1-f194.google.com with SMTP id x23so16057359oix.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 16:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xdz3AySOWc37zBjAyPNQE0AtCWFwpBdKiIR9Wnn8T0k=;
 b=AbJv8838++eG0xhtSP9rftD5+OPCGMbt6yfNyFfTx3Iolik+kbAoS/NPw2zbfCWHVg
 ZCC/qvw2pZJBSe8OpLvohgKsl08+ZMypWo34w9WSCkkfUc1tuwtvLYaE2EB9XmRsxMS2
 SB0OAGBBSE6puajt4cR77WwQuh/oipDle3zG/Yd3jSmFkhIkiUGGd0zZu2a+NLHYz7yA
 nJw87Hwi6YtgNAeR070S3qK1itco/LNH2mQlu1iEs4nzJJ8tUHtqiqc9FxTg2uJJytdU
 GH6v/ccaRO5R2fnZaRmhpBfQwaQ8XBYoyBu6Wyj39Zyec7JgSbL4uOrnyimEK69EQWum
 Bihg==
X-Gm-Message-State: AJcUuke6Q8A1KBvqKlX4lgpy1BrbUZyeryLaIwH5+riktU1LjwRjrDnU
 WmEtbAOCXslfVbW0a0u+TA==
X-Google-Smtp-Source: ALg8bN4meCILV1rwD9Ze0PSruuOmQHSm7866wqkZ90BVvM8+qY7l/POl0NVHJPyg4nUEIr9+VQQjZQ==
X-Received: by 2002:aca:5205:: with SMTP id g5mr7192901oib.149.1548118087942; 
 Mon, 21 Jan 2019 16:48:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s186sm6959854oif.0.2019.01.21.16.48.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 16:48:07 -0800 (PST)
Date: Mon, 21 Jan 2019 18:48:06 -0600
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 09/24] dt-bindings: PCI: Document "atu" reg-names
Message-ID: <20190122004806.GA32204@bogus>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-10-kishon@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114132424.6445-10-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_164808_947820_D1EB27CF 
X-CRM114-Status: GOOD (  18.77  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 Murali Karicheri <m-karicheri2@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 06:54:09PM +0530, Kishon Vijay Abraham I wrote:
> Document "atu" reg-names required to get the register space for ATU in
> Synopsys designware core version >= 4.80.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index c124f9bc11f3..5561a1c060d0 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -4,8 +4,11 @@ Required properties:
>  - compatible:
>  	"snps,dw-pcie" for RC mode;
>  	"snps,dw-pcie-ep" for EP mode;
> -- reg: Should contain the configuration address space.
> -- reg-names: Must be "config" for the PCIe configuration space.
> +- reg: For designware cores version < 4.80 contains the configuration
> +       address space. For designware core version >= 4.80, contains
> +       the configuration and ATU address space
> +- reg-names: Must be "config" for the PCIe configuration space and "atu" for
> +	     the ATU address space.

I'm pretty sure we already have other platforms with an ATU. Those all 
just represent it with the other ctrl registers? So maybe this is TI 
specific that it is separate. Or should have some conditional like 'if 
the ATU space is separate, the reg-name should be atu'.

>      (The old way of getting the configuration address space from "ranges"
>      is deprecated and should be avoided.)
>  - num-lanes: number of lanes to use
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
