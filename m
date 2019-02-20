Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDA8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:59:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4E9208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NMAbgrBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4E9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=02zFN77LI+HqHtaWzohkwdgcP8QJDMqFTrEozsaEJkM=; b=NMAbgrBK9BckVh
	DRNgHnfxEy1fc69QlrcXhIxsHuVcpm7dZbaZoe6KVegZ8Au/7Mb5PjIJVYKLBKAbh0XGDKWKFh8Mc
	/eU8BWKiaxJrGjyz3I0MKQ+5Z1ip9K7vA2RmfXtPYNT8tKYlbN+jAs+PSI8n73sdeOlyj/R0qEAyS
	lzOXk2gC2QBLpydoi86XnbjrUYLJS1xlZYK5d1tmIAe9ARtstn9BHXCN2Yr4bjAYMvQ5GIY0mFTQy
	ROAJM7AARS+ii1RLGi027D7wkaR74gumm5p5GzCbau8cvbNmqm9H5f5PFGtqE8ljJKdx/YxmQPSnL
	tbeAWz4V60YDRTu1bqEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwNid-0000Er-F0; Wed, 20 Feb 2019 08:59:07 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwNia-0000EK-KO
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 08:59:06 +0000
Received: by mail-ed1-f66.google.com with SMTP id h58so19175007edb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 00:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rAdoxIJZWnnE6eiIWpkNn6CLgQlgSDug3I3b8dKQXHU=;
 b=tggR01q/2Rs8vDTee6zj3o14EVF4aZuP+mcDH8lolM/Eq9Mh/t/RVzCNBHDNCO46Jc
 yXeF0eA2uJEGIzbzY9SGj4TqB+6VZHfj5pUIGEGGNS+LivEKx2zqxccSeA84qv7BzIEM
 n5PLvnDv31cNTnq1S1JPPV/Q7NDIYPZ5kWpeQwdhqbyr+C3BeyNeGEpWKBrRhMKCFSYF
 GXr3q/WCk5uJtviahxo3TKOMIjkrnm4Vg89H9b9dBs+83w9OTvcOGGVPS052ZeYjUPwg
 AQSvfMbJKOZ9mPBCeoUBuwhvakw3VmdAcYb6wq2nuLOiC8fihHeaErLzdyLksEvzmAtZ
 wIKA==
X-Gm-Message-State: AHQUAuYiyTq5D8QqaNUlOylLWAPxmor71jVQeVUwYiwIJj6ckhe9e6xz
 fK1B1+XYt9W1d70CaPLbqsoZzO0DF9A=
X-Google-Smtp-Source: AHgI3IYj96CNI9uh6N7fNHYHfYiwLuw8V/dpCyLIWbjZRLRpNsATfBd3DYR2iaE3A/V/YvkHQZQwAg==
X-Received: by 2002:a17:906:3749:: with SMTP id
 e9mr23830278ejc.194.1550653141694; 
 Wed, 20 Feb 2019 00:59:01 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com.
 [209.85.221.48])
 by smtp.gmail.com with ESMTPSA id t25sm1926296ejr.30.2019.02.20.00.59.00
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 00:59:00 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id c8so25013649wrs.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 00:59:00 -0800 (PST)
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr9498091wrw.120.1550653140186; 
 Wed, 20 Feb 2019 00:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20190216182132.12895-1-mans@mansr.com>
In-Reply-To: <20190216182132.12895-1-mans@mansr.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 20 Feb 2019 16:58:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
Message-ID: <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun7i: add pinctrl for missing uart mux options
To: Mans Rullgard <mans@mansr.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_005904_673528_EBEAAB49 
X-CRM114-Status: GOOD (  15.63  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 17, 2019 at 2:21 AM Mans Rullgard <mans@mansr.com> wrote:
>
> This adds pinctrl settings for various missing uart options.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 45 ++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index af5b067a5f83..2295ff5adf48 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -944,6 +944,31 @@
>                                 function = "uart0";
>                         };
>
> +                       uart0_pf_pins: uart0-pf-pins {
> +                               pins = "PF2", "PF4";
> +                               function = "uart0";
> +                       };

We've had the policy of not adding pinctrl nodes that aren't used in-tree,
to avoid bloating up the blob size. However DTC 1.4.7 introduced the new
/omit-if-no-ref/ directive, which would make the compiler discard marked
nodes if they aren't referenced.

So please add this to all the new nodes. It seems to work regardless whether
you add it before or after the label, though having it after the label seems
to make vim syntax highlighting happier.

Regards
ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
