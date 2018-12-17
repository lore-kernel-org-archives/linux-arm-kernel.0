Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49587C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:11:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0900B20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L3WH3fhi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE2hQJ5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0900B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t/EH1mY2HbtaJui5H2Fhlv8cHKteb3f1pnkgvKjgTTI=; b=L3WH3fhi29rnSn
	vmfea8tGbXbNPfWJTrctEuFaUzWUwzs7ToFEoNETQA5yjF9hSuctkFf4N+E8BsQnfkTttkV+hh+oM
	Sw1I1pQpzqh9rgrL53vwADFUBrnOh4ciuurUdVfllj+OIBooGi5U6UIa+/QTfXeYZ3tRA4wDTEPu4
	E5X72O8Zc1vd0xGt1kxy347idIKUYsOWOLg/soXiHekFxynigdhoTWD0d4p2l7kz+NP6anGbZPLbl
	H/v27egVRox9yQPS767qZwBOnhiGZW849I4s2IZ5Ws/RNBvH/vcIIdlAs8W2Z+4eBV0UoJTO7HaJN
	ttoenGK1MifNu872gfbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYwQe-0008PJ-BE; Mon, 17 Dec 2018 17:11:40 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYwQb-0008Ng-4T
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 17:11:38 +0000
Received: by mail-wr1-x442.google.com with SMTP id z5so13062847wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 09:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/ZY5abb5RJfKSZwIuefMoxZ8yU6NpVNydtn2GiM4hyg=;
 b=bE2hQJ5VNOfh1ytM66ct3zjSi/JsfqigkAoclkdGTispgNcAEBXfdwfVzWtfVf6nce
 bPXUMnUNhUs+DTNOx42ARgRrOxntgkYiU1c+JG2uirmSEBqLgg1hclY97DOIRB5xNZna
 d/1W4qUW1VL2iipDMCfhDgtNnJspUv6GMWF8KVskOEYRt5GT9Oa63l/jt4ZMiWz6BNUu
 1/vpJObiJ/zmY6RKTIlkid53cDewhOiX1akjx3k7KJsABTTuh5nQYb5CcWhgPEAfsYF1
 EGcNBQkgSWasDceiWVum3EOmiNicsT/DgKeAbQ69CrYKqQ8g4vh2qVFtOvamVvxUdfN5
 i5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/ZY5abb5RJfKSZwIuefMoxZ8yU6NpVNydtn2GiM4hyg=;
 b=qsS//bQtpFs4s+LTgCkDNIHmlyAltWiWiUzxYzJ0N1QxXKGE9bX/BD1bY9UDfgf4fe
 mJD+UZLc5MxNi0FyUuwl7XkO+9cBDlT+NRAm+1sEUVPGNGlfZaXljAU4PVQ46otfv6da
 yv+PcJmlEw47Hn18iKuwTy40sD0QDnspm4i9YyaiXgGmcN00C3h6g2ScK6S0YIYxdHjR
 Mr6EDFxx5V86nGyKNHzJ7VW/apCXvAHQ7K6cAoQ9fzUgsHoIg2jdTkFhhMMr+tM226RR
 190yMKGCdYwk3NZ3Pggr5sdGnc1YtBW+dLyxmiiHpIWRz1MZiWomvamiU3auJa7yb/Mx
 blKw==
X-Gm-Message-State: AA+aEWYPkAfceX2jvdrAdg9J5+Z1jQaYuvKW2SicVY3ASgRVje7ZtSPk
 7TWVb1C5uQ7xUn+d0bq5WgoIFf1erW8JD/L6A0GtHQ==
X-Google-Smtp-Source: AFSGD/XElLSSUsi/CjNXXV69Ucpm1nJRDdp2hbTudva9JuEPERBBb4MaDH9moukhIcpeZbFIF/HY8JBtm2dFva2MeH0=
X-Received: by 2002:a05:6000:51:: with SMTP id
 k17mr10814319wrx.259.1545066685084; 
 Mon, 17 Dec 2018 09:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
 <20181216230916.22982-3-andrew.smirnov@gmail.com>
 <VI1PR04MB5533AAAEA69A54F1CF01D44CEEBC0@VI1PR04MB5533.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5533AAAEA69A54F1CF01D44CEEBC0@VI1PR04MB5533.eurprd04.prod.outlook.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 17 Dec 2018 09:11:13 -0800
Message-ID: <CAHQ1cqEo86-B0mw8edqr0fr9834YRziFJPJbssqoutYnfroyog@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: imx6: Invert checks in imx6_pcie_reset_phy() and
 imx6_setup_phy_mpll()
To: Leonard Crestez <leonard.crestez@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_091137_178925_ACB2F8A5 
X-CRM114-Status: GOOD (  12.96  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stefan Agner <stefan@agner.ch>, Fabio Estevam <fabio.estevam@nxp.com>,
 dl-linux-imx <linux-imx@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 2:24 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 12/17/2018 1:09 AM, Andrey Smirnov wrote:
> > In order to avoid having potentially ever growing list of variants
> > that don't support methods implemented in imx6_pcie_reset_phy() and
> > imx6_setup_phy_mpll(), change logical checks in the to check for SoC's
> > that _do_ support what they implement. While at it, share the code via
> > a small helper function.
> >
> > +static bool imx6_pcie_has_imx6_phy(struct imx6_pcie *imx6_pcie)
> > +{
> > +     return imx6_pcie->variant == IMX6Q ||
> > +            imx6_pcie->variant == IMX6SX ||
> > +            imx6_pcie->variant == IMX6QP;
> > +}
>
> This would be an ideal match for adding a field inside drvdata, sadly
> that was part of a series which stalled:
>
> https://patchwork.kernel.org/patch/10712261/

OK, I can pick up that individual patch into this series.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
