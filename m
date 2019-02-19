Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F256CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:39:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07F120645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lpXeaeWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07F120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s1j6+TYaseaBvGjv9Hl07Wrzd8FxxVP1SWQDg/OMJW8=; b=lpXeaeWz4s4cJOxR1X2C4wlOY
	aVz227zZjVZ5uhXPBZ7dzJZZZP09cXEgxugf9Ckn3CbTt4hLeSq1O6TnRDJ9i3e9i/yhxd9vSQLxU
	K+jgpW1Ry+vPcsFrp3qhTnLnEXd+v+fL4Eu83UytWLyg4nEYG6oSEjsGYoVPxDJXl1P9njnoYZkaH
	M+99cz7UN3QjOU3derMSHTbCts72OIl75D2bgKaaaUY7MqhNcmA0fkSl1F81EAcYO6AeFTPDjQwIQ
	SBO+IApI9BKzgBo2TjSfl/xjGHWy8MOi0a4UqDEvAaY99/fWrKPR5jROMStIFBV9vjZFRXguu1Ujb
	3nfTrosJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvzzr-0001P0-Pm; Tue, 19 Feb 2019 07:39:19 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvzyr-0000Lx-W7
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 07:38:30 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 19 Feb 2019 16:38:17 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 1D9726117D;
 Tue, 19 Feb 2019 16:38:17 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Tue, 19 Feb 2019 16:38:17 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id 7F4E740340;
 Tue, 19 Feb 2019 16:38:16 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 5880F121B6C;
 Tue, 19 Feb 2019 16:38:16 +0900 (JST)
Subject: Re: [PATCH v2 00/15] Add basic support for Socionext Milbeaut M10V SoC
To: Arnd Bergmann <arnd@arndb.de>
References: <1549628687-29628-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a3_j2W+KXSynW_SkVZk_+PJ-DqyxjLkgJL-OichS0fwWw@mail.gmail.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <26959ef6-bca0-fe51-fc24-9969913e9af4@socionext.com>
Date: Tue, 19 Feb 2019 16:38:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3_j2W+KXSynW_SkVZk_+PJ-DqyxjLkgJL-OichS0fwWw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_233818_583191_F7B8AF26 
X-CRM114-Status: GOOD (  29.45  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Takao Orito <orito.takao@socionext.com>, Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, Jassi Brar <jaswinder.singh@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Thank you for your comments.

On 2019/02/18 21:20, Arnd Bergmann wrote:
> On Fri, Feb 8, 2019 at 1:24 PM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> Hi,
>>
>> Here is the series of patches the initial support for SC2000(M10V) of
>> Milbeaut SoCs. "M10V" is the internal name of SC2000, so commonly used in
>> source code.
>>
>> SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
>> computer vision. It also features advanced functionalities such as 360-degree,
>> real-time spherical stitching with multi cameras, image stabilization for
>> without mechanical gimbals, and rolling shutter correction. More detail is
>> below:
>> https://www.socionext.com/en/products/assp/milbeaut/SC2000.html
>>
>> Specifications for developers are below:
>>   - Quad-core 32bit Cortex-A7 on ARMv7-A architecture
>>   - NEON support
>>   - DSP
>>   - GPU
>>   - MAX 3GB DDR3
>>   - Cortex-M0 for power control
>>   - NAND Flash Interface
>>   - SD UHS-I
>>   - SD UHS-II
>>   - SDIO
>>   - USB2.0 HOST / Device
>>   - USB3.0 HOST / Device
>>   - PCI express Gen2
>>   - Ethernet Engine
>>   - I2C
>>   - UART
>>   - SPI
>>   - PWM
>>
>> Support is quite minimal for now, since it only includes timer, clock,
>> pictrl and serial controller drivers, so we can only boot to userspace
>> through initramfs. Support for the other peripherals  will come eventually.
> 
> I've looked over the platform once more. Overall, it looks very good, and
> I'd still like to merge this for linux-5.1, but we are running out of time
> there. If you send the patches to soc@kernel.org quickly, we can try to
> still merge them in, but if anything goes wrong, it will have to wait until
> we start merging patches for 5.2, directly after 5.1 is out.
> 

I see.
I do my best to make it.

> I did not look at the device driver patches (clk, clocksource, pinctrl, serial)
> in much detail. If you have an Ack from the maintainers, feel free to
> include them in the series, otherwise let's merge the rest now and then
> you can send the updated patches for inclusion through the subsystem
> trees in 5.2.
> 

OK, I'll add the patches with "Acked" or "Reviewed" tag.

> I have sent a few comments. The only one that is really important
> here is the missing platform check in the suspend options. Please
> try to address most of the other commentsm, either by changing the
> code, or by explaining why your version is correct.
> 

Okay, try to address them.
I send the next version as soon as possible.

Thanks.
Sugaya Taichi

> 
> 
>       Arnd
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
