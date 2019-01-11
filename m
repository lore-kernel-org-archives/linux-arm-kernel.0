Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5704C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:43:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2C220657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LDJMeZbw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="v+ogUNkp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="bQt1nTdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2C220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5+9ABhUvCncKUYOx49Dt8iY+2AX2caSALwv4SWTy8fY=; b=LDJMeZbwaydNeN
	uBQ7iecnCRaiXJSt1RgZYv2wmoCI8x+kTwZW4VbF7mqbZV26u0nY9t2Jx6um7UXKWI9o3DZMZqX2/
	xUSy9kp6zB2ICq+IIgF6pxadKAq8TEtgIkFbOsHb41eDM7PhSyEB59eeXAO/7Ar2EF69Rhxm9YPAD
	fxcqFUcCTTiDXk+R9nbVuP7Erg+VaQ0zTJK+3amqB93lVyHceTD/yTeHYbfbHeJvV/OaIkIJorSFg
	0oh2bywYYlRNdJz5DYHf7/sr9Rebo1WVLo2ouo3KDqFo5YV6yhAG+8vFFItpOBMOGyxg/XIJ1+Aab
	ULMRkPX2oPzIRRgDfipg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghzuU-0001D2-7w; Fri, 11 Jan 2019 16:43:54 +0000
Received: from mx07-00252a01.pphosted.com ([62.209.51.214])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghzuQ-0001Bw-3t
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 16:43:52 +0000
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
 by mx07-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0BGXXOF021736
 for <linux-arm-kernel@lists.infradead.org>; Fri, 11 Jan 2019 16:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org;
 h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pp; bh=FAFFVvs2vAHaVVm0ozGiHUmZcvZSzccWBOXa8aa7ebs=;
 b=v+ogUNkpVlyNiVlepmnniYIbc4NjjjUGvk8xncNbAoMcJe0MCsqvsZk+tzEHGMZEEDXA
 ojHoSQCdNovmrjQB6zn5x1TiiXGHpmgMOfv8QyoHSAN+umBcZtn2asY9lQKuvxuImKgm
 oeW9lOfILp9a7FjvTIMyo4Vyg5FdKCBT9czpG6K2Q6WRd+pBHVBiIxKW3MPbUiai8MGZ
 7eOC4onuRtL0cSRhh5Zp4QzGIZvh0wckORShPUeZCvNDlavSZfZJLoiSUUU7Q3e4dMJA
 LkJH5bjrZ2XHmklifIfvM6//quQ1FNLkzbWXS6WsxZ0SmM2xG+06YRF8/RuUAVQtD8MM NQ== 
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx07-00252a01.pphosted.com with ESMTP id 2ptjv43438-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <linux-arm-kernel@lists.infradead.org>; Fri, 11 Jan 2019 16:43:43 +0000
Received: by mail-pl1-f198.google.com with SMTP id v2so8557156plg.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 08:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FAFFVvs2vAHaVVm0ozGiHUmZcvZSzccWBOXa8aa7ebs=;
 b=bQt1nTdXhHXR/EvbFwpbLQYDmQk1gWZFMzTzpeN14Qc94u0Ok3XRZDw71FwUF2MVMR
 FnwDK/yZggzsAC6u9bTHAiWL/QVXg4FvzI68WEdsFXYmbP69OONEamarfXoGBSlMOj7m
 ZTNS0Zf/uvHmLoethanuLpoiUzzA2DB5qo/44vLYWQAUQutcka2ZhNfX+fGFfzuU8oPz
 yYOe0gkidNcI2ac7gW0savvskw6P1zwpHNqAJVXd7EKb+21+zySnbP6xJL4nCUAFt0Tp
 UBKkYWzkZsxeCcWztytRm/TOHdB2H0N6iHEg1h+UvUzec+rvG1FOouusKVWLRkC1Skof
 c6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FAFFVvs2vAHaVVm0ozGiHUmZcvZSzccWBOXa8aa7ebs=;
 b=ImCdXaOylC8UPoJE0jSTpyO10hIgxxzLTjyCcePX/s06CR6xY76+HUkehnUizTjk7r
 VCR5PJMUYrXODhl6VpIqk+69Xi8UBNWdyefhHvIpNvDgqtsNBf1JxuypnU5YLUxSAcz6
 YVsC8X7VJF5/jPs/Qj4sJf2tyP3tLITQLONfnkTWZck6mfBpPHiZ0/ZzA7rI79z/hqt4
 GyxKasI9AbINe1/+sLnY1gTgcswACHXbbjyiyQVAx6K9uvAEZ6dBN3fcFNl7t3acgEip
 eW1LFiLY6JFwvRZGn1ghMkSCMUSHpzXJQ1BbqfNdnphwVEcVtrG6P8Q24Sf6ZIVN5dLE
 mlyw==
X-Gm-Message-State: AJcUukcXfXsFzYp1NstvMYXoXmRGSoL1B17tN/7kx0MsMwWuldBurEmN
 lexh65s9j7gR1gET0ymAkpd9iTDLL3gUN4wXR45/1KcXm+6or6X8mjYatsUPg4jYPfCcJ9149ef
 /4zVsbAWxPUgug6w/zI/r4tJUsz8gMdcD1yv0nGv4biaG9zKQVw==
X-Received: by 2002:a62:3adc:: with SMTP id v89mr15034500pfj.109.1547225021181; 
 Fri, 11 Jan 2019 08:43:41 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5eA9KvdfGBwmtsOe9W49KHfzeRhkpqrQSR52iubhyQLUNuCtxLP0gM/Az8YOM24aRBrqpLDjPOLJNFArmu2+w=
X-Received: by 2002:a62:3adc:: with SMTP id v89mr15034491pfj.109.1547225020864; 
 Fri, 11 Jan 2019 08:43:40 -0800 (PST)
MIME-Version: 1.0
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
 <849520506.312349.1546937289972@email.ionos.de>
 <CALeDE9OYZi+LZCtnm3kZQ2g5oJ1BWXgfoX0MBD4X0Bz2Vj9Tng@mail.gmail.com>
 <389675377.186771.1546942833612@email.ionos.de>
 <CALeDE9PPt8yTF1FLioxz0C1kJZDYn1uYH-MoBii2Ewpo-yC3tg@mail.gmail.com>
 <2090321804.324042.1547101471247@email.ionos.de>
 <CALeDE9Nzibm=GUfUDKm=d8Zu1fR7J0t-UXMAysmBHxN0oKd-Zw@mail.gmail.com>
 <528752360.347624.1547146121882@email.ionos.de>
 <CALeDE9OZpGVD4HGxCqjtWf1qCXxkH1YAAM28na7tBvFyRpHJow@mail.gmail.com>
In-Reply-To: <CALeDE9OZpGVD4HGxCqjtWf1qCXxkH1YAAM28na7tBvFyRpHJow@mail.gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.org>
Date: Fri, 11 Jan 2019 16:43:27 +0000
Message-ID: <CAAoAYcNUp2fjdqHgae6wTaL6i7ztfn4zUxri1EjbBatgQb76NA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
To: Peter Robinson <pbrobinson@gmail.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-11_09:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_084350_486859_739401DF 
X-CRM114-Status: GOOD (  24.00  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
 tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, mikebrady@eircom.net,
 Eric Anholt <eric@anholt.net>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>, nsaenzjulienne@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Peter

On Fri, 11 Jan 2019 at 06:10, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Stefan,
>
> > > > > I get difference results with 5.0-rc1 but neither of the above apps
> > > > > work either, will follow up based on the rest of the thread there.
> > > > >
> > > >
> > > > My first step with Raspbian is to enable the Camera interface which results into an appending of the following lines to config.txt:
> > > >
> > > > start_x=1
> > > > gpu_mem=128
> > > >
> > > > AFAIK a smaller value for gpu_mem wont work. Please provide your settings which results in this crash.
> > >
> > > start_x=1
> > > gpu_mem=64
> >
> > even with those settings i'm getting a picture in qv4l2 (v1.12.3) and no crash.
> >
> > According to dmesg i also have 64M reserved for CMA. How many do you have?
>
> I have 192Mb of CMA with LXDE, the vc4 driver uses CMA rather than the
> gpu_mem via the firmware so that's what we set it to (and to 256Mb for
> GNOME)

As Stefan says, with Raspbian the default gpu_mem to use the camera is 128MB.
The memory required depends on your use case as it includes the
buffers for the output images.
Checking on a running system, a V2 camera streaming 1080P YU12 with 3
V4L2 buffers is using 58MB of gpu_mem for the camera stack. H264
encode isntead of YU12 and it's around 63MB.
With the vc4 driver loaded there's only a small number of other
allocations left from the gpu_mem heap, so it's around the 70MB mark
that will be the minimum to get the camera running.

> > Does your qc4l2 make use of OpenGL (not in my case)?
>
> Yes, mine does. The crash with qv4l2 was only when I tried Cheese
> first, if I reboot and just use qv4l2 it works fine when configured
> with 128Mb without any crash. Which display driver are you using? Are
> you using vc4 or the proprietary closed one? With vc4 using cma rather
> than gpu_mem I wonder if we can reduce the amount needed there, but in
> the interim I've at least now got picture output when using purely
> qv4l2 and a reserve of 128Mb
>
> I'm not sure quite what gstreamer1/cheese is doing to cause that crash.

Can you confirm what resolution and format they are using in your
failure case? "v4l2-ctl -V" after they've been run will tell you.

Your earlier request:
> As a side note it would be a useful debug feature from a support PoV
> if the following line could also note which firmware is loaded:
>
> [    8.087691] raspberrypi-firmware soc:firmware: Attached to firmware
> from 2019-01-09 20:07
>
> Something like "attached to extended/reduced/whatecer firmware from XXXX-XX-XX"

A very valid suggestion.
I've made the firmware changes to advertise the build variant and
firmware hash via the mailbox service, and that should be in the next
firmware release.
Pull request https://github.com/raspberrypi/linux/pull/2806 has added
the Linux kernel changes to our kernel rpi-4.19.y branch.
With the updated firmware, "vcgencmd version" will also report the
build variant for you.

  Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
