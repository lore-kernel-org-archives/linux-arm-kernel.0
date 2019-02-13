Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF45C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:34:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A862070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uXTupUTw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It8fgDzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A862070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=JF/o1An1bYXT8ijXB3K9fJHti5EHjvOubuPlHmBGeVo=; b=uXT
	upUTwkC+bI2fLselgrq6Eht1z1QXtoNzmNPTmbfjJztMu/57ybj8OBly+7Bgl4AdPd81kUEgD/3d5
	T8fdAzwqbRtEvBh5qT2lidB/V657dHVhZ9ImthgK13fyZ5/61C5PUogji3FtwxugwmKNxLnAGq0uK
	Ij22sTiF30QuD2uSWrAch3c1vYZu1CmJLuY9kNEgwPRGKhH0JX4PIJuvrpXAdXAUtRU50eHEKLh8J
	uyde3BISWfibwQo5jg5QgMiYlFIsO0//BuF8F3WsrV0ILIEC8ZsLDcUr4ajtJxhc6zVh0B8+aVVB1
	4btS3XB7Tz0fZqRmUQpqooJOIuZdOog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtpzn-0001Y3-Bx; Wed, 13 Feb 2019 08:34:19 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtpzj-0001XE-VP
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 08:34:17 +0000
Received: by mail-vs1-xe42.google.com with SMTP id k11so930407vsm.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 00:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=F43oSbigyOcSEV4nj0Ob69X4hDmCS9KAcYBEnqAqvuk=;
 b=It8fgDzCF3jQrAFpmYUO0g5jEOWlCv8YG7M7v8Al1kXXnmwsFUGYpBNhUW5x29Ymrp
 NaJKXBS1BJZ0F00XsMMWA7G2G38ev0IimEJ3fXHTAag1+S2Lh+qoUMUBDXjBY73nDOez
 KbetomsUuDJIcwOv50ET+jZcyfXCNEVETGuvxfoMD2DiwrAPfZVSUr00dbzXlPL7sMyl
 bNwBI20bSizAOQMauh4djjR3VAAFd0YqdMNiDfVbkEqUs54x5hCskz5qpDGZ9CCfn/Hc
 s7Pui4VA7pa3ISomovEdEJ4rCzL5oN5+OkWClifYwDSgB0FjAMz993mI8BZS5L23pwk4
 mA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=F43oSbigyOcSEV4nj0Ob69X4hDmCS9KAcYBEnqAqvuk=;
 b=AagBtV5tdG4JUfssWbqoMkxMoohx0vEC3KsCqueydPfHxrJLjeHp/YvH6y+nuOfJ7H
 bXfZHGlaU4Mj5F9Qq2yI7RWmDtHMI+XtMNHzclesFE7ybS33MDuNvCA3Azm92n6d1MBa
 YRekZRSZTd4lwbnEf+wfLT9EQzqcM0QT6bH1y3YdiRwdhwPWHB6yW7U5v28i6vLhG+kr
 jfXrVcpWD0JmfjidEZ1K5KpplQokCuZ3ebUL9RotnWx5VMgt+yEaGxqJzQtOJFBb9KTo
 zWP/35SFZ5aXrYcaXmbMjbM0RchpvLH5eYdQ+IXFF76kCwzlznIGss1Fkv6KS3blyThI
 7rDg==
X-Gm-Message-State: AHQUAuahh3CWHwDCFL9vdV/WKtVMSXUxyHtBTzHqf8a89N2Oz/Ura+SB
 I7AzGHM7YbK3o0/22nxuWC0qqRuSjD0gToyGFHo=
X-Google-Smtp-Source: AHgI3IYBRvB9VsXzmrYBjmxbRm8j2ErkbwNCDV7jX1q+IgvTKmo6nPwgDbeP9NkTLdrSARkx1Hqupnvl+j63CMtdyIU=
X-Received: by 2002:a67:f793:: with SMTP id j19mr3148261vso.196.1550046854186; 
 Wed, 13 Feb 2019 00:34:14 -0800 (PST)
MIME-Version: 1.0
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Wed, 13 Feb 2019 14:04:03 +0530
Message-ID: <CAOuPNLgaDJm27nECxq1jtny=+ixt=GPf2C7zyDsVgbsLvtDarA@mail.gmail.com>
Subject: BUG: sleeping function called from invalid context at
 kernel/locking/rwsem.c:65
To: open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, 
 linux-rt-users@vger.kernel.org, linux-mm@kvack.org, 
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>, 
 Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>, 
 "Xenomai@xenomai.org" <xenomai@xenomai.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_003416_032495_B56F5AA9 
X-CRM114-Status: GOOD (  11.63  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

I need some pointer in debugging the root cause of this issue.
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:65
[   22.140224] [<ffffff88b8ce65a8>] ___might_sleep+0x140/0x188
[   22.145862] [<ffffff88b8ce6648>] __might_sleep+0x58/0x90
[   22.151249] [<ffffff88b9d43f84>] down_write_killable+0x2c/0x80
[   22.157155] [<ffffff88b8e53cd8>] setup_arg_pages+0xb8/0x208
[   22.162792] [<ffffff88b8eb7534>] load_elf_binary+0x434/0x1298
[   22.168600] [<ffffff88b8e55674>] search_binary_handler+0xac/0x1f

I am using msm-4.9.103 kernel on some qualcomm reference platform:
https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/?h=CogSystems-msm-49/msm-4.9
Then I applied Xenomai/ipipe arm64 patches for kernel 4.9 on top of
it, but later disabled it.
But I get this sleeping issue even after disabling the Xenomai
configs. I expect the behavior should be similar to normal kernel
after disabling it.
AFAIK all the above callbacks are from normal mainline kernel, so
there should not be any issue, as it was working previously.

So, if anybody have debugged this issue earlier, please share your
findings about what can cause this type of issue.
It happens just during rootfs mounting and all above callback looks
normal to me.
Even I compared their implementation with mainline code and it looks
almost same.

So, I guess it might be triggering from somewhere else, may be from
interrupt context.
So, I am looking for ways to pin-point the exact place, and resolve this issue.
Any pointers will be highly appreciated.


This is the complete logs at the time of crash:

[   21.681020] VFS: Mounted root (ext4 filesystem) readonly on device 8:6.
[   21.690441] devtmpfs: mounted
[   21.702517] Freeing unused kernel memory: 6528K
[   21.766665] BUG: sleeping function called from invalid context at
kernel/locking/rwsem.c:65
[   21.775108] in_atomic(): 0, irqs_disabled(): 128, pid: 1, name: init
[   21.781532] ------------[ cut here ]------------
[   21.786209] kernel BUG at kernel/sched/core.c:8490!
[   21.791157] ------------[ cut here ]------------
[   21.795831] kernel BUG at kernel/sched/core.c:8490!
[   21.800763] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[   21.806319] Modules linked in:
[   21.809474] CPU: 0 PID: 1 Comm: init Not tainted 4.9.103+ #115
[   21.815375] Hardware name: Qualcomm Technologies, Inc. MSM XXXX
[   21.822584] task: ffffffe330440080 task.stack: ffffffe330448000
[   21.828584] PC is at ___might_sleep+0x140/0x188
[   21.833175] LR is at ___might_sleep+0x128/0x188
[   21.837759] pc : [<ffffff88b8ce65a8>] lr : [<ffffff88b8ce6590>]
pstate: 604001c5
[   21.845228] sp : ffffffe33044bba0
[   21.848590] x29: ffffffe33044bba0 x28: ffffffe321580680
[   21.854045] x27: ffffffe32df6f780 x26: ffffffe32155db80
[   21.859495] x25: ffffffe3215980c0 x24: 0000000000000001
[   21.864954] x23: ffffffe321598040 x22: ffffff88baaaf000
[   21.870410] x21: ffffff88b91f50d4 x20: ffffffe330440080
[   21.875858] x19: 0000000000000000 x18: ffffff88baaafb08
[   21.881313] x17: 00000000cea8ef66 x16: 00000000f32c652b
[   21.886759] x15: ffffff893ace16f7 x14: 0000000000000006
[   21.892209] x13: ffffff88bace1705 x12: 0000000000000007
[   21.897671] x11: 0000000000000006 x10: 0000000000000462
[   21.903122] x9 : ffffffe33044b8d0 x8 : 0000000000000000
[   21.908581] x7 : ffffff88baaafb08 x6 : 000000002ec8289a
[   21.914029] x5 : 0000000000000015 x4 : 0000000000f2e11f
[   21.919488] x3 : 0000000000000004 x2 : 3f188ee06c84b500
[   21.924949] x1 : 0000000000000000 x0 : 0000000000000000
[   21.930407]
[   21.930407] PC: 0xffffff88b8ce6568:
[   21.935432] 6568  f9401a81 d28dd3a0 f2aaf580 f9400021 eb00003f
54000181 d53b4220 36380060
[   21.944046] 6588  d5384100 94030485 d5384100 b9401001 b9453800
0b000020 6b00027f 540000c1
[   21.952653] 65a8  d4210000 d000a180 91242000 9403e085 17fffff2
b000a180 91376000 9403e081
[   21.961253] 65c8  b000a140 aa1503e2 aa1503e1 910e2000 9403e07c
9000a140 91340000 9403e079
[   21.969858]
[   21.969858] LR: 0xffffff88b8ce6550:
[   21.974884] 6550  b9467a83 1a9f07e1 91214284 12190042 91232000
9403e099 f9401a81 d28dd3a0
[   21.983486] 6570  f2aaf580 f9400021 eb00003f 54000181 d53b4220
36380060 d5384100 94030485
[   21.992102] 6590  d5384100 b9401001 b9453800 0b000020 6b00027f
540000c1 d4210000 d000a180
[   22.000710] 65b0  91242000 9403e085 17fffff2 b000a180 91376000
9403e081 b000a140 aa1503e2
[   22.009311]
[   22.009311] SP: 0xffffffe33044bb60:
[   22.014335] bb60  b8ce6590 ffffff88 3044bba0 ffffffe3 b8ce65a8
ffffff88 604001c5 00000000
[   22.022949] bb80  304408d0 ffffffe3 00000015 00000000 ffffffff
0000007f baaafb08 ffffff88
[   22.031554] bba0  3044bbd0 ffffffe3 b8ce6648 ffffff88 ba11b8b8
ffffff88 00000041 00000000
[   22.040162] bbc0  00000000 00000000 2155db80 ffffffe3 3044bc00
ffffffe3 b9d43f84 ffffff88
[   22.048775] Process init (pid: 1, stack limit = 0xffffffe330448000)
[   22.055108] Call trace:
[   22.057603] Exception stack(0xffffffe33044b9a0 to 0xffffffe33044bad0)
[   22.064118] b9a0: 0000000000000000 0000007fffffffff
ffffffe33044bba0 ffffff88b8ce65a8
[   22.072024] b9c0: 00000000604001c5 000000000000003d
ffffffe3215980c0 ffffffe32155db80
[   22.079934] b9e0: 0000000000000000 0000000100000000
ffffffe33044ba90 ffffff88b8d2ef88
[   22.087842] ba00: ffffffe33044baf0 ffffff88ba1188c8
ffffff88b91f50d4 ffffff88baaaf000
[   22.095754] ba20: ffffffe321598040 0000000000000001
ffffffe3215980c0 ffffffe32155db80
[   22.103661] ba40: ffffffe32df6f780 ffffffe321580680
ffffffe33044ba60 0000000000000000
[   22.111567] ba60: 000000003044baa0 3f188ee06c84b500
0000000000000000 0000000000000000
[   22.119473] ba80: 3f188ee06c84b500 0000000000000004
0000000000f2e11f 0000000000000015
[   22.127376] baa0: 000000002ec8289a ffffff88baaafb08
0000000000000000 ffffffe33044b8d0
[   22.135279] bac0: 0000000000000462 0000000000000006
[   22.140224] [<ffffff88b8ce65a8>] ___might_sleep+0x140/0x188
[   22.145862] [<ffffff88b8ce6648>] __might_sleep+0x58/0x90
[   22.151249] [<ffffff88b9d43f84>] down_write_killable+0x2c/0x80
[   22.157155] [<ffffff88b8e53cd8>] setup_arg_pages+0xb8/0x208
[   22.162792] [<ffffff88b8eb7534>] load_elf_binary+0x434/0x1298
[   22.168600] [<ffffff88b8e55674>] search_binary_handler+0xac/0x1f0
[   22.174763] [<ffffff88b8e560ec>] do_execveat_common.isra.15+0x504/0x6c8
[   22.181452] [<ffffff88b8e562f4>] do_execve+0x44/0x58
[   22.186481] [<ffffff88b8c84030>] run_init_process+0x38/0x48
[   22.192122] [<ffffff88b9d3db1c>] kernel_init+0x8c/0x108
[   22.197411] [<ffffff88b8c83f00>] ret_from_fork+0x10/0x50
[   22.202790] Code: b9453800 0b000020 6b00027f 540000c1 (d4210000)
[   22.208965] ---[ end trace d775a851176a61ec ]---
[   22.220051] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b


Thanks,

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
