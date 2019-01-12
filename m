Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BC4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:05:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84EEE2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NJLnCXbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EEE2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LQDSrd/6pLM3nvBo4sCEceK/R3qimCCAeZ/whGaPLNY=; b=NJLnCXbdFSxJGJ
	+dEfNM5ATuwGpUYEWlVbcjPUDsvwmCvXzkcDgPV7iniecv5MBbeO2VQiFoWH4L44Fqoz3ojI3Qfc6
	YrPsDIHyVpwgBHJzEfzPxidFxT85r/XE+OloVM9VPRc9MKFUbeqSqOG/bhGA+YWv8jFsPkszvy4u7
	I+mHCv3q4upEvHi7WJo6Irwc4JfzoC9yEckg3jcC0t/MGGH4h30druxlW49MjpZtwFpo8lF9FmcaX
	OVx1FsD3N+j8QMZG7kKK6ig+onXiGCXbDErgFSFBLvoC8+7u7vhtk987xuie9Wjm+f/+MQ5csWFvy
	cchbDuh1xWX/c+7m7Tsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giKqm-0005Zl-0F; Sat, 12 Jan 2019 15:05:28 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giKqg-0005ZD-Qo
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 15:05:26 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1giKqa-0003ir-Jh; Sat, 12 Jan 2019 16:05:16 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1giKqZ-0007fz-NT; Sat, 12 Jan 2019 16:05:15 +0100
Date: Sat, 12 Jan 2019 16:05:15 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
Message-ID: <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
 <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
 <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_070523_310750_D5CA8251 
X-CRM114-Status: GOOD (  22.22  )
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
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Praveen Kumar B <praveen.b@broadcom.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Scott,

On Fri, Jan 11, 2019 at 01:28:45PM -0800, Scott Branden wrote:
> On 2019-01-11 12:48 p.m., Uwe Kleine-K=F6nig wrote:
> > On Fri, Jan 11, 2019 at 10:51:14AM +0530, Sheetal Tigadoli wrote:
> > > From: Praveen Kumar B <praveen.b@broadcom.com>
> > > =

> > > Add new compatible string for new version of pwm-kona
> > > =

> > > Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> > > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > > Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> > > ---
> > >   Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > =

> > > diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt =
b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > index 8eae9fe..d37f697 100644
> > > --- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > +++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > @@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
> > >   This controller has 6 channels.
> > >   Required Properties :
> > > -- compatible: should contain "brcm,kona-pwm"
> > > +- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v2"
> > Is v2 used on a newer generation of kona SoCs? On i.MX these variants
> > are usually named after the first SoC that came with the new variant. Is
> > this sensible here, too?
> =

> It doesn't make as much sense here as different revs of the IP block are
> picked up based on various decisions.
> =

> A new SoC could decide to use an old version.

IMHO this is no reason to not use the name of the oldest SoC with this
variant. I don't know how the SoC names are in the broadcom family, but
if they were (in order of age, oldest first):

	ant
	bear
	crocodile

and ant and crocodile use the same IP block we would have

a) with v1, v2:

	ant:
		compatible =3D "brcm,kona-pwm-v1";
	bear:
		compatible =3D "brcm,kona-pwm-v2";
	crocodile:
		compatible =3D "brcm,kona-pwm-v1";

; and =


b) with the SoC naming:

	ant:
		compatible =3D "brcm,kona-ant-pwm";
	bear:
		compatible =3D "brcm,kona-bear-pwm";
	crocodile:
		compatible =3D "brcm,kona-crocodile-pwm", "brcm,kona-ant-pwm";

(If you want, drop "brcm,kona-crocodile-pwm", but keeping it is more
defensive.) =


I like b) (with "...-crocodile-...") better than a). crocodile using
"...-ant-..." is not more ugly than crocodile using "...-v1". This is
also a tad more robust because if broadcom releases kona-dolphin and
someone finds a minor difference between the IPs used on ant and
crocodile it depends on the order of these events who gets v3, while
with the SoC naming the result is clear.

(OK, and given that "brcm,kona-pwm" is already fixed, both approaches
need slight adaption, but I guess you still get what I meant.)

Best regards
Uwe


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
