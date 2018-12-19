Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A637C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:20:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D772084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cLLnVhrX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDDr24EW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D772084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E7gDsPOhZCJcNLdcbPN+JeM7Ba7HbcodymnWCCYs4KI=; b=cLLnVhrXaK2NP2
	0JSeWM/hSbo3iawPDLfYsxZSwgXUIdn6rlgrF6HwIaI2Re8FkTcr8JLJ3Ur8b/zw0YWw2wek/SIHj
	mt2cBLtCMeOngAteKbXmeQGvUu24aPUkJM/QA5Mifw3PbSRw3l8mON/wn/YSDyR/EHuK0cPO87cln
	pdIhD1V76XILc917dGumNqqAkHzZLYvmfNDtVQM7ksTjixm/mTwYEDNyFgP27IT4YE3M0MFgGK8H7
	/aEpBhs6bTLRd0yub2+pRdAT3IJuNnnW60ZcePNFAcg2t3EvbyKllAl7oaBt+NpAEEMjv+DguWWla
	ciNeVgq9sEUu62PCGkwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZciD-00058W-Q5; Wed, 19 Dec 2018 14:20:37 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZciA-00051e-D5
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 14:20:35 +0000
Received: by mail-oi1-x242.google.com with SMTP id m6so1688192oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=enBpW9z2Q8IDP1LWc6WGS6iQ8kJbCzIT6SFHV+eQdgE=;
 b=BDDr24EWhuTYnFx0pv5ycZQ7z0WxedpC+1VJuvbJz7aeGO880GbRNMwR5bFpX7QPjn
 qbMayO4/Ff3VMCin3leNIakB+9Xw8qGX09NONQnBUe0HwzYFV/sxnlmVAReVkvf74QSF
 JzPhk5EymwyIL8PCECiQIOSY6WXgc8QnWpAbbLhYnTweH1r3wABlXzOJuKeWF8ZOlwlq
 3z5sfIZnELtVaW97pEUAA5Ij5VifrGJklO8knLcvse2tD8VymuCCrPpXzT/40VA0gybi
 +A+ndZJnD04pIslS/CFP6cy4E9VLQgh8AAvT0lFH1qGtKnMyA3ZRw3/Zlx3sVd/tAF6u
 9u0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=enBpW9z2Q8IDP1LWc6WGS6iQ8kJbCzIT6SFHV+eQdgE=;
 b=Ai5JzvUXG13VEhmSO9F0n57buLbf+odahcvLqL+k/N2/C6PsEvCJTa4rGrD7WDdkcR
 rFRT4BoKVv7qfYTaXAKr3EIDOZIbvdoRVuyUs/ApSM93ohEhWTF8w76gRci1TAXrqFKP
 2e7Oid28m474Vk0kjmjemELWMhT83/uSHRg/7lt1JVuWf/MSyICKDWPMlaEvjKT7hD5f
 W3Xk2zSTo7StIAfo9xToE3kjPwOH9g+pjuv0gA2Llp3fFOT+iMhu9KDFz5AqjKwkBFOk
 Eeu3fFg35uY+IX2so/sJ0Sksjp1V8xyWq3KHBGnTPknx8qoa5EwqXeoJxhvHdhMKBn+Q
 2+UA==
X-Gm-Message-State: AA+aEWa1eHoyMQR5b3fDwFKR5zd5vvlFzbtFIfmf9pext7ebXX1sbQGW
 DLuhLK+avqk1Z1SbfEvKHKkpX/gMsWC9QJg0DPo=
X-Google-Smtp-Source: AFSGD/V2VfVgcdu67cktBky77q+AnN6zdP2WRORfE+XWRlSe4o7dc4B7BdKQRJ/25Hb0n60Fve9IVzAbt2AnTlUfltE=
X-Received: by 2002:aca:6155:: with SMTP id v82mr1236205oib.259.1545229222825; 
 Wed, 19 Dec 2018 06:20:22 -0800 (PST)
MIME-Version: 1.0
References: <fcbce8f7ba22014a8f06b7f52ad56faaa03b948b.camel@toradex.com>
 <8d6905f9aed82a0181d1d8eb2259946c47825a7f.camel@nxp.com>
 <CAEnQRZAHE77GsaES--LtWs3F4uHP2ePp3-KmP4xmZDh7NM4njw@mail.gmail.com>
In-Reply-To: <CAEnQRZAHE77GsaES--LtWs3F4uHP2ePp3-KmP4xmZDh7NM4njw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Dec 2018 12:20:17 -0200
Message-ID: <CAOMZO5AmaQgz+X_dYgafVYHooY649CBBP6ERbX6B+Gt_A-1s5A@mail.gmail.com>
Subject: Re: [REGRESSION] imx_v6_v7_defconfig: undefined reference to
 `__hyp_stub_vectors'
To: Daniel Baluta <daniel.baluta@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Rob Herring <robh@kernel.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_062034_438753_6B7B9FAD 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Daniel,

On Wed, Dec 19, 2018 at 11:32 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Wed, Dec 19, 2018 at 3:17 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> >
> > On Wed, 2018-12-19 at 12:42 +0000, Marcel Ziswiler wrote:
> > > Hi there
> > >
> > > I noticed that at least today's and yesterdays -next won't build with
> > > the imx_v6_v7_defconfig giving the following error:
> > >
> > >   LD      arch/arm/boot/compressed/vmlinux
> > > arch/arm/boot/compressed/head.o: In function `restart':
> > > (.text+0xa8): undefined reference to `__hyp_stub_vectors'
> > > (.text+0xac): undefined reference to `__hyp_stub_vectors'
> > >
> > > Has anybody seen that as well and knows what is going on?
> >
> > Hmm, works for me.

Yes, I haven't seen build failures reported by the autobuilders:
http://kisskb.ellerman.id.au/kisskb/target/7464/

> On the other hand I'm getting this warning:
>
> arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning (spi_bus_bridge):
> /soc/aips-bus@40080000/spi@400ad000: incorrect #address-cells for SPI
> bus
>   also defined at arch/arm/boot/dts/vf610-bk4.dts:107.8-119.3
> arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed
> prerequisite 'spi_bus_bridge'
>
>
> Maybe Rob can jump in?

Yes, I have already reported this warning to Rob and Lukasz. Hopefully
they could help fixing it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
