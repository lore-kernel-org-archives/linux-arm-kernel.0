Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5915EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:39:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1939721773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eXWEGszx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1939721773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mj2ifBD5GIl3CCQHwF2Y58Rih7QnrikerOa8dbpHgZ0=; b=eXWEGszxRt9U4z
	da1r/eVfXuOPCLUXzl0QLvqqwkZ0KRIBsEf8cyF6vpZhJ4rB37qbBKOIAJoaEpJ8mSxyrJUE6p4Q9
	TVVrqu30b96312PzWNf7DHFrkMwJ25L8Io1cWjqkALCwOO1SnTtBdDaBjkPTA+TKVgFIKfznoxp9k
	AhL4Wi1PVZYAp9EyJhrOcYOtCxYmdRVlf5VgE/XU35vXdJCb6mycX3tG/jqJH6hRgOyjWpXKau1u6
	5x4JoFuko9vfhm/XfdcN2NSDs1mo0d/gyjQ6/rXjZMIrfTw9BuidHQtJDeSf4foGOWaS9NSyjhtxb
	PuBtHIc6jEIiVmMQ7BjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga1Lw-0000h1-K7; Thu, 20 Dec 2018 16:39:16 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga1Lt-0000fd-Ez
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 16:39:14 +0000
Received: by mail-qk1-f194.google.com with SMTP id a1so1363423qkc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 08:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kfij4cGpooSWl1dptilPzHNmiFKwszwCs4MFkdZ5+Vo=;
 b=FuDD3Ic2ZQy9A5bpuZVReqmstgoL/8SGVuqI1H3GJv3wFOtJOPT/F7a9MF9Sm2r66+
 ZGFzLjeI6m4VFILNmJW7M/R3LkS467+49T9JGQD3NMF+yYjYn0pnGTH6GlPzYDf7WNjZ
 MJdEiIRDFxby3+bf8Uw0aAl8LnXZ3Nkr0kI24aMgXWhUDqxiJ3M8+qwmpeV7U/jKRpQD
 VPKbb3PDhqo3U9BjZN3+R8T4Yz4XWEk4F0mg0qn/NuYAs2TFfz0OiOOKSfADYl/7e/CS
 gwEx/CUNAbQtYqdM//75LPl4LnmudZBoTV0zbhL+MlsOvA5RthlYnfYqVM/wLmyj/llF
 kzPw==
X-Gm-Message-State: AA+aEWZX1YPbggplaOvPCKwV0VpRGszJ4D5TXtq0dW4yVj6shgZVytEf
 jbb9NfDhZOM0lKTT41VRkYGzblAOFouO+dy2Lic=
X-Google-Smtp-Source: AFSGD/V0RoSWfj7BL1tjtax6HC9vUFcGlcxJ+IaHpAphpMOm69Lsp7NzhCI6hd51l3EjmMWvRuSXw7uC0wrtZhP45FA=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr24076383qkf.107.1545323942081; 
 Thu, 20 Dec 2018 08:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20181214115647.12391-1-horms+renesas@verge.net.au>
 <20181218094407.hfe7aei2hmnsih5u@verge.net.au>
In-Reply-To: <20181218094407.hfe7aei2hmnsih5u@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 17:38:45 +0100
Message-ID: <CAK8P3a36OO+qM6r0BnrjWEWU6SV4SXu63Y=3Pq0FNt=56mzJXg@mail.gmail.com>
Subject: Re: [GIT PULL v2 0/3] Renesas ARM64 Based SoC Defconfig Updates for
 v4.21
To: Simon Horman <horms@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_083913_494568_50C9E00E 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> > ----------------------------------------------------------------
> > Renesas ARM64 Based SoC Defconfig Updates for v4.21 (v2)
> >
> > * Enable in arm64 defconfig:
> >   - Renesas R-Car Gen3 PCIe PHY driver
> >   - Renesas R-Car thermal driver
> >   - ASoC simple SCU sound card support
>
> It seems that Morimoto-san has determined that the sound card patch is not
> necessary. Rather than move to v3 for these not entirely critical changes I
> would prefer to withdraw this pull request and revisit these changes for
> v4.22 although if you do happen to pull this then I don't think any harm
> would be done.
>
> I apologise for any inconvenience this may cause.

No worries, I just dropped the pull request from my todo list for 4.21 now.

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
