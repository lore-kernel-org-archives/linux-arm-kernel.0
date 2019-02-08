Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B77C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:28:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D5B2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NdO7EXp0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="L/fyudzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D5B2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HB0uxYd0Z7cE+BFMJMhNlgWfeLEtJZlAdERwxWCLaWc=; b=NdO7EXp0JubkW4
	WwwIOlKxLd0tdFoU6sfWIW0vFS2tnyb+EsOekE6srxUCl6/P1qVgy4bDvr4PLZ5oKbnDg8AewaW5m
	3SmQVJThjQ+EqakxIxY9lkrEe4zEctiEmUIB700TpH+kwr6dUf3+ANtlLhe1qhEbOxuw6kKVZluwl
	oNq3N2zHxSotuohCqhQ4I5d4L/Y09OOH2Ds4AR84DGJDEgPifGYR9oh91f1MQXNNycxk1tgrAoOgu
	RODkqt3jEb8TLa9/HP510loehIFBCQ34H65r0LZ+bUnxuSuCiEDKi1RGL4luZr7lL95MmjR07cGdF
	o520QK5Ptsx6OAQPUx+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5H2-0001z4-En; Fri, 08 Feb 2019 12:28:52 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5GW-0001S8-KR
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:28:42 +0000
Received: by mail-wr1-x442.google.com with SMTP id z3so3399371wrv.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U4llWnWHk/iioaBg109tqNu+HuUT0xmojGp7I0EC54Q=;
 b=L/fyudzrkzoYTq4L/ntv6UXvIiIYQqA7Ub6OxQPODZcgS/4JVHGT856I6pqUC7Zb0G
 tFb21UBAOnBWD35EphMs15SF7tcLOw0jAiGEHEe6OmRmpSUTj8c9+Qwc+Uru7p+SYopy
 yhQ2gqJozThixs3FipH3W96aeQ/uAzyRp6uHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U4llWnWHk/iioaBg109tqNu+HuUT0xmojGp7I0EC54Q=;
 b=HhsEyKhDSuwBC0ToW8kFcVZVlZWn2Y2NKC7JUeje/xRVg/ai4qahWv3o1QmArrwNSW
 zPWBWefWreiRMD9nEpkoGJW1Ve/2ik3bpcegV3qgcvF47IHAi87q1NOiEEl6HHH0Qz99
 Qhjlqc998zLSMA3oukRUhNTv2UdGMsXVtUhaNx4AYJIGoZt+xVdrUlGXEwcTQ5sdS8ZK
 q2x1G6XKkKslWj4kcJAUz23E4YYnGZHDBZyP74upSTTpFLleKu4iCWpSYA+koNxLmVPS
 igUkizadojn+ASiZSgpwtmoZBm/gFVl6nE/frbCI/Ct/5vrAbKvQSc6477nHpNnvvLGt
 Rq2Q==
X-Gm-Message-State: AHQUAuaW3Y5PzLeOSIhbbLiTH+ALlw59symLF5NLQEX5NDeaQWxseY+o
 Wgc3WgQjmGY1w8Z3lTsmvgRbxAyMZm8IRB5zy7JTnA==
X-Google-Smtp-Source: AHgI3IbX0QUvVY2C3pm3ZumTALuuw3Fd6Hjq/SfVvqMKAzNqiHmSISFhlnJFt3zuK1w52e5QmA/4xzfTVQs0EHUfML4=
X-Received: by 2002:a5d:468e:: with SMTP id u14mr14259352wrq.253.1549628898050; 
 Fri, 08 Feb 2019 04:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-14-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-14-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 8 Feb 2019 18:00:57 +0530
Message-ID: <CAFZiPx165X4AQqxFW4r_zZDNjB29-OQD46xce2Lhh4=n-qYHxw@mail.gmail.com>
Subject: Re: [PATCHv3 13/27] PCI: mobiveil: move irq chained handler setup out
 of DT parse
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_042821_800417_BCEC48CA 
X-CRM114-Status: GOOD (  14.31  )
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

On Tue, Jan 29, 2019 at 1:39 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Move irq_set_chained_handler_and_data() out of DT parse function.
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
> index c2848c22b466..db7ecb021c63 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -460,8 +460,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>                 return -ENODEV;
>         }
>
> -       irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
> -
>         return 0;
>  }
>
> @@ -902,6 +900,8 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>                 goto error;
>         }
>
> +       irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
> +
>         ret = devm_request_pci_bus_resources(dev, &pcie->resources);
>         if (ret)
>                 goto error;
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
