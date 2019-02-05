Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B639C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:06:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA482175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J6UbwbfM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="q0302VE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA482175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JzSEAwv/yvVeZWQEEEDs0gFibCgQuT7cPcfSxDhKM0M=; b=J6UbwbfM4bfMyw
	T61GgKXVHVpi9TaC7dEXVztrbwrc3kbz95M+U8+PIaDq2J7pr5vVSwp4c7gIIgmkgTw2zbYihVvOQ
	t14iHB4uPS9okK5p/4/nofUriPy6e0FXRHDE1OjKvUsH45VLXfqUTGXkQ6AiX16yfP2HiZGZAKdIJ
	iQjluXwakL+znzFmcte4AMEtTNt5MoxcyBHGrwsClwYajdUb3r+dTwNEnCjHMbCbY5FymG2VGLyLB
	9gLreLN47RvQMODVB1D+XvyeLvlADahcPZgcJlXgNf3qLM7oTWlvtJp4wreIIlMi+GihZlbDxClAn
	Xm0lGqaHGmNMx5t2YSYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqtrp-0000Wv-D2; Tue, 05 Feb 2019 06:05:57 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqtrk-0000St-Ip
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 06:05:55 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so2237819wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 22:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jcZjY5XDE/E9FNQRkXQrr6M7zvi/tvQDKDvX/q8jeBg=;
 b=q0302VE6ZZ4eNwzx+A/WjcR8zgl6JfM1E9Cb7sWFs3EnBG8DlBam36U/zaUIomk+Rn
 PB/UJi6qNDOJeNoxyP5YBBm6F/SKwfXjCV6humG+s32dhAo5O4Sl7rjWXrfNAFmkdcZS
 ah15QIs+ac7BXFU+SI+Ree7g0rLUefx4a1/00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jcZjY5XDE/E9FNQRkXQrr6M7zvi/tvQDKDvX/q8jeBg=;
 b=ibsZ/iaobC/dACoXKO/Uqbdjd9vlJ/3gFR3LyhS+NAaFRd+nlYEDPNs28jBxmQE4dl
 qy6AJ3jusXv+bhzZleHXQMB82NGiHtqPeGA+zNaiMgJbvei7Ap5x0YaScEpZWmW6G5Lp
 j4dqbPg3MdclcP/sBKlrDUPy9+2jgXWZZuye8Tlah3kmk52LYkCHF+gKCA5gcV7Yqfj3
 rMG2QdoC9zR7ORQBYjS4bFVCK/pzwHKoMg2TEEeyQ4vyPS0wGLRQ8Xh84f4Cjsazlnpq
 6XWyFreo13eGNwBZIfbgQyG/PVZw5D8sf4eC7iLcvoFFj/MZj+SozJjfVDC6LMGw/JEa
 UPRg==
X-Gm-Message-State: AHQUAuZdgdp8Pvrg6PGHj2fhWf9nyTpf9LA6B+Pe7IJELF8HHYuGt3it
 H13hLusMpeELZ6Vb0o/PvRt2343b+1w7zuUulvsA3g==
X-Google-Smtp-Source: AHgI3IZJKwW71eEFV/3N1NOzT6DuLNVD97wOcuHi4aYiIwiKY7zBlO5L43hFAXGP2PhSDNVMebdU2WxBXYVABu5rJ6Y=
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr2241827wme.82.1549346750647; 
 Mon, 04 Feb 2019 22:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-9-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-9-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 5 Feb 2019 11:38:24 +0530
Message-ID: <CAFZiPx0jgFROcecsa6Q3+HjDY-WL0Msp9DvJTRQp9fP79BGmnQ@mail.gmail.com>
Subject: Re: [PATCHv3 08/27] PCI: mobiveil: use the 1st inbound window for MEM
 inbound transactions
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_220552_619473_003A74DD 
X-CRM114-Status: GOOD (  14.63  )
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
> The inbound windows have different register set with outbound windows.
> This patch change the MEM inbound window to the first one.
>
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
> index df71c11b4810..e88afc792a5c 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -616,7 +616,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>                            CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
>
>         /* memory inbound translation window */
> -       program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
> +       program_ib_windows(pcie, WIN_NUM_0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
>
>         /* Get the I/O and memory ranges from DT */
>         resource_list_for_each_entry(win, &pcie->resources) {
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
