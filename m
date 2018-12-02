Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D37C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:02:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212A220834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cIXxq76/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pDAUm7kV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212A220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e+WBN7XPFSXRpjsETOh9lSwjS7eHeaFgftFKzoB7VuE=; b=cIXxq76/T7tPWg
	jB26QZ+co0LAsvQbT9pBa+9TCXjkjWKT/N7XMgLtrYN308wI0K3KYb7lj2c3OlUQ/h+qIlhp74fn8
	X3i/YUGuQXp+hQvZbPcRo8I5uqFy9Cvcxhr/hwa0Y5YLPHTy4OZonr5flcQdJSM52lKy6XipG3ZqX
	/z02GYzSECticzIYhC5vvaDIVqO2NcbG06IDE5bOzQaoNp4XPBVHIySJkgum5Yn1Gl//a6eMMge5s
	7pj5fo7S6qPn1cz7JegKnL9cHqZ0CzvRGDLHCLjPFcnEFo8cRCsVRqWO8lV2100AmTfAxbbVfpM/O
	2smWDoZxDlISy06DBXgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTXwb-00025h-7r; Sun, 02 Dec 2018 20:02:21 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTXwY-00023Y-CF
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:02:19 +0000
Received: by mail-io1-xd41.google.com with SMTP id n9so8695702ioh.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6bLEXPScqafBgvmyyxDn7aE/051nLKxY7a8aCT/ZmLo=;
 b=pDAUm7kVtaTNqx7B5VYFVgcPfP+a2yJBT/ZY+C1SeAkgwz2Sr015CtoRqzkCCs6yko
 5hQm6SbvDpmOxzwRtgk9j/5FGIy2QoWjbLtmh9KxSk0C4yTKEdnKq9z9mNCoRkdl/rad
 iE4wJirqCD2HZpeSLllJ+FhTX1ewzrVkOq3awwSttHLQDmMSqvU18vJCPaAy5PytgDG+
 46+eO/dbNHeQaWCgmqAXrrH3TyFRvc0VDKfVobn3XI9C7q3RmJEzfeuE3m5dmALmGbIf
 0tafHGzts9kYglB+2avJRb4FN/7nTMW+Yr2sxUDgditPLUVlFxRT8GnkyuD7RwihOvh1
 RAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6bLEXPScqafBgvmyyxDn7aE/051nLKxY7a8aCT/ZmLo=;
 b=Fwi+v1TOmcrOScnJUDWAUs385RzR+nMycFDW+rU+gmbf0FXzdspxwfjAZdS97fBxAn
 D23n9D5g73Pat6wDl8x4Exkh6D+252Idzlv8KFwxTc9XS86Z64nAoJG0cEGv2WtiJBbz
 xairz/GpSu4lMSvbBvbg7ITQnNOtl2geZTEsQi0jtO4sqcXpZvSLPr2WrT+1ppGDpPGm
 Po6o+CRnJr01fmBFqHDwzqz/RqXQi9vYMbq6PQ2ixraHCi4UDpWZUBLGw6jc/XgbisEP
 4AKU583iJs+SFQzt8OXh7TRTkghFNhvhRAiUXqZ5GMsnyJ1UNadpcVLDYyOA0DfXdGry
 jmog==
X-Gm-Message-State: AA+aEWZYAfWFGHB4oid151Jewe/F1BklYZ9+bretq00eIFzpx0TLOwj/
 j5qjy2shZ/eaOcVu3YUY0vGS7slpsTezflGM77y98Q==
X-Google-Smtp-Source: AFSGD/WMETQUdwLN5IEJ11V6JF2o8lzl0QCIWZ1zGPh0I78zdlkkwoLI3G9ClzyiLy2/biyEyuwAGdGUHxPeeUTpAYo=
X-Received: by 2002:a6b:1414:: with SMTP id 20mr11563608iou.140.1543780926158; 
 Sun, 02 Dec 2018 12:02:06 -0800 (PST)
MIME-Version: 1.0
References: <d131fdd3-663c-9a5b-4296-94f2635f8c41@gmail.com>
 <5e3371a7-e4a3-49cc-b517-20902a5e2ed4@gmail.com>
In-Reply-To: <5e3371a7-e4a3-49cc-b517-20902a5e2ed4@gmail.com>
From: Olof Johansson <olof@lixom.net>
Date: Sun, 2 Dec 2018 12:01:54 -0800
Message-ID: <CAOesGMimqGGL+3Dd8tyyJpb506j9-tJZP0FeSCkvKwuUGWAmAg@mail.gmail.com>
Subject: Re: [GIT PULL] arm: mediatek: DT fixes for v4.20
To: Matthias Brugger <matthias.bgg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_120218_410747_CCF44D0A 
X-CRM114-Status: GOOD (  13.31  )
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
Cc: ARM-SoC Maintainers <arm@kernel.org>,
 "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>,
 Ryder Lee <ryder.lee@mediatek.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 2, 2018 at 11:57 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
> Hi all,
>
> On 26/11/2018 11:34, Matthias Brugger wrote:
> > Hi Olof,
> > Hi Arnd,
> >
> > There two issues with the mt7622 based boards in the current v4.20-rc cycle.
> > Could you please pull the following fixes for the issues.
> >
> > Thanks,
> > Matthias
>
> I just saw, that this is not part of armsoc-fixes [1]
> Does it fall through the cracks or are there any comments?

Hi,

I pinged you on IRC, which I'm guessing you didn't see.

Your branch was based on -rc3 when the rest of fixes were on -rc1 for
this cycle. I asked if I could cherry-pick, but in the end I decided
to send what we have and just merge it once Linus picks it up (since
the new branch would be based on -rc4 or 5). So, it's on the list and
I'll merge it later today or tomorrow.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
