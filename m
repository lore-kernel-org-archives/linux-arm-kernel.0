Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE61C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:43:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A343213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UGz9Y0Jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A343213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GGeLaJE4Zvn4tdX+YwkUD+HndBs/sg37ZBK15XKHr/w=; b=UGz9Y0JnfZD/fZ
	ZnZY9aezbH1G/TjvtP7GS8O6txC9xBTrbjN3K36ZQ4YRpsD41LXGPWFZ5+ZzYTz8fqdxpA9p0Jpgg
	UpSRcRPGWjqGAkLysSMLDimT5weeR8iMdRMgY4lOl2yc0Q6kAsza5tJxhbFmgGRWGak4MPoH7/jxL
	ymmzt8SWdIAi43kyyzAF9+SQ3u3Xdyj8xMAVFbpDHxKzdeSjjb9mzFXVprH3Ts4gOMew3rlgRT0kr
	NgHaRWQLfKB8olMg/QFrNG9i9XWE4NubaX0smsevf+gC8AlA377RZyV1Ejzr6w673ytdemX/j2dvb
	uaHeEFjipsy+THjiXNeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUe0v-000562-HX; Wed, 05 Dec 2018 20:43:21 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUe0s-000552-Rz
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 20:43:20 +0000
Received: by mail-ot1-f65.google.com with SMTP id 40so19947077oth.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 12:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WtfdFOrHLEdBRRSKnZ3mtxk3yR28RHuLiNsARcqEx70=;
 b=lyLpO7SX3naG0bx/fFIQcys2vckKEFgwugVoaINZTghOGX6ocvzLHoP5xBNPcgNbaE
 94KAHibc5O3nHBAMvh6QcvUKvbHokWizdQ+G5MAdCpEv2Omh839bCigJ3xPU1YWo0l67
 vjQaVgx2gcAFHb9MIR4VuixKHZKve06dnC2Ah7fzUwvP2LbzP+znQF9X6TFl6O78lTdu
 KQVGwAQ9vre8ake4lxlYF41/8CGNNd7O0DLJu5ok92pL2yNY1FRc3Hzi73Ot3k81JDqT
 /TatKU9ilYwQiWuwJ1vhzLjPijl/DXMiPLa4fyV1kRPnXfHMGAb7FIHkFc1X4Ih4TyJP
 h75Q==
X-Gm-Message-State: AA+aEWbpq+w4NVtZBnQQySyPeIEseeVgX2PbYWxl1hFcAvVUyiYlZA+W
 KUfMDD199YKEp644YSXSsN5BW/fqkfs=
X-Google-Smtp-Source: AFSGD/VMNSZU8MTAh8Ezgkvw2AiJoyIC1Nn04Kkg9Lc4DDcdLfCsxCRUsVQ/r21yJRuHyzYwCVex0A==
X-Received: by 2002:a05:6830:1414:: with SMTP id
 v20mr17011829otp.125.1544042587825; 
 Wed, 05 Dec 2018 12:43:07 -0800 (PST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com.
 [209.85.167.169])
 by smtp.gmail.com with ESMTPSA id u18sm8030729otk.1.2018.12.05.12.43.06
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 12:43:07 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id v6so18779855oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 12:43:06 -0800 (PST)
X-Received: by 2002:aca:654a:: with SMTP id j10mr15212756oiw.301.1544042586603; 
 Wed, 05 Dec 2018 12:43:06 -0800 (PST)
MIME-Version: 1.0
References: <1543741258-17433-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543741258-17433-1-git-send-email-hofrat@osadl.org>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 5 Dec 2018 14:42:55 -0600
X-Gmail-Original-Message-ID: <CADRPPNSZ18XhgojYgw-KJHHCS=7XnGa_6rYvXw8E0_UUwb+p7Q@mail.gmail.com>
Message-ID: <CADRPPNSZ18XhgojYgw-KJHHCS=7XnGa_6rYvXw8E0_UUwb+p7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] soc: fsl: guts: handle devm_kstrdup() failure
To: hofrat@osadl.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_124318_906136_EFF17582 
X-CRM114-Status: GOOD (  19.93  )
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 2, 2018 at 3:07 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> devm_kstrdup() may return NULL if internal allocation failed.
> soc_dev_attr.machine  should be checked (although its only use
> in pr_info() would be safe even with a NULL). Therefor
> in the unlikely case of allocation failure, fsl_guts_probe() returns
> -ENOMEM as this allocating failing is an indication of something
> more serious going wrong at system level.
>
> As  machine  is from the device tree which I assume to be RO - if
> that assumption is always correct - a better alternative would be
> to use devm_kstrdup_const() here. That would then simply copy the
> reference to the RO data and not perform any allocation at all.

I think your assumption is correct.  Do you want to send a new and
better version?  :)

>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: a6fc3b698130 ("soc: fsl: add GUTS driver for QorIQ platforms")
> ---
>
> Problem located by experimental coccinelle script
>
> Patch was compile tested with: multi_v7_defconfig (implies FSL_GUTS=y)
>
> Patch is against 4.20-rc4 (localversion-next is next-20181130)
>
>  drivers/soc/fsl/guts.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 302e0c8..a0c751b 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -156,8 +156,11 @@ static int fsl_guts_probe(struct platform_device *pdev)
>         if (of_property_read_string(root, "model", &machine))
>                 of_property_read_string_index(root, "compatible", 0, &machine);
>         of_node_put(root);
> -       if (machine)
> +       if (machine) {
>                 soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
> +               if (!soc_dev_attr.machine)
> +                       return -ENOMEM;
> +       }
>
>         svr = fsl_guts_get_svr();
>         soc_die = fsl_soc_die_match(svr, fsl_soc_die);
> --
> 2.1.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
