Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A8EC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:08:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15122083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GHDarUch";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="p9GLObg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15122083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JTLDUdfjzyQNvUaL1JxDeZxkkjFlVZ2vt1E6F8hP5h4=; b=GHDarUchW0firf
	D/3cAItrKSmqTF/JTo9UmbfkIDM608ypfaiC86trpHxG9CKUp8afqgaqF2eFbtSN8+oq9f0NeVQQQ
	yLhQ7WZB1jQMtGlGE6zBPpfrvZ/ieehilOzG4e+h9i/y2AqSuymHqSzuu6/PJo22Hy2KPmWZl3dAp
	ad+ZRRHNNzCMKgcxyJaxh6BJ0Yp9dURw9lCdX88VPGWc/n7XUF9DFQqQLXoQTcvEK2UqcMc6ofXbp
	0dXGFDeL5ppWxG6Ai91Z/Jqq2lU1cw67Zuxg5yWRdvIm+oM8+Tki+L310oGPvrObrsM+Jg1cx9aI4
	X3Pv7RjhbOc44d/JXP1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqtui-0001B5-QM; Tue, 05 Feb 2019 06:08:56 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqtuf-0001AS-1j
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 06:08:54 +0000
Received: by mail-wm1-x341.google.com with SMTP id y8so2286964wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 22:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ELibCrneAOqwWPIu61khxaNFyTEmcNLtmVqUCXdZgZI=;
 b=p9GLObg0JIzLvnYv92UNo3hutvaKV76mneDoQ2L9/iTDSMkv3BmHlcM2r2diWaexun
 +bwDe1L79unhjKqIc7PdW6AxCpdjScxefjOqXn1Bp2WyEuEvsc8rTypwqcYBZfdaGNcp
 1avY7a1g6ehg1Q1DcR74Aj1fpp0U0Op9aInUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ELibCrneAOqwWPIu61khxaNFyTEmcNLtmVqUCXdZgZI=;
 b=h1Ad8Q3yOUDBi5gSGUcjdjR3GRSpiJMv4xp56uVrRgDrWtxgj7XF7im9JR2WjIMQsE
 8Cahal6NPMYIH174CfY0DbLJWRsoD5Oxcy+8xJSd2+h7CdhKlQCJyZ6l0wXhJeZFvUWk
 uBJoEGxxciY3btnkAKKyjvD30rhN+rpAZFS8jDAMt82jRuXserEIcpMY0fF7Fw+BgKFh
 kyZLARcl1xuBiqdxfUErr2JM+ZISilAeSL5Hs5T0LYlDpMflRAvtoUqaQUPFZbl1u529
 EUtHbjQMa38W5BcBHqcVACERAz30XZC8A5np8j45jhUS/1h+Re6BPVPiVAp1KVWg9vbu
 2dOw==
X-Gm-Message-State: AHQUAuYcIIl05wMijFhkJgsWkhZ0IMLD6ud2DoYj7qU+HrJ0nyVeJRcy
 PrjB08PdgHi5WfX/Xj9xSm0Nhx2Xy06vi05ncN99TQ==
X-Google-Smtp-Source: AHgI3IZ7vYwWoGmUAjYcSLDuLlos9cVh2whMlbvpfSVJ8Ytix0mKWBdHfrN2urnd6jPoX1ucPPMGeuzPxTUEa4j1BaQ=
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr2221588wmu.52.1549346931639; 
 Mon, 04 Feb 2019 22:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-11-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-11-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 5 Feb 2019 11:41:25 +0530
Message-ID: <CAFZiPx3niFC67o-p_NRi-ReuWYDcSJqUWmVfqKj+R2LnzAMPFA@mail.gmail.com>
Subject: Re: [PATCHv3 10/27] PCI: mobiveil: fix the INTx process error
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_220853_091211_7A4819B4 
X-CRM114-Status: GOOD (  17.13  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Mingkai Hu <mingkai.hu@nxp.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

On Tue, Jan 29, 2019 at 1:39 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> In the loop block, there is not code change the loop key,
> this patch updated the loop key by re-read the INTx status
> register.
>
> This patch also change to clear the handled INTx status.
>
> Note: Need MV to test this fix.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
> Bridge IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 4ba458474e42..78e575e71f4d 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>         /* Handle INTx */
>         if (intr_status & PAB_INTP_INTX_MASK) {
>                 shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> +               shifted_status &= PAB_INTP_INTX_MASK;
>                 shifted_status >>= PAB_INTX_START;
>                 do {
>                         for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
> @@ -372,12 +373,16 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>                                         dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
>                                                             bit);
>
> -                               /* clear interrupt */
> -                               csr_writel(pcie,
> -                                          shifted_status << PAB_INTX_START,
> +                               /* clear interrupt handled */
> +                               csr_writel(pcie, 1 << (PAB_INTX_START + bit),
>                                            PAB_INTP_AMBA_MISC_STAT);
>                         }
> -               } while ((shifted_status >> PAB_INTX_START) != 0);
> +
> +                       shifted_status = csr_readl(pcie,
> +                                                  PAB_INTP_AMBA_MISC_STAT);
> +                       shifted_status &= PAB_INTP_INTX_MASK;
> +                       shifted_status >>= PAB_INTX_START;
> +               } while (shifted_status != 0);
>         }
>
>         /* read extra MSI status register */
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
