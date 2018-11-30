Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F4C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:00:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76872146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PihOs9wY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR6nWM3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76872146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vFFCzsEMzoyR/FVtOn60uuT8FxRFrjms0YqO4yz3Dq4=; b=PihOs9wYmxB98S
	kATlC9+P3zvpvzupxJr5JK85No8Z3Hlw0sag8Pj5CBk/mWHST/tZ44zjelHhkp3s6K7m+wabenMiU
	R1t6J7fftvXFDsbuHwzkiCs5pqwufxF912i58TNI2HJ/tK0ZP+n1d45Q1feVTHv2ItI0tb8hNgtvK
	Dp1CXhU+9Oyr/H+hD7W0dSMGgVoUKrX1P7pXxUtLhE150umrKxGFFX+yAbpckFK+7nFXTU83iPIC0
	wfGTsHLhfeNHnyL6fXy5iTYpIMz4VgUoECuWRHJqctKhaF6jpQg4Lcp3/25OCXYWWWiM2NTG/jqgI
	CPw4VHM0UIX5auCttgwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSn5q-0007IC-BI; Fri, 30 Nov 2018 18:00:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSn5Y-0006z8-7Q; Fri, 30 Nov 2018 18:00:31 +0000
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BF146214D9;
 Fri, 30 Nov 2018 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543600817;
 bh=/QpuGKJw2ddCeYOK3BoT6q8Eh45edi10/QgSRj8sg4I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=fR6nWM3wBm1dMxNyAUPSbwdj1Q+K/XNmHKVIxb+tfplFWTz5Hf9UQePJG9BlCS+qO
 Bf+tw27Vw48FA0mSJiQ4QVwrMDXC1EEGZj3XbJh6TVqZe+eC0hdOB2ibCvO4cXY5VB
 hS0wpOT5xwQYG6bMvsnZX/wBPyPmQm8uSOExBHd4=
Received: by mail-qt1-f169.google.com with SMTP id e5so6832092qtr.12;
 Fri, 30 Nov 2018 10:00:17 -0800 (PST)
X-Gm-Message-State: AA+aEWYPokI2d0A3SZH4tplYlLEe2u/fu7912lSP+lWzdo/nK7hRiqaW
 x/HMIzLMXwnGNmcUilUSIJIMuEAzDwBfskX1dQ==
X-Google-Smtp-Source: AFSGD/UiLGFEHfl3xFMRQ6BqqrGeqaokngd70FI9UTO2I8nWvpdwvFH4mj26CvCmZOH7gYUq10ZoErtWi8ZQJGhpW+0=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr6546459qts.144.1543600816930; 
 Fri, 30 Nov 2018 10:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-13-robh@kernel.org>
 <035ae23f-3c92-ffd9-0753-abbd604c5c02@xilinx.com>
In-Reply-To: <035ae23f-3c92-ffd9-0753-abbd604c5c02@xilinx.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 30 Nov 2018 12:00:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
Message-ID: <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
Subject: Re: [PATCH 12/36] dt-bindings: arm: Convert cpu binding to json-schema
To: Michal Simek <michal.simek@xilinx.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_100028_481823_B78523CD 
X-CRM114-Status: GOOD (  16.96  )
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
Cc: devicetree@vger.kernel.org, Kumar Gala <kumar.gala@linaro.org>,
 Grant Likely <glikely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>,
 Tom Rini <trini@konsulko.com>, Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jonathan Cameron <jic23@kernel.org>,
 Olof Johansson <olof@lixom.net>, linux-mediatek@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 8, 2018 at 2:49 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Hi Rob,
>
> On 05. 10. 18 18:58, Rob Herring wrote:
> > Convert ARM CPU binding to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-mediatek@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
> >  .../devicetree/bindings/arm/cpus.yaml         | 503 ++++++++++++++++++
> >  2 files changed, 503 insertions(+), 490 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml

[...]

> I have take a look at xilinx part of this and try to build it for arm64
> platforms and I see errors coming from this cpu description.
> /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> cpu@0:compatible: ['arm,cortex-a53', 'arm,armv8'] is too long
> /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> cpu@0:compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)

Thanks for actually giving this a spin!

> Based on grep this is used in a lot of places
> compatible = "arm,cortex-a53", "arm,armv8";
>
> Should this be moved to just simple?
> compatible = "arm,cortex-a53";

I'd normally go with the majority which would be to keep it. However,
'arm,armv8' is of questionable value, isn't actually documented, and
doesn't exist for any other version of the architecture. So we should
kill it IMO.

Paging Mark Rutland and other arm folks...

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
