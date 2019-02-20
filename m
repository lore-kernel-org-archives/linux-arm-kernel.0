Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50CDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:00:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9182021738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oLHt/pMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9182021738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZY2ZJ8D/W+GlKQzzjXbEuTunImy7qAQGWxb75nQXoQM=; b=oLHt/pMnldbpPj
	NmDfX3jJIIus73bd4m8T3JnFwCFc4mTGLA6P4k/FVlKC2gx7FbP2GBUKVrGvAJLcn5KFMaAACf/ey
	18GTugiDdKZ/N4JHRCPRul6uDcmyzE7mGnANxHBPuSuKLmKKHjdS6Lo/r6PAC5lSxdQZ03igzrexK
	z9s1znQ6ZvBAFhctA78mkDPnB0jOqpp6nm95UpOJTqcAdh9wee7LKUfUqNAVKmbRE9DmZfbWY6F8r
	YDlaEBYn5Zt8qk+WwOPyMz0J1U1Z3e4Kp5rF9g93fglNtpu40is1oWfH3Wd0lTEHFVvdqAxnIc0B6
	7eXC/ro5QopyJV+BBiKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwI7D-0003h7-QD; Wed, 20 Feb 2019 03:00:07 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwI79-0002vB-NH
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 03:00:05 +0000
Received: by mail-ed1-f65.google.com with SMTP id h58so18593313edb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 19:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kx6Mv5hmjbEtG9ehmh0BjC1fToEGSWVIZ3eqHBq3bns=;
 b=pERZqvpdNjiuRJaXvCWYORw5BCR0tSbqbw5mcRRxcv/W2sd1NqAbMjkdd/p929Mluc
 TBNZksuPZ9IECDQdWFPiNDC2d2cpJLQDO5uEp6pJXr40N54is9ROzYmpBHHCqUm1h9Kl
 WeMIsxjn1CzdAaNdOuurtcDPBrDmN+nESczCvEul8lEEeBl7TurGyDiYu44K4imMAsRY
 Q4WdVCLVyd1PGwBeD7Yv5tnEJH2F566ceeX/zR3akfrYb44AYeZnhzpYCPgRoFzFGlq4
 3qpYsXRjdOuI3bA/j56z/9QUGI50YzAwbffguW/hFanfrmV5JWllb3FlM2gjlCuHclhz
 XaHQ==
X-Gm-Message-State: AHQUAuaV7XCJTuGmhlELaVz+LfDo2vjyJQw/NT5zIO8aebbugmj3vwdJ
 C/vI0uA22kigBbjn75WszYOCqmd5nWE=
X-Google-Smtp-Source: AHgI3IYjfmVgRVgsvbtNsi2ghn31pK7w5x1tSRFcJ3w8SIXoSygzK1daVNTY3q0/LKMfOnw295WDqQ==
X-Received: by 2002:a05:6402:549:: with SMTP id
 i9mr11402267edx.13.1550631601166; 
 Tue, 19 Feb 2019 19:00:01 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com.
 [209.85.128.54])
 by smtp.gmail.com with ESMTPSA id l6sm4102652ejs.29.2019.02.19.18.59.59
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 19:00:00 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id a62so5005508wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 18:59:59 -0800 (PST)
X-Received: by 2002:a1c:4c08:: with SMTP id z8mr4337333wmf.99.1550631599174;
 Tue, 19 Feb 2019 18:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com>
 <20190218211035.GA28145@bogus>
 <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
 <1245842044.588056.1550527701604@email.ionos.de>
 <CA+E=qVdMNmVkytCzXqYgJtV196-G=c_bWx+aLvs=Y0iuRpjdRg@mail.gmail.com>
 <CAL_JsqLROpJMoEPLXaAL_JG1SNufstMDmB4xy_V_p4=duHKPSA@mail.gmail.com>
 <6a26ff97-0b9c-cfdd-9428-74580694220a@davidjohnsummers.uk>
In-Reply-To: <6a26ff97-0b9c-cfdd-9428-74580694220a@davidjohnsummers.uk>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 20 Feb 2019 10:59:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v65ZCaRcr1SJ=6pvviMAn7S0Nf3gEt8y9o8-ftXwXGc5hA@mail.gmail.com>
Message-ID: <CAGb2v65ZCaRcr1SJ=6pvviMAn7S0Nf3gEt8y9o8-ftXwXGc5hA@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To: David Summers <beagleboard@davidjohnsummers.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_190003_795993_362DA843 
X-CRM114-Status: GOOD (  24.92  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev <netdev@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>, Stefan Wahren <stefan.wahren@i2se.com>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 5:09 AM David Summers
<beagleboard@davidjohnsummers.uk> wrote:
>
> On 19/02/2019 14:17, Rob Herring wrote:
> > On Mon, Feb 18, 2019 at 4:28 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >> On Mon, Feb 18, 2019 at 2:08 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >>> Hi Vasily,
> >> Hi Stefan,
> >>
> >>>> Vasily Khoruzhick <anarsoul@gmail.com> hat am 18. Februar 2019 um 22:24 geschrieben:
> >>>>
> >>>>
> >>>> On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
> >>>>> On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> >>>>>> Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> >>>>>>
> >>>>>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> >>>>>> ---
> >>>>>>   .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> >>>>>>   1 file changed, 35 insertions(+)
> >>>>>>   create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..8357f242ae4c
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> >>>>>> @@ -0,0 +1,35 @@
> >>>>>> +RTL8723BS/RTL8723CS Bluetooth
> >>>>>> +---------------------
> >>>>>> +
> >>>>>> +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> >>>>>> +BT is connected over serial. It speaks H5 protocol with few extra commands
> >>>>>> +to upload firmware and change module speed.
> >>>>>> +
> >>>>>> +Required properties:
> >>>>>> +
> >>>>>> + - compatible: should be one of the following:
> >>>>>> +   * "realtek,rtl8723bs-bt"
> >>>>>> +   * "realtek,rtl8723cs-bt"
> >>>>>> +Optional properties:
> >>>>>> +
> >>>>>> + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> >>>>>> + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> >>>>>> + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> >>>>>> + - firmware-postfix: firmware postfix to be used for firmware config
> >>> sorry, i didn't noticed your great series before. David and i working at the same stuff but for the Asus Tinker Board.
> >>>
> >>> I created a similiar yet untested patch version for hci_h5 [1]. Maybe it's useful.
> >> Looks good to me, but you may need to add firmware-postfix.
> >>
> >>> Just a comment about the binding. It's really necessary to add the reset-gpio? Can't we use the enable-gpio with inverse polarity for this?
> >> Yes, we can use enable-gpio instead of reset-gpio on pine64 and pinebook.
> > Then why do we have both? Reset and enable are distinct. The inverse
> > of enable-gpios is typically powerdown-gpios, not reset-gpios.
> >
> > Rob
>
> Both data sheets that I know:
>
> http://cit.odessa.ua/media/pdf/Intel-Compute-Stick/FN-Link_F23BDSM25-W1.pdf
> http://files.pine64.org/doc/datasheet/pine64/RTL8723BS.pdf
>
> BT_RST_N BT Reset IN / BT_DIS# General Purpose I/O Pin
>
> So from the datasheet there is only one pin. And from its name it sounds
> like reset.

Yes there's only one pin. Would be nice if we could use "enable" though.
That is what ACPI uses.

> This said though the datasheets of these Realtek devices are a bit thin ....

These datasheets are for the integrated modules (the chip plus passive
components).
I don't think the datasheet for the chip itself is public.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
