From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 18 Jan 2011 15:46:54 +0530
Subject: Why call calibrate_delay() in smp.c: secondary_start_kernel()
In-Reply-To: <4D3552C2.3020101@stericsson.com>
References: <4D3552C2.3020101@stericsson.com>
Message-ID: <ebe9b3d6a0cc160cd46a97ae05b72119@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of Jonas Aaberg
> Sent: Tuesday, January 18, 2011 2:14 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: STEricsson_nomadik_linux
> Subject: Why call calibrate_delay() in smp.c:
> secondary_start_kernel()
>
>
> Hi,
>
> calibrate_delay() calculates loops_per_jiffy. loops_per_jiffy is not
> per cpu.
> Therefore I wonder why there is a calibrate_delay() call in smp.c:
> secondary_start_kernel()?
>
> If you don't set lpj= it looks like it just takes longer time to
> boot
> and bring a secondary cpu online.
>
> u8500 seems to do fine without the calibrate_delay() call.
>
I did send a patch on the same some time back but the conclusion
was we still need to have calibration.

Have one more patch do deal with it so that platform can choose
if they like to skip. My mailer might screw the patch hence attaching
the same
