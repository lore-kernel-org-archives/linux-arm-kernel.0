Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ECDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:19:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C166420842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f9Tf1yFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C166420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MjO3c1YUwxPMEnSZiGx1BZFEGXBs72LtFT5QKLjryfA=; b=f9Tf1yFxDYqGPq
	IaFt9WsINlyPnuVO86jkzWowbTGPzk5c+fgPUTY7aCNoK8eFS89IJS1sCh60smsp293QQai7vGZiJ
	MfQuQpIYiOFwXj3WxS50qvO8I1WrJND7sUDciMTWKCLAfQ/TV/oSEtdYUB4cSG9mMgBOKQJQ0laFw
	2h4Kvpzd4388VRbLndcRZRavyg1Ng2wQZEPYWDvS5G/7Mam0G7IpUr8creCvPJC5OY0cjNyVKSvb0
	aR/g0ITn08CQlZO2HL1thA7yqEcEE6okcomfXHNHyPRpQ57cWfiSg6YuM4JXjh/PD7W9cF33OJA/F
	gHgtiTHS4/ICcSCf8lIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyCQD-0003By-7k; Mon, 25 Feb 2019 09:19:37 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyCQ9-0003BA-Db
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 09:19:34 +0000
Received: by mail-qk1-f194.google.com with SMTP id x6so4846490qki.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 01:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tl5z+HS6nWD0PvKbpb2FdFcWwLxwGMZEBWe8vjH+kyw=;
 b=E1v3dxCjEzNb5sDFHQW4YL4TGgGtYBN7P7+JHVwlwrBTQDLCn4Oc4KykbmtW6tc8XI
 axitIJeaaEgA99DYA/4S4/p0yOFG0IYlEWTCRly8VgcvB4Tb3CTipoRM0NDSJkellvsx
 ScGzpfsQ749xLIysHIJWHVmUOGTIZfoFiIIpzPdlHo5hASK+jZZMCdWNwO8YNx+s2BPo
 UfGKWCy5hqR8/IvtlVDYLiyxoHzDD5jWBzLqNiPgE5h7LnaaS5wrhlyG9mzu1MYyaEUv
 bIeyxbmyaQHt1gczw5h5LOPgTZ+gZV2QXDZwHv4Pq4C6cIiPzceLg5kLyi6L1OomliCr
 Rv1Q==
X-Gm-Message-State: AHQUAuYbhBVBJwhn0L9i3OnXxYgXTwlPALHe8oxhnHcsf2EWovipVP80
 as2TQ9eWL/zjqUbMIrBwHCtUYOdaYsJqsultlpg=
X-Google-Smtp-Source: AHgI3IbBPTOyNgEcGfm+bE8oq5rwobqvkL3vpRy+Olk4dW5SlNNEjaU1+ZFShX0UcKPIjoxDR+oY5UzN66Xw1wfI9uU=
X-Received: by 2002:a37:d492:: with SMTP id s18mr11428837qks.343.1551086371433; 
 Mon, 25 Feb 2019 01:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20190225123615.49bce7cd@canb.auug.org.au>
In-Reply-To: <20190225123615.49bce7cd@canb.auug.org.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 25 Feb 2019 10:19:15 +0100
Message-ID: <CAK8P3a3moJ12SDM3Ow-Hw3qBeTv9siswK+9pPiEA4JJ+7k4xvg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the sound tree with the arm-soc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_011933_459925_ED901BCC 
X-CRM114-Status: GOOD (  14.12  )
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
Cc: Takashi Iwai <tiwai@suse.de>, Sameer Pujar <spujar@nvidia.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Olof Johansson <olof@lixom.net>,
 Thierry Reding <treding@nvidia.com>,
 ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 25, 2019 at 2:36 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Takashi,
>
> Today's linux-next merge of the sound tree got conflicts in:
>
>   arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>   arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>
> between commits:
>
>   5eef17ee764d ("arm64: tegra: p2972: Sort nodes properly")
>   be4f0dd347ad ("arm64: tegra: p2597: Sort nodes by unit-address")
>
> from the arm-soc tree and commit:
>
>   11ce4308307c ("arm64: tegra: custom name for hda sound card")
>
> from the sound tree.
>
> I fixed it up (see below - in tegra194-p2972-0000.dts. the line added
> just needed to be moved up a few lines) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

The merge looks fine to me, but I wonder about that commit
in the alsa tree, why does the sound card need a board specific
name?

I see this property being used in commit c0bde003a013 ("ALSA:
hda/tegra: sound card name from device tree"), which removes
a questionable use of the root compatible property, replacing
it with the new 'nvidia,model' property. We don't do this for any
other subsystem, so why does the sound subsystem export
information about the board as a string here?

(added ASoC maintainers to Cc for insight).

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
