Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA17C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:08:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EAF217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fwDiTCKF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="As/SFm8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EAF217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J2uz16wVPE1KuU8AeAkE9xtDhwSL9AJoE6j1EZU7WzE=; b=fwDiTCKFTZo9OQ
	a/1ZMN7MmIcaf78wpFfKACIT191pWgX49StLH6IpQdWUNBl8qdS1xXhCmvYjuxeOuuPkDfs+7ALdw
	s5o2bpRXXMU+pWA6QbjqHcYv+79O6aUfGz9fPoKJj228wSgKo/G/FBCkLy+WaLmONckw/QiuJf3zC
	WxK4wkEPmmZxbSusV4OXFVbWbh4/ZOmPAlYF59pN1RN7JXGaC804lEckaO5NpKcbJaZrKrok1d//8
	szaKPLcMFdUnUl17scyCx7fzzIQ1+NASF2U6xTbLtTt7GVHr1vZcjjRWBdr+gdlzTj6yKAsR8dwWE
	8iNkY3a/LGD8kHRIrL4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyZfC-00011R-Up; Tue, 26 Feb 2019 10:08:38 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyZf8-00010i-Hz
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 10:08:37 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id EE97E25BE5E;
 Tue, 26 Feb 2019 21:08:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1551175710; bh=OhQ55XBvz/ooihtIVs6wJwoGtefXctRaSKll8NQpmFo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=As/SFm8RlZJTy59ZArwrX7PfsV9zp9lUjA6fWkBxINGak9C0LqLz2NqNG3/me0ZG5
 +mQ0ajdTYKCEWfA6xj267LM4B1p44iR1naXsEe7CPwfR9ko0O2AlHUEQcDWOmu+uF6
 bANIKjuPI2GXowyywTBRJWdxR45PHF1yp5yPJmUI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 3389F940373; Tue, 26 Feb 2019 11:08:28 +0100 (CET)
Date: Tue, 26 Feb 2019 11:08:28 +0100
From: Simon Horman <horms@verge.net.au>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] arm64: dts: renesas: salvator: add dummy 2nd port to
 rcar_sound
Message-ID: <20190226100827.ulpdghtq74nb73yp@verge.net.au>
References: <20190225093604.25753-1-horms+renesas@verge.net.au>
 <878sy3bdzh.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878sy3bdzh.wl-kuninori.morimoto.gx@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_020834_785217_3A1E9ABD 
X-CRM114-Status: GOOD (  19.41  )
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
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 09:28:53AM +0900, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> Thank you for your patch
> 
> > Add dummy 2nd port node to rcar_sound ports node to satisfy dtc
> > recommendation that #address-cells / #size-cells is only needed.
> > 
> > This addresses the following warning:
> > 
> > arch/arm64/boot/dts/renesas/salvator-common.dtsi:703.8-719.4: Warning (graph_child_address): /soc/sound@ec500000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> > arch/arm64/boot/dts/renesas/salvator-common.dtsi:703.8-719.4: Warning (graph_child_address): /soc/sound@ec500000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> > 
> > This change should not have any run-time effect.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > ---
> > Build tested against renesas-devel-20190214-v5.0-rc6
> > ---
> >  arch/arm64/boot/dts/renesas/salvator-common.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> > index a225c2457274..20b35991bc17 100644
> > --- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> > @@ -716,6 +716,15 @@
> >  				capture  = <&ssi1 &src1 &dvc1>;
> >  			};
> >  		};
> > +
> > +		/* Dummy node to be overriden by board DT
> > +		 * Satisfies dtc recommendation that
> > +		 * #address-cells / #size-cells is only needed
> > +		 * for graph nodes with multiple child nodes.
> > +		 */
> > +		rsnd_port1: port@1 {
> > +			reg = <1>;
> > +		};
> >  	};
> >  };
> 
> This solution is strange for me.
> I want to solve it, but I couldn't reproduce this.
> Which branch, and how to reproduce it ?

Thanks Morimoto-san,

I see this on renesas-devel-20190225-v5.0-rc8 using:

ARCH=arm64 make dtbs W=1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
