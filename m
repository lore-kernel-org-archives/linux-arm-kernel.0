Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63D5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:11:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E552075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bYRZUtP8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bltQQJBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E552075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k8gDWN9If1qFLm/XkpO2vzuaHgNa0qaj54/84Y3sU50=; b=bYRZUtP8eZdTUm
	+LHRooJh6XR3JPf6mcRAfsrx6OioM6bTJ4B40NxFqyxQagdSt/ZwAmGPpGAbEH5MnJzc8CBS5ULU4
	leGwswrN1TosA5t7g0yzC7CBHUYS2eGWSvfEL4Sh0JvCiQ1v85JqtO0g3psrsWaHDNqQfTpEd64rq
	5yH7kOix8cJNqEPOLp/6R9uLoN2CsqncXPAHEoyasc6XqtMWnHPIJMc1FZQ8AtpJJc7/PhV/LTONi
	jTCl4zpsqHXN0gP5w6RtDEOCo9IvqE8zwNWuJGbwwMd9udBkoYjCvMLtRcp8dgKtDJfqcU1Fwl80Z
	m+OLC7ga2TwojtzutOYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxJ2M-0001VE-VP; Fri, 22 Feb 2019 22:11:18 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxJ2J-0001Ub-I2
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 22:11:16 +0000
Received: by mail-ed1-x544.google.com with SMTP id a16so3100228edn.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 14:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yuHwDkyo+FE+kx/nk3ypUawi0rYD4PuoS1hwu59DHRQ=;
 b=bltQQJBq77iVWZX8IQbvi4zj/TVzxkPp4uD+6beKh9il3NgC922hIXmrNvJ5nJKX+R
 xux+2kSNS3JZM/F762m4oOQhE6QbqSF7CJMR8o2Vra8pC207nD+20jVqx5KocXNGKAg6
 qrpKUWtRWWVJPdDCI1voshOEkZ2Pje8Qo+Yq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yuHwDkyo+FE+kx/nk3ypUawi0rYD4PuoS1hwu59DHRQ=;
 b=hLoifjXXbT4HXIk4+7qLN/DTXbC0yj70PsDzMzddO6MTZ58n4bnUeLY5r/NOBL3poZ
 zvqRtAVx3j0McTqDPuuCEK2MjWtYA0oZRPyGnxrKTmRaQ10NEOhi3AbL8BnfGirTLjW2
 5mLjrBOraSdOE4kWe+SFRDgcEkXBTw4lAixkBYeH1bNgDz9R12mMCG9R6SzmdvUagWNy
 hBVXrCk87cSponuNpeblwjvE0rRXQflB0E9HCcoQ2GneOLspF+602j7RZtDK0gHh0OwF
 HTmXOcJFRyEt4O9mDTQ8k9cpA1zhMPhN66Qb+30dxQu2uRySAv8ZQy8ODrsQBOl9MtuW
 wIBg==
X-Gm-Message-State: AHQUAuai2zmZO7WZgy15Rr/UKpQ+74MaXPDsgs6z8VJUbziCtHsKmK1/
 r2/ZByXA6/l3g0PeMGm3kb8qZPQ+iv0=
X-Google-Smtp-Source: AHgI3IahxRCpfrwAadrRWGSyhLdcPo/S8HVhAXL8+T/9ze0FTOPSNAOx8oYwMWarUwbaMb919ArOMw==
X-Received: by 2002:a17:906:3fd1:: with SMTP id
 k17mr208623ejj.87.1550873471807; 
 Fri, 22 Feb 2019 14:11:11 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44])
 by smtp.gmail.com with ESMTPSA id v4sm465117ejj.4.2019.02.22.14.11.10
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 14:11:10 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id x7so3057409eds.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 14:11:10 -0800 (PST)
X-Received: by 2002:a05:6402:164a:: with SMTP id
 s10mr4911135edx.6.1550873469625; 
 Fri, 22 Feb 2019 14:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20190222003403.128243-1-briannorris@chromium.org>
 <20190222003403.128243-2-briannorris@chromium.org>
 <5efc9f02-eeb8-78cc-0f11-13e0010efd46@arm.com>
In-Reply-To: <5efc9f02-eeb8-78cc-0f11-13e0010efd46@arm.com>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 22 Feb 2019 14:10:57 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOFTYmXHw6DD6f3P-0DfyKGZUt9MANEYZXfBBkiXqikYQ@mail.gmail.com>
Message-ID: <CA+ASDXOFTYmXHw6DD6f3P-0DfyKGZUt9MANEYZXfBBkiXqikYQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: net: btusb: add QCA6174A IDs
To: Robin Murphy <robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_141115_623129_CB532211 
X-CRM114-Status: UNSURE (   9.65  )
X-CRM114-Notice: Please train this message.
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
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Douglas Anderson <dianders@chromium.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Rajat Jain <rajatja@google.com>, Matthias Kaehlcke <mka@chromium.org>,
 linux-arm-kernel@lists.infradead.org, Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 1:57 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2019-02-22 12:34 am, Brian Norris wrote:
> > +               "usb0cf3,e300" (Qualcomm QCA6174A)
> > +               "usb04ca,301a" (Qualcomm QCA6174A (Lite-On))
>
> Nit: the USB device binding states that those leading zeroes in the VIDs
> should be suppressed.

Ah, thanks. Didn't notice that part. I'll remove the zeroes and resend.

Brian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
