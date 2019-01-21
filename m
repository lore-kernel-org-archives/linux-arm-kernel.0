Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D65C2F3D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:37:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0A62089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fh7G6Gbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0A62089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e52U0MOERluQkhTjscnycRcAhxkdljjgnUhuzqjVlDk=; b=Fh7G6GbvwklRvJ
	AboeQEMKKNzp6HTeOSBa1rgtWI3Nv5bA3WEaY+OjLNoAZ7ZIkpUQRRW/y/sWLtyGfG6jVWC0Bqz8o
	SKeOiAp2dascwDdwWD4Bv53TjTQZ4BLiosLB+sTQ1hi4JMnwxfDvVT3tbeAvmrJoBwpq2QmDOCLu1
	t2FJ5VEMdGig3OkVO98jDPLSGMpcUtbo45nfZz3oUBInVDoyRFw4dVQF/QPw++32Pp5U+u7jsai20
	IFqYtis6tgbVDTXTdmb0mFF96XCq1nQ+8g2IuikYrhEZn50r8LxHZe4AEieMwW9Y20v7EPmFV8go3
	OagkRasjrxMlXa/aJnMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glahP-0005ZM-RB; Mon, 21 Jan 2019 14:37:15 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glahN-0005Yi-76
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 14:37:14 +0000
Received: by mail-ot1-f68.google.com with SMTP id f18so20658721otl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 06:37:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yCZE0qmHTsavb3lVKD5eIngzqW5FGtladyA6/TKyrl0=;
 b=aaWLVru9g189CFI9e0NduoC9IpdCNBnS49VwyaVPuU+B8+waTikvCqQdVSOdP/CAll
 F7Zjl6lYXqBC7a/vv20vnG59zZ3Ig3NUDQkI35C3XEk5XNQebRwOgNZ2PCV7htUVLVSV
 ssLlY9486v6i7qVNI6naqSDSqjKP5YrlwV+GOINHZDjGP8H9eDQQO09cSX/u00i7RrPZ
 aub7dU+pCzcx3SfVbzBk/Ip6IIa2ekgBD7lTR+38RuoBLraKb2PLuH/i3BkfTTrMBAo3
 +OClrZWObmDfYKUFPhhgzZIgH/y4PbzgExn/usqU4UZS/dIchDqRcFO3P+zzGbapJAGQ
 8Utw==
X-Gm-Message-State: AJcUuke+XsIwiFYtLjV4iIoBHXucniWUS7sHT/05Ck1b1eoJmAtA6Uz+
 nbN5lufauUZpnmr0DGpD4A==
X-Google-Smtp-Source: ALg8bN70Q4ksOHrrmPpNmJxNmO3jRYxHaViWwUELu9sncCjtnH94eEs9zdYbjYPjPBO5KUeNXVTrgw==
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr19070332otl.196.1548081431955; 
 Mon, 21 Jan 2019 06:37:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id y25sm5426170otk.50.2019.01.21.06.37.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 06:37:11 -0800 (PST)
Date: Mon, 21 Jan 2019 08:37:10 -0600
From: Rob Herring <robh@kernel.org>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv5 1/4] dt-bindings: add DT binding for the layerscape
 PCIe controller with EP mode
Message-ID: <20190121143710.GA10941@bogus>
References: <20190121094500.10657-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121094500.10657-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_063713_253468_1F155534 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: mark.rutland@arm.com, roy.zang@nxp.com, lorenzo.pieralisi@arm.com,
 arnd@arndb.de, devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 kstewart@linuxfoundation.org, niklas.cassel@axis.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com,
 minghuan.Lian@nxp.com, cyrille.pitchen@free-electrons.com,
 linux-arm-kernel@lists.infradead.org, pombredanne@nexb.com,
 bhelgaas@google.com, leoyang.li@nxp.com, shawnguo@kernel.org,
 shawn.lin@rock-chips.com, mingkai.hu@nxp.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 05:44:57PM +0800, Xiaowei Bao wrote:
> Add the documentation for the Device Tree binding for the layerscape PCIe
> controller with EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Reviewed-by: Minghuan Lian <minghuan.lian@nxp.com>
> Reviewed-by: Zhiqiang Hou <zhiqiang.hou@nxp.com>
> ---
> v2:
>  - Add the SoC specific compatibles.
> v3:
>  - modify the commit message.
> v4:
>  - no change.
> v5:
>  - no change.

Still missing my R-by tag from v3.

> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
