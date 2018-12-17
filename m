Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F90C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:58:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD332146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S3taw1Oy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIC4UmgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD332146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D0WjyhEkgN3Xztum5xmrAVH7rQiWmq3ow6sCkWRabR4=; b=S3taw1Oyka8NbW
	S0rPQUTODn44r4xVw9o7tvKI/M7lgo/mammmnIuOZRQdLFhIRU2zr41OkPtKtyHRjqO5SLoD4aDhd
	OR2K+0q3a5emiI8yPDKau6JrmsVDZaTZm13pL8P6eAfKaM3QmUUnWWLp0Vm53vfL7k0CdqB+RKi3z
	LB5py+yF19GtdPUCR9I6ix4O4fs3OQCHZonNhgAzj/RJf/Tzg/KzGCsCG65h6YVoD9epnzlBsBrHt
	8SQv4utnCeLoJFjJ2mo1ASTwbWzLpNwbSeg63I4ShOP8qdfhWMwtXTzB6Dj0Xpvy94uQBQMiEBaHY
	CJ7XoKgDoOdfEDL5Tr4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtQ1-00062N-H9; Mon, 17 Dec 2018 13:58:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtPy-00061J-7V
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 13:58:47 +0000
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4B0282133F;
 Mon, 17 Dec 2018 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545055115;
 bh=fMAJHnfi5IG4Ruj4T3wXEl4IsIwZe6gAaTaAQFNacZ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MIC4UmgFCJhAASGPwQ/R2JehEu2jCJ92mdSwyM6IM8o6/CSwqPcpfwolKflSUM0hk
 V88ifYAgrUgP1iIamyzKZt8igCCvW8aWslmUwQtH/eq9+OVHfES6DGsePBfPfcFI9m
 VsOaWTNvt0nsG/UvXozjweEkDCP05izvsR5TMcK0=
Date: Mon, 17 Dec 2018 07:58:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 3/3] PCI: imx6: Make fallthrough comments more consistent
Message-ID: <20181217135833.GJ20725@google.com>
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
 <20181216230916.22982-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181216230916.22982-4-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_055846_289536_C214503A 
X-CRM114-Status: GOOD (  16.95  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 16, 2018 at 03:09:16PM -0800, Andrey Smirnov wrote:
> Convert all fallthrough comments to say "fall through", as well as
> modify their placement to the point where the "break" would normally
> be.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>

I didn't make it very clear, but my suggestion was really to remove
the annotation completely; see below.

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 59658577e81d..a0510e185d44 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -362,7 +362,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  
>  	switch (imx6_pcie->variant) {
>  	case IMX7D:
> -	case IMX8MQ: /* FALLTHROUGH */
> +		/* fall through */
> +	case IMX8MQ:
>  		reset_control_assert(imx6_pcie->pciephy_reset);
>  		reset_control_assert(imx6_pcie->apps_reset);
>  		break;

IMO this use of "fall through" is superfluous and unusual in the Linux
source.

A "fall through" comment would be useful if the IMX7D case had
executable code but no "break".  Then the comment shows that the
intent was to execute *both* the IMX7D code and the IMX8MQ code and
the lack of a "break" was intentional.

In this case, the intent is to treat IMX7D and IMX8MQ the same, and
there's no executable code specifically for the IMX7D.  I think it's
easiest to read that when the list of identical cases is all together
without the comment in the middle, i.e., as

>  	case IMX7D:
> 	case IMX8MQ:
>  		reset_control_assert(imx6_pcie->pciephy_reset);

rather than this:

>  	case IMX7D:
> 		/* fall through */
> 	case IMX8MQ:
>  		reset_control_assert(imx6_pcie->pciephy_reset);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
