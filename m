From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 13 Mar 2013 14:13:41 +0900
Subject: [PATCH 3/4] clk: samsung: always allocate the clk_table
In-Reply-To: <513F321E.1020703@samsung.com>
References: <201303120042.09633.heiko@sntech.de>
 <201303120044.29499.heiko@sntech.de>
 <CAJuYYwT183EcZZ20P8D7AP34CwXfKYLzsmZdoJz1ny7XznzyAg@mail.gmail.com>
 <513F1037.3080107@samsung.com>
 <CAJuYYwRDv4ULqXQOXmTsGfqVopt6XPR+XXb-pPZ35+pC7kUN3A@mail.gmail.com>
 <513F321E.1020703@samsung.com>
Message-ID: <CAH9JG2VZqMWcR_cacjpO81PkeckM+dz6MRhr__L8RnSLS7AMFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 10:48 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 03/12/2013 12:46 PM, Thomas Abraham wrote:
>> And, you mentioned Exynos4 will be dt-only from 3.10. Does that mean
>> we just drop support for universal and nuri non-dt board support? Or,
>> will there be a equivalent dt support added for these boards?
>
> I think Tomasz has some initial dts files for Universal_c210 ready, and
> Nuri could probably just be dropped. But we need Kyungmin's opinion on
> that.
Agree.
Tomasz will send unviersal DT files soon.

Thank you,
Kyungmin Park
>
> I'm not sure about other boards, they look pretty basic though.
> So it shouldn't be difficult to replace them with corresponding dts
> files. Currently there are:
>
> arch/arm/mach-exynos/mach-smdk4x12.c
> arch/arm/mach-exynos/mach-origen.c
> arch/arm/mach-exynos/mach-nuri.c
> arch/arm/mach-exynos/mach-universal_c210.c
> arch/arm/mach-exynos/mach-armlex4210.c
> arch/arm/mach-exynos/mach-smdkv310.c
>
> And there are dts files for:
>
> arch/arm/boot/dts/exynos4210-smdkv310.dts
> arch/arm/boot/dts/exynos4210-origen.dts
> arch/arm/boot/dts/exynos5250-smdk5250.dts
> arch/arm/boot/dts/exynos5250-snow.dts
> arch/arm/boot/dts/exynos4210-trats.dts
> arch/arm/boot/dts/exynos5440-ssdk5440.dts
> arch/arm/boot/dts/exynos4412-smdk4412.dts
>
> So except Universal_c210 and Nuri the only ones not supporting booting
> from DT are these two simple boards, which seem to be maintained by
> Samsung:
>
> arch/arm/mach-exynos/mach-smdk4x12.c
> arch/arm/mach-exynos/mach-armlex4210.c
>
> It would be nice to make Exynos DT only in this kernel release.
> I guess there was enough time to get all boards converted to DT
> already.
>
> --
>
> Regards,
> Sylwester
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
