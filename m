Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33E4C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:39:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906B82081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RbBlWITZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IwqoG7xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906B82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MHbAqHUzpRHQeXH8AiFjGKV4b2WUEpIMMAEcfHW5uAw=; b=RbBlWITZjTT+uQ
	irnkkvz3K/+faMznwlDi0MnJ0pceuK0wpfQaRV6iJoQhKJdiIr5aPK29YDMPoL1uF2Ov9NGr1xbX5
	Ss63swmLCM4STC1gB+cOWY24v+tB8Rhl9d4ZCLA/CY1d7UYzNORivFWyJVJrbAT76S/7Pl0TIqsUy
	G0O+vxHdXaoMsXb0mBtUkpv424szlokLwFfSx73jCfvor5fOCgbQq+WMxNAtsniQcG/6szxcDzwiE
	CLESyUoVQ4cTeOdEWTGdkV3b+NTtBVzPo0aaoBJhCn8oXYDRxzhU0IJM2SWNN+xodLAzVrNCmON4Z
	Ti66md4raO+ioyN0qT2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gql1D-0001oj-Dx; Mon, 04 Feb 2019 20:39:03 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gql1A-0001ny-Gx; Mon, 04 Feb 2019 20:39:01 +0000
Received: by mail-ot1-x342.google.com with SMTP id w25so2051080otm.13;
 Mon, 04 Feb 2019 12:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uXK+oSaz8Oqrh9EHtaflT5bRlHlYm132lPxhGZoFKUA=;
 b=IwqoG7xcTLfYaRl1kgehXVgrM8ooW82RdLPE/szWr5j+K3WqUtXyV3xD8Vt6CbB6cs
 fAY1/hBZQk2zvxZAK3S9TIIxN4I34oukRh0xc8tPIlvwQShjWAMvE1vy4vjPO4pfCJ7t
 8yB771O+4eqU5fa14G+XzV83Lf72SynSjy9TnVr11zHj1s2AaI6JfsD0OCJAJ7P/9JwO
 z3wiRh5Ei2dNLjfDRw6vv8vClGwB+d28x5s46KyhqJ6y+UJsODlN9M+OIiHBzJs6d2RF
 uT1dy8RkYmd+0JkPFz6N6h2eBJRRE7Mxbia+MPfXmn8U8zq5JoBebioDK3NqenJmw0Eb
 fMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uXK+oSaz8Oqrh9EHtaflT5bRlHlYm132lPxhGZoFKUA=;
 b=buTQzIl5Bn+kb+lIX6HvtUqLSLVLL5p/y8cnsgtYUNlYwIX+q9QAMeYCcBu3wG+ygs
 AH4MwQpPitkQ/vys4s39qyna20Ctp4rzijp2eu+GOkEJln0Ef0LLIdd66pkpcYeZAnU8
 Lj5EOx/575xd2KPYkteGU2cLFHFFLfkp9Ltrl5J8JurBTAT2n16ivfsUAEHg2QqcPjfw
 ZhcVkBUFlZgyRPaOg6Tbz9ilEjJcQM9TXPpvH4wFOSCm+3I0NCdLHIhkEmhDOxpfcifJ
 VvPrzk9UA3OpsUZizqW5vxnUjYStmvaSoOgdpalAP/CbwvDKzBSQdC5G76gED3bJdOLn
 XzOQ==
X-Gm-Message-State: AHQUAuYyblYILAWnV+ktwezNeP1Y4yGYs8+2x7OAlGOQpbfiiyKke3FM
 tEYSoOst9M1qKuDAvhmYeGpjzsezy93VtDTTLso=
X-Google-Smtp-Source: AHgI3IbW2IM70Xtyb3MSm1rIL5r4TSzy0rTqMiqLwBb+QjUnKNXALt4e3gQGjoHfNWMdhW8yTaFx4tsGh5b/u78tnq0=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr695581otg.308.1549312739429;
 Mon, 04 Feb 2019 12:38:59 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <CAFBinCC1xjqogcLm94gu+iLS_b_zB8eNEXL+4bYhog==zN0S+A@mail.gmail.com>
 <CANAwSgT3tVss-hQ0jYzTaSvkfVkSQZtiRFhdq1KmUSL4idZmLw@mail.gmail.com>
In-Reply-To: <CANAwSgT3tVss-hQ0jYzTaSvkfVkSQZtiRFhdq1KmUSL4idZmLw@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 4 Feb 2019 21:38:48 +0100
Message-ID: <CAFBinCDj0jA9dT72J8RvfJtyL3bBKTy+PaRsHXukvTuKitaXqg@mail.gmail.com>
Subject: Re: [RFCv1 0/3] Odroid c1+ usb fixs
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_123900_582455_CBB18EAE 
X-CRM114-Status: GOOD (  12.33  )
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

Hi Anand,

On Mon, Feb 4, 2019 at 9:04 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> I dont have multi-meter to check this out on old and new kernel.
> As per my observation Amlogic 3.10 (32 bit) and 3.14 (64 bit)
> both use some state machine the tune the usb port.
>
> It's not clear that this will work with upstream kernel.
do you have a filename / line number in Amlogic's kernel regarding
this state machine and / or tuning logic?

> I just checked with board booted with usb device connected we are observing
> the bus and is getting power up and hot plugging of usb device is working fine.
>
> $ lsusb -v|egrep "^Bus|MaxPower"
> Couldn't open device, some information will be missing
> Bus 002 Device 003: ID 1b71:0056 Fushicai
>     MaxPower              500mA
> Couldn't open device, some information will be missing
> Bus 002 Device 004: ID 152d:0578 JMicron Technology Corp. / JMicron
> USA Technology Corp. JMS567 SATA 6Gb/s bridge
>     MaxPower               30mA
> Couldn't open device, some information will be missing
> Couldn't open device, some information will be missing
> Bus 002 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
>     MaxPower              100mA
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Couldn't open device, some information will be missing
>     MaxPower                0mA
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>     MaxPower                0mA
for me it stops at the Genesys Logic, Inc. 4-port hub (I see the root
hub, the 4-port hub and then nothing more) using the mainline kernel
(with or without your patches)

I'm not sure what to do with this information though.
currently we have no reliable way to tell if GPIOAO_5 is only for the
OTG port (usb0) or also for the host-only port (usb1).


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
