Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BB3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F19320660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ngXUq8Vn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Vscfogo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F19320660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=79JB8OY+c4BYbwuK0P3MNC/IuqP6dYIzsX7pUpis6VM=; b=ngXUq8VnRGWhPQ
	wGtaQMHjfZP3WQKndkM2uDt58sADmMBKTMAI40d3dRj73BQd3XX+iqxciUiUxDpfHhUXovCRjatJF
	bwiDYrth2nzIYX/auao+zDHuf0nLHuFhG1mW5KBWJz1L9zWv0xZAPuapK6VwWtOaO+jdBIn7g7RNa
	CVFThcDaF8j828UV4oPVqPt8kqid+vASZgYEyW8A8quiu0DD0jbuUrD0McLuaMNUxHkVy65T4CvCQ
	N2OL4RLqjHvbUNBYcvoi0g/F4qNDWFk5374uuyaBsPdQ2fDfMwmLv+7M8pM0sbVAZRiGaztJdji4H
	HIpBZwXKj5yAfBz3bk8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsf7-0002fp-OH; Fri, 30 Nov 2018 23:57:33 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSseV-000231-5A
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:04 +0000
Received: by mail-lj1-x241.google.com with SMTP id t9-v6so6470253ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9uD9YDnydevo9nRMPJgLqBg/yfbRj9oimK9+k829brM=;
 b=Vscfogo7iEiyhGO74tSw5fSVcJ0Mpux/Q4mAtZuqD46znw/go4jeKGVy+2a6eH07f6
 sPwRvGDlO70OwTAthVTSBTIEE6KTGxLkLKYmIh93iuCfZAMXPsZPgqtcswA8uzkXjgFJ
 xtMmHLszfmL9FZAwNlNc5IYoZ8QS17JXoe5/J9wq1n3OdbHdq56sk1GUXxz/Ht9T9MFD
 7AY3lutwIrYXWz4qZQoqU8TIAvmUGUIymg8b5qF8K652+2321Np1M62idrQmxEMJuQFM
 FzOKcZHU2qsKKOfGLTAs7ACzdMppIEksBAI6K7nwbC1BsysceLydpT0mJMoZUtVy0o+Q
 rxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9uD9YDnydevo9nRMPJgLqBg/yfbRj9oimK9+k829brM=;
 b=tPD8r7VoYhTA7ELhlHY3yraCUCZIX7RIRlwHznQxDicm1ai80DA8Yylm0+eJF+X9Eh
 FLJzQc1hlISIcDyn/nZAgs8ZkYfpbmWEOZZOtWKXDaU/TZadnlvHrjYYINVILOXEqz1a
 OdqhYxGT+rkHWanChGpT5aNT2LHHnYCu8cOlaiMJ9le0sW6yAFm1AiJc2eyYXNUdvb9/
 8fQo8Qbg/hr2zCyQVPhXyscR4nU9yqUJFgIKowK4KxaitKWm5ul6SIPq8pemDcKbEcUI
 nOaWRc3kiqKJTYq4Gw4/cZ7yFIru/xb2WiIoughy5rzYY79gSEezu0pD2UbR6p6V5Fzj
 XxOg==
X-Gm-Message-State: AA+aEWbXECHICQTc5FzX4LBycfzDV/DlNquLl/fqINgwtEnMJAuqrPuV
 ADNqjB1QURHzRgH9y9Nx96jX1Q==
X-Google-Smtp-Source: AFSGD/U9LxSbFUtJznEdr67t8v7UsrWGsEjQtEyKpMxzwYtX3J09+cNEGsGVYPhsfn9TJZDMWwWQKA==
X-Received: by 2002:a2e:9256:: with SMTP id
 v22-v6mr5638119ljg.178.1543622203021; 
 Fri, 30 Nov 2018 15:56:43 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id j138sm1056677lfg.64.2018.11.30.15.56.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:56:41 -0800 (PST)
Date: Fri, 30 Nov 2018 15:06:04 -0800
From: Olof Johansson <olof@lixom.net>
To: Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.21
Message-ID: <20181130230604.4wpje3qfal2lkqwx@localhost>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155655_592509_F89EEED6 
X-CRM114-Status: GOOD (  21.69  )
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

On Mon, Nov 26, 2018 at 01:55:01PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM64 based SoC DT updates for v4.21.
> 
> I am sending out this pull-request at this time as there are a number
> of patches queued up in my arm64 DT branch and I hope that this
> will ease the burden later on in the development cycle. I expect to
> send a follow-up pull-request for this branch at the usual pre-rc6 timing.
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.21
> 
> for you to fetch changes up to 275e4eb3f21a09b6b8bd4a353b9a01e500240385:
> 
>   arm64: dts: renesas: Add all CPUs in cooling maps (2018-11-26 09:11:44 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM64 Based SoC DT Updates for v4.21
> 
> * H3 (r8a7795) SoC:
>   - Remove unneeded sound #address/size-cells
> 
> * M3-W (r8a7796) SoC:
>   - Describe CMT (Compare Match Timer) devices in DT
>   - Describe I2C-DVFS device node in DT
> 
> * M3-N (r8a77965) SoC:
>   - Describe CAN, CANFD and LVDS in DT
> 
> * R-Car H3 (r8a7795) and M3-W (r8a7796) SoCs:
>   - Describe CPU topology, capacity and cooling maps in DT
>   - Add SSIU support to R-Car audio
> 
> * R-Car H3 (r8a7795), M3-W (r8a7796) and M3-N (r8a77965) SoCs:
>   - Extend register range of HSUSB device to match documentation
> 
> * R-Car H3 (r8a7795), M3-W (r8a7796) and M3-N (r8a77965) based
>   Salvator-X, Salvator-XS and ULCB boards:
>   - Switch eMMC bus to 1V8
> 
> * R-Car H3 (r8a7795), M3-W (r8a7796) and M3-N (r8a77965) based
>   Salvator-X and Salvator-XS boards:
>   - Describe USB3.0 xHCI host and prerepheral devices as companions
> 
> * R-Car E3 (r8a77990) SoC:
>   - Add thermal support
>   - Add support for interupt controller for external devices (INTC-EX)
>   - Describe all SCIF devices and SYS-DMA for I2C and MSIOF devices
> 
> * R-Car E3 (r8a77990) based Ebisu board:
>   - Enable SDHI, CAN, CANFD, audio and USB3.0
>   - Describe serial console pins
> 
> * R-Car E3 (r8a77990) based Ebisu and
>   R-Car D3 (r8a77995) based Draak board:
>   - Enable USB2.0 peripheral device
> 
> * R-Car M3-N (r8a77965), E3 (r8a77990) and V3H (r8a77980) SoCs:
>   - Connect EtherAVB to IPMMU
> 
> * R-Car V3M (r8a77970) and V3H (r8a77980) SoCs:
>   - Describe TMU (timer unit), PWM timer controller and MSIOF devides in DT
>   - Add thermal support
> 
> * RZ/G2M (r8a774a1) SoC:
>   - Use clock and power index macros
>   - Describe VIN, CSI-2 and CAN devices in DT


Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
