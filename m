Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78148C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:55:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E04320861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SQYdGiN6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6wpTH0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E04320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vnd+keCdzTbeaBu+07VcH7TTKtppqIJHzoRBQSzi0x0=; b=SQYdGiN6FMptEf
	XWmkBqM/hWUq76UZITTOPP24wgWlPX5tjVKo/qJYJwg6VdJlxc71sC3kfAeIHNZDPOGVGoDwp2E+Q
	Lcr1bF782v3minfmn0OIWAv1kgruhk45wEoSJM8rjtWsl3EDYGkMlgJkB7UASPhRYzMCJcz/ly5FG
	cuOWFqb0NInlJVGGqGF89EG3AdGRkQPqarxCOM6A53beXt1aWJfEJr7lkIj10uNJ+QR+Zfm+Jub4B
	FJhhDoK5oy+D9TkL6T7J0YhkjZRdCkg9K8D7+eSePccMDBs4sueUmuyHU0GDKA/JCEMftYxeb8V4c
	eVXCOrJbP/VUMb5df2vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glmDo-0008Dt-MD; Tue, 22 Jan 2019 02:55:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glmDl-0008DR-Ba
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 02:55:26 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7455920861;
 Tue, 22 Jan 2019 02:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548125725;
 bh=9jX+hExG7Z/VsPHCaZ4+xU/CGWwSntX6wiyeWXQPH0Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M6wpTH0z8KUoRLq8TKHHvc5tmbK2flUrWDjELSLiWxLxsezfClVWEz57zNpeBnV5s
 D3EsJZT7+eTQMMSItEOVKyIxen+upLcrPytEQ8PFhPlkH9QEXvuPC5cFZjgBiLrYdg
 R1BhIwJ9NxBvmZdSmd4Tnwg7Z9pVneR8y7FMhRsw=
Date: Tue, 22 Jan 2019 10:54:43 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH 2/3] Documentation: DT: Add entry for DPAA2 console
Message-ID: <20190122025441.GB19233@dragon>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-3-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545406240-3061-3-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_185525_409472_35B36FA9 
X-CRM114-Status: GOOD (  15.49  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 03:31:11PM +0000, Ioana Ciornei wrote:
> This patch adds a devicetree binding documentation for
> FSL's DPAA2 console.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  Documentation/devicetree/bindings/misc/dpaa2-console.txt | 11 +++++++++++
>  MAINTAINERS                                              |  1 +
>  2 files changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/dpaa2-console.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/dpaa2-console.txt b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
> new file mode 100644
> index 0000000..f4e16b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
> @@ -0,0 +1,11 @@
> +DPAA2 console support
> +
> +Required properties:
> +
> +    - compatible
> +        Value type: <string>
> +        Definition: Must be "dpaa2-console".

Why this doesn't need a vendor prefix?

Shawn

> +    - reg
> +        Value type: <prop-encoded-array>
> +        Definition: A standard property.  Specifies the region where the MCFBA
> +                    (MC firmware base address) register can be found.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b76a80..229d4fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5969,6 +5969,7 @@ M:	Li Yang <leoyang.li@nxp.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/misc/dpaa2-console.txt
>  F:	Documentation/devicetree/bindings/soc/fsl/
>  F:	drivers/soc/fsl/
>  F:	include/linux/fsl/
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
