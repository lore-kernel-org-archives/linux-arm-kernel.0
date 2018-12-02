Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870ABC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:57:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553C920834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I6qRr0iZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfkQO8X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553C920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AoA4Q+1LxcT9ItKRVYuVi8CiW/xHvIAH7qwhks2lx0s=; b=I6qRr0iZrfNiAX
	BNcp0h4bi/+qj5Q78fcK4U7GN9cst+XN3CpdwRoBTfe4olAY0eAdQLW9SdW9VYay316X/PLvaWN/g
	TIvQVqnlPih4rzpoFsz5ruVwAYKdF+dYALhJ4WD42OFCuXIxgul5sg/0S5Qcnwgv3TsaeidV4dmnL
	9BjEvRcXFMp6HDuVv1EWTNSYH1yi2L5LvXMJZplum/KxpWP7qZQmOcFYiVxQ1o+Z8HpPZayiJkqQj
	X9+yxvpEKgJpczgrWbShG3Vbu96HU3bfEIc/y5XQVKLCtrXrHbe8bpgJz/py+1Xs+mdUa7vTappn2
	Tikty0NbRHyiKcBiKcqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTXrg-00087u-6M; Sun, 02 Dec 2018 19:57:16 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTXrc-000871-Bv; Sun, 02 Dec 2018 19:57:13 +0000
Received: by mail-ed1-x542.google.com with SMTP id o10so8927895edt.13;
 Sun, 02 Dec 2018 11:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8MHVvAsabTkcIa8zDnpkWJMj8BIxD4hQPN/IhFTJqRU=;
 b=YfkQO8X/Cm4NcJbjwZsWCpSu0zzeKT5H8Xbb49efK5AOH0GlXizkOMHNY3/HIPECpv
 FWztMPTRop7AiMoQBjEsMVFXbul6Y1YMFt4zU8DZsSavG+mk+WgxcqFlq9uauJdoql8y
 bO0GmLADRB+9vOGfMgNNkkZ4yohq+fQhhVv54kaGj5xXkZM3Md49bK+uGs6QaLUMCNMQ
 5x7sFbbJ8yGLe04e2iZiKkVXE4UZFkOI4Pgv7dXxOF0i3MVuTvP+ra8e7LF37VTa3LHi
 4iPWGa+FWUZFbTkfSRpUNnm9UX9l3mj3C53Od+FM8tuWaYQ57o3r5924xkhWycI0nMl2
 FDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8MHVvAsabTkcIa8zDnpkWJMj8BIxD4hQPN/IhFTJqRU=;
 b=HyP71TPG7M/3mdEZ5tbuBrZTWmxQ5+kmU41ZBnaR7fVP7XHpuhLPCtUO2afMV9Qbo/
 EQI7dSXgg4rvCSgUmn+STHcDIrTMQJRfevhgeYLAarxBTooV684dRr3BaBTu2DLfpQgp
 1oQCPzPzroV8E8gcfD8btJ/snkteYvhnOk7oMD/n9EMgEqg+Wak73K79hqIaw1BsVScT
 TlSRgt8S1c/qB4k/bwzl4WZSWZ0GD623wynEZD3e/kuXZpTxnf8CLSfwRx6wx1rqdhEU
 cQoOeTAvP/BjKCNTKXLs8yEwcnGMBEPY5A1VrL0HAdyyCXcVwHQrt/t29kFWDKkCZA/v
 y6dg==
X-Gm-Message-State: AA+aEWZi49503LjU769PNZq9eypSw8zsFAplWUoRornSlPN3tWBb/euJ
 kVcZI4v54Vp3OMpRB4LDL2ZtKe5y2MI=
X-Google-Smtp-Source: AFSGD/Xk3zO4cFOL+UMoD8HYvjYL1HWA655WKsUxexTN/DgjkMNrcC8yMyjDdNpsgeMx8rkKQeCogQ==
X-Received: by 2002:aa7:c5d0:: with SMTP id h16mr12516928eds.107.1543780620816; 
 Sun, 02 Dec 2018 11:57:00 -0800 (PST)
Received: from ziggy.stardust ([93.176.147.153])
 by smtp.gmail.com with ESMTPSA id e26-v6sm1854302ejb.29.2018.12.02.11.56.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 11:57:00 -0800 (PST)
Subject: Re: [GIT PULL] arm: mediatek: DT fixes for v4.20
From: Matthias Brugger <matthias.bgg@gmail.com>
To: arm-soc <arm@kernel.org>
References: <d131fdd3-663c-9a5b-4296-94f2635f8c41@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <5e3371a7-e4a3-49cc-b517-20902a5e2ed4@gmail.com>
Date: Sun, 2 Dec 2018 20:56:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <d131fdd3-663c-9a5b-4296-94f2635f8c41@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_115712_435899_4844F2EC 
X-CRM114-Status: GOOD (  20.49  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

On 26/11/2018 11:34, Matthias Brugger wrote:
> Hi Olof,
> Hi Arnd,
> 
> There two issues with the mt7622 based boards in the current v4.20-rc cycle.
> Could you please pull the following fixes for the issues.
> 
> Thanks,
> Matthias

I just saw, that this is not part of armsoc-fixes [1]
Does it fall through the cracks or are there any comments?

Regards,
Matthias


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=armsoc-fixes


> ----
> 
> The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:
> 
>   Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
> tags/v4.19-next-fixes
> 
> for you to fetch changes up to ce68cc6fad893eb33b69ef7ec186233a51696236:
> 
>   arm64: dts: mt7622: Drop the general purpose timer node (2018-11-26 11:19:19
> +0100)
> 
> ----------------------------------------------------------------
> DT mt7622:
> - kernelci awaits a working stdout-path.
>   Fix the path for reference board and bananapi-r64
> - general propouse timer has issues with clocks that didn't
>   get probed early. Delete the DT node as the timer isn't
>   need, a ARM arch timer exists on the system.
> 
> ----------------------------------------------------------------
> Ryder Lee (3):
>       arm64: dts: mt7622: fix no more console output on rfb1
>       arm64: dts: mt7622: fix no more console output on BPI-R64 board
>       arm64: dts: mt7622: Drop the general purpose timer node
> 
>  arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts |  7 ++++++-
>  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             |  7 ++++++-
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi                 | 10 ----------
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
