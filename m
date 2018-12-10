Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E8EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:48:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6A320880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U7rRzBeV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCnCWSH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6A320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BX/vP0+QrQ1EMAHHzYVGmMYk+9draZpZHes0isRZYko=; b=U7rRzBeVUzL4Sb
	jYZkFpl1dMKdqfYdH851kOjRFlDVQwgxQiJcH7VJACE4kt4Du3ML7HWNVJqcavNjjThmEsbTKlKqI
	h513smnlQyeYpb5NV4ufEGgZuuBmAs2y5N29QcVdCeH9PqaRz9wzO8xU6akehqcKsx3RAPGMzjFJe
	GmF9Ye5roeiYe2XbcnOsd7KsZlhXtrVEs2J2r87PwlKCmZ0e4lOQRZK2BJ+hIkWG70oyoTBhX9vmG
	T/LZHGDjKpSfUlGDooiAnbo1asZ3khBD/qMFVZWrfSiul6MQc1gIp6/fFAHCcdyaH0mQlz/ttKlia
	7soiTNq+ezfdornmUobA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWK2i-0006dt-R9; Mon, 10 Dec 2018 11:48:08 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWK2f-0006cg-0X
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:48:07 +0000
Received: by mail-lj1-x241.google.com with SMTP id g11-v6so9324072ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 03:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QZLdaXtwBiokUOdYOoqzXl3a32J9Pz9YgiivWxkIym8=;
 b=OCnCWSH8SHCYu7eVZ1XzHnwiosQQF4VO91PwFcjtnHApAEmww0OCDJ3YY5PxbSA0z0
 5jBQfQ6nIl6u0Kih0vnyxEBW+HdK+WEcQFrV4LlpuoFFYZxJamkllmL0oYtaVoQSHaza
 EI8IFe9XEN/uEKdaTxNa+uB8YwY3uRsqX9J0CC81RsCPkoL2wsk2299WoihbnW9jzazf
 wCbNje7clfBKSURuB4vxcXLzL+Eon67Sf2qt7O4044IYTIt2OKUPiJmSOaTyR/I77lLW
 qs8VBsHk3PHoFkXid8khsS1TOG1SYAI8V9PVcjECnHzC/0Ifs4ZlTlWD+0WQb0GZtEs7
 H9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QZLdaXtwBiokUOdYOoqzXl3a32J9Pz9YgiivWxkIym8=;
 b=TwtGe3COv6odrbZIwEysvqTdMQz6069ARGZbHsIAhbzgcvyfx0/X4owICT+3tIrT3D
 2X/NiXMVqxU8hODJbJL63jsPrUMiluYXsD5IpalOrAxgO8RwbrpMsMLmoZ7THA4+j5Uw
 67jnkE7iHAsq5rzFwFtcjrVDzVRJtqb5/xysVww/A4zpgNWqtA5sz/mqzpguHAn6VAXZ
 eyJlgvuvsFRlqbmaVwthTOD5ymswNHgp0yQ0BKvwygqNw02FGZY3vc2ZHQhkWaI/MYyR
 mnJyajC6/EpztZ1j4wALjRFU/H1ESARQrNFP1FFLHmyBZjn6t1BpSaYzaYfs08ZMhrNG
 Osqg==
X-Gm-Message-State: AA+aEWauf+WVwfJ/eMihcxk8r/LWUGhDokQQpW6EY7yGwvE5qZaPGL6v
 QrI7o4pqsVaJFMP0Q/XFNoY=
X-Google-Smtp-Source: AFSGD/XS4atiApiTxJIxvQmW1n906RxLTlmRDq6sh7PkUlqPdvHQhUinhHmLz7la/gApKP7domLSkg==
X-Received: by 2002:a2e:744:: with SMTP id i4-v6mr3295988ljd.140.1544442471617; 
 Mon, 10 Dec 2018 03:47:51 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-165-221.pppoe.mtu-net.ru.
 [91.79.165.221]) by smtp.googlemail.com with ESMTPSA id
 t19-v6sm2117846lje.23.2018.12.10.03.47.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 03:47:50 -0800 (PST)
Subject: Re: TK1: DRM, Nouveau and VIC
To: Thierry Reding <thierry.reding@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ben Skeggs <bskeggs@redhat.com>
References: <0c2db0d1c102a4f5a441f8e5a90f6793f329ada7.camel@toradex.com>
 <20181210102147.GF15154@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3f60a544-e046-01ea-5869-e761d4be4dde@gmail.com>
Date: Mon, 10 Dec 2018 14:46:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181210102147.GF15154@ulmo>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_034805_083871_F4CDE01F 
X-CRM114-Status: GOOD (  20.61  )
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
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10.12.2018 13:21, Thierry Reding wrote:
> On Sat, Dec 08, 2018 at 02:54:45PM +0000, Marcel Ziswiler wrote:
>> Hi Thierry et al.
>>
>> I noticed that since commit 3dde5a2342cd ("ARM: tegra: Add VIC on
>> Tegra124") graphics on Apalis TK1 is broken. During boot it fails
>> loading the vic firmware:
>>
>> [    1.595824] tegra-vic 54340000.vic: Direct firmware load for
>> nvidia/tegra124/vic03_ucode.bin failed with error -2
>> [    1.606140] tegra-vic: probe of 54340000.vic failed with error -2
>>
>> Subsequently Tegra HDMI seems to fail completely:
>>
>> [    2.379860] tegra-hdmi 54280000.hdmi: failed to get PLL regulator
>>
>> And finally, Nouveau even crashes:
>>
>> [    8.241115] nouveau 57000000.gpu: Linked as a consumer to
>> regulator.31
>> [    8.247889] nouveau 57000000.gpu: NVIDIA GK20A (0ea000a1)
>> [    8.253396] nouveau 57000000.gpu: imem: using IOMMU
>> [    8.270210] Unable to handle kernel NULL pointer dereference at
>> virtual address 0000006c
>> [    8.278340] pgd = (ptrval)
>> [    8.281250] [0000006c] *pgd=00000000
>> [    8.284944] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
>> [    8.290260] Modules linked in: nouveau(+) ttm
>> [    8.294625] CPU: 2 PID: 203 Comm: systemd-udevd Not tainted 4.20.0-
>> rc5-next-20181207-00008-g85b0f8e25f86-dirty #110
>> [    8.305055] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>> [    8.311331] PC is at drm_plane_register_all+0x18/0x50
>> [    8.316373] LR is at drm_modeset_register_all+0xc/0x70
>> [    8.321513] pc : [<c056200c>]    lr : [<c0564cc8>]    psr: a0060013
>> [    8.327768] sp : ed527c70  ip : ecc43ec0  fp : 00000000
>> [    8.332993] r10: 00000016  r9 : ecc43e80  r8 : 00000000
>> [    8.338209] r7 : bf182c80  r6 : 00000000  r5 : ed61b24c  r4 :
>> fffffffc
>> [    8.344735] r3 : 0002f000  r2 : ffffffff  r1 : 2e124000  r0 :
>> ed61b000
>> [    8.351260] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA
>> ARM  Segment none
>> [    8.358383] Control: 10c5387d  Table: ad64c06a  DAC: 00000051
>> [    8.364127] Process systemd-udevd (pid: 203, stack limit =
>> 0x(ptrval))
>> [    8.370654] Stack: (0xed527c70 to 0xed528000)
>> [    8.375004] 7c60:                                     ed61b000
>> ed61b000 00000000 c0564cc8
>> [    8.383177] 7c80: ed61b000 00000000 00000000 c054b5b8 00000001
>> 00000001 ffffffff ffffffff
>> [    8.391355] 7ca0: ed527cc0 c0f08c48 ed61b000 00000000 00000000
>> 00000000 bf180c5c bf0dc900
>> [    8.399531] 7cc0: eda29208 5dfe844b 00000000 ee9f2a10 00000000
>> bf180c5c 00000000 c05a9328
>> [    8.407695] 7ce0: c1006828 ee9f2a10 c100682c 00000000 00000000
>> c05a744c ee9f2a10 bf180c5c
>> [    8.415871] 7d00: ee9f2a44 c05a77a8 00000000 c0f08c48 bf182980
>> c05a769c eefd14d0 c05a77a8
>> [    8.424048] 7d20: 00000000 ee9f2a10 bf180c5c ee9f2a44 c05a77a8
>> 00000000 c0f08c48 bf182980
>> [    8.432226] 7d40: 00000000 c05a7884 ee9ebfb4 c0f08c48 bf180c5c
>> c05a5790 00000000 ee88135c
>> [    8.440405] 7d60: ee9ebfb4 5dfe844b c0f71168 bf180c5c ee379e80
>> c0f71168 00000000 c05a692c
>> [    8.448570] 7d80: bf15dc00 bf180ac8 ffffe000 bf180c5c bf180ac8
>> ffffe000 bf1aa000 c05a84a0
>> [    8.456746] 7da0: bf182b80 bf180ac8 ffffe000 bf1aa170 c0fbd220
>> c0f08c48 ffffe000 c0102ed0
>> [    8.464924] 7dc0: ed53f4c0 006000c0 c01b3d98 0000000c 60000113
>> bf182980 00000040 c02592d0
>> [    8.473102] 7de0: eda60200 2e124000 ee800000 006000c0 006000c0
>> c01b3d98 0000000c c025a8cc
>> [    8.481281] 7e00: c024ce54 a0000113 bf182980 5dfe844b bf182980
>> 00000002 ed53f4c0 00000002
>> [    8.489459] 7e20: eceba000 c01b3dd4 c0f08c48 bf182980 00000000
>> ed527f40 00000002 eceb9fc0
>> [    8.497625] 7e40: 00000002 c01b61a4 bf18298c 00007fff bf182980
>> c01b2f88 00000000 c01b279c
>> [    8.505800] 7e60: bf1829c8 bf182a80 bf182b6c bf182ab0 c0b03ab0
>> c0d58964 c0ca726c c0ca7278
>> [    8.513978] 7e80: c0ca72d0 c0f08c48 00000000 c02654a0 00000000
>> 00000000 ffffe000 bf000000
>> [    8.522157] 7ea0: 00000000 00000000 00000000 00000000 00000000
>> 00000000 6e72656b 00006c65
>> [    8.530336] 7ec0: 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000 00000000
>> [    8.538502] 7ee0: 00000000 00000000 00000000 00000000 00000000
>> 5dfe844b 7fffffff c0f08c48
>> [    8.546677] 7f00: 00000000 0000000f b6f761cc c0101204 ed526000
>> 0000017b 004a3270 c01b66a4
>> [    8.554855] 7f20: 7fffffff 00000000 00000003 00000001 004a3270
>> f0ced000 06e8994c 00000000
>> [    8.563032] 7f40: f0e37f3a f0e50a40 f0ced000 06e8994c f7b75f9c
>> f7b75d34 f63e62dc 0016b000
>> [    8.571209] 7f60: 0017f6f0 00000000 00000000 00000000 00050a48
>> 0000003b 0000003c 00000023
>> [    8.579388] 7f80: 00000000 00000014 00000000 5dfe844b 00000000
>> 004c0ec0 00000000 00000001
>> [    8.587554] 7fa0: 0000017b c0101000 004c0ec0 00000000 0000000f
>> b6f761cc 00000000 00020000
>> [    8.595730] 7fc0: 004c0ec0 00000000 00000001 0000017b 0048e114
>> 00000000 00000000 004a3270
>> [    8.603908] 7fe0: bea8f990 bea8f980 b6f71269 b6e9f6c0 400d0010
>> 0000000f 00000000 00000000
>> [    8.612096] [<c056200c>] (drm_plane_register_all) from [<c0564cc8>]
>> (drm_modeset_register_all+0xc/0x70)  
>> [    8.621499] [<c0564cc8>] (drm_modeset_register_all) from
>> [<c054b5b8>] (drm_dev_register+0x168/0x1c4)
>> [    8.630855] [<c054b5b8>] (drm_dev_register) from [<bf0dc900>]
>> (nouveau_platform_probe+0x6c/0x88 [nouveau])
>> [    8.640739] [<bf0dc900>] (nouveau_platform_probe [nouveau]) from
>> [<c05a9328>] (platform_drv_probe+0x48/0x98)
>> [    8.650574] [<c05a9328>] (platform_drv_probe) from [<c05a744c>]
>> (really_probe+0x1e0/0x2cc)
>> [    8.658827] [<c05a744c>] (really_probe) from [<c05a769c>]
>> (driver_probe_device+0x60/0x16c)
>> [    8.667096] [<c05a769c>] (driver_probe_device) from [<c05a7884>]
>> (__driver_attach+0xdc/0xe0)
>> [    8.675543] [<c05a7884>] (__driver_attach) from [<c05a5790>]
>> (bus_for_each_dev+0x74/0xb4)
>> [    8.683729] [<c05a5790>] (bus_for_each_dev) from [<c05a692c>]
>> (bus_add_driver+0x1c0/0x204)
>> [    8.692004] [<c05a692c>] (bus_add_driver) from [<c05a84a0>]
>> (driver_register+0x74/0x108)
>> [    8.700324] [<c05a84a0>] (driver_register) from [<bf1aa170>]
>> (nouveau_drm_init+0x170/0x1000 [nouveau])   
>> [    8.709857] [<bf1aa170>] (nouveau_drm_init [nouveau]) from
>> [<c0102ed0>] (do_one_initcall+0x54/0x284)
>> [    8.718980] [<c0102ed0>] (do_one_initcall) from [<c01b3dd4>]
>> (do_init_module+0x64/0x214)
>> [    8.727079] [<c01b3dd4>] (do_init_module) from [<c01b61a4>]
>> (load_module+0x21b8/0x246c)
>> [    8.735094] [<c01b61a4>] (load_module) from [<c01b66a4>]
>> (sys_finit_module+0xc4/0xdc)
>> [    8.742937] [<c01b66a4>] (sys_finit_module) from [<c0101000>]
>> (ret_fast_syscall+0x0/0x54)
>> [    8.751114] Exception stack(0xed527fa8 to 0xed527ff0)
>> [    8.756157] 7fa0:                   004c0ec0 00000000 0000000f
>> b6f761cc 00000000 00020000
>> [    8.764333] 7fc0: 004c0ec0 00000000 00000001 0000017b 0048e114
>> 00000000 00000000 004a3270
>> [    8.772510] 7fe0: bea8f990 bea8f980 b6f71269 b6e9f6c0
>> [    8.777556] Code: e5b5424c e1550004 0a00000c e2444004 (e5943070)
>> [    8.784011] ---[ end trace ad8c21587c118655 ]---
>>
>> Of course my root file system does include resp. vic firmware:
>>
>> 7ef01d2e3f507c91ca79584e89edcc64  /lib/firmware/nvidia/tegra124/vic03_u
>> code.bin
>>
>> If I bake that one into the kernel binary, Nouveau still crashes like
>> above albeit VIC loading and Tegra DRM now at least showing something
>> on HDMI.
> 
> Yeah, this is a fairly common pitfall. The general rule of thumb is that
> the firmware has to live on the same medium as the module. So if you've
> built Tegra DRM as a loadable kernel module and installed it in the root
> filesystem, then that's where your firmware file also needs to be. If
> the driver is built-in (or a loadable module installed in the initial
> ramdisk), then the firmware needs to be in the initial ramdisk (or built
> into the kernel image itself). That's somewhat annoying, but it is what
> it is. At least it's logical.

It's not very logical in a sense that display driver doesn't load because of firmware that it doesn't need at all. Deferring firmware load until it is really needed should be the most reasonable approach, please let me make an RFC.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
