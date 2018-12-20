Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EDDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:00:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030E421720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O5kTeVw5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdnUMcCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030E421720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kQgsmY6vuldLqzs4JJHuTcWKY994tsyRYgb+aVgHcRU=; b=O5kTeVw5BSZwWc
	ludXo34rvHPJ0m0UZwFZW/+FCt4QvwFwAmZnB2MDJKDL/a76Kgb5J6k294r5Jyq6FRdj3quKIdkq6
	59BUE5eopOjW/MpyN6fT2+MJtpW6xpMt+hm3bkqZR0N4MIFp2UF5xxyJrPiR/iz9BnaaUzTWXDewb
	W7NlgOx5B25JF0vq+pzCqbr9V6nb8Mqxla+0v9A9iac3GzVOcNZh3PuBbSQSqbFRg3hz7M7MlZo45
	NTm7I0pa1KFHuWiDQEZPS/bTc9WbKgGqMFPqbcgKb75Uk2tKgDVPTOC5h2Ji8L0tIpxBEAhujt48i
	bJD4fGQuYEJl7N4y16AQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZzoM-0002PM-5t; Thu, 20 Dec 2018 15:00:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZzoI-0002OM-5b
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:00:28 +0000
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8C8C7218D9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545318015;
 bh=PgdcFzzFJRfg9e6GuRKfjwKRt1qszJo4vAoki4ZdPow=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=pdnUMcCFDBFzHEAMdpyHRqX9GgShwKo+QWg59/9Oe4NJ82DCoTOfLtLzZYMANPtwQ
 L0sUq2vX5mD6Af6yxTOnQuLhXBpFkmQnsid16WJWPW1iqe/fF8awRHmT6MQ7y6YWYx
 uTqdoLMVoIEznpEq3UtzC3+ivOhjCz4zQIY5fcgI=
Received: by mail-qt1-f173.google.com with SMTP id k12so2084939qtf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:00:15 -0800 (PST)
X-Gm-Message-State: AA+aEWaQfq8/rASCGV7VgWY0sQJhTfyr3PL9NThW+PHX+7l+2uWwJIbK
 R6QKboOEje6a8PFl0N7r/9iSG8/BgQNDWyUdcA==
X-Google-Smtp-Source: AFSGD/UI6ZKZCM3DWOK3vRuT6L0eQh3X21IsbTvynvSnAaNVyobUIJbREiqUsj9quGSzKi6VGzTplbsMOKm35Uj5ark=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr26745039qvk.106.1545318014699; 
 Thu, 20 Dec 2018 07:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com>
 <20181218151533.GA2922@bogus>
 <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
 <CAL_JsqJb24ZpM7qQfy_F7RUVEGyceBAXOndbZcTMh3a__k38UQ@mail.gmail.com>
 <CAHQ1cqEMxxo9JGN5be4XQWAtPz7nC2JyLCr3qasnD5QK7_hOYQ@mail.gmail.com>
 <1545268969.22930.77.camel@impinj.com>
In-Reply-To: <1545268969.22930.77.camel@impinj.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 20 Dec 2018 09:00:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJBxZw225qqWfCFa8UqADtGOUCjFogo6Pb2bd8bKwz3nA@mail.gmail.com>
Message-ID: <CAL_JsqJBxZw225qqWfCFa8UqADtGOUCjFogo6Pb2bd8bKwz3nA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
To: Trent Piepho <tpiepho@impinj.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_070026_247747_6F51C395 
X-CRM114-Status: GOOD (  21.31  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, NXP Linux Team <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 7:22 PM Trent Piepho <tpiepho@impinj.com> wrote:
>
> On Wed, 2018-12-19 at 16:47 -0800, Andrey Smirnov wrote:
> >
> > > > This series initially added explicit offsets but I suggested a single
> > > > "controller-id" because:
> > > >   * There are multiple bit and byte offsets
> > > >   * Other imx8 SOCs also have 2x pcie with other bit/byte offsets
> > > >
> > > > Hiding this behind a compatible string and single "controller-id" seem
> > > > preferable to elaborating register maps in dt bindings. It also makes
> > > > upgrades simpler: if features are added which use other bits there is no
> > > > need to describe them in DT and deal with compatibility headaches.
> > >
> > > You already have an id for the controllers: the address. Use that if
> > > you don't want to put the register offsets in DT.
> > >
> >
> > Lucas, are you on board with this?
>
> Does address here mean the address from the controller's reg property?

Yes.

> How do you map that address to the controller's index?  A giant table
> of every soc so the soc type plus controller register address pair than
> can be looked up in the driver?

You only need the 2-Nth instance addresses. A non-matching address can
be instance 0.

> I.e., on iMX8MQ the controller at 0x33800000 is controller 0 and so on
> for every possible SoC address combination?
>
> Not really a fan of that.

Well, this was not my first suggestion.

> The situation here is that some registers for these controllers are
> interleaved, right?  I.e., there's one register somewhere where bit 0
> means enable controller 0 and bit 1 means enable controller 1 and so
> on.

So? The only difference here is an additional mapping step.

> Isn't cell-index already the standard device tree property for this
> kind of setup?
>
> I know cell-index was historically also (ab)used in an attempt to
> provide a fixed kernel device enumeration order, something now handled
> better by chosen node aliases.

Don't use cell-index. Consider it a deprecated relic from OF that is
not used on FDT (though there probably are some cases it did get
used).

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
