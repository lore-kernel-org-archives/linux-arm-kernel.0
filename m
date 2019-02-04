Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABCEC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:04:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95932081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XQ8NvIxZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvgS5929"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95932081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vMjG9xm5G9VNrp/z7NM4215Eel3CkYX7dDiT53tUstI=; b=XQ8NvIxZPpPNUO
	41FCZRSmcPA8TX22kLRcsqHRI6N2uCThbdYE8c32zW8YsYYDiVakS0EdBhnXTMYv2aYN1iJVn2rZK
	6Y4jVLjqiFpbnzc427g6gYe77f4mMZeumv7luLBj8FSMM1B5kFaj+lztz8gTC++19jbxmToLi4qLi
	X0FO0YmXvaKR649phTe/egiBLgJbmeJHY6y0paEb/ZrwBBv4vjIvO4jNeCIQSWvYc/QI79R01oRBD
	ic1pQuG0Mgoc/8giemVMgshZKa0u9bvapCywrhGOjYFeuWhhAQG+hPvWof3BI5yD7KsEV83sKe6r8
	ogpauBg6njrbd1ObFI3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqkTn-0002CP-Me; Mon, 04 Feb 2019 20:04:31 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqkTk-0002Bp-HQ; Mon, 04 Feb 2019 20:04:30 +0000
Received: by mail-ot1-x343.google.com with SMTP id u16so1926930otk.8;
 Mon, 04 Feb 2019 12:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dW+a+Z93xOCDo99QKGnPlF6M5n3mCX+nDYSNYF4Vszo=;
 b=hvgS59297EobM0he1AJpb3+GqdQorFyOkJWp4r+NcPiNaYfqE8NZ6+2ETkV0T+D0Ra
 Lthv0UiMdfk6PHIQ8Ga8KlpjrvP1tcspRE1FWlP5ZQoCf94sauFViXClf/Ek+l3ptNRG
 ZjGvoRU//th4hJUOi/+ZglVrHqv6RVB61klL7Up7XIqb8JWFGwQAi3j9+iPQCHUZgz7x
 VmLt28wfBDrfJyWtrSIgV7Lxp/+j39uGp16rtRDIfjgktcjlI84oUX9Xb21bDVWDEEBL
 fHgG2/l6er57CNuGpVo2KYnLmi0AMS5px1gKCcjTTKRqUf2xXGO8QQzblfiylhC972QN
 3kmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dW+a+Z93xOCDo99QKGnPlF6M5n3mCX+nDYSNYF4Vszo=;
 b=B8cax3tdn8ZdrerakVzzIPmcop9NgzVI4nfcfpN9UvWJ0dXactUjf+fhidRFe9tgPi
 txo7XTSmYaWBqvUVlwbwNgYCzsI2CRjYsncEywaNwc41PmZHxqUofqtxxFhuxkG0SM/W
 87jsST8Qvoqbcbipy+NO0ztnp3eLm9Z1fgG6NbPkkKGdUQsWmLHGotpjQZO7UlqC44hE
 0qcFM98J2sSd4toSteSdKQ3G5E6pHZZItPyTNGOGwGzTxU3x7MdRNYWdOMJQR8EsiDx4
 Rw09ztxlYDkLc8BnVkBrblSR577Q+KpmSqXkpYh5gHgoVigwiKtLw6lWXJOb/ajOziKJ
 OzhQ==
X-Gm-Message-State: AHQUAuZ1JPi9k3SO9ugwAILH63iQt5ttsxy7MxGAMfmvIQdGCi0PDIGY
 0uo9CCX4NNai2JaphnzxRHWY0RiU3x0lF7T+tHw=
X-Google-Smtp-Source: AHgI3IZI/FpEH8tQ1XlWnDyNI8/eN2aZowQsxjbRKlDyDWxXVUqmhpf0oCHh7UrdLtSd/EVUWSdSUNJHWfnmKRipFSk=
X-Received: by 2002:a54:4382:: with SMTP id u2mr561177oiv.262.1549310663424;
 Mon, 04 Feb 2019 12:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <CAFBinCC1xjqogcLm94gu+iLS_b_zB8eNEXL+4bYhog==zN0S+A@mail.gmail.com>
In-Reply-To: <CAFBinCC1xjqogcLm94gu+iLS_b_zB8eNEXL+4bYhog==zN0S+A@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 5 Feb 2019 01:34:07 +0530
Message-ID: <CANAwSgT3tVss-hQ0jYzTaSvkfVkSQZtiRFhdq1KmUSL4idZmLw@mail.gmail.com>
Subject: Re: [RFCv1 0/3] Odroid c1+ usb fixs
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_120428_573938_D9E40777 
X-CRM114-Status: GOOD (  18.30  )
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

On Mon, 4 Feb 2019 at 19:21, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Wed, Jan 23, 2019 at 4:12 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > This is follow up on my previous patches.
> >
> > [0] https://lore.kernel.org/patchwork/patch/1031616/
> > [1] https://lore.kernel.org/patchwork/patch/1031617/
> >
> > As per Martin's suggestion and input I have tried to fix below issue.
> >
> > Fixed the phy power issue on the usb port.
> > # cat /sys/kernel/debug/regulator/regulator_summary
> >     USB_VBUS                      4    2      0 unknown  5000mV     0mA  5000mV  5000mV
> >        phy-c1108820.phy.1         2                                 0mA     0mV     0mV
> >        phy-c1108800.phy.0         2                                 0mA     0mV     0mV
> >
> > Fixed the OTG phy warning and initilizaion of usb0_phy
> > # lsusb -t
> > /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> >         |__ Port 1: Dev 5, If 0, Class=Mass Storage, Driver=usb-storage, 480M
> >         |__ Port 2: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 480M
> >         |__ Port 3: Dev 4, If 1, Class=Video, Driver=uvcvideo, 480M
> >         |__ Port 3: Dev 4, If 2, Class=Audio, Driver=snd-usb-audio, 480M
> >         |__ Port 3: Dev 4, If 0, Class=Video, Driver=uvcvideo, 480M
> >         |__ Port 3: Dev 4, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> >
> > Now hotpluing of usb device is working on odroid c1+ boards.
> unfortunately it's still not working for me :(
>
> all following descriptions are seen when looking at the PCB with the
> 40-pin connector on the bottom, USB ports on the left, micro USB
> connector on the top right.
>
> my test-case is:
> - power-cycle the board
> - enter u-boot command prompt
> - gset GPIOAO_5 out high (or replace high with low)
> - measure
>
> I checked the voltage at RT9715EGB (U19) with a volt meter:
> GPIOAO_5 HIGH:
> - EN pin (bottom, left): 3.3V
> - VOUT pin (top right): 5V
> GPIOAO_5 LOW:
> - EN pin (bottom, left). 0V
> - VOUT pin (top right): 5V (not sure why...)
>
> I also checked the voltage at Q5 2N7002W with a volt meter:
> - gate (bottom, right): 0V
> - source (top, right): 3.3V
> - drain (left): 0V
> this is always the same, regardless of whether GPIOAO_5 is HIGH or LOW.
> however, with Armbian booted (which uses some Amlogic 3.10 kernel
> where USB works) I get:
> - gate (bottom, right): 0V
> - source (top, right): 0V
> - drain (left): 3.3V
>
> what do you get on your board?
>
I dont have multi-meter to check this out on old and new kernel.
As per my observation Amlogic 3.10 (32 bit) and 3.14 (64 bit)
both use some state machine the tune the usb port.

It's not clear that this will work with upstream kernel.

I just checked with board booted with usb device connected we are observing
the bus and is getting power up and hot plugging of usb device is working fine.

$ lsusb -v|egrep "^Bus|MaxPower"
Couldn't open device, some information will be missing
Bus 002 Device 003: ID 1b71:0056 Fushicai
    MaxPower              500mA
Couldn't open device, some information will be missing
Bus 002 Device 004: ID 152d:0578 JMicron Technology Corp. / JMicron
USA Technology Corp. JMS567 SATA 6Gb/s bridge
    MaxPower               30mA
Couldn't open device, some information will be missing
Couldn't open device, some information will be missing
Bus 002 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
    MaxPower              100mA
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Couldn't open device, some information will be missing
    MaxPower                0mA
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
    MaxPower                0mA

>
> Regards
> Martin

Best Regards

-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
