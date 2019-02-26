Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E95C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:32:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004882186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WBx1+Gdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004882186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AwZ1JoTEBDY6gZJCJvXK3TNX2uIylMjg1NGVm6lfF08=; b=WBx1+GdmP1EHXH
	ErEOq5PXnZbFPPTG0usgBt/9/APBqwiz6Law1ut3AtOkb6KurdFd9TEkAbbjOGEKRYMo2o4Itjo1t
	7yrTpezErkwkBv36t4eGkUzeRg7MjBfEZAKDnH7zQAA8GVVXHaDHD31VUckn7iFehvNOg9ADsYsK7
	7+ZOxPLIxdoJret9La847G8+ykhD0OMIPE0ExFo8goSC6dgK2uTIZ4kZDWh1IXlU0BprDUTrvhqEp
	gO/Hhhz6rpG82nPy7L4CNch2vxeUFYIoTSsxwJhsjXFcw3rvPh+HCQpaQvaQYfE45AaZG+HZRQGPS
	iGEzAF6UAPT/tRqH7VaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gylHS-0003Vv-Vc; Tue, 26 Feb 2019 22:32:54 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gylHI-0003Kk-DN; Tue, 26 Feb 2019 22:32:46 +0000
Received: by mail-oi1-f193.google.com with SMTP id b4so11797739oif.6;
 Tue, 26 Feb 2019 14:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vJKRJ/fSxcePULZfYSakgORctZ3ryZ3sejfiVGWNW1I=;
 b=ek60SD7tzUvwaisvw6rBNVTldhzmEgXd43WKMJ6VhJEjNiobTQ8z0EJ0WGDAcuhkpp
 mhRA6dsqVt+T9F8GlFnjt4DxuqmLWzT5MXnJSabvpfvfe9AnBLEn0MgRm7+ndESm5hi2
 gtHrTnYQ8TqntzmlAHIZAXvaJP2a3b7nRFJuK1J+oaAdrifJxdOCGWmOVWD5vnK2wPf1
 x7PH1hkR4z/eLL1AtxuOKUctWSZTZP9zstTD/61QZdpP2WqMWl/lD4snhRdyZ8Qaoqia
 A799FuYwS6OIUiIJQ2Z/SLNiTjGiLrzMsSLDXJcs1fMOTCIYgc9piZf4KtElZJpctjC2
 4beg==
X-Gm-Message-State: AHQUAuaai5uhB3uu2o2TE2JMshtYOS2pOuyss/AX9OzF4ZFWbU2TzfFH
 sktQDDHkjuLBpi5v4ufPHQ==
X-Google-Smtp-Source: AHgI3IacdPmyUtJwePB72wRcyWJRTdl1X7hbyiYt2Od7LhkXzfq4iqKwHT6vEfgj3kNcKjCxRWeTjw==
X-Received: by 2002:aca:ecd5:: with SMTP id k204mr3618991oih.153.1551220363613; 
 Tue, 26 Feb 2019 14:32:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id v62sm6087785oie.21.2019.02.26.14.32.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 14:32:43 -0800 (PST)
Date: Tue, 26 Feb 2019 16:32:41 -0600
From: Rob Herring <robh@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: net: btusb: add QCA6174A IDs
Message-ID: <20190226223241.GA2365@bogus>
References: <20190222225345.69084-1-briannorris@chromium.org>
 <20190222225345.69084-2-briannorris@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222225345.69084-2-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_143244_466209_89A29526 
X-CRM114-Status: GOOD (  11.28  )
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
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Brian Norris <briannorris@chromium.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Rajat Jain <rajatja@google.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 22 Feb 2019 14:53:44 -0800, Brian Norris wrote:
> There are two USB PID/VID variations I've seen for this chip, and I want
> to utilize the 'interrupts' property defined here already.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> v2:
>  * drop leading zeroes from VID
> ---
>  Documentation/devicetree/bindings/net/btusb.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
