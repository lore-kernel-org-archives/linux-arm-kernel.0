Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E66C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:02:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC322083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OymAyQ2X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="u0hfqtB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC322083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AQtPDuUagN8cnfdl+XXbRXSdUGt5cD74wBHMqbU7uhw=; b=OymAyQ2XLeN3RB
	KXKOrWwXJLA9zVygy0oaEhQ/N4rPxNOtcsAG/RkGxbLUqhtTNFNqkwG+y0FA6vexsyxVBCbxnchqj
	kMATrfg8S9Vwc7rCQfjJztsqzl/Fb1wAJcDrQW2NvqtT5lj1ZfwnzTPBhJt4paQLdhY9Z0ixYTb4L
	BIwCSdyhzlJpONgzmtvWWIq5+Ht8mhEelkIAij9pKBLmNncnH6Xi1FErtmndaAwVfWyuB66bC8CGs
	+4AH6Jq9Deh4+wiICB8E69lEcNEMDgwNBWMzthBeTJCJQwfv1Psqt3oV9GWAYdkKM4QMJLGjkL+id
	1n44l9LI6JLD+ndQfvLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqtoo-0006Ot-T0; Tue, 05 Feb 2019 06:02:50 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqtok-0006FI-Rz
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 06:02:48 +0000
Received: by mail-wr1-x444.google.com with SMTP id a16so2317294wrv.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 22:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+iXYvqbL04CrMC9Msn9+P2yhEIYzuGJ1s0Z7Tbi9M9Q=;
 b=u0hfqtB6n/9xUdBNpa+lUEjHPSk0axN4rIGHPdjhsjG/v2VvNzoR9t/3kaCEzLeaas
 OHCgZhiEc5h7gQrWYefmkhDJo24KkLKA+fH16gY+JW6aJI5oZjjv8JXBSWCyMDPMMVht
 6qBwfjmveYOlfNjzJOw51ZZsJX5tnM+ZL6oB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+iXYvqbL04CrMC9Msn9+P2yhEIYzuGJ1s0Z7Tbi9M9Q=;
 b=RDWzhQW3H4fa2d8syIuezc/+J4GpN7um8mMaLAJVATK6+rWfTE4rMrCn2qlduCOmSl
 dXTSDnPh5rwd2ahpwYzs5zRiX2kG799A4e46lbyKTF//d1vR8Riuq9LmeGiyQjm8jReb
 PvZ1SU46GD3ditPCD23jOtDoCWCP8MlKiqq+tcQPIb+QUy1QVv+dCztcpaWK8BmmX8pO
 AX1oQJGbOyjdlaKqE39PSw8vAbKhnEQXuGHVGd67xsW/nTjRyYF2SR0QB71iv+5lYUVp
 eZJUEE7sG833UpITw92Y4yIbKOIIvmVloZbICqglgdddywhOIaz/pG6JxVdZdckyyyJV
 JAJA==
X-Gm-Message-State: AHQUAuZQSYeAXfhvx++bzo8s/3uD2VLsIKj2j5bQlrXNjTojFfrP1WHb
 nQB+RFbWs/7np/bG/PMSuqdh+YvnJ1zy23w0VCkR4A==
X-Google-Smtp-Source: AHgI3IabIa+8GnpOhA0TxuLJJFYCpplG1t9plmrYCiZAkge7q1SBCrmcqhBkCINFhgjx2A+iGoBr42hYp8YZYZD3u/Q=
X-Received: by 2002:a5d:4ec7:: with SMTP id s7mr2188770wrv.14.1549346564989;
 Mon, 04 Feb 2019 22:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-5-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-5-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 5 Feb 2019 11:35:19 +0530
Message-ID: <CAFZiPx0aiLkVrqVxmyLRcVZJ0G=+60vED4cJOfAo=18DDnOtcA@mail.gmail.com>
Subject: Re: [PATCHv3 04/27] PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_220246_904271_71B9A6C3 
X-CRM114-Status: GOOD (  16.35  )
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

Zhiqiang,
why are we removing multi-MSI support ?
what functionality this driver is not providing to support it ?

Thanks.

On Tue, Jan 29, 2019 at 1:38 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> The current code does not support multiple MSIs, so remove
> the corresponding flag from the msi_domain_info structure.
>
> Fixes: 1e913e58335f ("PCI: mobiveil: Add MSI support")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 563210e731d3..a0dd337c6214 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -703,7 +703,7 @@ static struct irq_chip mobiveil_msi_irq_chip = {
>
>  static struct msi_domain_info mobiveil_msi_domain_info = {
>         .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -                  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
> +                  MSI_FLAG_PCI_MSIX),
>         .chip   = &mobiveil_msi_irq_chip,
>  };
>
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
