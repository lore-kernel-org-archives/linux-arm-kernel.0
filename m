Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4CAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:27:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DE220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g/+BOOxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DE220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RPhVeutVj2qDcoToZhbTIP3qlbzVW/cLoUP/Crj1f2s=; b=g/+BOOxip5NsGO
	PBfbCrTYfxeT3ZmQpgJ8Bh8eCaSFO72AImz0Ttr1pVXpx0jQ0lSrxtPpgm5kwITMCjMbwA2yOnTpR
	i0GJUmFvVjA82QZnI3hdHtgtjqD6RNJ0FS3AiJmAr3KqzZoigQ9QKN4bzc8+WQ4WDMYrsERTVy2s9
	VQe0kB6tDgzf3/qCdGLbcLmza5M6ZNQ2uPDlYa6tb66jUpvViIa75iG9PjoeqqQF9olfjK3e/K8Hm
	24g5ye3nVKcQLf2PdXiXNdLEZYspy4uk/FVzus8agBQxUBN6FDtRDpsKEBqzroUbW7PAwflqJ0Ji+
	GIXFx9dRsebL8n24ycEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWU1W-0003q2-TO; Mon, 10 Dec 2018 22:27:34 +0000
Received: from mail-ot1-f51.google.com ([209.85.210.51])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWU1U-0003p4-8p
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:27:33 +0000
Received: by mail-ot1-f51.google.com with SMTP id v23so12076012otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NvRhIVVhr/cozyJX9RAjS/CB+7fBgUA/l3WWhv0euSk=;
 b=K5oZHrhEH9yeT88j82Ljsl4ZQnef2CxjPKmMAh901SFSuCJBwazlkG0XmgqILVXILW
 RAyafxiZeoYMnatoN6879jvOzUY1R/PRYepOv76OsqnpQ6zY48sfcQCjryO8TgS6n7DH
 UAUMFQdJt5RxoYcu31y55XU+Ox7EWzNVtqyVW50Fup/0C7fLjCoEWgiZ18o/B9udTu4C
 nNiwalIsA6T64oRpFhrzjLK7F/81wplNi689k3UEDzzdfSTzZnzJeFbE2sS+VFm6FaMe
 Ia5hd2V8g0i1PS8ElMfXEnMhs/kYDIE0jqNKPk3zQdWro8Ty1DYLCu6c8XHskzIQosUk
 8+zA==
X-Gm-Message-State: AA+aEWYqIkgPR6VYmd51BpjWBy+qLz1Db0ZRVkpplrvqq0hxluK6GYDS
 iR2N9owlU+hS1TEReKG8cA==
X-Google-Smtp-Source: AFSGD/UddJoUUe90aa225QLWVvx6jXXsrkNO0JvtpOE/jl2a4WMPME28Jfk11g9sdE5mSwnpMhleLA==
X-Received: by 2002:a9d:3208:: with SMTP id t8mr9630444otc.312.1544480841066; 
 Mon, 10 Dec 2018 14:27:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s66sm9097817oia.55.2018.12.10.14.27.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:27:20 -0800 (PST)
Date: Mon, 10 Dec 2018 16:27:19 -0600
From: Rob Herring <robh@kernel.org>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv3 1/4] dt-bindings: add DT binding for the layerscape
 PCIe controller with EP mode
Message-ID: <20181210222719.GA6506@bogus>
References: <20181203103505.46885-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203103505.46885-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_142732_313978_B258D855 
X-CRM114-Status: GOOD (  13.01  )
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

On Mon,  3 Dec 2018 18:35:02 +0800, Xiaowei Bao wrote:
> Add the documentation for the Device Tree binding for the layerscape PCIe
> controller with EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - Add the SoC specific compatibles.
> v3:
>  - modify the commit message.
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
