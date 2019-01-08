Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA5CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:43:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C91420700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EfbxcQXj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSJ0+pdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C91420700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nZwxgBA7Sm7UBv+HX0wHBDIm8et/zGgSiZhfF/GHivA=; b=EfbxcQXjWbK3Vw
	UZak0tE4AymjjfLm/l1hu8URIqp7bn2VMQd+Acg1s6uf2msf0hqcKrQdOa3H6mknXdMR/uoskQkIU
	ZvDCCpjDlxK5rkP0Pt1jXISUdMCf8/yBSfRkHYamGlLEiyvzjoYKwK/RMqo0s8RdlYWgdtF9nAhov
	qFiOByLl2VeNiZJUBevro5gT3P/5eZUCznM5rQRXnhDKpCy9zdHh/SzLp86Wgcg9Wk4iLACgVOD4Z
	7sT5Zb5S1fT9eUr/qwQVwbwOCsODqB9pj5GUoLn8Ydj7IHUQw3lEBKwZM7XKVMlujsI+HuWimwQNb
	0QGrA9eYUhNKDBCCq9nQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggl6r-0004JX-G6; Tue, 08 Jan 2019 06:43:33 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggl6o-0004J1-Ao
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 06:43:31 +0000
Received: by mail-pf1-x444.google.com with SMTP id c73so1413087pfe.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 22:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UdHzhJVeJmSIWD79VrtwfdwnEHHkueYkM3uPAgwr6n8=;
 b=LSJ0+pdAlw6SkBv3kB9wrusgeuPZI+N7QtENQeU0Hio3ArEWrQwnZS82GEvOCqxzBJ
 OtDSosfrrY2nlDSSwBCK1g56bALjSfQMTZ3+cyfpHakr22g+UEZ2PB//ctn10JzKL2w8
 iLHPpiR1HmSFaUTEeWXW8tDnpsNQ60F+JnQjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UdHzhJVeJmSIWD79VrtwfdwnEHHkueYkM3uPAgwr6n8=;
 b=OfsDISnXHfFjShSbMBEF4fndAOHbqxTgP7GMaJreuPoxFlSxszmwYDyRBrAMCboTPu
 +x5GGFoGJy35W8aQMMqRprBVaGAnX5Z505Ost2DOyfXf5DI+ZmFBIl0JPqulLPH8PYE4
 lx//ANRBsGaLgdtuUJSrXgGDa5J0YiHcG861l6XQiKIqkKWRrzVNMiS03iXzg/QYP+uD
 n5S6GEm5f4mmpa/FHh5oH0I6LQSswNpfQc5sucylQGTiGPUDAIiQhKmdD0+fxF51w0DP
 ICRwaxjHyyzEFZRSD6ZhG0uN6C5lcRsbip/aVBlOeDCkhJPZpj3Qb6bQ4IzMq3nBD1Wb
 w3NQ==
X-Gm-Message-State: AJcUukekJDXdBjxuiK1b4FyYr1lQTBdSN8bIa0vP4WcZBu1bW4NrJSru
 qJocMSsIlmAjYfhWGFlocvlU
X-Google-Smtp-Source: ALg8bN5IkjFor0bRPhper9G7CoUwp+7zC+c564P8JRNy8liNjsZYjYzrlMSk9B/RM35xyLWvgH26fg==
X-Received: by 2002:a62:9913:: with SMTP id d19mr547199pfe.107.1546929809112; 
 Mon, 07 Jan 2019 22:43:29 -0800 (PST)
Received: from mani ([103.59.133.81])
 by smtp.gmail.com with ESMTPSA id h79sm134026080pfj.186.2019.01.07.22.43.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 07 Jan 2019 22:43:28 -0800 (PST)
Date: Tue, 8 Jan 2019 12:13:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: dinguyen@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 0/2] Add board support for Chameleon96 Board
Message-ID: <20190108064321.GA6543@mani>
References: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_224330_374190_842FA4A2 
X-CRM114-Status: GOOD (  17.81  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, nazik@novtech.com, yossi@novtech.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 15, 2018 at 08:31:50AM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds board support for Chameleon96 board from Novetech
> based on Intel Cyclone V SoC FPGA. This board is one of the Consumer
> Edition boards of the 96Boards family and has the following key features:
>     
> * SoC - Intel Cyclone V SoC FPGA
> * GPU - Graphics based on Intel Video Suite for FPGA
> * RAM - 512MB DDR3L
> * USB - 2x USB2.0 Host, 1x USB2.0 OTG
> * Wireless - Wifi, BT
>     
> More information about this board can be found in 96Boards product
> page: https://www.96boards.org/product/chameleon96/
> 
> This patchset has been tested on Chameleon96 board and the board boots
> into a distro on SD card with USB ports working.
>

Hi,

Ping on this series!

Thanks,
Mani
 
> Thanks,
> Mani
> 
> Manivannan Sadhasivam (2):
>   dt-bindings: vendor-prefixes: Add Novtech Vendor Prefix
>   ARM: dts: Add support for 96Boards Chameleon96 board
> 
>  .../devicetree/bindings/vendor-prefixes.txt   |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/socfpga_cyclone5_chameleon96.dts | 130 ++++++++++++++++++
>  3 files changed, 132 insertions(+)
>  create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts
> 
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
