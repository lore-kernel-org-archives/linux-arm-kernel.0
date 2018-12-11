Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56073C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271B22084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jcUFf6Ni";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vb20TmGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271B22084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4zrQ5VXvL6dHZAgLV+hValCuZWQ9pnKTRXfbMXjvO5U=; b=jcUFf6NiHOoM5C
	0yov64FWtXh1S5rtINdbd4xIJo2nWkl7paI7qXy2huZ0VsNKxkMI8ifJlCT4f2fXC9q40/oJ7Tqnb
	px+YZKOc1JJGNj2GJwRFA6vljc5e1H+gaa4mzwIj0wod/+UPnTgJYZX7sEcg7UYjQC9foTmBRQ8wE
	OYie9zvSyggLe5Ujl/Seo0g2jt2GvAlLlF04WifEw4ZqU0U28ektHgdYNz2lE6BohR2BPL2YeihUL
	cucOLHkyEuDcDeuyXJxOCx98Nbj3R5TRnhaeLdKc6s4/+oUBTBB6nwv+iI0OKxNPMKNCmpcIVhduX
	IAB24YgEVTabzZ3KfFzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkfC-0005nZ-Dv; Tue, 11 Dec 2018 16:13:38 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWke4-0004NG-8h
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:12:33 +0000
Received: by mail-lj1-x242.google.com with SMTP id n18-v6so13466199lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pvhpXOMsxkTlIYyqbC40+seCfFxUjBqooYGLPgBruW8=;
 b=vb20TmGsuv0ByrmTk49/pYJuYwDsVs6dIPqJucBacPOsBrkVh1UT1xerHyF/jiFneP
 o/9SngaTur1yLXDGGRzeMhOLNH8ERMTev1Jq1wY7+d9Qmhn9Ci1AgzgT9JsXF6kWnvY2
 TIpD7XziPfA0GGIwNZH1KO2pQbS2iM15AqYU22ML+/mQn1S1SDOEwMujorw+IwKp2j3E
 EQERolRf2hNwEwDldm+0XRQg+IlFcWuAX9cBXhMvzV1UMyWf7jSfqrpFpXo1+83SdN5o
 gAMX9MA+eObK8oRFe4NGQM8VwiYKRWZh4uJTJonbEjlGvG5Ts6gX8ECAxdqe10BeCXKM
 SiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pvhpXOMsxkTlIYyqbC40+seCfFxUjBqooYGLPgBruW8=;
 b=izOV8aRYugoBlrCFbw2GZCg9PK5tUMMaroJNrdTDP96sXub8igjjB0PFHBmj/2sfAl
 5U3gZG9SG441xy3iB58GeLmC7Eu59AogTY4Got5UinQKd0BdcXCYkSvjXB9ojz1ZbmVw
 K0PHT1WC/4fvjxSRQBEvK+wBoRU+uk/P7vaizLU3hLpDZl122BhF0E6/UosldepWiMMn
 owH1WAG9Rm/UmP28zYi2QHvVbzXNvvXHxGWGQevgfewj86LJkESVfVIy65Yrn0ayMjd9
 Ng+Y0rYLUltuIhemhjxT+yYSweZHJOLKvBASVlcratOluYV8bBEgK/ny+eKze/9FnMxH
 TzDw==
X-Gm-Message-State: AA+aEWajL3T5ht7IxYOpRaRxdGXlFlcw50x+jR52e9woCpwEMd7AonvC
 SIPuwL7bs5Twl/XaxpbUOzRaLA==
X-Google-Smtp-Source: AFSGD/WXMqx+6oXt8/iXdsMMQjmdn9DhXcmWrHs0ZUNkKU5rRJ1rOSanPkWXwfF+7HurIr/E6bM6ew==
X-Received: by 2002:a2e:750a:: with SMTP id
 q10-v6mr2157610ljc.39.1544544746414; 
 Tue, 11 Dec 2018 08:12:26 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id l21-v6sm2772956ljj.48.2018.12.11.08.12.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 08:12:25 -0800 (PST)
Date: Tue, 11 Dec 2018 08:04:19 -0800
From: Olof Johansson <olof@lixom.net>
To: Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for
 v4.21
Message-ID: <20181211160419.nl24m6e3s5z2dmd3@localhost>
References: <cover.1544125558.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1544125558.git.horms+renesas@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_081228_653876_11B5A9BC 
X-CRM114-Status: GOOD (  17.75  )
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

On Thu, Dec 06, 2018 at 01:58:23PM -0800, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC DT updates for v4.21.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-arm-dt-for-v4.21,
> which you have already pulled.
> 
> 
> The following changes since commit 673df60a880f060e3e94920c7b5f7a9ed8aa65f2:
> 
>   ARM: dts: r9a06g032: Correct the GIC DT node name (2018-11-28 13:55:30 +0100)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-dt2-for-v4.21
> 
> for you to fetch changes up to e259e04748e2798a747d9c363ded50514b15a7b9:
> 
>   ARM: dts: r8a7744-iwg20m: Add SPI NOR support (2018-12-05 11:52:46 -0800)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC DT Updates for v4.21
> 
> * RZ/G1N (r8a7744) SoC
>   - Describe in DT: SYS-DMAC, GPIO, Ethernet AVB, SMP, [H]SCIF{A|B},
>     I2C, USB 2.0 and 3.0 hosts, USB-DMAC, HSUSB, RWDT, Audio, CAN, IRQC,
>     thermal, CMT, VIN, VSP, IPMMU, PMU, TPU, QSPI MSIOF, and PCIE
>   - iWave G20D-Q7 board
>     - Initial support
>     - Enable eMMC, SDHI and SPIO NOR support
>   - Add camera daughterboard
> 
> * RZ/G1M (r8a7743) SoC
>   - Remove legacy "renesas,rcar-thermal" compatibility

Merged, thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
