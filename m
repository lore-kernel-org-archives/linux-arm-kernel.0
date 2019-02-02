Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4B5C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:39:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46D620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ms/GRsWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46D620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ovxW1VrDWEuBVDty8jJ3NfpQ7l1Tt+Q0IRSotvXf5vg=; b=ms/GRsWheznsV5
	0lxL1UW1KGzwSYqMrV089gIu8ev2qkPr5QSvKrGqayfVbyIXPz7SVq+eRajtEvmXW975H1sb9l3x1
	lrq4pJsF20xFKAPff1rJd1A4qb+2GUwkd8ulABea+smaln1tKtcDb8gPHRn8KYWeneEoLH2HYp+zA
	yQlWydnLMu2PLBqKxvztWao2Okd13WM7wJup0BUJAIVAw888ddE7GhZ++wiKW+w9gOCGgTG5GbcB/
	dgnIAOpastWdH7NZZbwNBGcND0WFLwDmahkGAf9Dm80+TgrmQgYfwqZ3jHf8pDuWRCqFZQ+3W2b2i
	oy9GLHyxt2sp6Kuq+OYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpsho-0003vv-Uz; Sat, 02 Feb 2019 10:39:24 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpshk-0003vK-Vw
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 10:39:22 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id E8B06FB03;
 Sat,  2 Feb 2019 11:39:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CZEUgBty-uNg; Sat,  2 Feb 2019 11:39:13 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id B1312461D6; Sat,  2 Feb 2019 11:22:11 +0100 (CET)
Date: Sat, 2 Feb 2019 11:22:11 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: Add documentation for mixel dphy
Message-ID: <20190202102211.GA3506@bogon.m.sigxcpu.org>
References: <cover.1549010639.git.agx@sigxcpu.org>
 <107cd5e7f44f5361db64115530e228ba5993e692.1549010639.git.agx@sigxcpu.org>
 <20190201141409.GA15276@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201141409.GA15276@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_023921_188025_FB6A0468 
X-CRM114-Status: GOOD (  13.33  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Robert Chiras <robert.chiras@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,
On Fri, Feb 01, 2019 at 03:14:09PM +0100, Sam Ravnborg wrote:
> Hi Guido
> =

> On Fri, Feb 01, 2019 at 09:49:54AM +0100, Guido G=FCnther wrote:
> > Add support for the MIXEL DPHY IP as found in the NXP's i.MX8MQ.
> > =

> > Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
> > ---
> >  .../bindings/phy/mixel,mipi-dsi-phy.txt       | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-ds=
i-phy.txt
> > =

> > diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.t=
xt b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> > new file mode 100644
> > index 000000000000..10323ae8ee37
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> > @@ -0,0 +1,29 @@
> > +Mixel DSI PHY for i.MX8
> > +
> > +The Mixel MIPI-DSI PHY IP block is e.g. found on MX8 platforms (along
> MX8 =3D> i.MX8 ?

Fixed and queued for v3.

> =

> Other than this nit:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Thanks,
 -- Guido

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
