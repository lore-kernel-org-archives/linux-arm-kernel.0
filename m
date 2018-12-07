Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDA4C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:57:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F462082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JIOhQol6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VynMgugX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F462082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VTlfJG7t9QOOtsxq1z3icn4ATxm64WBjmBYPQDcAAjI=; b=JIOhQol6xBOKUf
	G7kkKI2g2e2I0P4PD7fYCvkCAhkG+mDPP0kSBStSY+L7gI6H16yD1FTZK/hqwabuMxPjIUda/C/pW
	XfAcAWEaKURldb3j5DdAbSmQF7Qt6Pa7eZj1Qx3jygY9a1duASnziU17Ikl7Vtnjc8Tb6bDlk+BtT
	RbYGNVy1SN6+IURiEuKnSlGEeiowoSBeQy7d3drlzI/JULYTIuBn1ivLuWAJPpEQgV/DJEP9VFAu0
	gPuGdRqWMRl6lKSqEcDR+pzqagZp7s/PlowAPvxJBtI5YMt6eNu69D0GiKK9m8UwIv0UDfaqCUtzx
	Wspo0ui+S/6ABKL/3efw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVO7T-0005bB-A4; Fri, 07 Dec 2018 21:57:11 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVO7O-0005a8-Qk; Fri, 07 Dec 2018 21:57:08 +0000
Received: by mail-oi1-x242.google.com with SMTP id h25so4613067oig.1;
 Fri, 07 Dec 2018 13:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+gkuNHo406Xx6IfmLiDSrYjRQqEJkUTAYr5tHeoComo=;
 b=VynMgugXjWLNsrw0ZDaPevXUsvTdmWXOCKY0gj5QLO5jaod3VOcgkTObT0ej2VXVA0
 Muv8tLwvhclMmpG1ZxcClvqQHsBLXeO5je5lurTu3nbENqnwil8p6dnmVpST/1TIsScl
 igo918SY0TQDG+JU5smHVIOuU5RQiBOy4K4uoRm3pGyqc9iRAJikmpeAZoSwgwzPqSZE
 7WoKSam8MoEXlN/5q52vmS68+8YDEOFJ3q8pYrAt6MTBrGH18IkuxNVQFLTU09rqMkv3
 /wekK2Z3qFw5C0TCCJbwVB/rUsFFHnJOdq8xyWnNb25pTJxft98ulPAviuxqcYBGT2FZ
 58UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+gkuNHo406Xx6IfmLiDSrYjRQqEJkUTAYr5tHeoComo=;
 b=IEgYF7BmTzIVuCXIjgD5Ab6DBgq1ZJF3Zck05CaWMlZtUUnDsC+MsRocfjZEitiYJ1
 hI514IkAW2pkyEfSVTZPp8BzMaNbgmBJkJ20Rn351+rEs1WzGOUjr7L/jNWT5GvbYdvb
 30l+LIjWH9nGdQ0sb1fgPTr2tJhGhUwDR8xr8PwCt7Ara1TEnjoRb6WIsWSQUgnl4y/Y
 +aV/BV+MZHF8YxG660w45dfLcqzAyUIgMYo50x7FdKMY3Xpm7Ju6JtCepL0usumZDc/V
 y31qHVLQ1jZSSb9mk65cBiEgE6pXZT+pad/caQcFTrd5nafvw0e60RH2l/BvEbdjC4FP
 BuAw==
X-Gm-Message-State: AA+aEWb47GR1LoerwhR9VETOZSDNfP3cIXPjw9T45pqVFGjiBzeIas31
 2tJ7ALwwL7qtfRv0osQFHlM42jguSZBa6R7qLWw=
X-Google-Smtp-Source: AFSGD/XVTHNyv7KLBjo0NkCbv1+kH7lDtOOpFgDbQnTfFbB0mDR5vKum/wLVlOnLjDCgRCVFt42M2FiL7wLAJ6xiEc0=
X-Received: by 2002:aca:5e85:: with SMTP id s127mr2344994oib.181.1544219814545; 
 Fri, 07 Dec 2018 13:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20181204160447.27869-1-ccaione@baylibre.com>
 <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
 <20181206124347.GA10676@ingrassia.epigenesys.com>
 <85973a9cd43c677ffa5c80853e86d79f36a9eb3a.camel@baylibre.com>
 <20181206155228.GA15225@ingrassia.epigenesys.com>
 <20181206185158.GA19901@ingrassia.epigenesys.com>
 <44c9eedf4dc2616645c2a49b080f42a493fe03fd.camel@baylibre.com>
 <20181207182845.GA3779@ingrassia.epigenesys.com>
In-Reply-To: <20181207182845.GA3779@ingrassia.epigenesys.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 7 Dec 2018 22:56:43 +0100
Message-ID: <CAFBinCD8uwm-MJ7gCSVRrjZ3ksahPE8oRrcw+TieaWes-Kbr=w@mail.gmail.com>
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
To: ingrassia@epigenesys.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_135706_896939_0B18E302 
X-CRM114-Status: GOOD (  10.37  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ccaione@baylibre.com,
 khilman@baylibre.com, robh+dt@kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Emiliano,

On Fri, Dec 7, 2018 at 7:28 PM Emiliano Ingrassia
<ingrassia@epigenesys.com> wrote:
[...]
> > All your test seems in show it the fact the Amlogic SoC usually prioritize the
> > TX traffic over RX, which is something we've known about for a while.
> >
>
> Is that normal and/or acceptable?
the public S805 datasheet mentions in the "Ethernet MAC" features
section (22.2) on page 120:
"RX FIFO 4KB, TX FIFO 2KB"
this suggests that

I did some tests using some Armbian 3.10 kernel on my Odroid-C1:
root@odroidc1:~# iperf3 -c 192.168.1.100
Connecting to host 192.168.1.100, port 5201
[  4] local 192.168.1.163 port 44297 connected to 192.168.1.100 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec  49.9 MBytes   419 Mbits/sec    0    809 KBytes
[  4]   1.00-2.00   sec  48.7 MBytes   408 Mbits/sec    0    809 KBytes
[  4]   2.00-3.00   sec  48.4 MBytes   407 Mbits/sec    0    809 KBytes
[  4]   3.00-4.00   sec  48.9 MBytes   409 Mbits/sec    0    809 KBytes
[  4]   4.00-5.00   sec  48.2 MBytes   406 Mbits/sec    0    809 KBytes
[  4]   5.00-6.00   sec  48.8 MBytes   409 Mbits/sec    0    809 KBytes
[  4]   6.00-7.00   sec  48.7 MBytes   408 Mbits/sec    0    809 KBytes
[  4]   7.00-8.00   sec  48.0 MBytes   404 Mbits/sec    0    809 KBytes
[  4]   8.00-9.00   sec  48.1 MBytes   403 Mbits/sec    0    809 KBytes
[  4]   9.00-10.00  sec  48.1 MBytes   404 Mbits/sec    0    809 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-10.00  sec   486 MBytes   408 Mbits/sec    0             sender
[  4]   0.00-10.00  sec   485 MBytes   407 Mbits/sec                  receiver

iperf Done.
root@odroidc1:~# iperf3 -c 192.168.1.100 -R
Connecting to host 192.168.1.100, port 5201
Reverse mode, remote host 192.168.1.100 is sending
[  4] local 192.168.1.163 port 44301 connected to 192.168.1.100 port 5201
[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-1.00   sec  87.5 MBytes   734 Mbits/sec
[  4]   1.00-2.00   sec  89.2 MBytes   748 Mbits/sec
[  4]   2.00-3.00   sec  89.0 MBytes   747 Mbits/sec
[  4]   3.00-4.00   sec  88.9 MBytes   746 Mbits/sec
[  4]   4.00-5.00   sec  89.2 MBytes   748 Mbits/sec
[  4]   5.00-6.00   sec  89.0 MBytes   747 Mbits/sec
[  4]   6.00-7.00   sec  88.5 MBytes   742 Mbits/sec
[  4]   7.00-8.00   sec  88.5 MBytes   742 Mbits/sec
[  4]   8.00-9.00   sec  88.5 MBytes   742 Mbits/sec
[  4]   9.00-10.00  sec  88.2 MBytes   740 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-10.00  sec   889 MBytes   745 Mbits/sec    0             sender
[  4]   0.00-10.00  sec   887 MBytes   744 Mbits/sec                  receiver

iperf Done.
root@odroidc1:~#

[...]
> Furthermore, as Martin reported in one of the previous mail,
> even Amlogic's buildroot kernel uses an edge rising IRQ type
> for the Meson8b MAC. Other evidence that is not so clear
> the need for the first patch on 32 bit Meson SoC.
please note that the dwc2 USB controllers are also using
IRQ_TYPE_EDGE_RISING in Amlogic's 3.10 kernel.
mainline on the other hand uses IRQ_TYPE_LEVEL_HIGH after your commit
291f45dd6da5fa "ARM: dts: meson: fixing USB support on Meson6, Meson8
and Meson8b"
what I want to say is: in some cases we need to use different settings
than the 3.10 kernel!


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
