Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED45BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:12:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4572086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qersEGdK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="phgxi0CT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4572086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i+nGZvlbGSLRcCi/wsIbGFwo3lLRh823bkTmJElRxnM=; b=qersEGdK2X4Tv8
	wst4+8LCeyc4JAhmisOsLfSZb6LEgvKehYcVigaYcx64CUB8ApuW8V3aXMjAuF4t0IMHa8cQ/zsbb
	MX/8U2JzUyHWe8v/p7oxBmSxw0tq28vLLlsgvlETFZHQCWSMQxT3HHI00gpAKpR7FEJ5g+d78el+C
	bPLfMS2oT8L4XvnbDe5oOxgA8Ew0sJ9GCvN+NRki4nv2g6RBfFIlvSoZlWJU2zqwCKdtoP6RNoefT
	EfZolkr03qWyV/x2EGeG/M7LfXlzHL8ZnKb3vqgJPmiO4Ao/mBfFyWH4YKTMcB62/w2gx+btdHBC/
	xZH3SlTcDHmZwl9ZHWJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJUR-0004Ik-St; Mon, 10 Dec 2018 11:12:43 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJUO-0004Hc-OC
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:12:42 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 3062825B7DC;
 Mon, 10 Dec 2018 22:12:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544440345; bh=oRoU1UtWG/hI2sAcfvjea8bkUbn17Pq3e+Jpna+LddI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=phgxi0CTBMi1DTjVtsTkARUZs8Y+JxwjNDhNdG5Eo+HHO7J3YQdvUWvwdw8Vcazkv
 a2Rua12uj1v9EoivlakOXeyZ88Wlg3/R1Fl6JLDg0VfbtlHM5WVHodlI9z1Tr1az92
 g+yRRZI9HmagkS9futK/GHru3ZjlJnASvIXQzkiw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 8D7B59402E1; Mon, 10 Dec 2018 12:12:23 +0100 (CET)
Date: Mon, 10 Dec 2018 12:12:23 +0100
From: Simon Horman <horms@verge.net.au>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
Message-ID: <20181210111223.fstjmazyo3vof7kc@verge.net.au>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-27-robh@kernel.org>
 <20181204144822.uqonsto45u7ysdu5@verge.net.au>
 <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
 <CAL_JsqJX9eb58piavQayXM5j5GXxsGxmy93m5oRKtghMFvkhuA@mail.gmail.com>
 <20181205194419.p6u56h57yk63xshj@verge.net.au>
 <CAL_JsqKHwYhHSb7GNFgOtBCqEeMshbRnU+0ONe_yW8OOiRC=SA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqKHwYhHSb7GNFgOtBCqEeMshbRnU+0ONe_yW8OOiRC=SA@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_031241_092790_38FC1B86 
X-CRM114-Status: GOOD (  20.28  )
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
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:MEDIA DRIVERS FOR RENESAS - FCP"
 <linux-renesas-soc@vger.kernel.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 01:38:42PM -0600, Rob Herring wrote:
> On Wed, Dec 5, 2018 at 1:44 PM Simon Horman <horms@verge.net.au> wrote:
> >
> > On Tue, Dec 04, 2018 at 09:08:57AM -0600, Rob Herring wrote:
> > > On Tue, Dec 4, 2018 at 8:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Tue, Dec 4, 2018 at 3:48 PM Simon Horman <horms@verge.net.au> wrote:
> > > > > On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> > > > > > Convert Renesas SoC bindings to DT schema format using json-schema.
> > > > > >
> > > > > > Cc: Simon Horman <horms@verge.net.au>
> > > > > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > > Cc: linux-renesas-soc@vger.kernel.org
> > > > > > Cc: devicetree@vger.kernel.org
> > > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > > ---
> > > > > >  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
> > > > > >  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
> > > > > >  2 files changed, 218 insertions(+), 151 deletions(-)
> > > > > >  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
> > > > > >  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > what is this based on? I get a conflict when applying the .txt change
> > > > > and if I knew the base for this patch it would be rather easy to work
> > > > > out what has changed.
> > >
> > > 4.20-rc2
> > >
> > > > >
> > > > > Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?
> > >
> > > Yes. Though it was pointed out that get_maintainers.pl can pull emails
> > > out of this file. We'd need to get that to work by default though.
> > >
> > > > Probably even s/shmobile.yaml/renesas.yaml/, while at it?
> > >
> > > Sure, if that's what you all want.
> >
> > How about this?
> 
> LGTM

Thanks.

As my tree is already closed for v4.21 I have applied this for v4.22.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
