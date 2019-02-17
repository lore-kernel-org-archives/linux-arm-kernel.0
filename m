Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E32C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:33:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238CA2196F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pOWGVHPN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN2olmA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238CA2196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I7lVXouQqUssU7ArEaJ9RDc0aRiXsaQmyUIaZdwjiS8=; b=pOWGVHPN/H/e3e
	ujqf6vfrOouOCVaf2GCKIL0CwjCmZ2F0Pd/1QwXoGbu5PZ94pUgeBomwxjTr7Awyiq4lt6JpRXn8P
	ZAgZbGGNG+vq5G8Nsc7d+7AVgx5nGgZR51S+K00vR54poAp9BUUCJlOpqQ5RGsPduPptLFG6l6s6K
	iLB9YMWqNKogTGM3eJYwIlrdrb5CMo1mpeXHMYZZUViF9+NzLIR6R3jN96YCrLNrsO9xNbiCgmbVc
	PPH3xthWfcAye+UtIVZ26iJGTewkQfOy03aRLTysPFH4pyMSTiNxkO2XOk6cdyiYeC+lbmfRodQgO
	RvSGkB1+cDI16UHOrXWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvQJP-00075y-OU; Sun, 17 Feb 2019 17:33:07 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvQJL-000753-V5; Sun, 17 Feb 2019 17:33:05 +0000
Received: by mail-ot1-x342.google.com with SMTP id n8so24574306otl.6;
 Sun, 17 Feb 2019 09:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e1CQq+LFPBi/xzgTbhG/qJgIzOEHQ7dRGAjRRfKz+bo=;
 b=gN2olmA3F4zSCltCwlpIn1P5fYG0TD+T8JyNk2sk6fGTP/AQa4QggLvyf2ldOJ02NC
 8lcuNakLa3gcKvAp/HznldEc14TB9wRWYxZDWwhDPGzGnI1Xls5qSTrujJg1OxbDHujL
 lXc8Usr8FCWdTMGgS1+7QF+6DbLvGTbLxHX2D5zu1rskmEJEV88ilUiqWbOcrhjykkDO
 el+Aq4PwUbqwznvfBQDMCvknIJvnlwNpulv8PhhZjtJ3javNeM8szf5i4f3LEVer9fwW
 ThfsuFSFXasvq+q1rMck5YZmmjLbpRw8ppCTT531TnBCi1xV6DZ7VGvoGQbFh609XXvm
 twcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e1CQq+LFPBi/xzgTbhG/qJgIzOEHQ7dRGAjRRfKz+bo=;
 b=Ixj+A4+6Nhxd4mEqtnjNFIjQsD5ldhUsZX6hRfHHRVqA+0gVSFT0/wJ/L926nRqTVK
 JMMfKvUvAFMcuVBj+g+AMEZhgrLgubp+gRfRMeyE7bXsG3OiONplq9RcfAEWP8Q7je1H
 jQ/tRUOhoge3QZ8PG+45MFoKaF2anQBbFD2NUpTQbgqdj8lltm6tVoIh2T6F+4GtsMzK
 rt8QKheObJ8Cbpq3CCd05aIOSjrqY0piiYcolHmon7Iadsj7nFI4nsqYidqh2v1clJkm
 oFHLcDSmZpFxQHKIsD0CCm0pAoncNQO46S13+R0OspQHdj2HHUTGXpa5sTf/MbFjwqvz
 8oMQ==
X-Gm-Message-State: AHQUAubaXQQd0OkbiglJghewEVjn3azVZPYEnkhLEPmjfY0ZFMhxPW08
 IelliDrKJ/h/jsjIQq/ZTOKrI3vj2iT5iG+XSWQ=
X-Google-Smtp-Source: AHgI3IafGo+d6OfHZJx1kMHTRCxMBrzs2T9WB3HTKFSeBeimmo9IAkog3btrz9OhMsI9eerJFKpjKALXyx7LSFEv1cc=
X-Received: by 2002:a9d:5183:: with SMTP id y3mr11076365otg.5.1550424782779;
 Sun, 17 Feb 2019 09:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-3-beagleboard@davidjohnsummers.uk>
 <CAERgokmpHQb2czJdx++qFoogFRmkvXZm=4BNOsVuCz-ZvgTEaw@mail.gmail.com>
 <4ef63671-f58d-3b16-9055-09e69314a0e6@davidjohnsummers.uk>
In-Reply-To: <4ef63671-f58d-3b16-9055-09e69314a0e6@davidjohnsummers.uk>
From: Tony McKahan <tonymckahan@gmail.com>
Date: Sun, 17 Feb 2019 12:32:50 -0500
Message-ID: <CAERgokksSKkFJx5rK16KoAUAz4qCzYEAAN6YrWKVNOcu5CfUJA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
To: David Summers <beagleboard@davidjohnsummers.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_093304_026466_6321C501 
X-CRM114-Status: GOOD (  19.90  )
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
Cc: mark.rutland@arm.com, Stefan Wahren <stefan.wahren@i2se.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello David,

  I agree, of course coordination is not always so simple, I did not
know Arch didn't have this configured yet.  As for patching, I agree,
but the Tinker has some... peculiarities, I am a hardware guy,
software is a passtime, so my code is not always perhaps up to
standard.  And I wasn't 100% on submitting changes to the device tree
based on a staging driver.  Most of my work has been absorbed into
https://github.com/Miouyouyou/RockMyy .  As for your approach, as I
said, the wifi is the same as I have except for the reset/enables and
the DDR50, which I didn't know the rtl8723bs supported.  BT I have no
in-kernel support for other than enabling the RTS pin to the device
tree, I handle it in user space for now.  I've been watching the
hci_h5 conversation, I'll look into testing these changes/options
tonight perhaps once I make sure our rockchip-dev recipes are still
valid with the newest RC, and can have them committed so others can
test.

Thank you,
-Tony

On Sun, Feb 17, 2019 at 10:55 AM David Summers
<beagleboard@davidjohnsummers.uk> wrote:
>
> On 17/02/2019 14:32, Tony McKahan wrote:
> > A similar configuration has been in use on Armbian images since kernel
> > 4.14, but not in a clean enough format for submission. I will test
> > this, but the only differences I see compared to ours are combination
> > of the mystery "chip_h" power domain/reset with the Wifi one and the
> > inclusion of sd_uhs_ddr50.
> >
> > -Tony
> >
> > On Sun, Feb 17, 2019 at 7:16 AM David Summers
> > <beagleboard@davidjohnsummers.uk> wrote:
> >> This patch adds the wifi to the ASUS Tinker Board (S) machines.
> >>
> Tony, thanks for the interest in this and the Bluetooth RFC. To my mind
> it would be good if we could mainline an agreed solution. As much as
> anything doesn't make sense to me for Armbian and ArchLinux Arm to have
> independent solutions.
>
> In the ArchLinux Arm  camp I'm not a fan of applying many patches to
> support a board, as much as anything it makes that board non generic -
> and so has to have its own hand crafted kernel. This to me isn't a good
> solution, so if possible prefer the pain of getting it mainlined.
>
> Stefan Wahren has come up with a minimal patch to hci_h5 for bluetooth,
> that says the relevant properties can be read from the device tree. This
> means that acpi is no longer necessary. Thats currently out in testing.
>
> Anyway would be good if Arch and Armbian could merge our efforts ...
>
> Regards,
>
> David.
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
