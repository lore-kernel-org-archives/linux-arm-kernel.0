Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA56C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:51:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5E02192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O+tTXUiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5E02192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uc5pogSE35K/+RMJNC07Vxd64pYHroaZA1WA/IsdAus=; b=O+tTXUiDiYucII
	YkV29xaZkrVrDoXkxvf7tQfoyPfcIlW6TLwJjcOHI8Pevbz1+7UzcqYXBnJdCa7oP7cB/tMk1MD8k
	CHUaMTsHVTVohlXWbCpoq9fczdoqO0PNSk/RFFd8+VcwWlWxDSF3M6YjTH8sy8OHqqjTj6n7USBkM
	bKGduu6iKNayow5GDs4n/TemHvuDfn4Osv59eh5hFZany8WOsw3MvpOX1saD6wKwT/1zQiGabjJpn
	rn9BuiT8rL+oV1Y7bYINFkv7Ir0iNV2MmcLc9WN+yK6dNxJB+MVeb2tdOEWs3ZkNDWvoYlKr3vYoN
	5ALhhfB3NLeJTSJ2IHEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gudts-0005Vt-5U; Fri, 15 Feb 2019 13:51:32 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudto-0005VU-PW
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:51:30 +0000
Received: by mail-qt1-f194.google.com with SMTP id p48so10910620qtk.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GXJ4TdfrfPZpEboVGed4F2HLewgeWz70eZjaGGK0Fi8=;
 b=DR5rT5YjpQI/rESUWtIvjsrzAnM09jo6qDWkBvzTiLfaFiGtrFFzV/8wWXR/tgBX+L
 3ojEn/QXRCbkJiFCk4P/bj094m5GU5ji4bPCTeTxHgNTDoMBIpNNLNxqDpYYeyGm+oCG
 UZKz4/9HaWti0X9xYWGSsAw1V6X7jja29GpS/0RzT04lJ7v2H+BIHmznHCAvbDozwlxE
 WyNWwZfIRsuTlU7Xu4CyQIkCrFR1EhsuT3oD6uRqScPwWXjNEX0Gr9haDES/RZJeDmWg
 EZPAmEmnElBsr+kIt5WT//o407TcQ8ShUYlYV8+xof+OnBiDHnZU9dLx1QpTum3UbmLk
 5ZJQ==
X-Gm-Message-State: AHQUAubEpnkg8UkfMw7KZK8LNG6CWTCoEBUoEMNxtixydxF9OQTlv3RI
 ZT69w9oeZK4n285tlugJkfNr7SzuREE9PBDnEf0=
X-Google-Smtp-Source: AHgI3Ibys0942rHRfxI/N8bmkElKnUgmeop0wL6o7fI/jPuGBjUheepjmn1z7UxwspX1e63MGT+EN8eddgMbsr9d6jw=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr7692244qta.152.1550238687949; 
 Fri, 15 Feb 2019 05:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20190202172237.11147-1-f.fainelli@gmail.com>
 <20190202172237.11147-2-f.fainelli@gmail.com>
In-Reply-To: <20190202172237.11147-2-f.fainelli@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 14:51:11 +0100
Message-ID: <CAK8P3a20psYKk3bD-OB-_eJvb14iyoRRVk8Fr1RcAd=8pYiYAA@mail.gmail.com>
Subject: Re: [GIT PULL 2/4] Broadcom devicetree changes for 5.1
To: Florian Fainelli <f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_055128_823026_75A3E00B 
X-CRM114-Status: GOOD (  13.96  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh@kernel.org>,
 Hao Dong <halbertdong@gmail.com>, Dan Haab <riproute@gmail.com>,
 Olof Johansson <olof@lixom.net>, Eric Anholt <eric@anholt.net>,
 arm-soc <arm@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Dan Haab <dan.haab@luxul.com>, Kevin Hilman <khilman@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 2, 2019 at 6:22 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-5.1/devicetree
>
> for you to fetch changes up to 0a37cac509063da4696937482ab0d4e960ba358d:
>
>   Merge tag 'tags/bcm2835-dt-next-2019-02-01' into devicetree/next (2019-02-01 11:25:26 -0800)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs Device Tree updates
> for 5.1, please pull the following:
>
> - Dan relicenses the Luxul DTS files to GPL 2.0+/MIT
>
> - Hao adds support for the Phicomm K3 which is a BCM4709 SoC with dual
>   BCM4366 radio
>
> - Stefan adds support for the Raspberry Pi A+: binding and DTS files. He
>   also provides a bunch of DTC warning fixes for the different RPi DTS(i)
>   files and adds support for missing GPIO lines on RPi 2/3
>

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
