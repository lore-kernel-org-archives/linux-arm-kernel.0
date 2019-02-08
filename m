Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86E9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:39:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938C02077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TtWoydq/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="fHYpdPCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938C02077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xLxQWnOvonE3eYEiJuvULuQiXxP5/rJB1Glhbo7TXx4=; b=TtWoydq/SMl92K
	InGChyaQelKzOPfJtxu2jurutX9appdUDOm2+cDJzslytQtLIejebcnxQEjEFzWGu3tYCH0r4wUjp
	l9tgSlty3WIbAvA6UwrhL8b7NcP1rtbn5aCDj4eYkTsxMJcl09enNGTqvWI+HANcsOLJCz2WM5Z+O
	tWPayStqJjbkjrXlO1n3pefNt42QmUmpoiW+ormGQ1HZRw5BmP6wH4H3msokjX3saHsgcRVigZv8q
	CyizRslAMsSqPau+MmacG+hbeu9a81zHdr+6jBvveZoKfy1E2Kx+yIHVBV30K2X47Uc2h1lnWKPw+
	j+f/sTN1bJhc23Zh0M6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5R3-0008CW-59; Fri, 08 Feb 2019 12:39:13 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5R0-0008C4-Kh
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:39:11 +0000
Received: by mail-wm1-x341.google.com with SMTP id h22so6710437wmb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SOmmoEnVav+euIt9Iv/uAN2WfRPzXaYHTM5sqnc8FUg=;
 b=fHYpdPCuqrHZZ8RtFUO8NNmfzDp8Hp+hyisTU7ORlGPs+J7aGd7wnv9Vj0aASwU2ZP
 CA9u2vEdVZvsq0UwbBucKmlcDIP72/hSmegsjMGX9ybOb55p9E5+961tIdC2hK+p8DqI
 AmuvcI1cWY17NJvHINuU3Pl5Q6XYPARf6imrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SOmmoEnVav+euIt9Iv/uAN2WfRPzXaYHTM5sqnc8FUg=;
 b=gSO4Don4yRjKtraRVqg9qYWTNJIkXDyOAk+DDmZ8I0VXnHjRswn38eOtWnJyJBaWbQ
 V70zzeC4hwC0QDrvJOH7OxxS5oQrAjLLOAK2NOTUvKhVVz/PLPPvQPIb7iJZ5gsnEMI+
 l98BqmmSbwELQQpgIHGjm9Hwob1jjiEy5U8BFbbxgUdDd0AZ+5JkYZk6XtjJojcV2B7+
 rCZuXbMZNMBm/WP2KoRSKKizD8n25ps2BSq1RvytUGEWolkbMqzhihcGwqwSEZ/yw9tD
 ZyrvB9AOIFm1SN4sb/gG88eP9k+ORA6txCiZu2cV3ca6oe0JsML1N7wqo/kpNS3QFIrh
 9djA==
X-Gm-Message-State: AHQUAuZlEQ4RQc0JYe2vjimr+CFLHvS4btoxrJM9ypOSOsdryrz8gynZ
 Db2PQ7YmENBc+hN8fAevmM96V3jSFeG1Jn7PA6PjTA==
X-Google-Smtp-Source: AHgI3IbFjpJWc8rNSFfqShcxmeGZCZTlTw3MsHSYS4+CSbBi8WavbbLbYYm+HrwAPPxI2i47LEa7EBpfVljyxDI0qas=
X-Received: by 2002:a7b:c458:: with SMTP id l24mr12191490wmi.143.1549629548841; 
 Fri, 08 Feb 2019 04:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-19-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-19-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 8 Feb 2019 18:11:48 +0530
Message-ID: <CAFZiPx0v9nw=k=Cq3dhy_NB4iR7P0FmvZ=9hgKv27xbgxaCFNA@mail.gmail.com>
Subject: Re: [PATCHv3 18/27] PCI: mobiveil: continue to initialize the host
 upon no PCIe link
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_043910_676025_DB672143 
X-CRM114-Status: GOOD (  15.68  )
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

On Tue, Jan 29, 2019 at 1:40 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Sometimes there is not a PCIe Endpoint in the PCIe slot, so do
> not exit when the PCIe link is not up. And degrade the print
> level of link up info.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 1 -
>  drivers/pci/controller/mobiveil/pcie-mobiveil.c      | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index 1ae82e790562..d1765d572f44 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -596,7 +596,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>         ret = mobiveil_bringup_link(pcie);
>         if (ret) {
>                 dev_info(dev, "link bring-up failed\n");
> -               goto error;
>         }
>
>         /* setup the kernel resources for the newly added PCIe root bus */
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> index ee678a60825d..370658d6546d 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> @@ -222,7 +222,7 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
>                 usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
>         }
>
> -       dev_err(&pcie->pdev->dev, "link never came up\n");
> +       dev_info(&pcie->pdev->dev, "link never came up\n");
>
>         return -ETIMEDOUT;
>  }
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
