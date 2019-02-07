Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D25C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:41:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDB6218FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NWlUUZ9g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVeQbB5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDB6218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kf45HGzc+w1M5YyWlVht/sy6YUAUCER5ywgCpEPZRRw=; b=NWlUUZ9gHF7E95
	frodFL5Y5IRza8x83WJGXnvZ4mSkI4BWdIQvyxAEu9SLgKX7t+JkX6AMHPX85dGY/xTglHMiehPr6
	SEHwN/1m96lbAh7xzDYKts7B6XOEQGE4n5oxkTBSGzuehaThQnZ7k96lxHUBKLjqPBdKYRNeEZ2GT
	AxEDOrSEgHz5YEBwILGXK0zTMCrUQh7qqDtCstmUdPTwhVnQpIkbhaI76Wvh5VCbMGWnpZwxRK7i8
	vDHAHEur2XF3IEaLt/qATD1c2KuTMi4vZy4n/h1ZL+AM7FBDIoyzLAjk18mlBC/HkzrnLCDaxgwoK
	alRjJ9nKmf+x8+mPDtoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grdNL-00048h-SW; Thu, 07 Feb 2019 06:41:31 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grdNJ-00048B-4g; Thu, 07 Feb 2019 06:41:30 +0000
Received: by mail-ot1-x342.google.com with SMTP id a11so16447992otr.10;
 Wed, 06 Feb 2019 22:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rKdpQD+eseLw1OpR71Xm+Hl91hjsoSlvdf0ELn0fVW0=;
 b=EVeQbB5qVDqzjG3ZiycVk8V9WSUnCgvo6jyXDA+3vuaKiXhvlJAcCTmmnQ+Ub/cMkr
 shxgh9zAJtC/Q7kzRef8/m/iPfnfNfwLgxxUhb+UIGXV8a4TsEPMvC0r4ecosM+k2Kbn
 LZiihKfAcKR5z5xBFzC+UscWsYjQyEOePt5THr1UVv1QZO46G+apqLNNLVJ2oPkoXNbw
 pzbQTR86VtAFhXq60b18dPC1pl/dsqPLmcAF42/cJWv7vgiWLgNQzQVw56QvVfhfG3wE
 pnqK3d4gkOdgdbFALfzNpBgIAySUUwUMD4y1Epy9s23PbQKtc/sAvhQzS0je189TKDP0
 sA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rKdpQD+eseLw1OpR71Xm+Hl91hjsoSlvdf0ELn0fVW0=;
 b=r7FseXHoIH3qaBqknS+3tlm2la+0fXFkjmKjQk0hpepPCD+GBgvzIvErNbStadeJVJ
 QTKydKUMEJORGv1BfPgBY7gPR4KdwmVRmigDAhPz0fBw81KPvtgucRBo1/ihtB0g4YSn
 hjBpr4AoqRaK6BbEzppiUKBQHVyQTzvQtdeJ/+eCGBE921JagoUl9d/AllLNfn0jq/fY
 JoxGI57ZYuci/Sr1VpVpXGG8DVN87BDpsoDg0g8RHIyKHBLHXdJ0nNXdgznsacnutyqb
 6fTAjXo8hW0ktgFS4DhzLz5RyE6nlX7MHrL2HnawsMDMZ6o5lQm//QXkVRpGi2eyYWBN
 1trg==
X-Gm-Message-State: AHQUAuasVIFzoStRxEM7pqJOP33IlGTrYTvBGJVmPkUdyX5S9f3FECiT
 pEm24O2bpaUdV/49xdWxneS1yzCGZiUp4nrkEiM=
X-Google-Smtp-Source: AHgI3IYpvnwgDJTsW3VddP1CLyA7SuJr9dnx+sdW3mdDJh1vKZc2bhv+rIYU/Qcazj33Z1DB38Y2rKG7PoSTChjVL2M=
X-Received: by 2002:a54:4113:: with SMTP id l19mr1778228oic.142.1549521687824; 
 Wed, 06 Feb 2019 22:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-2-linux.amoon@gmail.com>
 <CAFBinCCOQ_GqHZuYf6n8ba_ZMbOwKmUzc4EJAuXRpn4tTTCUKA@mail.gmail.com>
 <CANAwSgSQH2zta+tOcqnM3JPZ45XkqWEJAWOL3Do0Mnrbam8VSw@mail.gmail.com>
 <CAFBinCD_O7FEX5iLyo2BzqE1KcrmATaZMMq5pFr-Q7wnRBPziw@mail.gmail.com>
 <CANAwSgSh--pom9kmVBWejHwVHJNv2o4Ta93wabR3Ak=f3V4JbQ@mail.gmail.com>
 <CAFBinCAhjo4ueh6UDE+TKiF8Vc2Pz2JsjzcVsrsPQMU=ZEiLwQ@mail.gmail.com>
In-Reply-To: <CAFBinCAhjo4ueh6UDE+TKiF8Vc2Pz2JsjzcVsrsPQMU=ZEiLwQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 7 Feb 2019 12:11:15 +0530
Message-ID: <CANAwSgRVypZ2CyendeOGJ9MZ6X951EwPW3x8K=0mru_Pj1qMLg@mail.gmail.com>
Subject: Re: [RFCv1 1/3] phy: meson8b-usb2: Enable otg phy controller on
 Meson8b SoCs
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_224129_183506_CC1A1259 
X-CRM114-Status: GOOD (  19.78  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin,

On Wed, 6 Feb 2019 at 17:18, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Tue, Feb 5, 2019 at 8:52 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > personally I would start with getting device / peripheral mode working for usb0.
> > > if you're lucky the PHY driver will work without any changes and you
> > > only need to set the correct dr_mode along with the g-* properties.
> > >
> >
> > Yes that should be the goal on getting working usb0 phy and otg port.
> > So for now we will drop this patch and disable the usb_phy0 mode in
> > dts for Odroid c2
> > in order to get ride of the power failed WARNING.
> I checked Kevin's Odroid-C2 (GXBB) on Kernel CI and I can't see any
> power failed warning: [0]
>
> > When we get the usb0 node to work again with good phy configuration and
> > tuning we can re-enable the nodes. I will try to look into this in the future.
> >
> > Can you share your thought on this.
> sounds good to me! especially because it would give us OTG support on
> Meson8, Meson8b, Meson8m2 and GXBB (because these SoCs are sharing the
> same USB implementation)!
>
> I see four challenges:
> 1. getting host mode working on the micro USB port. you have already
> proven that you can do this :)
> 2. getting peripheral mode working on the micro USB port. my hope is
> that it's only about setting the right dr_mode and the g-* properties
> on the usb0 node (but I haven't tried this)
> 3. make OTG detection work and integrate it with dwc2. I would consult
> the dwc2 maintainers to see what can be done
> 4. bring everything together, making sure that one feature doesn't break another
>

Thanks for the feedback!
I will give this a try, In case I am stuck I will ask to you help.

>
> Regards
> Martin
>
>
> [0] https://storage.kernelci.org/next/master/next-20190130/arm64/defconfig/lab-baylibre-seattle/boot-meson-gxbb-odroidc2.html

Not a issue If I could reproduce my  kernel warning consistently again
I will share the boot log and the step I followed.
I will be dropping my patch for the initialization of usb0_phy untill
correct solution is-found.

Best Regards
-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
