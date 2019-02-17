Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC39C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:27:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E0C217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i55GujTx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iE1g53XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E0C217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2+DlKMIk6sfsLvO0cL+qd6uRW9fllVQYOFsraYQlDug=; b=i55GujTxsgbZjD
	btqgzqjrZ7tm1Y2d15BsYmqbXFe9A5a2v7MySA+geSoSkyenZCqWc4Ra96uF9IKRZxp1lVDL/k8Te
	a2jyBr8oup6yfynfUcF2PMtN79yGshQhQcA+bzPkUUO6Mvc4o/ppmMxfQk8GrVfqVpFQ5GMQ5tvw/
	vvoqgYSHhYxJFeSGrvA657B/cYNHcDwANVJtxLpPeBbtSlyncf/XdCFvCDY/w3z7mk57bl8Tf+Sum
	qC0LQLflYcK+p3SkwnIjjuvNGxeTSLRKxK/PFH37bECRT/C08YXAtEfbfQxGI0zSeQmZvhNcm0s72
	COhM2bKseq7+PewcFucQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvNPL-0006a8-KU; Sun, 17 Feb 2019 14:27:03 +0000
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvNPI-0006Zh-2p; Sun, 17 Feb 2019 14:27:01 +0000
Received: by mail-ot1-x32e.google.com with SMTP id 32so24076052ota.12;
 Sun, 17 Feb 2019 06:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yE0xzs/BLftvltq6QC5JJitLB59LDN+Qew2H1ea1uq4=;
 b=iE1g53XDNBv/dAGxeVlnV+y+G5bRiYifHVAhI5hlv6fvkC9EgMe6SXoAJiqGV4uGd6
 XTFjQ6oEocN6Z05Hc1e84z2hanugpW48qIpVdBkdYeg6hPyTJJcXCZtVFp2j50Y7tSFu
 hcIU4WQUanvHGBPWslJTHpJPYBkUsEwY3PgiozozaN5LrFm7oLVtF7JmUl4tbBLW3z48
 8wK6Ro1YD37d9KQKS/YOZuJ45EX7mpDGBdJ+Sj6I5aa/aiYRhl9fSe4Y4XEXro22ukiE
 paC/zuS8WS7JUj8N7yU7WrW8XOs1DzPffyiVRmUbf0EU3MdEsqddDJBQTcV6uvEd/gw1
 rFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yE0xzs/BLftvltq6QC5JJitLB59LDN+Qew2H1ea1uq4=;
 b=Eaih1H0JjF2dpMvFBWuezBuKcEgzp7iUVS/8JHBmVe4GDo/lQEn2RsPsDjkg/MhU4e
 sBhDRbxeeKxQnyo2bLc6dhvalbhWJf7wXUpQzHO+5YopyvH5Y7zp4qNty2boAzzDs+PR
 NcrjCiZp13ZikFctICuWr9NITFm9+ByGDKQ9pVuz9GVKHArgZi9oZCY/MYp+wsRQcwFw
 RUisfxuW40Hhu6xPq/JyEZzjeFKAK5USWRLuo28iclQn/9t6F245zuxMTjz/14KWMuO/
 1QnVQgZ2KC7f4KPGXOjQfHcTFWpYWd/YPLFSxhyd41kBo3hFXV9T04IBiPznUeFKby8T
 K3Ug==
X-Gm-Message-State: AHQUAuYQidNGbxkPjDIqT3pid4TqXs7zT53uLbr4a59aFZlfSEPrwKOg
 8hCUuPB3Ok7upjEInblSjOY2IvPrhmZSIY4CiwI=
X-Google-Smtp-Source: AHgI3IZ3b0lBps/6NpgWAFY9KYFMdqM2KgkpQCU6RhlUnWzGkMXiKfgmNCObnoYqpSF3gLeO92/IcBX2m+bbLKw/8N4=
X-Received: by 2002:aca:3586:: with SMTP id c128mr12065134oia.47.1550413617329; 
 Sun, 17 Feb 2019 06:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-3-linux.amoon@gmail.com>
 <CAFBinCAdf0rtt-7tON_LRNH_cpvGJXX3LX8g-i4xsC3wahZSVA@mail.gmail.com>
 <CANAwSgQ4=Vn6RM4Kpd20UWkQNW81=mfg-qB0G73dsRem3qwjcA@mail.gmail.com>
 <CAFBinCB=3kmuFb_xXzhW+m8dTasVrCHQp2wti+=5UjrAHk5TTg@mail.gmail.com>
 <CANAwSgQnMkXECkCVjFKwNKB+2JoiPtVPQbateppmtgfPYCutZg@mail.gmail.com>
 <CAFBinCCFoBkbf-HvEoMk7mTYTBV27nJ9TF1X-DrLuHR9qDVDSA@mail.gmail.com>
 <CANAwSgRtBWzKiFLUV6twxv+TnvjLdHXv=U8+ppQ7=9uBBLEH+Q@mail.gmail.com>
 <CAFBinCD_Pddu+pBEKwMS6467J5nxKF4T5-LxVo06nFvyUSLpew@mail.gmail.com>
 <CANAwSgSQRwF+_VR1jJFg=Q9wSdanEH0GmnFaeegt=hRMXiHX3Q@mail.gmail.com>
 <CAFBinCBwDg21t+HT6w7CcUgH_aDuwh-UgoPs7GuZo9rABvPDig@mail.gmail.com>
 <CANAwSgRKgWCyNoDUxrK4asjZ_6z77Rew2nGCg1Yq9m3pi0Amrw@mail.gmail.com>
In-Reply-To: <CANAwSgRKgWCyNoDUxrK4asjZ_6z77Rew2nGCg1Yq9m3pi0Amrw@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 17 Feb 2019 15:26:46 +0100
Message-ID: <CAFBinCALfZ4HbBdyXjMqFX-HyJtTyOU_FgW18+jK4cW4Svfenw@mail.gmail.com>
Subject: Re: [RFCv1 2/3] ARM: dts: meson8b: odroidc1: fix USB power supplies
 for phy
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_062700_149401_2D8D0F83 
X-CRM114-Status: UNSURE (   9.72  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Emiliano Ingrassia <ingrassia@epigenesys.com>,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anand,

On Mon, Feb 11, 2019 at 4:09 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> Can we have other people who can test both the approach for
> *vbus-supply* vs *phy-supply* setting.
> Then we can conclude on the correct approach.
this is a good idea. do we focus on the 4x USB host ports for this
test or also on the OTG port?

my test-setup so far was:
- Odroid-C1+ board revision 0.4 20150615
- the board is powered using the micro USB port
- connect an USB thumb drive to one of the USB host ports

test-cases:
- an "unpatched" (in terms of USB power regulators) kernel
- using Anand's phy-supply = <&usb_vbus>; inside the usb1_phy node
- using vbus-supply = <&usb_vbus>; inside the usb1 node

in all thee scenarios the LED of my thumb drive did not light up and
there was nothing in the kernel log. also lsusb -vv didn't show
anything.

Anand, do you have any other test-case in mind that we need to check?

I CC'ed Emiliano because he initially added USB support to
meson8b-odroidc1.dts (that was before I got my own Odroid-C1+).
He can probably help us test on his board(s) as well.

> Honestly I am using power supply from dc jack rather than power via usb otg.
I don't have a plug which matches the little DC jack so I'm powering
my board using the micro USB connector.


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
