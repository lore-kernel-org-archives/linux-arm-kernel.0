Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2152C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:08:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975712075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bahJ7N9w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjzrMEG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975712075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KjYALwj58jObv7keIR8Aql8PgwbiokNiPgdxJJ16ydw=; b=bahJ7N9wfP0QNl
	IKIJ9dk3aS77/PSSprIqS5iuL2Bg6tiOZcP5ooynXBQ86R8Jt0vHE8mMr1ZS5RGbjHQimA7FKLpMH
	9fMuulYzePBQZom4tdWAVwdbOF+3ybOjjQ5LggU1z9klFniGuDXApLvMi8v26jNR61BL8n8T4W2gZ
	fnKj8rYqogKFOkFl5P/mmFv6mJMtLyRPZK07uTYm+t6m+Wh7mUkHMtuLvh0RwHBdLNQisQjhmxHeQ
	jr0J7zNCE7a2ZILbBYkXOwiBp/UfUMqPZ66Y080MuponCS/8XL7s4ABI0NoKzNcqoC3qZUJwx7uYU
	KWZDufJyD/dG36CJJSMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtywx-0002Ot-SJ; Wed, 13 Feb 2019 18:07:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtywu-0002OU-MV
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 18:07:58 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 39FA6222C9;
 Wed, 13 Feb 2019 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550081276;
 bh=rvTkxM2pJJrdLPA4N1SdM/Jn9teubk/E72psCNHDpgY=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=tjzrMEG0Zz7GF+bkG11xxCc6fcFdwHQQhnSqb10bkv0NujhWnQNyLW1m6xSRrnP5b
 vJR8LYAir+iQh27N6ADVMhCXpg75fUdHyiYGrdhumUGHjRU3xIaw9JCQB7m2vwYAlE
 wWfbAQuTKfZ12mkO0gmtatcLAkV92FSN/7JAGP9k=
MIME-Version: 1.0
To: Sugaya Taichi <sugaya.taichi@socionext.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <155008053444.115909.15767350529461671558@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v2 07/15] ndings: clock: milbeaut: add Milbeaut clock
 description
Message-ID: <155008127539.115909.8938099989804942@swboyd.mtv.corp.google.com>
References: <1549628823-31388-1-git-send-email-sugaya.taichi@socionext.com>
 <155008053444.115909.15767350529461671558@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 13 Feb 2019 10:07:55 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_100756_753742_B173AAD6 
X-CRM114-Status: GOOD (  13.57  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Stephen Boyd (2019-02-13 09:55:34)
> The subject seems to have been cut off? "ndings"?
> 
> Quoting Sugaya Taichi (2019-02-08 04:27:03)
> > diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> > new file mode 100644
> > index 0000000..bcfc5df
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> > @@ -0,0 +1,49 @@
> > +Milbeaut SoCs Clock Controller Binding
> > +----------------------------------------
> > +Milbeaut SoCs Clock controller is an integrated clock controller, which
> > +generates and supplies to all modules.
> > +
> > +This binding uses common clock bindings
> > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +
> > +Required properties:
> > +- compatible: should be one of the following:
> > +    "socionext,milbeaut-m10v-ccu" - for M10V SoC
> > +- reg: shall contain base address and length of clock registers
> > +- #clock-cells: shall be 1
> > +- clocks: shall be an external clock
> > +
> > +Example: Clock controller node:
> > +
> > +       clk: m10v-clk-ctrl@1d021000 {
> > +               compatible = "socionext,milbeaut-m10v-clk-ccu";
> 
> I thought there was some length limit on compatible string names. 32
> bytes? Just barely under!
> 

Ah I'm wrong. Compatible is 128. Good.

Seems I was thinking of DT property names.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
