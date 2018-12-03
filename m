Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0D9C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:48:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BFA20666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fE/jD949";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ARpNzQsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BFA20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WzYaW/9yN95QctOuCTr3X554X4hfzjH4wLUIR/nllek=; b=fE/jD949UhoNsf
	MsNXEOEzMwwBG7wGCNZc/x3dcP09Upk4KxGPHMxYRtwk0OyzpYis5LvYL51OzC0EnqbLHChYZt+eh
	SBPhs+8+wEXHuZWmEupR5WMsGVEWh746ZgbjG90h9RzYLki6MsnwRZBliD+T+cx/wfykfafDMhYAs
	rCw8EyrZyuS/djeTb5kBTVZjEPxQUSF/IS/yYEjbRAnk3SlDw91CSULYVDrLhkxCKDUBXWl5a3vpe
	tSnesqBOh1DctC+Hga5eTpyeAUiqpkEnUKFd6koOeBII5kaqBmLzUow/2nNqbM9fxZp1kHBF/GLql
	6FrVUH/qsd7JK6Fk+WUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTv8q-0006Ie-Bg; Mon, 03 Dec 2018 20:48:32 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTv8m-0006GT-SU
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:48:30 +0000
Received: by mail-lf1-x141.google.com with SMTP id p86so10243698lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WeSbty5s2StJSZwdlxjqLIoLi6Ov8w7BzLw7TAwCPZA=;
 b=ARpNzQsYBw54I4Ym6PM+mOIQC8yrWpMeASjF4GLJR0r/Y1YXxLArgGTd4p7U4/0kIg
 p3qDN63Yll5rNVpQdraDMLu1Mh0XccZYzEvx2ezLFzFDAlExg6rOsBEhMoMh/2RDFC94
 35vI5pbPXDZmfLVYmlJ6uSbkcJ/898cKc4YwZTV4SmH6NQFNXib9CWLX0C+li505qCjd
 QU9xwVJv89/5f/85FS7WTJO/tV1wGPDiwCx9MUIeD8Raio0+77HcKlaAq8VolOQqWPrm
 Eeg0udyON/i+sNKYq4r4C6eegIJhioyejtO79dXk0gm0tGuTk2uvNUmW4K4Qx97KGS8B
 f6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WeSbty5s2StJSZwdlxjqLIoLi6Ov8w7BzLw7TAwCPZA=;
 b=U1DjESVttv8trsCj0f4PUzzimwN8CBQBchmIRS2fQ5Qa8Wk+K6k+u146NORTykw3Lp
 8mlKLPa+StGN9y1rjJNfAbFeYn5/TjrK/2BrKfs5+WL8A8d9ggbx2/V5a+UoV+O9P7IC
 8hAX0sJoIYvyGJHUfGWkGa/BQe1vjNzOIHGt9203La7nHJAbaKNIVozKij3D5Fr1WZFF
 /xKzunzxxCm13ich9wh9h+cMdf5Uj8/3qgtACF8SKf8ng6g3EZi5g2/AWULU1qFTjiSS
 5McKP5aIWHY+NGjBn2Cs1NErDOe2IpZnrqMvofkSAJS534PbZqN9nBo8rQkbqgAwH5vW
 ViTA==
X-Gm-Message-State: AA+aEWYWD5lShPKmeoWxbCvuIoBq43sORM890r8k34llQb1HO7gtnPh6
 aAmvWi1z5LCRs6VlN6/V3X4dfQ==
X-Google-Smtp-Source: AFSGD/Vaj8TzPH77M4UDok20WtK9JS6aIl+Ep88Ia9Kwkg9E7iWCwS8ZU7He4HhZMQDj1Bk8sleOsA==
X-Received: by 2002:a19:a28e:: with SMTP id l136mr10853292lfe.87.1543870096206; 
 Mon, 03 Dec 2018 12:48:16 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id 15-v6sm2933677lje.18.2018.12.03.12.48.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 12:48:15 -0800 (PST)
Date: Mon, 3 Dec 2018 12:37:10 -0800
From: Olof Johansson <olof@lixom.net>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mediatek: Update SoC entry
Message-ID: <20181203203710.aj4payon4aym7ipx@localhost>
References: <20181016145758.12995-1-matthias.bgg@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181016145758.12995-1-matthias.bgg@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_124828_944261_BB324BC7 
X-CRM114-Status: GOOD (  11.73  )
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
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, mchehab+samsung@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Oct 16, 2018 at 04:57:58PM +0200, Matthias Brugger wrote:
> Add IRC channel and URL of the wiki.
> Also add soc drivers folder and regex to catch more
> mediatek components.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to fixes. Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
