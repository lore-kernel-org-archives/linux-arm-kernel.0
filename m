Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC25C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:00:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F9C320685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DFHgqf10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9C320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AUFrTpnVFZHmclTMduP5vOqxoYSlwqNlH83AoFxqEiU=; b=DFHgqf10nto+AY
	hlLiu0KIhw4+WwGvDCWerJaHQvLBgOqTd4odTkAIX8qSm9QHqSx/BnxiyJ8CGiJuV8IhoPO1MvKvI
	T0Zn08S4DfQXZY3kp0+nZOmIZjVLUBXsDOYathHnJFUaKL3MzXnwzFMkFp6q8qPKXjEaR5Xr2ZXPm
	ogKTONN0pTFkRmNOQKfE/0yi0fxtjgRs5J2gwNEnuEItGecyt36QJ6wwMlYHIQ9RSBGDhCZcF0vOz
	q5aCEAnezuTzfB8fYI6Qby8HxraavgDjFXhK5K4X20aEkfuBeEu+raBsO/DDqvHlJ7dnIk5qA6c+C
	8m1VB4RE5v06X8IVPUgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwPbg-0006mA-E3; Wed, 20 Feb 2019 11:00:04 +0000
Received: from unicorn.mansr.com ([2001:8b0:ca0d:8d8e::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwPbd-0006NG-3D
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:00:02 +0000
Received: by unicorn.mansr.com (Postfix, from userid 51770)
 id 710AA15632; Wed, 20 Feb 2019 10:59:58 +0000 (GMT)
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] ARM: dts: sun7i: add pinctrl for missing uart mux options
References: <20190216182132.12895-1-mans@mansr.com>
 <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
 <20190220090617.aprfndnidcamwcvy@flea>
Date: Wed, 20 Feb 2019 10:59:58 +0000
In-Reply-To: <20190220090617.aprfndnidcamwcvy@flea> (Maxime Ripard's message
 of "Wed, 20 Feb 2019 10:06:17 +0100")
Message-ID: <yw1x36oiybbl.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_030001_315529_1E9195BE 
X-CRM114-Status: GOOD (  17.13  )
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
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Maxime Ripard <maxime.ripard@bootlin.com> writes:

> On Wed, Feb 20, 2019 at 04:58:49PM +0800, Chen-Yu Tsai wrote:
>> On Sun, Feb 17, 2019 at 2:21 AM Mans Rullgard <mans@mansr.com> wrote:
>> >
>> > This adds pinctrl settings for various missing uart options.
>> >
>> > Signed-off-by: Mans Rullgard <mans@mansr.com>
>> > ---
>> >  arch/arm/boot/dts/sun7i-a20.dtsi | 45 ++++++++++++++++++++++++++++++++
>> >  1 file changed, 45 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7=
i-a20.dtsi
>> > index af5b067a5f83..2295ff5adf48 100644
>> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>> > @@ -944,6 +944,31 @@
>> >                                 function =3D "uart0";
>> >                         };
>> >
>> > +                       uart0_pf_pins: uart0-pf-pins {
>> > +                               pins =3D "PF2", "PF4";
>> > +                               function =3D "uart0";
>> > +                       };
>> =

>> We've had the policy of not adding pinctrl nodes that aren't used in-tre=
e,
>> to avoid bloating up the blob size. However DTC 1.4.7 introduced the new
>> /omit-if-no-ref/ directive, which would make the compiler discard marked
>> nodes if they aren't referenced.
>> =

>> So please add this to all the new nodes. It seems to work regardless whe=
ther
>> you add it before or after the label, though having it after the label s=
eems
>> to make vim syntax highlighting happier.

Should we also add this to existing nodes?

BTW, I really do need all those uart pin options.

-- =

M=E5ns Rullg=E5rd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
