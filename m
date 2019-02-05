Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59982C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:05:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292B12176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gHZyu0Zf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="SRE815C4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292B12176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qn8BnzqG5EISGzieHdXPxFp1V4fQ80SA3mmnQUYk60A=; b=gHZyu0Zf1IBV+r
	uCMq/n7I0koUmvgC7LrFFBJXmt39KfHe89isQBL/W7VmAeRNI73HM/PHScma181r0Q6fPVAQtpjf6
	XlDSWPkJnA0g57OFr/wVGEQ5BL0rFagrwQi0EmyH5Tb+e5ypKyhKyqVtaLhrwon6pcFpVKBgcUv7Q
	rHJCRD3WyqbD+oVW61AmRUBCFnef2rpuO3Womb5iVndCaSnzWXc3iDBCExQVmfEcTZI9sDHAiPYW7
	/pO2YhiuXSf/xxdZdfLa6uugkLMDqhNf61wMWLk/VThPo7lBWdpHzGhBPxft8LqmyD0aj1T0/JK6E
	c2aQqI0vMB8CQXje0/8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqtrT-0000AL-5B; Tue, 05 Feb 2019 06:05:35 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqtrP-00009u-ML
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 06:05:33 +0000
Received: by mail-wm1-x341.google.com with SMTP id y139so2209708wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 22:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R58VXnmcQsUtQ66r5EJzM8NXDWdDZjbuPCSxVpk2C04=;
 b=SRE815C4N3sktm3vi9fx669wnGcjRJT9I7x1DlNmRwortUl/zUl0f6xdrnjuamG0lJ
 V+w/NRC2xDQ838y/irmlvhp1kG+5Fpiy2d2IKKMNXjoxY37/f2f1gwm+JAc4dDGdSKBo
 K1p5gkLFxZ73jk7SP0Mv349nWkqfkRcDOdamk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R58VXnmcQsUtQ66r5EJzM8NXDWdDZjbuPCSxVpk2C04=;
 b=d4/lV5We5SroSpvunzAsMYDVFVGOeLYLqibppT0JU7gkb3rTna3nIfq4h6wyId8MmF
 aUx/2lKjwdS8NOAodnOCAywKPXbfuGLEW+mVVv2xO0tpQmeC18J5c0wRTwt2QcrToY84
 qU5D5cv0bnfVS04ZFMcRq8ghdYhoj5Vwfkk+7m+vzf0ZoabagtGHgLLbGEwWW+nirCfL
 dAMGcb+ff7fIEOEydVH3zv+udmNNZ5/EqVqnmbxR4YWkro3b+XXpoAfnhhTi4hijo1z5
 getMl98Yq+u1zAADCu500w1u7bxoaJTxlnC8ikf8nETpfbirLYrZZXUMTd2t4dyedECp
 GSQQ==
X-Gm-Message-State: AHQUAubn2mwT0hIhmhjfNQ54MBX64fWvfXECPq5Rl9OqmaxRcnHVE9VC
 IgpMuISKzz8xeKD1HESvSYD457ENbjvrFyCFg+Y5bQ==
X-Google-Smtp-Source: AHgI3IYdRky9neI+cisyum0AuGIDv/vJG5HiERzlGTNDOxIyK8MM4wPBtU8pcm7t4qEqVmdBSe+Hu5fzkT9sVsunRew=
X-Received: by 2002:a1c:9d57:: with SMTP id g84mr2253821wme.143.1549346729826; 
 Mon, 04 Feb 2019 22:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-8-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-8-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 5 Feb 2019 11:38:03 +0530
Message-ID: <CAFZiPx3soEXCKixiix=L+Bvy2-V2rqvxdHEeYDgdnnra+AMq4g@mail.gmail.com>
Subject: Re: [PATCHv3 07/27] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_220531_734528_94E10C77 
X-CRM114-Status: GOOD (  13.54  )
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
> As the .map_bus() use the WIN_NUM_0 for CFG transactions,
> it's better passing WIN_NUM_0 explicitly when initialize
> the CFG outbound window.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index b2cc9c097fc9..df71c11b4810 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -612,9 +612,8 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>          */
>
>         /* config outbound translation window */
> -       program_ob_windows(pcie, pcie->ob_wins_configured,
> -                          pcie->ob_io_res->start, 0, CFG_WINDOW_TYPE,
> -                          resource_size(pcie->ob_io_res));
> +       program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
> +                          CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
>
>         /* memory inbound translation window */
>         program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
