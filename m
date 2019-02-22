Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB11C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:51:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C26120700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jPau0IsL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We65ejXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C26120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qOEOVwSC+kbnKjxLlO24V9xNjK9kGY6NSQVVjiHHe3k=; b=jPau0IsLld0eK/
	yzH8gEOLdf6nXL1wgwrwVOlGPe/TKHaKlqhUjzf/iBATlfmiXWUQ+dcf9K5+T4G1VZrmtOlajnpk5
	ZoT1/p5I4OBa49Cvb8TAkDGG/UKpz2nLz9FT2d/vhWZpfIuOwFmUkcbs2hEnX621GQI2W6so+eoQh
	v3f5UcoNrrtCijSDu8FOfccBbFusO7/Aavcubl2sx/qTdQRUShW3dEO0p5W6Bhgllcq0R8D4Dfdp/
	4/TFpLywIxOPe2uWhECntqdfSDWm4btot+VllMAutxh8s6xZwSvsLqeeivzeMFbt6h17NEVV81TtI
	EL3H43KJnkvy61oOP2VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxE2H-0004NA-7X; Fri, 22 Feb 2019 16:50:53 +0000
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxE2B-0004MQ-Sk; Fri, 22 Feb 2019 16:50:51 +0000
Received: by mail-vk1-xa41.google.com with SMTP id e131so630638vkf.10;
 Fri, 22 Feb 2019 08:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r+ptFvJ18N0UnrAzJS/StVWMlNtZYWTc8hvWf6ejkBs=;
 b=We65ejXbgJU3m0qEqWdZ5pkgpwzViF7OafNrhV1Fu+TJ6nid9Fq/eOuhV1Myp65GvN
 9halQAbpVVdhVo4Lqnc7zataJNvTlR/h15ECHkgErA/AOLXa8gEQyxyu8XdP+T4zAMos
 RiyA9iEL3xBQNHbxaNElyxPKYjq+K/pPTpfWUcgEECihXGU9DNN3tYV+mj5OgH2NC++2
 to8ReVSG3DJsozn7TzPJ/jQ1I6G2ZnNKRVGKBMAuGi+Fs0daqOBKXvWfUnBjqDHMk0bF
 z+f3lkKHnGgiVt/hesbj1ez1OoBegWQuKJmoTVGtIuex382aUQGKzLXW7UYyaxYL2bNT
 uaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r+ptFvJ18N0UnrAzJS/StVWMlNtZYWTc8hvWf6ejkBs=;
 b=du6zv/hRI+xbw7cTjotdLxXlXLthxQNZEKyivPJV246elQXo93ZKf79UXAteabvVfO
 j2YkQZOzQGSnMnsyJ4XkUztG2yvWYm/FxJzqJ54BL8Jwgb0C9TyVix7BhO9Y1LA8O3ip
 T/jDWzH0XUjc7lcWTamV5B9FA5VXZddtMvHqZLL2I1Ssnox+5YN0i8txIizgIv+ndXgC
 QZBIib+FItFEpizdnBcwbYKC7xN/iakbrhUNLmBV051GNtyEoayqJENp/jaSzJ0xCnl8
 UIyIJInoTI8NFz8Jl8sTE8JuXyKPAI/NBvznyTfr6dHTKAok4H1LVmcwzW0rgYyCjfTd
 zc4g==
X-Gm-Message-State: AHQUAuZDoyHbzNGujSqn8SGcnJstIHyVgqko0gL19Gq8/0Warmb0p696
 oV/J90J52TndiVSVcyEzmwbCy0cTu9gfCzMUvPVMcw==
X-Google-Smtp-Source: AHgI3IYIqZ4L0j4TdzyxEehdq3XbpGtscHTZl6FHyUapP+jJ8S76S2SeCLhQ2/SNvNgZJbCpqeywfit6lXKg7gOlR6U=
X-Received: by 2002:a1f:a986:: with SMTP id s128mr2668480vke.53.1550854246377; 
 Fri, 22 Feb 2019 08:50:46 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLhDtRJDBnwuV1kQ47Zd9B00qh2bXDNQvh9tXfTyYqAWDQ@mail.gmail.com>
 <20190222141059.GJ42419@lakrids.cambridge.arm.com>
In-Reply-To: <20190222141059.GJ42419@lakrids.cambridge.arm.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Fri, 22 Feb 2019 22:20:35 +0530
Message-ID: <CAOuPNLixfZUzVyv4uHzwWPXWQmCYwNUtTOtNXFwOg8aPZda3aw@mail.gmail.com>
Subject: Re: arm64 Kernel build for qemu-system-aarch64 ?
To: Mark Rutland <mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_085049_867322_206FA73B 
X-CRM114-Status: GOOD (  15.65  )
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

On Fri, Feb 22, 2019 at 7:41 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Feb 22, 2019 at 07:17:00PM +0530, Pintu Agarwal wrote:
> > Hi All,
>
> Hi,
>
> > I want to build Linux Kernel 4.20 for arm64 and use it on qemu-arm64.
> > I see that there is a defconfig available in arch/arm64/configs/defconfig
> > But I am not sure whether it will work for qemu-arm64, and by default
> > which machine type is supported.
> >
> > I already have working setup for qemu-arm for both versatile and
> > vexpress machine. There is already a defconfig available for these
> > under arch/arm.
> > So I can build the kernel for it.
> >
> > But, whether these defconfig are supported for arm64 ?
> > If anybody have setup for qemu-arm64 kernel, please share the steps.
> > About rootfs, I am planning to use the arm32 version of busybox itself.
>
> The arm64 defconfig is intended to work for all platforms.
>
> I use that with qemu's '-machine virt'. Assuming you use virtio-net and
> virtio-block, no additional drivers are required.
>
> For example, I can boot a defconfig kernel using the followign QEMU options:
>
> qemu-system-aarch64 \
>         -m 2048 -smp 4 \
>         -net nic \
>         -net user,host=10.0.2.10,hostfwd=tcp::65022-:22 \
>         -nographic \
>         -no-reboot \
>         -machine virt,accel=kvm,gic_version=host \
>         -cpu host \
>         -hda ${FILESYSTEM} \
>         -snapshot \
>         -kernel ${KERNEL} \
>         -append "earlycon root=/dev/vda panic_on_warn"
>
> Thanks,
> Mark.

oh thank you so much for your information.
I was exactly looking for this option.
Let me try it on Monday.


Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
