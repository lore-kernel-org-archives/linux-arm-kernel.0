Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A4BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517292177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rUMJwLMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517292177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BX+FEXd6x0T489/KWjM2pHpygW+ZvtNsL+DO9Bzhajk=; b=rUMJwLMabfK3jy
	DrRhgQUMtsuTSbBx/fcDq46Mjf7DsclLQptitdULMiwCjYm0OIGJKCH8kPvC5kIvR+v3G4zJEii+o
	90qlGn6cG69CcEG2xHWZvbzgNt1i2hDgx/NELQNR96MAoIti6wKNXhOfKfE0p484ktzRYOiVkg9rm
	z6uPeZ1K1hK6ki3F/UPiJBXRWbIu01DyALcbFR+gdrZ3xq//gp7dde3uzKEWqw7zjlkDXJm7mNj/X
	JY6Ojei5Nkk5ga4neyZZjWYeL/88WycrH/THu7EDHP6iwLQRbSklvfI/tP5n6v1gzwPB2yk7pwhdF
	RtTwZfL671qG/USemEXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghxqM-0000c2-P7; Fri, 11 Jan 2019 14:31:30 +0000
Received: from mail-oi1-f177.google.com ([209.85.167.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghxqJ-0000b9-Jj
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 14:31:28 +0000
Received: by mail-oi1-f177.google.com with SMTP id x202so12307431oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 06:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fVy93fNR+ZKX3Oyx2564C6JZXIF8X9/cPZx9J8v4si4=;
 b=JuUJ7hSPpWyfPLKqk945SbnwBrP717ki5Ien88ls5gcPkFUpDqKk9ViZzXXkX60eBm
 Jl50TMySXFbZKCXe1rZZO3DVKIMNY8o38bYcIPxajpMkk4CUq45Ml6rWh25dk9zxqdOZ
 onJhoTbFDlNFRPX5cbKBk4LDH2SM5tyYQGokQPcOSS92V8obyQ+EP7/5kAiDU5X4pJ6w
 G1N2Htrj1si594ZNPwbwTgYsbVTAgluKuK+YlGmPSNRfY3k0uSH+lGwpiky9HWxXXczf
 8s+lzCyp1+Qua0hoCXooIG9xRvxZtl9h7GiAUNUlnCi9xBY6FZtNHfzmg9YE2LE3qwWQ
 hMdg==
X-Gm-Message-State: AJcUukerN/eteA0pVMqJh76/dzCSbS5i+5bUjSw7Nyq63tyztcqCu6on
 dMKJm6aSPi4JJVqKrJedwg==
X-Google-Smtp-Source: ALg8bN4WsQm0l3CE4srtcBiKuMuAevRTcBgPlfPUqntmq9IuC1T6tqgtGT5vBulJsp2Blm2mGs2dsg==
X-Received: by 2002:aca:bf06:: with SMTP id p6mr8778071oif.269.1547217084941; 
 Fri, 11 Jan 2019 06:31:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id x9sm32990078otq.73.2019.01.11.06.31.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 06:31:24 -0800 (PST)
Date: Fri, 11 Jan 2019 08:31:23 -0600
From: Rob Herring <robh@kernel.org>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv4 1/4] dt-bindings: add DT binding for the layerscape
 PCIe controller with EP mode
Message-ID: <20190111143123.GA6960@bogus>
References: <20190108030922.24031-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108030922.24031-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_063127_644736_64907E37 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: mark.rutland@arm.com, kstewart@linuxfoundation.org,
 linux-pci@vger.kernel.org, shawn.lin@rock-chips.com, minghuan.Lian@nxp.com,
 lorenzo.pieralisi@arm.com, kishon@ti.com, mingkai.hu@nxp.com,
 niklas.cassel@axis.com, devicetree@vger.kernel.org, arnd@arndb.de,
 linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
 cyrille.pitchen@free-electrons.com, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, roy.zang@nxp.com,
 Xiaowei Bao <xiaowei.bao@nxp.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, pombredanne@nexb.com,
 shawnguo@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue,  8 Jan 2019 11:09:19 +0800, Xiaowei Bao wrote:
> Add the documentation for the Device Tree binding for the layerscape PCIe
> controller with EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - Add the SoC specific compatibles.
> v3:
>  - modify the commit message.
> v4:
>  - no change.
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
