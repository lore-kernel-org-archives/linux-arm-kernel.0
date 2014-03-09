From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 10 Mar 2014 00:59:59 +0100
Subject: [PATCH v4 5/5] clk/exynos5260: add clock file for exynos5260
In-Reply-To: <531AE1CD.2070203@samsung.com>
References: <1394113551-2134-1-git-send-email-rahul.sharma@samsung.com>
 <CAGcde9Hqs92bri0Fu3y7rvMhiFMYe+N7YWT-mxL2HTsnJTvz2w@mail.gmail.com>
 <5319D3E5.4000001@gmail.com>
 <CAGcde9GetFjdRxqJfPY_1qdxzKb+4cqjsc+ALnN0PxSrApjyxg@mail.gmail.com>
 <5319E445.9000409@gmail.com>
 <CAPdUM4Pt0Ofh=M5pwdj+0NwSvfK4JvZbpWUS6JfD3vnTi2JaGg@mail.gmail.com>
 <531AE1CD.2070203@samsung.com>
Message-ID: <531D007F.4030800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.03.2014 10:24, Pankaj Dubey wrote:
> Hi Rahul,

> I modified code as per our discussion and addressed all comments
> including moving fixed clock to DT
> and found it's working well, so we can now finalize which way to  go ahead.
> Following is some data between V4 and probable next version, which might
> help in making decision.
>
> drivers/clk/samsung/exynos5260-clock.c
>
> Before Change
> LoC: 1890
> size drivers/clk/samsung/clk-exynos5260.o
>     text       data        bss        dec        hex    filename
>    14226      14956          0      29182       71fe
> drivers/clk/samsung/clk-exynos5260.o
>
> After Change:
> LoC: 1806
> size drivers/clk/samsung/clk-exynos5260.o
>     text       data        bss        dec        hex    filename
>    15446      14544          0      29990       7526
> drivers/clk/samsung/clk-exynos5260.o

Well, somehow I've been under impression that the change would bring 
more significant results. Here we can see slight reduction in lines of 
code, but also slight increase of kernel image size. Still, in general, 
nothing extreme.

In this case I'd probably go with Rahul's original code, as it doesn't 
require second matching and separate match table, which adds redundant 
compatible strings used just for this extra matching pass.

I guess this is all just bike shedding, though.

Best regards,
Tomasz
