From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 21 Mar 2010 20:47:22 -0400
Subject: PXA3xx internal SRAM
In-Reply-To: <20100321124739.GG30801@buzzloop.caiaq.de>
References: <20100321124739.GG30801@buzzloop.caiaq.de>
Message-ID: <771cded01003211747n29be55a3p7608578ff1744f51@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 21, 2010 at 8:47 AM, Daniel Mack <daniel@caiaq.de> wrote:
> The pxa3xx series features a comparatively big and fast internal SRAM of
> 256KB which is currently unused by the Linux kernel except for a 4-byte
> return vector from suspend.
>
> I wonder what this could be used for. Is there any kind of cache that
> would be worth putting there to speed up things for example?
> And could the uncompressor probably benfit from that?
>
> Daniel
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

The size of internal SRAM isn't always 256KB. It could be 128KB, 256KB
or 702KB. In marvell BSP, there's a memory management driver (aka IMM)
to handle internal SRAM. So driver or user application could make use
of it. And one part of internal SRAM is reserved for low power idle
mode. But both of these two features aren't pushed into community yet.

Thanks
Haojian
