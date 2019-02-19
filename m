Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5B2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:30:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF0C217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F9+0eOhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF0C217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1/EtsidJdzdG4oYmtqtXiXixLzYez1pNYSQd7XkszfM=; b=F9+0eOhXGjSIk6
	P77JaIgAmgU/9UoNl5s1a5ssW1D+HL4mAZMfZzFDg5pw0XIt+Ka6lLMm2gM/BjZBkjIRH3NSIHgTS
	Gwt2KoDgR/kPrQ61eiDCjQwbfWMFj3Fh8YDAESaNPqPd3cXWFMlzbiedgq2EWGX9r+OpXF35S8le5
	Tu7DQiya9esX6MemlES+5WCboPROSJohdbH45kqNagQsfo++ef3q0jLn2ewinCAF/pu7erokoMI3f
	MMoLHMVvDBhHosVYBlQy/JIwhSBefQUzFm1B6dKqYlVKw4pNjT+F4/sh4etFK4ugADO5DFvNBCeiY
	VtIMjUhbdABcQ4n6nFEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvzrY-00064J-DK; Tue, 19 Feb 2019 07:30:44 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvzrU-00063G-Md
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 07:30:42 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gvzrI-0002aL-HA; Tue, 19 Feb 2019 08:30:28 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gvzrI-0002Vg-1S; Tue, 19 Feb 2019 08:30:28 +0100
Date: Tue, 19 Feb 2019 08:30:28 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 2/5] dt-bindings: pwm: add a property
 "mediatek,num-pwms"
Message-ID: <20190219073028.eljpo6vlqpgmzcef@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <7e1de17a43f2cde73aecd2773e2b3a5fdfd294f3.1547781007.git.ryder.lee@mediatek.com>
 <7d387d2a-74f0-c6c7-aa2d-cf9b87579682@gmail.com>
 <20190218203658.GA20434@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190218203658.GA20434@bogus>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_233040_897199_A897CF29 
X-CRM114-Status: GOOD (  23.08  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 linux-pwm@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 02:36:58PM -0600, Rob Herring wrote:
> On Fri, Jan 18, 2019 at 09:44:49AM +0100, Matthias Brugger wrote:
> > =

> > =

> > On 18/01/2019 04:24, Ryder Lee wrote:
> > > This adds a property "mediatek,num-pwms" in example so that we could
> > > set the number of PWM channels via device tree.
> > > =

> > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > ---
> > > Changes since v1: add a Reviewed-by tag.
> > > ---
> > >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > =

> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b=
/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > > index 991728c..f9e2d1f 100644
> > > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > > @@ -20,6 +20,7 @@ Required properties:
> > >   - pinctrl-names: Must contain a "default" entry.
> > >   - pinctrl-0: One property must exist for each entry in pinctrl-name=
s.
> > >     See pinctrl/pinctrl-bindings.txt for details of the property valu=
es.
> > > + - mediatek,num-pwms: the number of PWM channels.
> > >  =

> > >  Example:
> > >  	pwm0: pwm@11006000 {
> > > @@ -37,4 +38,5 @@ Example:
> > >  			      "pwm3", "pwm4", "pwm5";
> > >  		pinctrl-names =3D "default";
> > >  		pinctrl-0 =3D <&pwm0_pins>;
> > > +		mediatek,num-pwms =3D <5>;
> > >  	};
> > > =

> > =

> > Wasn't there a comment in the last version to use num-pwms instead of
> > mediatek,num-pwms?
> > =

> > Uwe I think you requested that.
> =

> Perhaps, but why is this needed? Typically, this would be implied by the =

> compatible or the driver doesn't care and we assume 'pwms' properties =

> are not out of range.

I think it is sensible to standardize such a property because there are
a few drivers that support different variants of PWMs that only differ
in the number of supported pwms. See for example pwm-mediatek and
pwm-sun4i. I wrote a longer motivation in a mail that is available at
https://www.spinics.net/lists/linux-pwm/msg08859.html.

The short version is that there are at least four drivers that have to
solve the same task to determine the number of available pwms from the
compatible. While this isn't a hard task it seems sensible to me to
describe this generic property of a piece of hardware that provides PWMs
in the device tree instead of implementing a table in the driver.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
