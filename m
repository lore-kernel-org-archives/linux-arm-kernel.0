Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CADC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:14:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813772086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hsnB/gem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813772086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0NAQfejPEqFSnyZbruNa0CGXKp3BDJd/RP8/QaDAXeY=; b=hsnB/gemqJ1xJ2
	a1FE9zYfzOaLHTtSstXKfRF4fntXCxo43X1BpzpLpEcd6C5W9WNL152jCt5UqYlg0gk7+zLf0ZT74
	WxrGmGnCDGOsm5nHUjczT4g6TxPxXrz/8j6LJtJl3UeJwQ7npftAKelNSNpHfJbzrPcN0+wQuRvAC
	JULzPzJ7G4Yn0shc1/4oamGrfeV8nGvjpVr/6tUmyZLkTZmiEaQuOgb9ucblK/k8vM+gDWaqfGUl1
	r4wfO3QmBjLN3w5o2zxJzYgyi04T26ATQ4IxAZbTQAYw6GchlvmKR5DSy6lkDyuBsTXspLSnBbM3K
	GFVibxDwbeoCMxQTxc9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpZaJ-0001IE-PN; Fri, 01 Feb 2019 14:14:23 +0000
Received: from asavdk3.altibox.net ([109.247.116.14])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpZaF-0001HU-FF
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 14:14:21 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk3.altibox.net (Postfix) with ESMTPS id 525622009A;
 Fri,  1 Feb 2019 15:14:11 +0100 (CET)
Date: Fri, 1 Feb 2019 15:14:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: Add documentation for mixel dphy
Message-ID: <20190201141409.GA15276@ravnborg.org>
References: <cover.1549010639.git.agx@sigxcpu.org>
 <107cd5e7f44f5361db64115530e228ba5993e692.1549010639.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <107cd5e7f44f5361db64115530e228ba5993e692.1549010639.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=8nJEP1OIZ-IA:10 a=ze386MxoAAAA:8 a=7gkXJVJtAAAA:8
 a=Y-R3UY6YFzVJNQr79tIA:9 a=wPNLvfGTeEIA:10 a=iBZjaW-pnkserzjvUTHh:22
 a=E9Po1WZjFZOl8hwRPBS3:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_061419_683844_E7576BB6 
X-CRM114-Status: GOOD (  13.70  )
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

Hi Guido

On Fri, Feb 01, 2019 at 09:49:54AM +0100, Guido G=FCnther wrote:
> Add support for the MIXEL DPHY IP as found in the NXP's i.MX8MQ.
> =

> Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
> ---
>  .../bindings/phy/mixel,mipi-dsi-phy.txt       | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-=
phy.txt
> =

> diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt=
 b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> new file mode 100644
> index 000000000000..10323ae8ee37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> @@ -0,0 +1,29 @@
> +Mixel DSI PHY for i.MX8
> +
> +The Mixel MIPI-DSI PHY IP block is e.g. found on MX8 platforms (along
MX8 =3D> i.MX8 ?

Other than this nit:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
