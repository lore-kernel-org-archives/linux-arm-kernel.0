Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82C1C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:47:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B536120850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CU2Rnb4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B536120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iChbqLYWiowl/A0/Au6eysMFZU3ukfFsrROHsyte1gk=; b=CU2Rnb4XZ8oags
	h34fQKydUGBU348uScvmPWQ69Bbt6Yn4j9mptyeGAw2qNYa2gHuLOofvfSK8Pv7sgZmkKWmpD6Jnh
	YFBsWFoyTJELKbuhB/hdl0AdGOYhhJs8qHLir0QV/U6OsGwgtccb46wINtSTCkS0GNccuQECvvkWd
	ehV6nCjDzL/QtQmOGqzHYteB9Flnww3CHSbHTBZGtKKIHyeTUZkoRHNHwu5vb4JICGA+XP6XMAWQA
	z02zNO6DAfkCR9M2bzRVwjqpcm6LxT7qkQ8CPbB+6fISeLLfnFum6Pd7Cf2FvHijBt0bkExpkInWe
	WDsqjJHWdsROjAkEe70w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUIXm-0003Cy-7y; Tue, 04 Dec 2018 21:47:50 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUIXi-0002tv-Fm
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 21:47:48 +0000
Received: by mail-oi1-f193.google.com with SMTP id i6so15683253oia.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 13:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=h4IfCXMBhmfDml/xc3p3lpzvdTs3Mo2ee3ruNM29h5I=;
 b=ExM+r5zT4F9La8B1UI1Vmy+gZT8o+3eRl7MHmoSDJcWXrHmHjvX2BCiTV7Q/eC+/kT
 raR4k5zh09HKB0dQEsytrPzzOaZAlbSqmd+5vxrSbFIumVAE90YpYvByslE0EBd5OPwj
 anGtDizuQfbfXxhqX+a2GsYRpYkEY0O7fsQrTouC8n4pvPvTtP4BUcoWK363+udCyvF7
 brHkKxg/Jsb/id/XTFBJsrZO43ebIVqpxLCuF72zkncBv6EB0Hr1rlXST0ivi7/zehrQ
 L76Ua5MIBzz0ij+5Xd6WHx5cIfpY/ECQqeCLaDE7+/903rpdRjHIuJvcBbtl6eTyjwzM
 VVFw==
X-Gm-Message-State: AA+aEWbchhhsR9Odp3e1eQogtrnoBB0ZOizFGfpU8EV+1juxw44nyI40
 yiKgpAr8uDSBBmVy8u9xAQ==
X-Google-Smtp-Source: AFSGD/Vg6ShvAjfY/VQ25n/XOjRR/3J2ssxWm80K8x5Ckr0APduYY0hD2SecbtSEiYDw+yWKayl1zQ==
X-Received: by 2002:aca:f306:: with SMTP id r6mr14195069oih.230.1543960055384; 
 Tue, 04 Dec 2018 13:47:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t8sm7316697otp.69.2018.12.04.13.47.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 13:47:34 -0800 (PST)
Date: Tue, 4 Dec 2018 15:47:33 -0600
From: Rob Herring <robh@kernel.org>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH 11/15] dt-bindings: media: cedrus: Add compatibles for
 the A64 and H5
Message-ID: <20181204214733.GA14148@bogus>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-12-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181115145013.3378-12-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_134746_626148_37D7F8E3 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 15 Nov 2018 15:50:09 +0100, Paul Kocialkowski wrote:
> This introduces two new compatibles for the cedrus driver, for the
> A64 and H5 platforms.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  Documentation/devicetree/bindings/media/cedrus.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
