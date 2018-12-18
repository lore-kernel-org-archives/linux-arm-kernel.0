Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88443C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:37:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A11120675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gQ+4rvXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A11120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zu0dUYLkhkwp3FCPGZqMJgye8MSEH8EObY5H+QauZq8=; b=gQ+4rvXrX/Ry6g
	tKdRjukZvFkK0TFkCltAFjfGakWtbO2F+8TVjJXztjii93OiqtlWrXi9K+fLj9vC4uKCwAWbWfNHw
	UqySWDb8pJ6pG4WkQxxSBP8aXZ0XLlb8LT2UrvMmqVlzHlFczfdNeYQrnBSiTNUrTyADv8GDR1am2
	9tPXlWg/eBLS51+O5/wVRZ+FTB3bHSoWX+4nrE7r4gn8cgfTKOnO6J96BZp0BC12USLwRal2shsng
	20kqRd6hEwYwrE9q8WSDNY8VOmJoIzrbd2ow5Jx9hHJwJL5TBrNp/LNBFFyl99x+UjHjP/HBmkpji
	astJ1V8ad9lxUSDIFvOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHQl-0002hv-7p; Tue, 18 Dec 2018 15:37:11 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHQh-0002Wx-5i
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:37:08 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 4DA43810D;
 Tue, 18 Dec 2018 15:36:57 +0000 (UTC)
Date: Tue, 18 Dec 2018 07:36:50 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181218153650.GA6707@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181218124616.GA10758@amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218124616.GA10758@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_073707_253003_120E16EE 
X-CRM114-Status: GOOD (  16.84  )
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
Cc: Rob Herring <robh@kernel.org>, Marcel Partap <mpartap@gmx.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, omerlle@gmail.com,
 Merlijn Wajer <merlijn@wizzup.org>, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 NeKit <nekit1000@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Michael Scott <hashcode0f@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

* Pavel Machek <pavel@ucw.cz> [181218 12:46]:
> Dunno, I see that you might want const there, but u8 -> unsigned char
> seems like a step in wrong direction.

Well I was just trying to follow what the serdev core is doing
nowadays.. I'll see if I can just constify.

> # commit	   cd16272060d8100ef0388349cf88f42a1dc667fc (patch)
> # tty: n_gsm: Add support for serdev
> 
> Is it worth putting those in separate file? n_gsm_serdev.c?

Yes that's the plan but that needs some refactoring to be done
and I did not want to get into that until I had things working
to prevent regressions.

> # commit	    0c1bc81ba976bcd480d6e3c3009a28589f8427c0 (patch)
> # mfd: motmdm: Add Motorola TS 27.010 serdev driver for devices like droid4
> 
> Oh, that is a lot of fun. Especially state machine for parsing modem
> responses. I wonder how well it is going to work when modem is
> accessed over USB... 
> 
> motmdm_read_state(... size_t len)

That's a bit of a layering violation yeah :) But we still need to
do that somewhere for notifiers. And the notifications are separate
from the commands and start with a ~ character so from that point of
view it should not be too bad.

In general, motorola-mdm should just deal with the custom packet
numbering layer and pass data to channel specific serdev drivers
or to the channel specific /dev/motmdm* char devices.

> I applied it over my tree (I still need patches for display,
> right?). I'm getting
> 
> /data/fast/l/k/drivers/mfd/motorola-mdm.c:1132:3: error: initializer
> element is not constant
> /data/fast/l/k/drivers/mfd/motorola-mdm.c:1132:3: error: (near
> initialization for 'motmdm_driver.driver.name')
> /data/fast/l/k/scripts/Makefile.build:291: recipe for target
> 'drivers/mfd/motorola-mdm.o' failed

Hmm OK thanks for letting me know. Yes Sebastian has updated
branches for the LCD.

> Oh and that mdelay(3000) is going to hurt... especially because
> console is initialized very late or d4.

It's msleep() not mdelay(). Sorry I have not figured out a better
way so far to get the n_gsm initialized other than spamming the
device with retries for a while on start-up.

> I did a quick test in my config... and it did not break my old setup
> -- voice calls still work when set up over USB and with manual mixer
> setup. That was good surprise.

OK good to hear. Using the n_gsm port instead of USB during idle
has a major PM advantage as the SoC can hit retention during idle
while still connected to the modem and getting notifications.

So looks like during idle we can keep USB in autosuspend mode with
something like the below shell script function.

Regards,

Tony

8< -----------------------
# It's OK to keep to keep ohci device on auto and qmi_wwan and cdc_wd loaded.
# Probably musb and ehci modules need to be currently unloaded for SoC idle.
suspend_usb() {
        ohci=$(find /sys/bus/platform/devices -name \*.ohci)
        if [ "${ohci}" = "" ]; then
                return
        fi

        devices=$(find "${ohci}/" -type f -name control)

        for device in ${devices}; do
                echo -n "${device}: "
                cat ${device}
        done

        for device in ${devices}; do
                echo -n "auto" > ${device}
        done

        for device in ${devices}; do
                echo -n "${device}: "
                cat ${device}
        done
}

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
