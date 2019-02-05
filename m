Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7B1C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:53:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5CF2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tzQw/f80";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uG+yx4mO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5CF2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UhHLjMMHgqT7oa9a5hVgNWMx/Qe5UrkMXKKa0PFL7KA=; b=tzQw/f80DwIAFu
	bqrliyYaSfRoR7Js/YcaRWxjjEYUm9//yjc3aAGIW4kfWh+JL50PX+2/qgfz44NB1N8akM7UehY17
	VLpKBqW/UHj+kCyHh9SZApjXSJGtvBhujqfuvwUz1pWuvYEEORSieizKU7X8ruTOqDi/Z4eLD0ino
	b5hmyayreOazSAhoJ4gj4mVQfvhvtIN+EPox8tE9PoqSMjIYLXIs/acZfrpBhDxbuhc5kdKTxp7uc
	aAUygTCr2+z8MBXGL2yudM+8lyt8EIdyvwRy9scSA0rLwK+H6dGgtHG7AwNGRPIlg0zR3Ue2chQ9l
	GnnBFCs+uzR+/WXmC/Iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr6mu-0003PR-JQ; Tue, 05 Feb 2019 19:53:44 +0000
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr6mh-0003MO-9P; Tue, 05 Feb 2019 19:53:39 +0000
Received: by mail-ot1-x32b.google.com with SMTP id s13so7911264otq.4;
 Tue, 05 Feb 2019 11:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6TpxB9wKUuQIyEkbFds5s9cGUD6kRMrQQ03ech8ZRS4=;
 b=uG+yx4mOqq/obmuL24Ni9s8gQmGRIzfid4PGdOezKVWQwrXCX6SGNSfxdUntNlNjRz
 T2cFoYIouCJkrv6siUv/0pMvs7xKZltbAK9kvM7WLkyizf0zh/jIPI5RN6dR3fHwMYHe
 Lzl/w/YGw6Gf7Raz99/WxMG+7Cr6mkTOBhV1TMViRIhB5DwW9fdE+cITNzChqxoAWRz/
 elfR98JZkm0w6YZHQXaqy40cfiR9dMJQ3HyTT76lfFb55aSCKr9PAexASp7bThsUGJss
 ali2b9qLu6jk6EJM11jByPYaWIbEjZbfma/nJgrvr/0jP6at0rezvcDPWnc5jOwjhjUH
 MBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6TpxB9wKUuQIyEkbFds5s9cGUD6kRMrQQ03ech8ZRS4=;
 b=D3+9vo6EdJvrmvX1AZfuJv3WGYWjz3E9kATZ1NxXuVgtAJo6ZwnSsMgeSN3tCJ9AnM
 p9puc7o/PDUxO6KdnjmKrJlP3G7zKDGy1t6/IUO4g6nfRCjvLYfD3M7kUakg6xdKqeuL
 MgrMMLnGJpnjphYlqerTYyJCZbfeslFBTIirSWmMH02/FlhqAHJyh1rVdOOg6a1WDfsX
 MDy0kwk5FlRXVT/NtI19VT4ySgA8XiEX5c/Xh46SdP/9/W2fApULUsE9VMHFf5VIa12G
 TpYpPRFDP/md0pK892XOPqCjqZnJC3cJtCPsRwe7999QNaFmivRyZLGKHAZb5HojkI0t
 sNLA==
X-Gm-Message-State: AHQUAubEERma7GwT9IZB0iYzSR0/tfRHoxercvYWsxx8U2RWl7y/UW+Z
 wJmh2fyQ5d159paevqVxfYB6bQVLY5S2YG88cNQ=
X-Google-Smtp-Source: AHgI3IZ/ODV+mHbgredq/e6Nhz2PMd21xUcJKyJ6t49Du1p+useF/5WNGET6SKNURzuwgOs0F5e6BgTkIKn+0viU6XQ=
X-Received: by 2002:aca:3fc6:: with SMTP id m189mr3566788oia.142.1549396410208; 
 Tue, 05 Feb 2019 11:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <CAFBinCC1xjqogcLm94gu+iLS_b_zB8eNEXL+4bYhog==zN0S+A@mail.gmail.com>
 <CANAwSgT3tVss-hQ0jYzTaSvkfVkSQZtiRFhdq1KmUSL4idZmLw@mail.gmail.com>
 <CAFBinCDj0jA9dT72J8RvfJtyL3bBKTy+PaRsHXukvTuKitaXqg@mail.gmail.com>
In-Reply-To: <CAFBinCDj0jA9dT72J8RvfJtyL3bBKTy+PaRsHXukvTuKitaXqg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 6 Feb 2019 01:23:18 +0530
Message-ID: <CANAwSgT1eej_U+CAB=Dp+TyYYdYw9WfCKg5FuLAZEx6t3VoDxQ@mail.gmail.com>
Subject: Re: [RFCv1 0/3] Odroid c1+ usb fixs
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_115331_401016_6BA58A56 
X-CRM114-Status: GOOD (  17.99  )
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
 Kevin Hilman <khilman@baylibre.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Rob Herring <robh+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin,

On Tue, 5 Feb 2019 at 02:08, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Mon, Feb 4, 2019 at 9:04 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > I dont have multi-meter to check this out on old and new kernel.
> > As per my observation Amlogic 3.10 (32 bit) and 3.14 (64 bit)
> > both use some state machine the tune the usb port.
> >
> > It's not clear that this will work with upstream kernel.
> do you have a filename / line number in Amlogic's kernel regarding
> this state machine and / or tuning logic?
>
> > I just checked with board booted with usb device connected we are observing
> > the bus and is getting power up and hot plugging of usb device is working fine.
> >
> > $ lsusb -v|egrep "^Bus|MaxPower"
> > Couldn't open device, some information will be missing
> > Bus 002 Device 003: ID 1b71:0056 Fushicai
> >     MaxPower              500mA
> > Couldn't open device, some information will be missing
> > Bus 002 Device 004: ID 152d:0578 JMicron Technology Corp. / JMicron
> > USA Technology Corp. JMS567 SATA 6Gb/s bridge
> >     MaxPower               30mA
> > Couldn't open device, some information will be missing
> > Couldn't open device, some information will be missing
> > Bus 002 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
> >     MaxPower              100mA
> > Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Couldn't open device, some information will be missing
> >     MaxPower                0mA
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> >     MaxPower                0mA
> for me it stops at the Genesys Logic, Inc. 4-port hub (I see the root
> hub, the 4-port hub and then nothing more) using the mainline kernel
> (with or without your patches)
>
> I'm not sure what to do with this information though.
> currently we have no reliable way to tell if GPIOAO_5 is only for the
> OTG port (usb0) or also for the host-only port (usb1).
>

In order to enable usb debug verbose output we need to compile the
kernel with following option.

CONFIG_DYNAMIC_DEBUG=y
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y

to get more in sight into usb initialization and low level hand shake.
-----------------------------
[    1.796436] dwc2 c90c0000.usb: mapped PA c90c0000 to VA (ptrval)
[    1.796481] dwc2 c90c0000.usb: c90c0000.usb supply vusb_d not
found, using dummy regulator
[    1.799183] dwc2 c90c0000.usb: Linked as a consumer to regulator.0
[    1.805320] dwc2 c90c0000.usb: c90c0000.usb supply vusb_a not
found, using dummy regulator
[    1.813600] dwc2 c90c0000.usb: registering common handler for irq26
[    1.814794] dwc2 c90c0000.usb: Core Release: 3.10a (snpsid=4f54310a)
[    1.814803] dwc2 c90c0000.usb: Forcing mode to host
[    1.883383] dwc2 c90c0000.usb: dwc2_check_params: Invalid parameter lpm=1
[    1.884534] dwc2 c90c0000.usb: dwc2_check_params: Invalid parameter
lpm_clock_gating=1
[    1.892435] dwc2 c90c0000.usb: dwc2_check_params: Invalid parameter besl=1
[    1.899318] dwc2 c90c0000.usb: dwc2_check_params: Invalid parameter
hird_threshold_en=1
[    1.907300] dwc2 c90c0000.usb: DWC OTG HCD INIT
[    1.907306] dwc2 c90c0000.usb: hcfg=00000200
[    1.907319] dwc2 c90c0000.usb: dwc2_core_init((ptrval))
[    1.907324] dwc2 c90c0000.usb: HS UTMI+ PHY selected
[    1.907330] dwc2 c90c0000.usb: Internal DMA Mode
[    1.907337] dwc2 c90c0000.usb: Host Mode
[    1.907599] dwc2 c90c0000.usb: DWC OTG Controller
[    1.911994] dwc2 c90c0000.usb: new USB bus registered, assigned bus number 1
[    1.919060] dwc2 c90c0000.usb: irq 26, io mem 0xc90c0000
[    1.924323] dwc2 c90c0000.usb: DWC OTG HCD START
[    1.924335] dwc2 c90c0000.usb: dwc2_core_host_init((ptrval))
[    1.924342] dwc2 c90c0000.usb: Initializing HCFG.FSLSPClkSel to 00000000
[    1.924349] dwc2 c90c0000.usb: initial grxfsiz=00000800
[    1.924354] dwc2 c90c0000.usb: new grxfsiz=00000200
[    1.924360] dwc2 c90c0000.usb: initial gnptxfsiz=08000800
[    1.924365] dwc2 c90c0000.usb: new gnptxfsiz=01f40200
[    1.924370] dwc2 c90c0000.usb: initial hptxfsiz=08000000
[    1.924375] dwc2 c90c0000.usb: new hptxfsiz=01f403f4
[    1.924389] dwc2 c90c0000.usb: dwc2_core_host_init: Halt channel 0
[    1.924396] dwc2 c90c0000.usb: dwc2_core_host_init: Halt channel 1
[    1.924401] dwc2 c90c0000.usb: dwc2_core_host_init: Halt channel 2
[    1.924406] dwc2 c90c0000.usb: dwc2_core_host_init: Halt channel 3
[    1.924412] dwc2 c90c0000.usb: dwc2_core_host_init: Halt channel 4
[    1.924417] dwc2 c90c0000.usb: dwc2_core_host_init: Halt channel 5

Best Regards

-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
