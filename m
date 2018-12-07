Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A43C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:06:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785D120838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="APBltVTO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="J3ffpUGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785D120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=akFG95XeH3g8ujxlcT8rnChM8HCrcpe52MO1KpURKIU=; b=APBltVTO7m+nZ6
	bJ/RmQoA8hDgTJHU/LCLCaaa8CUfEAoSISaDulIvMhSAJJGL8p+ETujn4XsPBP/XYyHWkDpm49I/I
	EMxO8O9FZT6eeiWi7j9xe4NpBGznW4xzg69yfkigADjjJpuAocv3VPETVYNvsqPArEPZUTNvv8Ypt
	lXdwqp7IDkBOZ91zpXhQWUxy9lWpXbmIels/RFYxFWmwGmAAJlIMtHdIJEeEYdfpr2QHplPm/e/wF
	Lw0uExcLGYfvN40RAkm1vfP3ttPkwIl5lIsFpB3qjHhpXJ0twriHpGWilTSPpPaiLpU3pDrYa536u
	qAfvG2Y5P3Or0M/98a4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVOGb-0000YR-0e; Fri, 07 Dec 2018 22:06:37 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVOGX-0000Xe-IF; Fri, 07 Dec 2018 22:06:35 +0000
Received: by mail-ot1-x342.google.com with SMTP id 81so5243586otj.2;
 Fri, 07 Dec 2018 14:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OzcRRM7D/K6vI0IdDBU7jni1K/eJIkMnK9AG49v+XfM=;
 b=J3ffpUGVRMHCuBiSU12eDAptqVrGk5pFQaTw3O7r8r8wYPQyfjJx6GIYOF8Sw10viU
 ve0CUTH8Fy/pG5Pk6qFhCwci211BQWHHtQHouQZM/ycyfMYL/Icy+CwF9TW2isRtPLK1
 7JTYFnfFP0qcBBW86SMCC7EwVBByQgOlrzDKqjXwyuG6O/d5cHXSY2nvkZp6x6XwcWvI
 VMi1Ro9ckQ3x7bN+qe3D7Sit8IT9nSlqZya3uHK2g2Ps079r/So9LHyboD1tAcC6ytGx
 QvLsiScWUOIgopzRqywDPschEAuz9Gz7Xc5O4xlFMYTOrHjTZW6LB8q70Oh3w5p/sveR
 wy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OzcRRM7D/K6vI0IdDBU7jni1K/eJIkMnK9AG49v+XfM=;
 b=RmM7/YQ6Kn8/SPjxVUAO8vVwj/7nzJg0QYc7pIlY1Lnfws35VutvGWF9R5pCn5PrWI
 2eS6AqCQAy17CV0NWRfp2aJRSzbAvryinHyqvPt9sSEh8G9R/kPm5N20Xn36GKiV8Di2
 IKxYzolGRdnycCOrHJWVxsEUKDzehvfwAjQUyaQj6Awwly9dwiNUWcYHfdBQXk1EwLTl
 2D0QBDrWyAmsopyXxkWAzpm0dCYm0szIwXFnuYmOSh8dLHjNg690ExsrWXxifAj4+o/2
 PI/oCiS/HmgU2Omthrwhan/ooKYgVhuGTsYM7ba94HQbIftmne7TNN05sD0176AxBs2a
 Fn9Q==
X-Gm-Message-State: AA+aEWYOSRwhSIemvIHEoe15L89jkf7x4MgyDySrbfNn7P1ppQr6Dmoo
 PXVMvRuyIXaRyT2CGM9CDDhJ6H1ypEL40hMSjzE=
X-Google-Smtp-Source: AFSGD/WFL3Fx4q5BTXr2worqKl9Pmpud+x88m+X3KgCXaMSzdBH517p3Rv8Gjh48RI+6l/4nIiffSNUqdDBw92UsO4Y=
X-Received: by 2002:a9d:6a8e:: with SMTP id l14mr2528207otq.348.1544220382485; 
 Fri, 07 Dec 2018 14:06:22 -0800 (PST)
MIME-Version: 1.0
References: <20181207105231.25593-1-ccaione@baylibre.com>
 <20181207105231.25593-3-ccaione@baylibre.com>
In-Reply-To: <20181207105231.25593-3-ccaione@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 7 Dec 2018 23:06:11 +0100
Message-ID: <CAFBinCBCO5ZOQPRQd4WvW9FPajqdhuTZGO0L07pMX8+6VO4aEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm: dts: meson: Fix IRQ trigger type for macirq
To: ccaione@baylibre.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_140633_603932_3FE0A837 
X-CRM114-Status: GOOD (  12.43  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, khilman@baylibre.com,
 robh+dt@kernel.org, ingrassia@epigenesys.com,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Carlo,

On Fri, Dec 7, 2018 at 11:52 AM Carlo Caione <ccaione@baylibre.com> wrote:
>
> A long running stress test on a custom board shipping an AXG SoCs and a
> Realtek RTL8211F PHY revealed that after a few hours the connection
> speed would drop drastically, from ~1000Mbps to ~3Mbps. At the same time
> the 'macirq' (eth0) IRQ would stop being triggered at all and as
> consequence the GMAC IRQs never ACKed.
>
> After a painful investigation the problem seemed to be due to a wrong
> defined IRQ type for the GMAC IRQ that should be LEVEL_HIGH instead of
> EDGE_RISING.
>
> The change in the macirq IRQ type also solved another long standing
> issue affecting this SoC/PHY where EEE was causing the network
> connection to die after stressing it with iperf3 (even though much
> sooner). It's now possible to remove the 'eee-broken-1000t' quirk as
> well.
I tested this on my Odroid-C1. however, I must admit that I never had
issues *without* eee-broken-1000t on any of my boards

without your changes:
[root@alarm ~]# iperf3 -c 192.168.1.100
Connecting to host 192.168.1.100, port 5201
[  5] local 192.168.1.194 port 38870 connected to 192.168.1.100 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  80.6 MBytes   675 Mbits/sec    0   2.78 MBytes
[  5]   1.00-2.00   sec   108 MBytes   904 Mbits/sec    0   3.04 MBytes
[  5]   2.00-3.00   sec   106 MBytes   891 Mbits/sec    0   3.04 MBytes
[  5]   3.00-4.00   sec   105 MBytes   880 Mbits/sec    0   3.04 MBytes
[  5]   4.00-5.00   sec  65.0 MBytes   545 Mbits/sec    0   3.04 MBytes
[  5]   5.00-6.00   sec  92.5 MBytes   777 Mbits/sec    0   3.04 MBytes
[  5]   6.00-7.00   sec  72.5 MBytes   608 Mbits/sec    0   3.04 MBytes
[  5]   7.00-8.19   sec  76.2 MBytes   537 Mbits/sec    0   3.04 MBytes
[  5]   8.19-9.00   sec  48.8 MBytes   504 Mbits/sec    0   3.04 MBytes
[  5]   9.00-10.00  sec  87.5 MBytes   736 Mbits/sec    0   3.04 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   842 MBytes   706 Mbits/sec    0             sender
[  5]   0.00-10.05  sec   839 MBytes   701 Mbits/sec                  receiver

iperf Done.
[root@alarm ~]# iperf3 -c 192.168.1.100 -R
Connecting to host 192.168.1.100, port 5201
Reverse mode, remote host 192.168.1.100 is sending
[  5] local 192.168.1.194 port 38874 connected to 192.168.1.100 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  21.0 MBytes   175 Mbits/sec
[  5]   1.00-2.00   sec  20.7 MBytes   174 Mbits/sec
[  5]   2.00-3.00   sec  22.4 MBytes   187 Mbits/sec
[  5]   3.00-4.69   sec  25.2 MBytes   125 Mbits/sec
[  5]   4.69-5.00   sec  7.56 MBytes   206 Mbits/sec
[  5]   5.00-6.00   sec  23.4 MBytes   196 Mbits/sec
[  5]   6.00-7.00   sec  14.6 MBytes   123 Mbits/sec
[  5]   7.00-8.00   sec  23.3 MBytes   196 Mbits/sec
[  5]   8.00-9.00   sec  27.8 MBytes   233 Mbits/sec
[  5]   9.00-10.03  sec  24.9 MBytes   203 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-9.36   sec   212 MBytes   190 Mbits/sec  1588             sender
[  5]   0.00-10.03  sec   211 MBytes   176 Mbits/sec                  receiver

iperf Done.
[root@alarm ~]#

with your changes:
[root@alarm ~]# iperf3 -c 192.168.1.100
Connecting to host 192.168.1.100, port 5201
[  5] local 192.168.1.197 port 45020 connected to 192.168.1.100 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  74.4 MBytes   624 Mbits/sec    0   2.75 MBytes
[  5]   1.00-2.00   sec   105 MBytes   881 Mbits/sec    0   3.03 MBytes
[  5]   2.00-3.00   sec   106 MBytes   891 Mbits/sec    0   3.03 MBytes
[  5]   3.00-4.00   sec  78.8 MBytes   661 Mbits/sec    0   3.03 MBytes
[  5]   4.00-5.00   sec  73.8 MBytes   617 Mbits/sec    0   3.03 MBytes
[  5]   5.00-6.00   sec  87.5 MBytes   735 Mbits/sec    0   3.03 MBytes
[  5]   6.00-7.15   sec  81.2 MBytes   594 Mbits/sec    0   3.03 MBytes
[  5]   7.15-8.00   sec  61.2 MBytes   603 Mbits/sec    0   3.03 MBytes
[  5]   8.00-9.02   sec  76.2 MBytes   625 Mbits/sec    0   3.03 MBytes
[  5]   9.02-10.00  sec   102 MBytes   880 Mbits/sec    0   3.03 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   847 MBytes   710 Mbits/sec    0             sender
[  5]   0.00-10.05  sec   846 MBytes   706 Mbits/sec                  receiver

iperf Done.
[root@alarm ~]# iperf3 -c 192.168.1.100 -R
Connecting to host 192.168.1.100, port 5201
Reverse mode, remote host 192.168.1.100 is sending
[  5] local 192.168.1.197 port 45024 connected to 192.168.1.100 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  22.6 MBytes   190 Mbits/sec
[  5]   1.00-2.00   sec  19.3 MBytes   162 Mbits/sec
[  5]   2.00-3.00   sec  22.1 MBytes   185 Mbits/sec
[  5]   3.00-4.00   sec  29.6 MBytes   248 Mbits/sec
[  5]   4.00-5.00   sec  30.1 MBytes   253 Mbits/sec
[  5]   5.00-6.00   sec  16.7 MBytes   140 Mbits/sec
[  5]   6.00-7.00   sec  21.5 MBytes   180 Mbits/sec
[  5]   7.00-8.00   sec  14.0 MBytes   118 Mbits/sec
[  5]   8.00-9.04   sec  20.4 MBytes   165 Mbits/sec
[  5]   9.04-10.00  sec  19.6 MBytes   171 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.04  sec   217 MBytes   181 Mbits/sec  1795             sender
[  5]   0.00-10.00  sec   216 MBytes   181 Mbits/sec                  receiver

iperf Done.
[root@alarm ~]#

RX and TX speeds are within 10Mbit/s before and after the test, so I
would call the result "identical" (within a bit of measurement
tolerance)
I'll wait a few days and see what Emiliano finds out on his board,
then I'll send my Tested-by and Acked-by


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
