Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC6FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:10:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E4520673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YA9j+Us4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fxPQ1y7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E4520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F2U90UFwmkc3/QjDr0yheAhgsePG+6Ogkm09jj4rehA=; b=YA9j+Us4dBUlZ2
	XiPAw6XLzS1+iSbCA292fMHGGKeDfpqfRCmic5g+sLcol/6YaMo3Q7oKPaLem55TFk4u2USRd+GlN
	mA+xB0/sCPPn/ppQIPML0dVKwemaRR36wWZO6UkYWdRBzPQwYzRt94Rwjvqa+0vCnSKzlZHcIURwz
	it9ty5hSp1n31eVWVCQ9dfTagxS55tnw62kVUzghQLsK2J66WJEkyONfT238uU8678A21a+yWKpID
	XKxKpp5UUrt+hEpI4r17eFC9/Xli0PyTF32Ha/vd4Dx+n9EC3rpRUwC8rVTLyVqbcNpxZACEhl0n1
	YrnLXQ3Qi4KnmyAwx+Rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsrZ-0003QD-B6; Sat, 01 Dec 2018 00:10:25 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSseU-000232-2e
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:04 +0000
Received: by mail-lf1-x142.google.com with SMTP id z13so5304864lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HLad5wMnu3PLm5u97aR6djwuKeq08pCIj7YlgKOhdg4=;
 b=fxPQ1y7RqLJMPd3BzFqz/yHHnkEsS/YIsk1x8rl6n3kfrKafQcFB7Vhak8TRoi+YHs
 A7CH2k7Opw4N7tOPLzEkzqzvQzuadrd/MoSMl4m8Ho0HE8CnqdTiaoNaesSRc0z2dYpk
 T9AJSJBUJj6LvDXkYFf1FPdsQWz3MoIjmzdNFDUV4Hq4XZhY8GlYz8GGnjZ6Gri+WMtm
 2jJ+uYxPqXPgiJXOe2FTw37CUESfPRMlfu4d79Rxd+5Ni58KaD/RvjY5MxMdcM4rWAAo
 f8BwlCswqYQefBIo1fjVW+UsToE+J4lR8TjyjZH+rFdiZOBP2uAGJP6FiwXuysjSmzPW
 YjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HLad5wMnu3PLm5u97aR6djwuKeq08pCIj7YlgKOhdg4=;
 b=l0k06mrGlLU02SeLjwBgP5lAUB5xwizkopbULaO6vzco6MpDlHDcvlBpFeqybDxUA6
 7BNoNXh/6GzMmdIi4xJsip45awtRi3OpXGLYA2AsfwlZyiqbUXiGA//J6JonLt2c+u50
 lAz/1GH6m1ACef9cE77K7a1rraqLgTCcEW1dBdX7hbH3QQ48srCX+tBawU+9ItmgA20Q
 EFItgarjKOdt/hUtgGcvVCU9MkEpdZYWMBDAkrJBKPLWFkhkUNF3amzqf8s/MuMD20Oh
 jRZtJVE33Pe3Eo3gWTLl2W4VIgD0ehlYey6pi5S5Jm6I0Sm3tFCm/m/6GNyetRbqli5M
 Gpdg==
X-Gm-Message-State: AA+aEWaGt/FfZN0UNTxXkaNGGIfBWthNojBbKPQg6+geaSQsAUIF6XB2
 85B4qkdWiIKO+Il8pW88ToTcug==
X-Google-Smtp-Source: AFSGD/V91o9Ka89qJ8wF0UdGxuZmcOJFWUiHO6ztJllurKdEBVpgF0nHesOt9oubNCiXZuvOVGmp7g==
X-Received: by 2002:a19:c014:: with SMTP id q20mr4456443lff.16.1543622205418; 
 Fri, 30 Nov 2018 15:56:45 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id v19sm1046587lfe.69.2018.11.30.15.56.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:56:43 -0800 (PST)
Date: Fri, 30 Nov 2018 15:08:26 -0800
From: Olof Johansson <olof@lixom.net>
To: Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.21
Message-ID: <20181130230826.5kjtfyq2wdr73iwl@localhost>
References: <cover.1543409901.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543409901.git.horms+renesas@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155654_156148_D5C2F303 
X-CRM114-Status: GOOD (  23.86  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 02:02:12PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT updates for v4.21.
> 
> I am sending out this pull-request at this time as there are a number
> of patches queued up in my arm (32) DT branch and I hope that this
> will ease the burden later on in the development cycle. I expect to
> send a follow-up pull-request for this branch at the usual pre-rc6 timing.
> 
> Changes since v1:
> * Correct garbled Reviewed-by tag in
>   "[PATCH 01/16] ARM: dts: r9a06g032: Add pinctrl node"
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-dt-for-v4.21
> 
> for you to fetch changes up to 673df60a880f060e3e94920c7b5f7a9ed8aa65f2:
>   ARM: dts: r9a06g032: Correct the GIC DT node name (2018-11-28 13:55:30 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v4.21
> 
> * RZ/N1D (r9a06g032) SoC:
>   - Correct GIC DT node name
>   - Enable pin controller
> 
> * RZ/G1C (r8a77470) iWave g23S single board computer
>   - Add QSPI flash support
>   - Add pinctl support for EtherAVB
>   - Enable CMT0 (Renesas R-Car Compare Match Timer)
>   - Enable RWDT (Renesas Watchdog Timer)
>   - Enable uSD and eMMC support
> 
> * RZ/G1C (r8a77470) SoC:
>   - Describe USB-DMAC and I2C devices in DT
> 
> * R-Mobile A1 (r8a7740), Emma Mobile EV2 (emev2) and
>   SH-Mobile AG5 (sh72a0) SoCs:
>   - Include SoC name in DTSI
> 
> * R-Car H2 (r8a7790) based lager, and
>   R-Car M2-W (r8a7791) based koelsch and porter boards:
>   - Disable unconnected LVDS encoders

Hi,

If you revise a previous pull request, please do it as a new tag (and
delete the old one so our pull will fail), or at least please reply to
it so I see a "please don't pull this, I've respun a v2" threaded reply.

No harm done in this case, since you rewrote with the previous tag,
but it made me scratch my head when I saw the previous one and the hash
didn't match the email. ;)


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
