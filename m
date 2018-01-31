From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 01 Feb 2018 01:47:15 +0800
Subject: About testing A64 DE2 patches
In-Reply-To: <41ed8d45-d8a1-303b-dd1f-ad6686a60ba5@orpaltech.com>
References: <41ed8d45-d8a1-303b-dd1f-ad6686a60ba5@orpaltech.com>
Message-ID: <250579B6-D23B-4E40-8678-1E3F30FA0A16@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?2?1? GMT+08:00 ??1:42:01, Sergey Suloev <ssuloev@orpaltech.com> ??:
>Hi, kernel people,
>
>I am testing A64 DE2 patches from the list below, series v4, with my 
>NanoPi A64 and 4.15
>
>https://patchwork.kernel.org/project/linux-arm-kernel/list/?submitter=173461&page=1
>
>and I'm getting the following issue regarding SRAM:
>
>sunxi-de2-clks 1000000.clock: Error couldn't map SRAM to device

Could you check whether it's finally probed?

DE2 clock may be probed before SRAM controller, so
the probe might be deferred. When SRAM controller is ready
it will retry.

>
>Here is my full dmesg https://pastebin.com/SQvDfJF0
>
>Thanks
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
