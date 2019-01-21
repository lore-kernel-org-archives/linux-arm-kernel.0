Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EB4C2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:50:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1D620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z0wHRVMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1D620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4gW2g634d2oChWav0H+AjIfUVbp+7fRoMGhIL2dD2Ec=; b=Z0wHRVMtUMlvlh
	8WBQ91L7BOo8A9jVcKhWj9wBPJU3ldthcH4VzvU/O3/tFLGiHdURJtU+nPk2uRzhWDcO5cXazLTMG
	c+mnfGcjJ9fZvf5EOKhVZvYYuRNOeXCTVYhmEu9HgkiMkVUtPUwYVmLOJ4Qx+VqhLeSnRV2zrXBPp
	S/CFQzuVfny5MCnmXoDrkI38tuAoXtLgIMMgiEDwEAD5rfHuxMpVwRfGDJwRuUBeces0dDr9oZ6hW
	pr63hoywzBWgcgDI43aqGjNIYReTZvAlwH1Qgvk70JtYevfBzn3+Q+nXliqEANkXhmrTmSaJRTSCd
	YZmd+xRIt4gGdv9VH2qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbpj-0004yb-2C; Mon, 21 Jan 2019 15:49:55 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbn6-0002fF-6p
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:47:53 +0000
Received: by mail-oi1-f196.google.com with SMTP id x202so14853525oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=v5Cag2bb1igmx1hitA5tXhWs1KMAnmvIryUl8ESliuY=;
 b=QObH7Xz3Mp42lJM0ASfRHL5zddwtBBszQ7XR1zRH1hMezlkRFOYkVeMXqVWy0ZJQ0U
 Yh3/C6ltehhhURPAu0571lHcPRj8ExxLsAfHYwYoTsxoQ6wWTtIWfqCeinyGhkTNJuBk
 wHHHXlEiwE+q8ZldtHBn3PeBa/nPTgMFtF+EPn+xfkPVzjHiBX+gqXY9G0pKp/Fd+6U7
 4anwq0AYP6wXE9pNyePyjZFKevJUuQgqbOYWnvRx9Op8fKm/0B22t4wsf+AtUZIa3wzX
 oxAQ81NHhosrJVtwBGbShzDNXfidNPya/6r7TWiCPpMN0cxcQMlv07ch92anz4/Poq5y
 msPg==
X-Gm-Message-State: AJcUukflUYP/NC4eeub1xy6uFvw1rko6Zr/vDV22ubCznwpGYyDbpiwu
 tg3Xa+PUA6l444VvZg3b/A==
X-Google-Smtp-Source: ALg8bN56MBiQdIRF1ImH0EjENgrD0JFR079S5Qr81gZVBfJlAcbU1SH+5Cessza7vQjhuWACNVTdkQ==
X-Received: by 2002:aca:88a:: with SMTP id 132mr6117440oii.224.1548085631296; 
 Mon, 21 Jan 2019 07:47:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id z7sm5933640otm.63.2019.01.21.07.47.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 07:47:10 -0800 (PST)
Date: Mon, 21 Jan 2019 09:47:10 -0600
From: Rob Herring <robh@kernel.org>
To: Nava kishore Manne <nava.manne@xilinx.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: nvmem: Add bindings for ZynqMP nvmem
 driver
Message-ID: <20190121154710.GA31999@bogus>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
 <20190121173835.21173-6-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121173835.21173-6-nava.manne@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_074712_758891_7518D49F 
X-CRM114-Status: GOOD (  11.46  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Nava kishore Manne <nava.manne@xilinx.com>, linux-kernel@vger.kernel.org,
 JOLLYS@xilinx.com, RAJANV@xilinx.com, robh+dt@kernel.org, michals@xilinx.com,
 linux-arm-kernel@lists.infradead.org, chinnikishore369@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 23:08:34 +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP nvmem driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-Added nvmem node as child of FW. Since nvmem driver is a provider.
>   
>  .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
