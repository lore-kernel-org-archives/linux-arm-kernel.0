From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 15 Jul 2010 15:34:58 +0530
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 , with
	RealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <AANLkTil1z_o2fBmnw4TljMmu1rbL7hzr0qQDFITs04go@mail.gmail.com>
References: <AANLkTimtpIQaKVHidWP9fvOKGGiQRc0tne1kO5mO-Zzs@mail.gmail.com>
	<20100715093107.GB17605@trinity.fluff.org>
	<20100715093831.GE26212@n2100.arm.linux.org.uk>
	<AANLkTil1z_o2fBmnw4TljMmu1rbL7hzr0qQDFITs04go@mail.gmail.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6087300@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of David Yang
> Sent: Thursday, July 15, 2010 3:27 PM
> To: Russell King - ARM Linux
> Cc: linux-arm-kernel at lists.infradead.org; Ben Dooks
> Subject: Re: Problem with dma_alloc_coherent at linux-2.6.33-arm1 , with
> RealView platform,board PBX-A9 and armv7 instructions.
> 
> I have explicitly added the barrier() in my driver, but it did't work.
> 
> I will go on testing until solve the problem. I need more advice.
>
The 'barrier()' is just a compiler barrier. You should be using "mb" "rmb" 
or "wmb"  depending on the usage.

Regards,
Santosh
