Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73809C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:32:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444852082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hYNiWDFw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO/WafPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444852082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VUo1M/a8q8dqaE77c/ECgxVTNRATsT6VXq8RHcVQ7TU=; b=hYNiWDFwMs7JTr
	WsSUns3+CTfO8cDQ0Dl5vAwnZUvBdT9uZp/bTucUn6vXomcQ+cgRs7ujva82PNc1581y+Tjvf1F/Q
	1OAnq98W4+qeJrqxWdxDK0wAI4E+VOVuUrla4nNgnVdQVSrYyZHjUB7ogaupnHEU4A3oZ4lKoTl7i
	gmrsHVnMXV/Ryj2w8URG/eQ+z0BOO+Lr/GiZGPIHUEyv8QH9kEzONgsgqi0Wl5t3Sb0q85nXhadhx
	p+RFetMsu6+NpPCNirFnalSixhdAVogpIJ50AIHISvt52fpWCHvqViUtlHoHV7SHaEFPn5+a3i1hp
	EDPQuSaXwkCiqg8KOMAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUjSz-000835-1I; Thu, 06 Dec 2018 02:32:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUjSs-00081r-MQ
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 02:32:38 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 82C742082B;
 Thu,  6 Dec 2018 02:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544063544;
 bh=MxhCiFQatjxOMgz+1rqbchlQdGtrqo0NSsYG5FYWZ6s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WO/WafPMZrb+EAztsrjxaORgNQ7gzJjtHZcTqVxc+J/O4V4tgZLQHDchsJgFwnEbU
 cl3vKj9Dufw7NpaM9XGFPGkF9cXJd0aLl8yC7fTGaenzs/1JM0I+g9M/EfcjWCTD4O
 wV2XcNOBlG1bOpEqr71/pgDECRwouF7S888ccBR4=
Date: Thu, 6 Dec 2018 10:31:42 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc
 bindings to json-schema
Message-ID: <20181206023140.GZ3987@dragon>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-19-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-19-robh@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_183234_749402_658C817F 
X-CRM114-Status: UNSURE (   7.79  )
X-CRM114-Notice: Please train this message.
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
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 03:32:07PM -0600, Rob Herring wrote:
> Convert Freescale SoC bindings to DT schema format using json-schema.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/armadeus.txt      |   6 -
>  Documentation/devicetree/bindings/arm/bhf.txt |   6 -
>  .../bindings/arm/compulab-boards.txt          |  25 --
>  Documentation/devicetree/bindings/arm/fsl.txt | 229 ------------------
>  .../devicetree/bindings/arm/fsl.yaml          | 214 ++++++++++++++++

Rob,

I do have any changes on bindings/arm/fsl.txt queued for 4.21 on my
tree, so please send it via your tree.

Acked-by: Shawn Guo <shawnguo@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
