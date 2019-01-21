Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBFAC37125
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:11:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A64120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iUj6A0pS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A64120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v9aC0bOQQq4A9LGHbreF8wUdELbdQGWLlEZPOiXpQHo=; b=iUj6A0pSjLCFyw
	4qTOsOeuzyDwVu0VjtTp3V2J6bWMlvXbVFC0VNb0/7kpglNBlECJRv62APxM/rIi76VJRkQuqxFuY
	73iNSC7cdhdukLpja57s0kF6cU5fj9xiDpuWbPVeF8b/szG/KMO9FYpIbnQsegA+7me17K5NfgSBJ
	1I5y7gZEjRjZSnJWYDyVVf1qMuWDUYz4NzgT7eItG4GzuOy5i7O0zitQkAwOuBvdqxixCeeJceXKy
	WOYDBdCKBjhHZl7G2VdwQsAmEQfqR9nFuiRRRy2iEW8KMF/QPAkCUbz3iL6zAot0cLxiKCi9TbBx3
	PL8o5hDQkeAvhHQTrthg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gliil-0000uY-UC; Mon, 21 Jan 2019 23:11:11 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gliii-0000u0-GQ
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 23:11:10 +0000
Received: by mail-oi1-f194.google.com with SMTP id a77so15880483oii.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 15:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=NwNeLn0NpBVarhMV52VLX7e0pWYxS9hGh57kuH7rECo=;
 b=newTGmDQZumWD2al+18a5BsE+wXk4qzWwhafQmCoU9sq+DJnmpcouwvABlAidh6HnE
 rL08VJoHZge+o10sInQ95iys4beJWIlg1k/lkIdWhuEdkti8uMssR6JX6VohNHyOEfPt
 G3aIPxwoIjXPq+GSJ7YT9EG9Y3f1t2blFTP22nzyhVS4FbmNYvxksC7PV5wTEiFXqjCd
 nR4nqqlFRfdTQScMOsCF76ZHQkcKyMzIf002I9yfjF0EssyBhVbIT/vd6B2G3uMpcqya
 6T1k+RQSx7Xrit7N1a2VraLR4gLo/wllxn3XUOT3NzlEzqfEGJCxsA6pCmZJqbDghxN8
 QDXQ==
X-Gm-Message-State: AJcUukfOlWlKNV2PntrD75/3NaFocDuOBcYnF/m3oaMPo5LlJEChaEXE
 nlRnwtkT3MotgUCb0qQmAg==
X-Google-Smtp-Source: ALg8bN6p+y2XEyno1sJgniFlSuloOmBoju0jcHaQK3PjbzOpfgdfm1vh2Q3q60fbYjwLzMxepeOmtQ==
X-Received: by 2002:aca:abcd:: with SMTP id u196mr7058419oie.29.1548112267236; 
 Mon, 21 Jan 2019 15:11:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 30sm6047743ots.52.2019.01.21.15.11.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 15:11:06 -0800 (PST)
Date: Mon, 21 Jan 2019 17:11:05 -0600
From: Rob Herring <robh@kernel.org>
To: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
Message-ID: <20190121231105.GA928@bogus>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
 <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
 <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
 <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
 <faadc46d-94b5-a32c-79ae-4206fbc26608@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <faadc46d-94b5-a32c-79ae-4206fbc26608@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_151108_542827_EA06D125 
X-CRM114-Status: GOOD (  33.39  )
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
Cc: linux-pwm@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 Praveen Kumar B <praveen.b@broadcom.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 04:14:21PM -0800, Scott Branden wrote:
> Hi Uwe,
> =

> On 2019-01-12 7:05 a.m., Uwe Kleine-K=F6nig wrote:
> > Hello Scott,
> > =

> > On Fri, Jan 11, 2019 at 01:28:45PM -0800, Scott Branden wrote:
> > > On 2019-01-11 12:48 p.m., Uwe Kleine-K=F6nig wrote:
> > > > On Fri, Jan 11, 2019 at 10:51:14AM +0530, Sheetal Tigadoli wrote:
> > > > > From: Praveen Kumar B <praveen.b@broadcom.com>
> > > > > =

> > > > > Add new compatible string for new version of pwm-kona
> > > > > =

> > > > > Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> > > > > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > > > > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > > > > Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> > > > > ---
> > > > >    Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > =

> > > > > diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.=
txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > > > index 8eae9fe..d37f697 100644
> > > > > --- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > > > +++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > > > @@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
> > > > >    This controller has 6 channels.
> > > > >    Required Properties :
> > > > > -- compatible: should contain "brcm,kona-pwm"
> > > > > +- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v=
2"
> > > > Is v2 used on a newer generation of kona SoCs? On i.MX these varian=
ts
> > > > are usually named after the first SoC that came with the new varian=
t. Is
> > > > this sensible here, too?
> > > It doesn't make as much sense here as different revs of the IP block =
are
> > > picked up based on various decisions.
> > > =

> > > A new SoC could decide to use an old version.
> > IMHO this is no reason to not use the name of the oldest SoC with this
> > variant. I don't know how the SoC names are in the broadcom family, but
> > if they were (in order of age, oldest first):
> > =

> > 	ant
> > 	bear
> > 	crocodile
> > =

> > and ant and crocodile use the same IP block we would have
> > =

> > a) with v1, v2:
> > =

> > 	ant:
> > 		compatible =3D "brcm,kona-pwm-v1";
> > 	bear:
> > 		compatible =3D "brcm,kona-pwm-v2";
> > 	crocodile:
> > 		compatible =3D "brcm,kona-pwm-v1";

Version numbers can be fine, but generally only as fallbacks as even the =

same IP version can be integrated into an SoC differently.

The other issue with versions is they should be meanful such as =

corresponding to version tags in IP repos. Often, I'd guess anything =

with a 'v1' is just what some s/w person made up. Of course, we only =

can really know that for opensource IP or programmable logic IP.

If you do use versions, document what the versioning scheme is.

> > =

> > ; and
> > =

> > b) with the SoC naming:
> > =

> > 	ant:
> > 		compatible =3D "brcm,kona-ant-pwm";
> > 	bear:
> > 		compatible =3D "brcm,kona-bear-pwm";
> > 	crocodile:
> > 		compatible =3D "brcm,kona-crocodile-pwm", "brcm,kona-ant-pwm";

This is the recommended practice.

> > =

> > (If you want, drop "brcm,kona-crocodile-pwm", but keeping it is more
> > defensive.)

Generally, you should have "brcm,kona-crocodile-pwm" in case there's =

some difference found later. Then you can support the bug or feature =

without a DT change.

> > =

> > I like b) (with "...-crocodile-...") better than a). crocodile using
> > "...-ant-..." is not more ugly than crocodile using "...-v1". This is
> > also a tad more robust because if broadcom releases kona-dolphin and
> > someone finds a minor difference between the IPs used on ant and
> > crocodile it depends on the order of these events who gets v3, while
> > with the SoC naming the result is clear.
> > =

> > (OK, and given that "brcm,kona-pwm" is already fixed, both approaches
> > need slight adaption, but I guess you still get what I meant.)
> =

> Thanks for your thoughts and explanation.
> =

> It is unfortunate devicetree has no proper guidelines or documentation on
> =

> binding naming.=A0 In the interest of getting this upstream we can name it

Surely we've captured that somewhere...

> =

> "brcm, omega-pwm".=A0 We can drop kona from the binding name as that
> architecture
> =

> is really no more - only IP derived from it is - hence the name kona-v2
> previously.
> =

> > =

> > Best regards
> > Uwe
> > =

> > =

> Cheers,
> Scott

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
