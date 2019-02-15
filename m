Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BDCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:29:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F0E2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YS5mgVyz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="mzveJjO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F0E2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pcz9mMe7EviKGJvck0+R7TJDYWW5E3DhJfv1CH2ytcY=; b=YS5mgVyzCwtEvC
	25yWiQ/0OljkJ1uuEBNIK/HF3PPuYODe9VklamnyslvMlRaP1xyiD6uYkkAwKK47qXy8r5wgLubrT
	D76Oaa7ohp1o5WNwRqdt6rvS7EbH1ZDbJ94t77KascI1eyPDoET4eRnI+MZRuQ2SoNBnXPNxt3br/
	IW246NKPaXoydklJdzmkf+eu6bgXN/SMs2BUM+wa92phKaCEcdtdd09quQthKGa7h45TpCwFg5L6U
	SviO6RFkW3gG149xO/Aq+KnEGdcWFQRk8AeAU+oVuXaMzBMjrv19YKe2Wp38wvftdk7sw89hjosam
	H8GgPK1PoVRMtAxFi9kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufQx-00019L-44; Fri, 15 Feb 2019 15:29:47 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufQt-00018z-NY
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:29:45 +0000
Received: by mail-ed1-x542.google.com with SMTP id f2so8235351edy.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ettus-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+qQVLOm+tc6witGNoTG9gdfSDZengbsbLuRNCQL5ryo=;
 b=mzveJjO+4aNOs1o6nVRjMlC6boIT0oM6N0eJWQHCDX/CwBMyt0vGJJs0G5RW7nPToK
 PBWAAGkqRsYICdw+NAgWwbPxtenmagWpOE6i2KEfSJfAxPrjBXTcxE05W6iiSEnPz8B8
 Wcw64qfslCSHVfwCD5Xn6SVMl0iPf9CDSlbnU9xYXBQyl4dEw3w8yb+vPNizXonIKhhX
 YUwecHkV49EbXpJFyTAaLx9Q0mNlg4ZiTl06VGMp9dWQzUQlopDfpz/bFbu7AvVe4Qaw
 JIBlrELn6xm0XLFY8/59DQCSuLQf/FBjF4nDNHzramoQGPygGnC+pf188J043T3P7yVb
 Ad7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+qQVLOm+tc6witGNoTG9gdfSDZengbsbLuRNCQL5ryo=;
 b=F6zd17newi+C/pUttFS8YEAr8Koyl4jTuAMywDvcU4elT/iFWRLfW0ZwS5QZApF0Ut
 1u1Yn6Ga3TBv09wi8c6S1lJUpfZa8zVN14elPRGprpKnSfImKR4G9PX5n5GG6OATP44n
 OVH/SQHPmDsjUIpk5jgVlvz0FgpSZzqVHLgWsm1+EVPeSG0W+pCOS/aU0sz+L6FCPVC4
 V0lt3BBvHO7jk2OsIOt43oVGsw85myGcRo5QXcYqop01Jhd/YcvSQxHfhoXsihg4rqR8
 icKh8OKyfsIT8t90cA6ZzVftHWtWVwjggkhtPgVdTdJZc+yzU7aB2fgWK9gykK/2MX4r
 g6Zg==
X-Gm-Message-State: AHQUAub6jl/P5Gw5qHnVrn5ZWr+DnOJEdCjF3gAFU1N4tKFCfj44/Ad1
 KQ55iEz7F+zkljjAoY86slKGTHNOjl9TYu8bgX8/gg==
X-Google-Smtp-Source: AHgI3IbhNdX2Bg74RLwEkcrRhm1vApGLVElMs+TzLvz6uAt2lN8weU+z+0CEEofHxBAMRg2aie/EVF7GCI6DKXSyJXs=
X-Received: by 2002:a17:906:651:: with SMTP id
 t17mr7169879ejb.144.1550244581539; 
 Fri, 15 Feb 2019 07:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20190131213957.11568-1-alex.williams@ettus.com>
 <CAKfKVtFM1zPb-MjBwY8WREy4xoHW60JrjZ-LnSzBvJ1Yv_zgsw@mail.gmail.com>
In-Reply-To: <CAKfKVtFM1zPb-MjBwY8WREy4xoHW60JrjZ-LnSzBvJ1Yv_zgsw@mail.gmail.com>
From: Alex Williams <alex.williams@ettus.com>
Date: Fri, 15 Feb 2019 07:29:30 -0800
Message-ID: <CAJZzcDiv8BGDa8pj-2gP+BWiu=CfrsDi15xHr=UUFwCwE-E4zg@mail.gmail.com>
Subject: Re: [PATCH] i2c: cadence: Handle transfer_size rollover
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_072943_827280_9A045A19 
X-CRM114-Status: GOOD (  13.78  )
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
Cc: linux-kernel@vger.kernel.org, Alex Williams <alex.williams@ni.com>,
 linux-arm-kernel@lists.infradead.org, mical.simek@xilinx.com,
 linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 2:53 AM Shubhrajyoti Datta
<shubhrajyoti.datta@gmail.com> wrote:
>
> HI Alex,
>
> Thanks for the patch.
>
> On Fri, Feb 1, 2019 at 4:22 AM <alex.williams@ettus.com> wrote:
> >
> > From: Alex Williams <alex.williams@ni.com>
> >
> > Under certain conditions, Cadence's I2C controller's transfer_size
>
> Any help in reproducing the conditions would be appreciated
>
>
> > register will roll over and generate invalid read transactions. Before
> > this change, the ISR relied solely on the RXDV bit to determine when to
> > write more data to the user's buffer. The invalid read data would cause
> > overruns, smashing stacks and worse.
> >
> > This change stops the buffer writes to the requested boundary and
> > reports the error. The controller will be reset so normal transactions
> > may resume.
> >
> > Signed-off-by: Alex Williams <alex.williams@ni.com>


One possible related errata is here:
https://www.xilinx.com/support/answers/61664.html

In our case, we only needed to hammer on i2c to reproduce in a few
minutes, with a script like this:
while true
    do date
    cat /sys/class/gpio/gpio882/direction > /dev/null
    cat /sys/class/gpio/gpio883/direction > /dev/null
    cat /sys/class/gpio/gpio884/direction > /dev/null
    cat /sys/class/gpio/gpio885/direction > /dev/null
    cat /sys/class/gpio/gpio886/direction > /dev/null
    cat /sys/class/gpio/gpio887/direction > /dev/null
    cat /sys/class/gpio/gpio888/direction > /dev/null
    cat /sys/class/gpio/gpio889/direction > /dev/null
    cat /sys/class/gpio/gpio890/direction > /dev/null
    cat /sys/class/gpio/gpio891/direction > /dev/null
    cat /sys/class/gpio/gpio892/direction > /dev/null

    cat /sys/class/gpio/gpio894/direction > /dev/null
    cat /sys/class/gpio/gpio895/direction > /dev/null
    cat /sys/class/gpio/gpio896/direction > /dev/null
    cat /sys/class/gpio/gpio897/direction > /dev/null
    cat /sys/class/gpio/gpio898/direction > /dev/null
    cat /sys/class/gpio/gpio899/direction > /dev/null
    cat /sys/class/gpio/gpio900/direction > /dev/null
    cat /sys/class/gpio/gpio901/direction > /dev/null
    cat /sys/class/gpio/gpio902/direction > /dev/null
    cat /sys/class/gpio/gpio903/direction > /dev/null
    cat /sys/class/gpio/gpio904/direction > /dev/null
    cat /sys/class/gpio/gpio905/direction > /dev/null
done

In normal usage, we have code that sets up a number of i2c GPIO
expanders and pokes them for values as it initializes devices.
Occasionally, the transfer size register will roll over, and the ISR
will cause memory corruption, since it doesn't stop writing at the
requested boundary.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
