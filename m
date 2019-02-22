Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E379CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:11:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3D0207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fLREF1cG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3D0207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wW0+A02x+XJQCg/R1X1EeSKbFDvNLvAXBNzAP8zGgYM=; b=fLREF1cGD1cAKq
	c6lrdcM/j/qaOYAD/dAK+POCSlbJsh3Ep29Ekiowh0dTrX5akC2rcWifeHDdtAPlMZ8XMMTCvqFzI
	RebY6/ObpmI+37+dUmXqbcFDKsoQPTwoSdyPHsCxGSdtEuUnk4G0OkE0vGPuwf+z7LD4vI1qUWxPS
	J5Nq+YqEIMbbsZxJJLY+8W7HWgR8s2KDX+08ANlsR/leJI/KuUKcPMVlH0qiZC2EYF6YXDgJD5B27
	H1AlUAR8U0NT2mm1YA6qkb1GmKNI1VrxXQCOff2Cg93NOa3g1aWtWQ3yl38S+xEUP+epGMLIZR1Fb
	Ev4VxMzCgQV9icJ/WNCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBXf-0006e8-WD; Fri, 22 Feb 2019 14:11:08 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBXc-0006dg-R5; Fri, 22 Feb 2019 14:11:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8DF1A78;
 Fri, 22 Feb 2019 06:11:02 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C82FA3F690;
 Fri, 22 Feb 2019 06:11:01 -0800 (PST)
Date: Fri, 22 Feb 2019 14:10:59 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Pintu Agarwal <pintu.ping@gmail.com>
Subject: Re: arm64 Kernel build for qemu-system-aarch64 ?
Message-ID: <20190222141059.GJ42419@lakrids.cambridge.arm.com>
References: <CAOuPNLhDtRJDBnwuV1kQ47Zd9B00qh2bXDNQvh9tXfTyYqAWDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOuPNLhDtRJDBnwuV1kQ47Zd9B00qh2bXDNQvh9tXfTyYqAWDQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_061104_884618_564A18BD 
X-CRM114-Status: GOOD (  13.55  )
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
Cc: linux-riscv@lists.infradead.org, open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 07:17:00PM +0530, Pintu Agarwal wrote:
> Hi All,

Hi,

> I want to build Linux Kernel 4.20 for arm64 and use it on qemu-arm64.
> I see that there is a defconfig available in arch/arm64/configs/defconfig
> But I am not sure whether it will work for qemu-arm64, and by default
> which machine type is supported.
> 
> I already have working setup for qemu-arm for both versatile and
> vexpress machine. There is already a defconfig available for these
> under arch/arm.
> So I can build the kernel for it.
> 
> But, whether these defconfig are supported for arm64 ?
> If anybody have setup for qemu-arm64 kernel, please share the steps.
> About rootfs, I am planning to use the arm32 version of busybox itself.

The arm64 defconfig is intended to work for all platforms.

I use that with qemu's '-machine virt'. Assuming you use virtio-net and
virtio-block, no additional drivers are required.

For example, I can boot a defconfig kernel using the followign QEMU options:

qemu-system-aarch64 \
        -m 2048 -smp 4 \
        -net nic \
        -net user,host=10.0.2.10,hostfwd=tcp::65022-:22 \
        -nographic \
        -no-reboot \
        -machine virt,accel=kvm,gic_version=host \
        -cpu host \
        -hda ${FILESYSTEM} \
        -snapshot \
        -kernel ${KERNEL} \
        -append "earlycon root=/dev/vda panic_on_warn"

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
