Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCAEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:58:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196502086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k1BgGK2I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIj0WZ80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196502086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bNh9eKT6OAk+CuQElYQs2hqNIR3G3Wvwj/TDAkS/xek=; b=k1BgGK2IY7mBUveKhEUUcGJ8X
	TlnEd+ZCfiqnci0iKQnw6kNwvBnxaDItaw5PWbouaOMJn4UQtkoUoJs6lQV9XL7kkmTp50gvH05aP
	+L3AOF+l4DEazMdRxEPKOVMwtKWCd3fnbtV1RVXg+Bdrf5AELUbn1y6YIrTpXBv0+EJZrEJb2AcHy
	xCwwL9UVIsaZjsELABpQW9rjELrEvaK4vwZAAB3RFoXbEW80GSb2MzIb0dTJydukcvwMAjzQVrbTF
	AFfeoXG0zVDBofFp3ykSXWS815bveE2NHCobutYUK8M5IVOq4ukswp60dGg/HZhBSWSyq2qvhYU2l
	+GgPe7H5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYBOB-0003VC-HH; Sat, 15 Dec 2018 14:57:59 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYBO8-0003UA-5D; Sat, 15 Dec 2018 14:57:57 +0000
Received: by mail-pf1-x442.google.com with SMTP id c72so4244432pfc.6;
 Sat, 15 Dec 2018 06:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+oZ8yQFI+tBK9p+3AmPM+g1VsW4TbnbAmenwuop//G4=;
 b=RIj0WZ80o7T2oHJfoXbW9K4AtxUB63cORHEymtuAvPEAZyvmHU1AiqS+D/AOG/OpgA
 /qaj5KgYoCk0lANaiuRgovG580UsEkQLNhpLtPPGlY7yomrn6RTPmiSzgQq6ojrw8E+I
 hmdIcyTnZyTYtX8UDxxM/L/uPOTdV83REEfN9AxruIQSn9dfDIVeYBAmyAFAtfwZtJ+p
 JRJLJ4Aizqf+li42qP3OJiqUFZyytKB03+JFwtN17H3umAV2ca1fp/ACWQBNWoVMVvox
 ZC/t2aDW9t595Byanw8sCCuwX9QzkIvWTuKZ2YSSk7pfpDE40oZVW2iIPQIEO4BKUHwM
 Bmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+oZ8yQFI+tBK9p+3AmPM+g1VsW4TbnbAmenwuop//G4=;
 b=FkI8dkMReXJ12KoGByaQ5zeBngpaWwJ1u3UNqP2KJ1TzJ+zAQ60NPsSIx82bGaOWaJ
 vBknGuoVp07XYaUVSKeWuS9N14JQqWwiVA7//XfWnjLMMjllIfpNjY6GWTg7oxxzIW/+
 WhqBnPMVLB6yVubVpzqajziZRYzfGinxqxjgmRmWAuFcjO3/N2SAxNZ9bPtPFJfXyIcR
 Zm+XTScenislYH3/gnWP1Jurs5IsZTTGBoAUUx+GThsLMhR2g85GAiwL3rni5ETIXA22
 rTuHr+6wMXRDvJCFOJwXwvak3b3y80osA9MbmWuMTxpAHbSsBkyABsPtvxj5JY7uXHjh
 4ymA==
X-Gm-Message-State: AA+aEWbhIOf8f0VQFQeioNxzDkVOgcLNrtjJgA5linUd7H2QeaUyuNot
 yGCvbFzIWcZ/tSksb3V0C+MxVtlg
X-Google-Smtp-Source: AFSGD/USDnpzPISPYb8ceeqq0IFsuHp/zdAef1v0Hz7qxMBl11J60Ik5z/YP0tmNfqnQuNuiAm3znA==
X-Received: by 2002:a63:9041:: with SMTP id a62mr3012889pge.163.1544885865326; 
 Sat, 15 Dec 2018 06:57:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 z191sm9077804pgd.74.2018.12.15.06.57.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 15 Dec 2018 06:57:44 -0800 (PST)
Subject: Re: [PATCH 3/6] sparc: remove the sparc32_dma_ops indirection
To: Christoph Hellwig <hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-4-hch@lst.de> <20181215063018.GA11415@roeck-us.net>
 <20181215104720.GA1575@lst.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <53761fd8-06f1-6443-1997-f518e725925e@roeck-us.net>
Date: Sat, 15 Dec 2018 06:57:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181215104720.GA1575@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_065756_206812_CE50812A 
X-CRM114-Status: GOOD (  13.77  )
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
Cc: linux-parisc@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
 Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>,
 iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/15/18 2:47 AM, Christoph Hellwig wrote:
> On Fri, Dec 14, 2018 at 10:30:18PM -0800, Guenter Roeck wrote:
>> and so on, until qemu is terminated. This is seen with all sparc32
>> qemu emulations. Reverting the patch fixes the problem.
> 
> Hi Guenter,
> 
> can you check which of the three new ops is used in this case?  Or
> provide the qemu config and rootfs?
> 

sparc32 defconfig+CONFIG_SQUASHFS=y+CONFIG_DEVTMPFS=y, and:

qemu-system-sparc -M SPARCClassic -kernel arch/sparc/boot/image \
	-no-reboot -snapshot -drive file=/var/cache/buildbot/sparc/hda.sqf,if=scsi,format=raw \
	-append 'root=/dev/sda rw init=/sbin/init.sh panic=1 console=ttyS0' \
	-nographic

qemu version doesn't seem to matter. I used gcc-7.3.0 using the toolchain from kernel.org
to build the image.

Root file system is at https://github.com/groeck/linux-build-test/tree/master/rootfs/sparc/.

Guenter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
