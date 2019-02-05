Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40EEC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:05:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8E82083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fmzhHojf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="PuZH3LDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8E82083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VCQQ7B368r6zt9I3Ic/iePBEhpoqfXTA5vy6DnaXvHg=; b=fmzhHojfGHecdb
	tDAowQcdl4r9vaTvUXnmVtB/wSDMzZ573tlfC0BFA9elHNVQFgAWMq8loPjACzOQHMeQiHGyg8qV+
	n03rMLYoK8y05Wtu2ldiGN0WuQ3W2dajW2hmWjP+FKP1EyjQ/5p8560w0Oq3+5jVIZ2AgJpHmYp8z
	sMyYjGmyZstTAbsMvAi4q0OlAmvIt0w4lIFoxuzdIhRLoUa+VhDhq1HrG8szHi+DFpWbwU+OKSRcE
	CAT6PbYNyQlgu5AhTrI+G1tS1SwQrR1gSQWq9aWB7qLO/ioeTVSCq2Hjmj0qycnayQqEVgvNIPa9M
	SdDRgYDIgDh+GbA+Tnfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqtqp-00071p-Na; Tue, 05 Feb 2019 06:04:55 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqtqm-00071Q-Qm
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 06:04:54 +0000
Received: by mail-wm1-x331.google.com with SMTP id d15so2232356wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 22:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3aQtR76X4VtJOe5HikigbKlmMNbkcyXJpnJePsqpATQ=;
 b=PuZH3LDRHXppM67bMX3nu+bUj3v5Xdm4kGzc3NjlmHaE5N4KR78ROx2/Ki4QA1i84K
 NDeWLjYlBuLu2VrSQXSQkYUMnO/DZFqh/Q/E+4CZCtSRTdasmo7B2tM8DrLl6qzcJRjM
 LIfV49RB3P5yCq5775EuUYxz6sh3EUkT1rbSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3aQtR76X4VtJOe5HikigbKlmMNbkcyXJpnJePsqpATQ=;
 b=p/Ng192WiMKeY1dMisGf6HJNRwqnaZKxoUrqDk7sn7kyZ1PsNG1vKtmJlChIiO6gKz
 xNkkdzf6er/YNS6/kaSaRI3PCUEzxEwogmBNGgmjBeRPWngXOphLG7NlSpkKEUnQXPkP
 oNsHdkp3BUuEnwxeeQjUqX4QjZk817zOjG9NVHCz0urwYMcTtuuOwhUy8OFLORXnh9Qw
 E90IA9Vz0kfGkewHPEYXl5cD/z8c+nfBFxQ6PDyY1wqjYekbGnIFZlA2vq2r0vhilur9
 8xve1XJ/E03wAnVj13Ziwn0S5kpRIRqMcEsYVxnpzsWl6zfth+NEOB7U2bfVmZ+umJIx
 w/Tw==
X-Gm-Message-State: AHQUAubqxJEbp/cDqKUoE6XoTarRvZuWGr8XI3XiMl5sI9qJkUDnI3ns
 sQu3xiA+6m2Lbhkc0hAxgOq+Vg36QbKt1AZTi5ZIYA==
X-Google-Smtp-Source: AHgI3IaUIENwON4vGBErykNufFGyL0jwh+Mj0IuiqAvWyNwrw1Szt8ore/d9WT1qSCmzWYRd0/UO91ZvfY245DOe5Rc=
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr2145787wmk.152.1549346690855; 
 Mon, 04 Feb 2019 22:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-7-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-7-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 5 Feb 2019 11:37:24 +0530
Message-ID: <CAFZiPx3yW89pXsB+Qo5nSQX-C998CYPVr7HWDrJotrV+6q9DBQ@mail.gmail.com>
Subject: Re: [PATCHv3 06/27] PCI: mobiveil: replace the resource list
 iteration function
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_220452_860935_1E39B76D 
X-CRM114-Status: GOOD (  15.07  )
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
> As it won't delete any node in this iteration, replaced
> the function resource_list_for_each_entry_safe() with
> the resource_list_for_each_entry().
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 8ff873023b5f..b2cc9c097fc9 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -569,7 +569,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  {
>         u32 value, pab_ctrl, type;
>         int err;
> -       struct resource_entry *win, *tmp;
> +       struct resource_entry *win;
>
>         err = mobiveil_bringup_link(pcie);
>         if (err) {
> @@ -620,7 +620,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>         program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
>
>         /* Get the I/O and memory ranges from DT */
> -       resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
> +       resource_list_for_each_entry(win, &pcie->resources) {
>                 if (resource_type(win->res) == IORESOURCE_MEM)
>                         type = MEM_WINDOW_TYPE;
>                 else if (resource_type(win->res) == IORESOURCE_IO)
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
