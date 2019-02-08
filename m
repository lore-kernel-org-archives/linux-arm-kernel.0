Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E4BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:21:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DA12077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ARXqyRms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DA12077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iBBH3j4bTo2wWTOK5V0PVS3GE5vvtGwScgMKOSy/AMc=; b=ARXqyRmsy8c1Zn
	Lc7+EkdNCAHyibLybq23i6xVyvJ+AjZU85yjJLiTgpiJUjqMKRfXS126/D9lWSapirOorOCQoP6M6
	cGEYgO6Bknyoh2znFV7/VeT0PV+SGKCo0vl6nNRTj9midKIjO1bJsTZYhzHjUQiaXSrOt7pTeZLQE
	t24NsEisE2KzpVyhAiJ/GLHXawAHW+CFT3xPNbzIrXKM+iHg9jFV4thnrndqNEQzSm77f3kqqshHs
	BeSG/+LvpiiuoFUkQtXN/xVUlcIDE9qZd/sGryowz0+IC6napPhM6yzyG/tuiD7bra5p4Iky0mbbg
	I3FZvQf4FwUQ19ckC0AA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsAmQ-0001RH-Gn; Fri, 08 Feb 2019 18:21:38 +0000
Received: from asavdk4.altibox.net ([109.247.116.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsAmM-0001Ql-58
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 18:21:36 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id 56A8D804D0;
 Fri,  8 Feb 2019 19:21:23 +0100 (CET)
Date: Fri, 8 Feb 2019 19:21:21 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 9/9] drm/panel: Add Ronbo RB070D30 panel
Message-ID: <20190208182121.GA7276@ravnborg.org>
References: <cover.23dbbc9b943ff8f36253ac7c617e2eda142b1b69.1549619502.git-series.maxime.ripard@bootlin.com>
 <3eff6d6164845eee5636d7451b0fe08b09d1cf07.1549619502.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3eff6d6164845eee5636d7451b0fe08b09d1cf07.1549619502.git-series.maxime.ripard@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=skhwakB6AAAA:8 a=P-IC7800AAAA:8 a=7gkXJVJtAAAA:8
 a=hU1VEbcjjjQde8rULrQA:9 a=CjuIK1q_8ugA:10 a=ygsXHyuYt4xGk45z1DgA:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=E9Po1WZjFZOl8hwRPBS3:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_102134_372537_4A8F402E 
X-CRM114-Status: GOOD (  11.34  )
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
Cc: Konstantin Sudakov <k.sudakov@integrasources.com>, bbrezillon@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime,

On Fri, Feb 08, 2019 at 10:53:22AM +0100, Maxime Ripard wrote:
> From: Konstantin Sudakov <k.sudakov@integrasources.com>
> 
> The Ronbo RB070D30 panel is a MIPI-DSI panel based on a Fitipower EK79007
> controller and a 1024x600 panel.
> 
> Signed-off-by: Konstantin Sudakov <k.sudakov@integrasources.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Driver looks good, no further comments.

With the issue pointed out by Konstantin you can add my:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
