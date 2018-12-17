Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EB3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:04:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC92420874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JSRDidk4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhY8iEjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC92420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mR57Uf8K0RZDjCmZfLjlRv+9zSoH+lEqpdmj7lDqvZE=; b=JSRDidk4AUV/gl
	85XrZXXrDd2wwLJ0OUewilQNZ67yUN5Gd6bO4PVC/IfhRn27jWHd2uUimU2zCJLKDaULazyV587sV
	QpN4mYwMFw/rOIJ+AbwVkbhsuJRyyqEgLXehXrPPdNgP+mbtBzIihBpBGbOZs2grfa/nQN++cakRK
	seFCbXRu5za/vX9bXOMWo8mW5fWo3roeEkWbyOxVhXc/Rgd9fkWXLpmeFjbCDXeRbbmD9syp/pB4E
	7u0ihFGwgUWkzVxrPltjbcVZ3s5L2Yw+TXeKlLPKy759a9sCp3NStEGCSB6dI80WFMbmmXMN8YY4x
	Qlnpb0Vhna7zCWW+ulMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYxFN-0003D9-DZ; Mon, 17 Dec 2018 18:04:05 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYxFJ-0003BF-L2
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 18:04:03 +0000
Received: by mail-wm1-x344.google.com with SMTP id a62so131587wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 10:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3iKE+lrdN0BbU0LrEqoXbpQFtnEmptT9/m4IOJh64Kk=;
 b=UhY8iEjjcRJnz14DlYAmcIR5A6CDKJuEStszagzquRc+JQrkAvUMy6ZbpUwx1WJgE4
 q5ACnchqXh3DBdnilP6EvA4iHAogkKJ9xcLIsb41Ip1lzoEa1m6gRNwgtDMHXhdaemuZ
 ilRSaYp6GWr+bB8C1W1G7DktRL3tu3VAB3xNnYzNLV6N7Tid8sNX4VScdOoT9B7x3/HY
 vV2FsY2KzP+ikY92JijZWzsTR4qRwKYWvzhrWDYCVP+pedMaApu54QlgKPLYG1Alv7Lk
 2KxqdVlh+hptcrjXeVOJFx91nptm9Gl198MlsAELSLFPvPBPVPANEnqnhweBMBWv3CCj
 K6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3iKE+lrdN0BbU0LrEqoXbpQFtnEmptT9/m4IOJh64Kk=;
 b=qqvXf1Ium0O3AkGQh6Kb5mdWAn1eTCAUwClSW8ufMOshzQsfLL12k2UFj89XouRSHh
 rEXq6bydEys4jfqA64LKDUwXDN+bR8WtVOt83xqCw3JjSt52v2bkeQoM1RT6MusMAqcU
 cdjBNjWaXDOalW1spDVnlp2TT4AGJHMTewwk/ygmdcM/HOjJPk0Bnb5Jg7XvHak6rCjn
 VlFjZ4y78gGGoMhqFlolyLfCcLXb0MXrt2mhea/44vQq57/ZYoELL+vvx09J3skgSxsI
 MvxAUEOVuxLf+oM1kL1GDoOJGyPBr1GjadsuLhcca1Bu0RnhGNdAJx1hrQB5gry4rB8v
 +RXQ==
X-Gm-Message-State: AA+aEWZWWDmTLJSLemNKZqOTIRS8Ud46B4CKVhuyQpiD/3ZJzMNtdbXL
 RTUwkzA2CvXNIJ0Kauk06DXmy5LrzWoqCDRULPUcWw==
X-Google-Smtp-Source: AFSGD/WC972fXIggXO9uTv5qdxGYibRZXFJUvhQaud5o/Jv6YiX3ZIg1rFnEv/SCIBd7Cta/P3ym0otTCVYrXGd5Zco=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr101622wmf.127.1545069827299; 
 Mon, 17 Dec 2018 10:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
 <20181216230916.22982-4-andrew.smirnov@gmail.com>
 <20181217135833.GJ20725@google.com>
In-Reply-To: <20181217135833.GJ20725@google.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 17 Dec 2018 10:03:36 -0800
Message-ID: <CAHQ1cqGA1xxY7qQMWBoo0_jbSa4=OBD=6_Du6dOKN5xsdqOj4w@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: imx6: Make fallthrough comments more consistent
To: Bjorn Helgaas <helgaas@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_100401_690938_BD31D3CA 
X-CRM114-Status: GOOD (  19.32  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-pci@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 5:58 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Dec 16, 2018 at 03:09:16PM -0800, Andrey Smirnov wrote:
> > Convert all fallthrough comments to say "fall through", as well as
> > modify their placement to the point where the "break" would normally
> > be.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
>
> I didn't make it very clear, but my suggestion was really to remove
> the annotation completely; see below.
>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 59658577e81d..a0510e185d44 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -362,7 +362,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> >
> >       switch (imx6_pcie->variant) {
> >       case IMX7D:
> > -     case IMX8MQ: /* FALLTHROUGH */
> > +             /* fall through */
> > +     case IMX8MQ:
> >               reset_control_assert(imx6_pcie->pciephy_reset);
> >               reset_control_assert(imx6_pcie->apps_reset);
> >               break;
>
> IMO this use of "fall through" is superfluous and unusual in the Linux
> source.
>
> A "fall through" comment would be useful if the IMX7D case had
> executable code but no "break".  Then the comment shows that the
> intent was to execute *both* the IMX7D code and the IMX8MQ code and
> the lack of a "break" was intentional.
>
> In this case, the intent is to treat IMX7D and IMX8MQ the same, and
> there's no executable code specifically for the IMX7D.  I think it's
> easiest to read that when the list of identical cases is all together
> without the comment in the middle, i.e., as
>
> >       case IMX7D:
> >       case IMX8MQ:
> >               reset_control_assert(imx6_pcie->pciephy_reset);
>
> rather than this:
>
> >       case IMX7D:
> >               /* fall through */
> >       case IMX8MQ:
> >               reset_control_assert(imx6_pcie->pciephy_reset);

OK, understood, will remove in next version.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
