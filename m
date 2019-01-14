Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F3C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:17:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F1A206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SXahV/GH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F1A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pCb2WNmSw5lLlwaLRATd7NiLuQScK/1XFoPe9t5kr9c=; b=SXahV/GHjwZW3Y
	yyq2Hs2yXWQkm0UlOjfPZM03dutDqqwUfdaF53ChL2Qvf9kvxE5g5OUaMvi87uEbClw5jqNw4pvWj
	utfalkDNpB4lPb16gn4ClbPGFBolbAH3CjWtTa/DjvW9qeLnPUgsBnA3HfAxh0Xm56TT98hlOGkTx
	61QnGFAVxZ56vwM4sZAPdhBpeQG4k1eJfEbvPGah54pdlGJT1IR83VDPHI/54WQ+/8MxCA/ZUbj5g
	MBA8Zyq18OL7zr0WWvz6iugM6KS+LiW3UystyEkuX621NG+wU0SqpdCivKneXo9pmZ9PMLSIxqkua
	9hsfwsRtWPmxaR1noxVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj7jX-0008Er-Td; Mon, 14 Jan 2019 19:17:15 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj7jU-0008Du-8V
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 19:17:13 +0000
Received: by mail-ot1-f66.google.com with SMTP id i20so180927otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 11:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OM/aIfnBVafWaMBtKs+zpeHlo8uj5Rb6aKAakxLObyk=;
 b=QSABVhdvJ12Zyjwyqf8lZ9OObtog2Nuy25T8sy2PloLn528Yz7UUB9S3qs2rNQSDID
 9zB48qpxRiwdh1YtkJmt7RViwAURYL5nB+i125zuBPVslTaFXC1Dw8RdI/ubOnCBjm+E
 mL8VqIG/oYABbuQ9Ntq2FwbLGIqD11sMAE2epXrL1LuYZ7v8ByKwibxqLqGn0PIfccWH
 r+NWjaSMRfgSF2PvgJLLw/3Klw1/9Ic1T9EYm9Fj7UmT9vGACz01Rf3Vy7m8nQ1lTr1a
 DK6fihBX1TzykmlWnUE7VantQeH4tSzJLER6pMf+gQI0KH7CYJcoZH2Yh8cnLH1LqumG
 F29g==
X-Gm-Message-State: AJcUukfqRPe4z3NTgU43xsgdzDcCR749yxVFmHO0YMkCQ6x7gRrir8kY
 yXTiPsaqChnFq346+nkuSYnk8U3Y
X-Google-Smtp-Source: ALg8bN6tGHj9CiL5z93wss/NFvD94/aUQIZEP6GaT3824MuHHrgUnBdKkBB3p7sApq5WNWfJQwkLCg==
X-Received: by 2002:a9d:908:: with SMTP id 8mr23727otp.28.1547493429098;
 Mon, 14 Jan 2019 11:17:09 -0800 (PST)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com.
 [209.85.210.42])
 by smtp.gmail.com with ESMTPSA id r184sm495724oif.56.2019.01.14.11.17.07
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 11:17:07 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id n8so138373otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 11:17:07 -0800 (PST)
X-Received: by 2002:a9d:1405:: with SMTP id h5mr16517479oth.331.1547493427615; 
 Mon, 14 Jan 2019 11:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20190114050237.32140-1-Bharat.Bhushan@nxp.com>
In-Reply-To: <20190114050237.32140-1-Bharat.Bhushan@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 14 Jan 2019 13:16:56 -0600
X-Gmail-Original-Message-ID: <CADRPPNRXgR_c+7tT9nv5QVBsHxm662T0sYwAhHS1PO=O9SC5Tw@mail.gmail.com>
Message-ID: <CADRPPNRXgR_c+7tT9nv5QVBsHxm662T0sYwAhHS1PO=O9SC5Tw@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: fix cpu range check
To: Bharat Bhushan <bharat.bhushan@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_111712_308808_B3CDD1CB 
X-CRM114-Status: GOOD (  15.34  )
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
Cc: Roy Pledge <roy.pledge@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 13, 2019 at 11:13 PM Bharat Bhushan <bharat.bhushan@nxp.com> wrote:
>
> cpu_possible(cpu) will always return true when cpu parameter
> is from cpumask_next().
> Check for nr_cpu_ids rather than !cpu_possible(cpu).

There is another patch pending merge seems to cover this issue too.
Please let me know if it doesn't.

https://lore.kernel.org/patchwork/patch/1020905/

Leo
>
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
>  drivers/soc/fsl/dpio/dpio-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index e58fcc9096e8..eb369dd9e0a7 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -133,7 +133,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>         else
>                 next_cpu = cpumask_next(next_cpu, cpu_online_mask);
>
> -       if (!cpu_possible(next_cpu)) {
> +       if (next_cpu >= nr_cpu_ids) {
>                 dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
>                 err = -ERANGE;
>                 goto err_allocate_irqs;
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
