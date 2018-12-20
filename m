Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0747C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:47:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7173620873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t0BKgnbT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYLpaLOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7173620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D881u2p5U0iK0CvPpTpNOfN9rkp6DooZvHCp1v0Q9Ww=; b=t0BKgnbTTf8MUe
	zfc9mdXaFzOLQdcji7Inm3fXmPijLvVQeFA+lDt40r5wwXzIGtBmiBQiJUnb/uj88lf8rsM8PhdTm
	HzaTATtHO8Qy7wX7Wy29vwi1aa6QdBk7e5aa4RvyuJkqc2INdErmOUoW+FBNEO32iMCBoaFoA7j9T
	HStD+4evQdJ2yN9ex/iv7ygUnH2sAdd+RyTyAKU1BP1WOKAZEeez/M6mVAtmEVWH3ZiwgBpd478gZ
	Wm+fHcZoYqGa8CP19O6OZTCQQ+uA1pfwMILl+pliSrsLyT/DBOlxdflSoitzaKlHFumIJj06VGPmt
	9Z8q4jVNZ071yqg72JKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZmVG-0007D1-7L; Thu, 20 Dec 2018 00:47:54 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZmVC-0007Bn-RR
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 00:47:52 +0000
Received: by mail-wm1-x342.google.com with SMTP id m22so293916wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 16:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AbdAJWgzqrgiKeUVUyhCN6wgu0RENht0s9o392+B19o=;
 b=aYLpaLOGNEz8s+JXblOJEXsg7azyVXjG8HEl4gLhm2YYm3OHvVb74JpN8RyZrav7hr
 Cm+6kqhZFXJIHTcDhh45NHkSxFF978VfdLlLZGcn5rIvpX0BwoJl0q5hMUGmjtO3Sgt2
 IGbbmezz1urmF3HEzDd3K7CBcOOHg3LRwHliwZzcJHBgTSd5vSVoEJuC4iIyNsd561Ac
 XGuDtQ6Rum3XGdMNI8jiB1+K8T7xabwi6VQiK3HohTTH3U7NI5dkTbooUujM5DDMuwYX
 27CVa1QiWpO774MZgs0lmqgkzoK56CCSmb++o+14XbNiJV48Djg87ya4uJjYKP7GuxHp
 rdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AbdAJWgzqrgiKeUVUyhCN6wgu0RENht0s9o392+B19o=;
 b=sCTA4vRI5lGgucb/dX2dI8bu1h68hbCOufO8TpvzziiItq9GQsMOiE7miAJh1PZR6Z
 TymCYLqN0tNRrAcnfimqjQhQlQV2CAY5vNDjBEzUf8TTyXho3aKe5T7YC4trNDRSGmRk
 L8mO5yqWzH7F50pWgZnbq/xbdVrzg84fh6RSR8RJO5+7UObt2X28tVIsU0dz7tiROysL
 vAgNgnc0MzlfM2VdcceTAwQJ/0s97LXkgqbJM7ix3FlXmH7DRaD5dtJjedLq7reTh39m
 y9eHOIzWBA7DOZUq5YH3e0IzxssK2Azxz/JqhOp7zkwZDU9NKe6QhtcMiEy2nUcE9Nc4
 14Aw==
X-Gm-Message-State: AA+aEWafP0sTvXPr0bNtmaN+6rVScflfiNaXU1DvGzUlGrn6TuE3t91f
 MjVQ3kOR+2duUGUpYGj0KuIAKuTrDb9QtJJZIhs=
X-Google-Smtp-Source: AFSGD/WV4tWAZ4QuNLDSV06RKJQcz+HdgXWWX1kqNu5IPQ+J5SrBqhDqZGX2YqAjwol4D4Noij/e8amOXWRD7mr0oiw=
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr9225146wmi.144.1545266856554; 
 Wed, 19 Dec 2018 16:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com>
 <20181218151533.GA2922@bogus>
 <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
 <CAL_JsqJb24ZpM7qQfy_F7RUVEGyceBAXOndbZcTMh3a__k38UQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJb24ZpM7qQfy_F7RUVEGyceBAXOndbZcTMh3a__k38UQ@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 19 Dec 2018 16:47:25 -0800
Message-ID: <CAHQ1cqEMxxo9JGN5be4XQWAtPz7nC2JyLCr3qasnD5QK7_hOYQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_164750_890546_6789A365 
X-CRM114-Status: GOOD (  16.54  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 18, 2018 at 12:09 PM Leonard Crestez
> <leonard.crestez@nxp.com> wrote:
> >
> > On 12/18/2018 5:15 PM, Rob Herring wrote:
> > > On Mon, Dec 17, 2018 at 08:07:02PM -0800, Andrey Smirnov wrote:
> > >> Add code needed to support i.MX8MQ variant.
> > >>
> > >> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > >> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> >
> > >> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > >> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > >>
> > >> +Additional required properties for imx8mq-pcie:
> > >> +- fsl,controller-id: Logical ID of a given PCIE controller. PCIE1 is 0, PCIE2 is 1;
> > >> +
> > >
> > > Remove this.
> > >
> > > If GPR register offset is what you need, then put that into DT.
> > > Typically, we'd have a property with iomuxc phandle and offset.
> >
> > This series initially added explicit offsets but I suggested a single
> > "controller-id" because:
> >   * There are multiple bit and byte offsets
> >   * Other imx8 SOCs also have 2x pcie with other bit/byte offsets
> >
> > Hiding this behind a compatible string and single "controller-id" seem
> > preferable to elaborating register maps in dt bindings. It also makes
> > upgrades simpler: if features are added which use other bits there is no
> > need to describe them in DT and deal with compatibility headaches.
>
> You already have an id for the controllers: the address. Use that if
> you don't want to put the register offsets in DT.
>

Lucas, are you on board with this?

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
