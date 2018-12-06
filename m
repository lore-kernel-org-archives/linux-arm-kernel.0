Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93827C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:03:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58AA820878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mYpvweqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AA820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a2/1W7NS9NSu+EY7U2mWwB+QyQc88Ffa4du9K2KjCso=; b=mYpvweqZL7/257
	1bbHK0Rjpy+UqlMR881fFKI/t2C2jkyw74ZmjTP2OgW7feYqRQdaOo9h7k8yusSrGaqfsqX+eT4pC
	q6pOrbsRlCeCQg9AErzWE4VvSYXdBjVSusL31LLMa6h/8uP98mlnoqwqEPJffRSl4WVyywi7N5W8u
	Q+XyXxQ10aNQeq8/sznW75XY18D4+A8A5mGYpYQyl+5xQwil9xfFapOaZtAfJbiYH7yeFWLEKw6UM
	Xd2+9NkjBAup93LSeoDY3FAe+ZqKSfXiM6gNoKiwALDjox9Rx2kjVOoaUiBKCbhYB6SQ8cwWvjcg/
	nMFVP0euh1ND0Sqn90SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtJh-0001dr-Pf; Thu, 06 Dec 2018 13:03:45 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtJe-0001bm-DF; Thu, 06 Dec 2018 13:03:43 +0000
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa
 (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256) (Exim 4.89)
 (envelope-from <heiko@sntech.de>)
 id 1gUtJP-00069e-HA; Thu, 06 Dec 2018 14:03:27 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: agajjar <Akash_Gajjar@mentor.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rockpro64 fix video output chain
Date: Thu, 06 Dec 2018 14:03:27 +0100
Message-ID: <3141294.pN5WgFrMoD@phil>
In-Reply-To: <09287391-d541-cddb-4168-55ca6fee3f16@mentor.com>
References: <20181201100817.20688-1-oskari@lemmela.net>
 <20181201100817.20688-3-oskari@lemmela.net>
 <09287391-d541-cddb-4168-55ca6fee3f16@mentor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_050342_591963_DE87C6E8 
X-CRM114-Status: GOOD (  15.43  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Mittwoch, 5. Dezember 2018, 14:03:29 CET schrieb agajjar:
> 
> On 12/1/2018 3:38 PM, Oskari Lemmela wrote:
> > Rockpro64 is not able boot if kernel is compiled with
> > CONFIG_DRM_ROCKCHIP=m
> >
> > Enable Rockpro64 board HDMI output to fix issue.
> 
> Hi Oskari,
> 
> Could you please describe this issue in detail.
> 
> I am not able to reproduce this issue if CONFIG_DRM_ROCKCHIP is compile 
> in or as a loadable module at the same time hdmi node is present or not.

I've now simply adjusted the commit message to:
"arm64: dts: rockchip: enable hdmi output on rk3399-rockpro64
    
The rockpro64 does have hdmi support, so add the necessary
devicetree node to enable it."

and applied it for 4.21.

While it still would be good to find out where the issue comes from Oskari
is seeing, the rockpro64 does have hdmi, so we can just enable it ;-)


Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
