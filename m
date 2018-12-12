Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82937C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:32:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50FB82084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kkEoKBur";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="FmA9lt61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FB82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E2laJuOkJEaErNN/BSBpD18tfmnKPblmkYd0pBx5F1k=; b=kkEoKBur2BMmIC
	Lz3s53atkapJnKoJVQaueLr63WAsNXvW9K/TUGOXPBMaJv9iDuvJ/Vls86zbqxFukRRWphS4yghEF
	ZnSPQNBwsSYMWZ9B9nEBMqChscfAytfvd8jg0+mbQUjRDIuMsCxc1ub9pTFsU9NceN3JHjWRKIcS8
	64i5O5FMCUi9/FcKAp1zX+DLWiiEYT2/2AxPYLjZeUlqy7sMcssCPn18aHQmi05XNl4+Xbcd7nYjV
	brPVqM9zqVdMw6tWbdlEJNdCb5y9fhS8zLRZArCDJ/W8jfVGYwwirnLg4efXX29nodU+SaDftdKJz
	keEsM63m+6eWXqt8HZew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1o5-0007zh-2E; Wed, 12 Dec 2018 10:31:57 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1o2-0007yo-5g
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:31:55 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 90B5325B740;
 Wed, 12 Dec 2018 21:31:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544610702; bh=hAJcJvwHkyYzPn3A2zaSnKd5HVN3ZKGVYKU9EBus/uk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FmA9lt61KO6WExa8fhQtZWrW7C6ebjTTOT64XpQcCZiE/629rRlpA3NwPbH+MHhSy
 HCj4uJR5ibkmTc3t4lMA2DiJxgjM65TvZOtfmt9ZBuiUxv50n7gkZdcfGylj9dUv2P
 jEZVFD1Z3ntOPXbnwNOq4unWyr/Qjfg4hFpG28pE=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id EA3A39404C7; Wed, 12 Dec 2018 11:31:40 +0100 (CET)
Date: Wed, 12 Dec 2018 11:31:40 +0100
From: Simon Horman <horms@verge.net.au>
To: Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable NXP pcf85363 rtc
Message-ID: <20181212103140.3kci64mn6fubuaok@verge.net.au>
References: <1544450712-44226-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544450712-44226-1-git-send-email-biju.das@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_023154_360608_6F7992E1 
X-CRM114-Status: GOOD (  10.50  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>, Arnd Bergmann <arnd@arndb.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>, Stefan Agner <stefan@agner.ch>,
 linux-renesas-soc@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-arm-kernel@lists.infradead.org,
 Alexandre Torgue <alexandre.torgue@st.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 02:05:12PM +0000, Biju Das wrote:
> The iWave RZ/G1C SBC supports RTC (NXP pcf85263). To increase
> hardware support enable the driver in the multi_v7_defconfig
> multiplatform configuration.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Thanks,

This looks fine to me but I will wait to see if there are other reviews
before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
