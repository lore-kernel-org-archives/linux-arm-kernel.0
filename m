Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DB4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:49:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECB820656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l4WofujH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="puw5aOOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECB820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RnBmXFoK8WQ17eXgRCcLFdEb8hGs7VBaZBq78CC5HCw=; b=l4WofujHct4tj1
	qF2MGecX42TuY2JpDlliinT/j2YbI3F8YJcpFb/8ReAP8lZQv4nl5H3z+kc+oHyryXK5CmwXTNkkt
	XpnMTAw+b7JQibWF2t7ePd4PxRV5iFsCRZ9B4ZeLrikgzLgJ+v4qu/ZCK+o/YVAvEud2YlBsiTNwt
	XuXqhC9ziTxJY94tgynIjo6XUbwSN5x0GMSlVJ2Ovm3vH+j1frtSdE3WcIDWmXVrE8x+AjOFUgI9o
	seCmLsVnmlMLBUbmHpIbNoXVE8+Sx6yLAek4trBeJg7Tt3Ury1/GnlrmLg54NHCgPGPqeu+LBgEFk
	wF0b+26r9j+f+SIP6Nwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjUhs-00076F-56; Tue, 15 Jan 2019 19:49:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjUho-00075j-A6
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 19:49:02 +0000
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D80020656
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547581739;
 bh=Vivl4+etHMq6ONGfeZB3fGogNeSGnltwyq4snpVBwX4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=puw5aOOtESR+voHmQRFXnyJOyBOowJzacBpyi/UvykuMMRuv0CbfYsZgYYFQssd08
 vN7CIFFgXEWYKOqEqVplxxxPwPy4jscGm7heNlyR7VGCEwTzRnpFgA2NoitIP3Yq3T
 OnBjMaZWkGKQfZLOEvI71zRXVroJ8Ef6RKGrhLE8=
Received: by mail-qt1-f180.google.com with SMTP id t13so4433845qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 11:48:59 -0800 (PST)
X-Gm-Message-State: AJcUukdgdB8DI69L5h5+A+cqXsqyrEMsFDi8UPpi0WStPOSuKXUWQquD
 Zpd+FtajC3y6zAbaWpA7ASxjhaxvkdo8wM9r8A==
X-Google-Smtp-Source: ALg8bN5NJZ+SJLma0ZqFaA4ZE8EsvZq04XsNQmDf6jI/ppxlnMIMvVtvyBS/GGwWISkqAeOBdoL+SEJNXoBelAq5AE8=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr4312788qvi.90.1547581738597;
 Tue, 15 Jan 2019 11:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
 <20190111163420.GA20311@bogus>
 <1308b7df-9f09-c46e-e740-131bd1c42fef@davidjohnsummers.uk>
In-Reply-To: <1308b7df-9f09-c46e-e740-131bd1c42fef@davidjohnsummers.uk>
From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Jan 2019 13:48:46 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+vu+31_G2Vbe0nJsR4MTJAurjTYm3aEq_eWfg9p-BAMw@mail.gmail.com>
Message-ID: <CAL_Jsq+vu+31_G2Vbe0nJsR4MTJAurjTYm3aEq_eWfg9p-BAMw@mail.gmail.com>
Subject: Re: [PATCHv2] Description of the realtek bluetooth device tree hooks
To: David Summers <beagleboard@davidjohnsummers.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_114900_396143_1D5D4F1B 
X-CRM114-Status: GOOD (  39.14  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 9:01 AM David Summers
<beagleboard@davidjohnsummers.uk> wrote:
>
> Thanks Rob,
>
> I'll hopefully make those changes this weekend, and resubmit - just so
> next weekend can move onto the device tree.
>
> Oh yes, on the "-bluetooth" or "-bt"; as these devices have both and
> sdio input for wifi, and uart for bluetooth; I guess they will need to
> be listed twice in a device tree, both under uart and sdio. Now as both
> these parts of the device tree will want to specify the driver used, and
> the driver is different for bluetooth and for wifi - doesn't that mean
> we should specify compatible differently? Otherwise how will the kernel
> know which driver to load for wifi and which for bluetooth?
>
> So question is am I missing something here, and this could be simplified?

The compatibles don't really have to be different as the drivers will
only bind based on the bus interface. But keeping a '-bt' suffix is
fine.

>
> On the interrupts, GPIO control lines, power supplies, etc, on the ASUS
> code that I'm basing the patches on (for Tinker Board S) - these bits
> are freestanding in the device tree, and mainly go in with the wifi
> patch (and not bluetooth). I'll put some though into how this is best
> arranged when going mainline. I think if I'm honest, if I wait to get
> all these extras in the documentation, this will only get settled when I
> get the wifi into the device tree - as problem is more natural there.
> This though would delay the bluetooth patch probably a month. I'd prefer
> to get something out there - even if I have to return later to tidy the
> documentation.

At least for all the combo chips to date, the BT and WiFi halves are
pretty much independent. So we can get away with describing them
separately. If there's a shared supply or clock then we can list them
in both nodes and ref counting makes it all work fine. However, if you
had for example, a single firmware image for both BT and WiFi, then
we'd want to represent this as a single device (and driver with child
drivers). So you need to know if there's any issue like this because
that would affect how we do the BT binding.

Rob

>
> Regards, and thanks for the helpful comments.
>
> David.
>
>
> On 11/01/2019 16:34, Rob Herring wrote:
> > On Thu, Jan 03, 2019 at 04:35:37PM +0000, David Summers wrote:
> >> This adds the desrciption file that describes the hooks for the
> >> realtek bluetooth serial devices, as needed to refer to the interface
> >> in the device tree.
> > Please follow conventions for patch subjects. 'git log --oneline
> > --no-merges -- path/to/file' usually gives a good clue. In this case,
> > something like:
> >
> > dt-bindings: net: Add Realtek serial bluetooth binding
> >
> >> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> >> ---
> >>   .../bindings/net/realtek-bluetooth-serial.txt | 28 +++++++++++++++++++
> >>   1 file changed, 28 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> >> new file mode 100644
> >> index 000000000000..0aabca1fc002
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> >> @@ -0,0 +1,28 @@
> >> +Realtek bluetooth devices connected via a UART
> >> +
> >> +- compatible: should be "realtek,<name>-bluetooth"
> >> +  except for "realtek,trl8761atv" - which only has a serial bluetooth connection
> >> +       "realtek,rtl8723as-bluetooth"
> >> +       "realtek,rtl8723bs-bluetooth"
> >> +       "realtek,rtl8723ds-bluetooth"
> >> +       "realtek,rtl8761atv"
> >> +       "realtek,rtl8821as-bluetooth"
> >> +       "realtek,rtl8821cs-bluetooth"
> >> +       "realtek,rtl8822bs-bluetooth"
> > Arguably, '-bluetooth' is not necessary as nothing else is attached to
> > the serial port. At least shorten it to '-bt'.
> >
> >> +- These device are bluetooth devices, that connect via a uart
> > s/device/devices/
> >
> >> +- all devices (except for rtl8761atv) are also wifi devices, this is connected
> >> +  seperatly via sdio - and is not covered by this compatible node
> > Really, this should be up above the property list in a description of
> > the device(s).
> >
> >> +- ideally these will be referenced in a device tree serial node via serdev
> > Not ideally, but it is only valid for this to be a child of a UART.
> >
> > serdev is a kernel thing, and shouldn't be part of the binding doc.
> >
> >> + http://events17.linuxfoundation.org/sites/events/files/slides/serdev-elce-2017-2.pdf
> > Useful, but again, not part of this binding.
> >
> > There's no interrupts, GPIO control lines, power supplies, etc. for
> > these chips? The binding should be complete even if your platform
> > doesn't need these.
> >
> >> +
> >> +Example:
> >> +
> >> +&uart0 {
> >> +    status = "okay";
> > Don't show status in examples.
> >
> >> +            pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
> >> +            bluetooth {
> >> +                      compatible = "realtek,rtl8723bs-bluetooth";
> >> +            };
> > Mixed tabs and spaces. Use tabs.
> >
> >> +};
> >> +
> >> +this ensures that the bluetooth device is tied to the correct uart
> >> --
> >> beagleboard@davidjohnsummers.uk
> >>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
