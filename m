Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECADC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:33:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDF720878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ArXfvGhu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8R+GUK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDF720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oh3M2DhaDXCJQ0tX0U2s/KqqEykRxCK71wj/Zt33gcM=; b=ArXfvGhuvrH+g9
	z+rMB1VwVNYAOcI9TjX+wCA1tjtKrAHnandzT8H0Xy9A/74ueanlRgvx7C+wHcgSePOWeItkE1WD/
	FZNbbJOG/uoaEeZDoiqplwpDd7woXDKG0xaXlJbG8RF0Q/kuE4dPevC3qt1Ilkd7mgYH4yZJhVfwm
	PbYKX1AC5wBjA3Gfw2ncBiNcvruSdQ/SYVbnZGZlmfW4SDDaNXPaHYVjHGBKl469ihK0XYXw7pmb7
	dGJIbyx7IvvNc3JhwM3h6Il1cUWcHOrfyCn5byRlcbVJLSHi7yDDnTlbf5WFiUmr7Y3yemw0p4hYO
	6Mp5AaPzIjniEG+j0MiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV39J-0005F2-Ra; Thu, 06 Dec 2018 23:33:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV39G-0005E5-8d
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 23:33:39 +0000
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0181E214DB
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 23:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544139206;
 bh=gZxZKWzS/CFBRJ5cx9gU4j7NTuSbfpHO6a+5reMvM/I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Z8R+GUK8HmCWPi80PyCnBiS2XVMwSALm+ygpr1Sb4NJTdT+RF6UcKTs2v8neW/MRT
 GVKK0yHT+VR4xT+Jnj9WY5GIJiNonv+56yeq2kJU6+i3PzYey5XM21Dg97lqWG/sfS
 vcqs/Q1VjdEmcMUYKwSYmLNeoqjLcLvuAey0TbrA=
Received: by mail-qk1-f179.google.com with SMTP id y16so1446778qki.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 15:33:25 -0800 (PST)
X-Gm-Message-State: AA+aEWaNYEVpk1OINbX23SgXvXCX8da1tpt+8zzCro0X3HShRYHo8FWN
 IkYr+1zv7Y4xJq49Ie54tTdNOJmcXA5fZp1AvA==
X-Google-Smtp-Source: AFSGD/VAAUM4UeHiln1FkoZdLxs4GVSy23jQgIG4UQhXKT7qgvB21vJxN+mpR+mykRFVaL2JgzlKp+pHBoQKxo1/gxg=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr28723113qkg.147.1544139205175; 
 Thu, 06 Dec 2018 15:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-19-robh@kernel.org>
 <20181206023140.GZ3987@dragon>
In-Reply-To: <20181206023140.GZ3987@dragon>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Dec 2018 17:33:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
Message-ID: <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc bindings
 to json-schema
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_153338_324220_6AADC097 
X-CRM114-Status: GOOD (  12.09  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 8:32 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Dec 03, 2018 at 03:32:07PM -0600, Rob Herring wrote:
> > Convert Freescale SoC bindings to DT schema format using json-schema.
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/armadeus.txt      |   6 -
> >  Documentation/devicetree/bindings/arm/bhf.txt |   6 -
> >  .../bindings/arm/compulab-boards.txt          |  25 --
> >  Documentation/devicetree/bindings/arm/fsl.txt | 229 ------------------
> >  .../devicetree/bindings/arm/fsl.yaml          | 214 ++++++++++++++++
>
> Rob,
>
> I do have any changes on bindings/arm/fsl.txt queued for 4.21 on my
> tree, so please send it via your tree.

What about:

c386f362957b dt-bindings: Add compatible string for LS1028A-QDS
3671cd57de06 dt-bindings: ls1012a: Add FRWY-LS1012A device tree binding

>
> Acked-by: Shawn Guo <shawnguo@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
