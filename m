Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69AEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:40:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93A820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CIj/wVWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93A820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=stIG7MOLzk4mWFVwal83MvaHMKZ6NPbPudrSa2yYwVo=; b=CIj/wVWmy7XFQ1
	Wk5dNTtcb6Q0qFgUdrTxytef9sgxGlY/vCDKwcey17pxiSYR+k9Q/IPG/ExNQMtBOaRkc8n1JLD7z
	6XDCnq/+WfDlcv/OqfTxUbT9nh0xt2+xaQ1l7IlQZnjtH1GzXBXkVaXjYYXWypnWGvxsFZpht4auo
	mmye3+IZqOJST59grvGukFDF/5JrOD5KoU1NLBLzfp1Wg3GcHWwQahhysxnsYKVBAIGXUjauqi72a
	sqFK5RC3GoEmbHlsTpHMta8lHETwoyUCL1eTb0NfnIrm5aumudTpvU/xWE9qEu+ZDC47GUAGg/cwv
	5BuqW6YJbgyH0cj2qTgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnWo-0001pr-19; Mon, 03 Dec 2018 12:40:46 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnWl-0001ou-6o; Mon, 03 Dec 2018 12:40:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B4231688;
 Mon,  3 Dec 2018 04:40:32 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 655A03F614;
 Mon,  3 Dec 2018 04:40:32 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 538511AE1062; Mon,  3 Dec 2018 12:40:52 +0000 (GMT)
Date: Mon, 3 Dec 2018 12:40:52 +0000
From: Will Deacon <will.deacon@arm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 12/36] dt-bindings: arm: Convert cpu binding to json-schema
Message-ID: <20181203124039.GA25097@arm.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-13-robh@kernel.org>
 <035ae23f-3c92-ffd9-0753-abbd604c5c02@xilinx.com>
 <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_044043_264233_8FD4F790 
X-CRM114-Status: GOOD (  22.37  )
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
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Tom Rini <trini@konsulko.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michal Simek <michal.simek@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jonathan Cameron <jic23@kernel.org>,
 Olof Johansson <olof@lixom.net>, linux-mediatek@lists.infradead.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 12:00:05PM -0600, Rob Herring wrote:
> On Thu, Nov 8, 2018 at 2:49 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >
> > Hi Rob,
> >
> > On 05. 10. 18 18:58, Rob Herring wrote:
> > > Convert ARM CPU binding to DT schema format using json-schema.
> > >
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-mediatek@lists.infradead.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
> > >  .../devicetree/bindings/arm/cpus.yaml         | 503 ++++++++++++++++++
> > >  2 files changed, 503 insertions(+), 490 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
> > >  create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml
> 
> [...]
> 
> > I have take a look at xilinx part of this and try to build it for arm64
> > platforms and I see errors coming from this cpu description.
> > /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> > cpu@0:compatible: ['arm,cortex-a53', 'arm,armv8'] is too long
> > /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> > cpu@0:compatible: Additional items are not allowed ('arm,armv8' was
> > unexpected)
> 
> Thanks for actually giving this a spin!
> 
> > Based on grep this is used in a lot of places
> > compatible = "arm,cortex-a53", "arm,armv8";
> >
> > Should this be moved to just simple?
> > compatible = "arm,cortex-a53";
> 
> I'd normally go with the majority which would be to keep it. However,
> 'arm,armv8' is of questionable value, isn't actually documented, and
> doesn't exist for any other version of the architecture. So we should
> kill it IMO.

I'd prefer to keep it around, since that's what's used to describe the CPUs
on the fastmodel iirc.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
