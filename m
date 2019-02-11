Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,SUBJ_ALL_CAPS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2966C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:57:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7022070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a8QtA/Aj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="piw8nFlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7022070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h00kMnwRtGD5ziqz4+XnBzdHZoFih6rwWHWykVOUWh0=; b=a8QtA/AjY4CSJa
	BYLMeDBlW/1qZYgf2V4qgX6yIxVf2Dv/3XWCdGk4lu44JH3aS0CYu9RDRdn5j+ApAgCS+EEtLG1GN
	qaIqZ0s0UKbSTgdJiFdC1Ovhad6XTO7WqR4R4PO9lT3VEQlwATVLN7IRCXU+PlzrutzaTvTHJLnW3
	v3ZSjQi7wh7BU79XBktPmkV1PjzhGMiie+oDibprzfJFbw6krS/nEkwokWWJrzDE4U/nFuwOUtUm6
	5V3HGsIG9cjTHXt0XcGfUwxO1L8VphW4X1/6BLWsekpeNzEsXsVf+1GtcIcDLGsT/6zHh1GsskNC8
	8pq4/91lrQoWACypqtXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtIdZ-0005NR-Au; Mon, 11 Feb 2019 20:57:09 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtIdW-0005Mc-3l
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 20:57:07 +0000
Received: by mail-ot1-x343.google.com with SMTP id k98so611081otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 12:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kpgZXQKUHGxbIqJILVvS63njtr5/ciRcnd20wCqjbUg=;
 b=piw8nFlrZq2/0EygH/i/aL177NZWDlM2kAxPT77aHxg6kopuR0q1m8hPl6bBSPfyU6
 8/3iDav+rZFA7hcLygGYFcrzhcfRMY3Tx/CfbIjCSdl0MC5rtCfzKPOE/rhsup9YW2RU
 Dbd217sFxwWI5Glxt4soH/79WkLIDKdkf6tM54ChvnZGprmri4VRySz2nBEm+iOibw42
 HzB1TzhlUisS2Zz5/AgmTM27v8ESKSt05Idxcc4W+zvGO4dZbk1DhkuGRcG9KVGd0gkN
 /Si+ekxnQS/HZ65nAYXHp5voH+9VXEbxvdYdaf7/lOka8FyCZuHKkdTELo0ql8FI+7m1
 k5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kpgZXQKUHGxbIqJILVvS63njtr5/ciRcnd20wCqjbUg=;
 b=oMHQ1bgJjhLE9xMULKH91V19RSpfRXnSe5CFjr6nOUmoIHIdQqiVrec9OeN77Qm3eH
 MYdbPj5gfao6mgKVExZTIRimvcEQCG9aMt+OiO8GGW9ZCHz1ryuYe9nhR3t0xnw8EEe3
 US+nF2AIQRWOhN/ihV4OOYIwDZqjQGHsbh4y1p6dbvBVVN13oALSG6ORzAuwErHttTON
 OawrMr1tsBhx+No0sMus8RzFG1v+zSYDlBbuqvar0WxyLfvpUswdPcVtAr+ay1OvzIfG
 w7iQuHaLr93yOg69i8xOXsZgnKzlhJLF+Mi3fHXNF9zLNSF8i/22g0ZlXtloNJ1KGV+W
 hLgA==
X-Gm-Message-State: AHQUAubMtcWhFwwk6a3teQnwxM2Msb28YvSYjJyymyeQNpnyg1HQPMcS
 xLctOkJNcJGjHrBJ0XZf8hE6euSB/4WaZn37ihSoBg==
X-Google-Smtp-Source: AHgI3IZaVpn+kmWSPjdH6sYpW26By63gEVIl+kx9+pbwY+wVpVNAisTLT2mml7wE4O3As9h8nsYcnNu3XNf1F8olhTc=
X-Received: by 2002:a05:6830:1658:: with SMTP id
 h24mr119347otr.301.1549918624943; 
 Mon, 11 Feb 2019 12:57:04 -0800 (PST)
MIME-Version: 1.0
References: <7himxqdpad.fsf@baylibre.com>
In-Reply-To: <7himxqdpad.fsf@baylibre.com>
From: Kevin Hilman <khilman@baylibre.com>
Date: Mon, 11 Feb 2019 12:56:53 -0800
Message-ID: <CAOi56cUzSyKVwLoEZWba67k9VpQ19Li9dd5c85KOogqOiDQfKg@mail.gmail.com>
Subject: Re: [GIT PULL]
To: arm-soc <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_125706_161466_26B6BB4F 
X-CRM114-Status: GOOD (  10.52  )
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
Cc: linux-amlogic <linux-amlogic@lists.infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 12:48 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-soc
>
> for you to fetch changes up to b3077ffcfa24b05c05af3b990d97a392ef88b22e:
>
>   arm64: meson: enable g12a clock controller (2019-02-08 09:30:25 -0800)
>
> ----------------------------------------------------------------
> Amlogic SoC Kconfig updates for v5.1:
> - arm64: meson: enable g12a clock controller
> - drop unneeded COMMON_CLK_AMLOGIC

Please ignore, resent with proper subject line.

Sorry for the noise.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
