Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F877C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:29:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1552073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qcdKgND1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nUiJSSjR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="eK5Pp9Ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1552073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uDKgn4RBg+i/lO7vxGNhZzniTniJWnFMui4rkP96ip4=; b=qcdKgND18v19zt
	Sky9tkTDNWnufz/+N5n4Ub8n9l2yM+Iz6/I7aIG6yEhinVqgt7Cii5LSavxwA7ThFWalaoN+mky4a
	80G+r47EV8jq2qw1qwreiemdojqFa7WrHussEoqYSlhTwyyL+UjxF5vHkaFSnvrZsH+wiowkkdLmU
	rlebQZcc5T1SHOVKX2wPoGSivBrOktxOvEFuxY5iwUvw+JXCJNUFjAWu3uDXR7RYD8jW93ih+OC74
	0RATsb0Q+zj7Y0pJmeMVTQaJ9nqeopNUmFnMLQlRnTKc3YU3aqk9ZDLYYlpTDJSjHtnGbjji32bMW
	CtHIscX1bgGWVrb91qhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5HT-0002IS-PR; Fri, 08 Feb 2019 12:29:19 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5HQ-0002IE-Ow
 for linux-arm-kernel@bombadil.infradead.org; Fri, 08 Feb 2019 12:29:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g9nFuyNIknlIPIGeHUyXP6qUPfqzFzQLiNuJwZvm5cU=; b=nUiJSSjR3kzzSLtigkuDPFAs6
 5LsTVmdY9Q9kMQsPL6T/Ma0m8RfDHI+FcQi4P+zkB6Bct7SUE48/BmxXaxpk7fnOe/ynqx2SwIbf5
 xEJaL7JaF7yVIl9QwPJzRbEvrO2RwX1FIU61ZQB8dAQrr020Jbs1zTR+sdoCznSjxXGzjH+TLje5D
 KjyjQcVVHIOwv0atuz/Cwvf7NBPigm36+DQVQB56zaZWNFl/N60g4sVJyGFcSp0UCn1tzyK/a0Nih
 WRuEJfqwBZXmAmuNd9YTf4GGbnhCCWvrNm9+NQFRDcIMD5PugVnEcF6fa5RXy++PWcQdhfAG3mXWo
 PaSKefsCA==;
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5HO-0003EG-1O
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:29:14 +0000
Received: by mail-wr1-x444.google.com with SMTP id z18so3413737wrh.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g9nFuyNIknlIPIGeHUyXP6qUPfqzFzQLiNuJwZvm5cU=;
 b=eK5Pp9RuVMmtIWtg7h7fgU66oyZMjz3hwMnNA+eP++5q7EFsskUTciNTLlXSPxZ3ja
 b413Rwfl8CdiPQedqr0B+riZ3+ruwnAFU1hHFHgWVzk8X5aAU/g/bP6B3hmcGnCobjN1
 xvjy2sUSCVGYEXtrv8VepBlC51tsCRacZ1Dig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g9nFuyNIknlIPIGeHUyXP6qUPfqzFzQLiNuJwZvm5cU=;
 b=mfUUUlRqTHozcBuxcWJKJbnN8KEuqYLLOxETI6S2bqiGeYkozHjcp8GEA6KyX2EjyJ
 vr2WEfBK5lj8J9TV6s96dZokE1CJBXquzkheIPTZNHDlsA9igHCkR5V7hpJGoaMmSnhr
 uZUTcLBhNRa8CLcNj09PEdTi+/ToaVCq2gD+qhy+HAtLvoi9+Bb/44bi7TVySQyoJpOA
 WLPns6vBraa49KjgIo0dEXSJNH/SAdJ6qBzSqd90ldEOqKUoi41mzLAY+kgQ4bK/afNL
 Xmfczt3xUJp5JE0RqrQZM7eV1+rjnR6WrgQMI0OCXh0hxEggef0ANi6s2UEgjye7ysYv
 M/TQ==
X-Gm-Message-State: AHQUAuYLLAbz0SOcTYTs2QdPcgRbIRi5FdG8H5czwSEDmjCvWWJpuijy
 oidwAZE3gFSEMnz8NIaEuXFFKyInK35dN3aytcxlBA==
X-Google-Smtp-Source: AHgI3IY1p3Yuz0ID0EDGHal6AKMUbD4D2TsUhOweezQ/5aEp+LsUms5K76ATBXPhfhNeKqUgYORS/92rCevTgNKKe88=
X-Received: by 2002:adf:b201:: with SMTP id u1mr3445624wra.165.1549628949513; 
 Fri, 08 Feb 2019 04:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-15-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-15-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 8 Feb 2019 18:01:48 +0530
Message-ID: <CAFZiPx3qPHWfyz8R1xhsvZyS40WdyWGCZzSd8xgcQ3q+H9WCYQ@mail.gmail.com>
Subject: Re: [PATCHv3 14/27] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_072914_097549_0872D8B3 
X-CRM114-Status: GOOD (  15.20  )
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
> The reset value is all zero, so set a workable value for Primary,
> Secondary and Subordinate bus numbers.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index db7ecb021c63..9210165fe8c0 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -582,6 +582,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>         u32 value, pab_ctrl, type;
>         struct resource_entry *win;
>
> +       /* setup bus numbers */
> +       value = csr_readl(pcie, PCI_PRIMARY_BUS);
> +       value &= 0xff000000;
> +       value |= 0x00ff0100;
> +       csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +
>         /*
>          * program Bus Master Enable Bit in Command Register in PAB Config
>          * Space
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
