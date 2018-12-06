Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C9CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:39:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991B320868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k5hJKn/o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qn9iTtt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991B320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DX0ynXSh3c38iMSGTzObASyXLlG/MDDGxnThjbj9tT0=; b=k5hJKn/or6o2kP
	CNDIb01JQM9tOD4h1S0BEoVoPjK6HBigwip2RjE9woh6Y4iwcXsXZQx3Gde1GL1oy0ZousZcU7v0P
	NJlm5ohWDNzNW2iLdZQTn3CBb4dSOunis2lus1vaoBW3KmVBsDRin8u8zMQ7UdcXyFNnwqiVrKOU/
	BlsmyCqITvARuBTpfgHouXcTK6xMkRautaonp+YebZ+9mXtQ99tb4qsSsNyLdoNH/sOl3rZMidwxo
	PXtNt5F/jfgKbC1h5M9UpCNzuP9HFgbQ/iOFRs4t1m+U2SmbQl9jG1aoAI/1nN/DIlnz87k6hiHDs
	RYF5+Vht63mCvffPYfdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUzUN-0003h2-7I; Thu, 06 Dec 2018 19:39:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUzUJ-0003fa-Lr
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 19:39:09 +0000
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DC265214E0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 19:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544125136;
 bh=R15F2uQ3pXQCp7bVIOuAth3P/jfGbhBVk+KMwmpfWB0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qn9iTtt0raOx10iGEVlD4bAKxMmC6tRyMD3t2TPHW8unn7KLrLjaoSuyLMEWXWRmK
 RUjogClJhhm6zEzmLhigVgq1F63l1ZywAXJRxk96Dbkr7MvfaYerzZBpm33AyDx+ZA
 2VsBi8JCU3mZYoS5P4GVIYZb9r1j9yyhJKSunoec=
Received: by mail-qt1-f182.google.com with SMTP id n32so1858192qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 11:38:55 -0800 (PST)
X-Gm-Message-State: AA+aEWb83Gl7U4o7fqS1ErCFvZ8bpe7KaevzaVdmyGLJxMGJTXguAvXc
 64Eb9YDD7NjmNCxDThY+DSwIEYPzgNC/xJsF0w==
X-Google-Smtp-Source: AFSGD/XfapvVxtgRCg5w8FKOyzy07I+hnLoDVXwvjcbTigNHC8acVEaq0cWkWQbnEk++xrOO7b1rywtLrTjH7jfXDwc=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr29147928qvk.106.1544125135017; 
 Thu, 06 Dec 2018 11:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-27-robh@kernel.org>
 <20181204144822.uqonsto45u7ysdu5@verge.net.au>
 <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
 <CAL_JsqJX9eb58piavQayXM5j5GXxsGxmy93m5oRKtghMFvkhuA@mail.gmail.com>
 <20181205194419.p6u56h57yk63xshj@verge.net.au>
In-Reply-To: <20181205194419.p6u56h57yk63xshj@verge.net.au>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Dec 2018 13:38:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKHwYhHSb7GNFgOtBCqEeMshbRnU+0ONe_yW8OOiRC=SA@mail.gmail.com>
Message-ID: <CAL_JsqKHwYhHSb7GNFgOtBCqEeMshbRnU+0ONe_yW8OOiRC=SA@mail.gmail.com>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To: Simon Horman <horms@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_113907_743920_00406A19 
X-CRM114-Status: GOOD (  24.64  )
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

On Wed, Dec 5, 2018 at 1:44 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Tue, Dec 04, 2018 at 09:08:57AM -0600, Rob Herring wrote:
> > On Tue, Dec 4, 2018 at 8:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, Dec 4, 2018 at 3:48 PM Simon Horman <horms@verge.net.au> wrote:
> > > > On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> > > > > Convert Renesas SoC bindings to DT schema format using json-schema.
> > > > >
> > > > > Cc: Simon Horman <horms@verge.net.au>
> > > > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: linux-renesas-soc@vger.kernel.org
> > > > > Cc: devicetree@vger.kernel.org
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > >  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
> > > > >  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
> > > > >  2 files changed, 218 insertions(+), 151 deletions(-)
> > > > >  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
> > > > >  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml
> > > >
> > > > Hi Rob,
> > > >
> > > > what is this based on? I get a conflict when applying the .txt change
> > > > and if I knew the base for this patch it would be rather easy to work
> > > > out what has changed.
> >
> > 4.20-rc2
> >
> > > >
> > > > Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?
> >
> > Yes. Though it was pointed out that get_maintainers.pl can pull emails
> > out of this file. We'd need to get that to work by default though.
> >
> > > Probably even s/shmobile.yaml/renesas.yaml/, while at it?
> >
> > Sure, if that's what you all want.
>
> How about this?

LGTM

> From: Rob Herring <robh@kernel.org>
> Subject: [PATCH v2.1] dt-bindings: arm: Convert Renesas board/soc bindings to
>  json-schema
>
> Convert Renesas SoC bindings to DT schema format using json-schema.
>
> v2.1 [Simon Horman]
> - rebased on renesas-devel-20181204-v4.20-rc5
>   + Added r8a7744 development platform and SoM
>   + Correct RZ/G2E part number
> - Update MAINTAINERS
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/arm/renesas.yaml | 228 +++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/shmobile.txt | 155 --------------
>  MAINTAINERS                                        |   4 +-
>  3 files changed, 230 insertions(+), 157 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/renesas.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
