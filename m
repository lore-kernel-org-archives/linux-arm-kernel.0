From: dave@chronolytics.com (David F. Carlson)
Date: Thu, 27 Aug 2009 09:57:04 -0400 (EDT)
Subject: Discussion request for new Samsung SoCs maintaining
In-Reply-To: <24498970.196691251371216483.JavaMail.weblogic@epml12>
Message-ID: <200908271357.n7RDv4U9028131@chronolytics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


My 2c...

I have been working with the 6410 tree in several places.  A merge of samsung tree would be greatly appreciated.

Please remember that since I am working SmartQ and there are 3 other 6410 based MACHs in Ben's next-s3c tree.  

So, please, MACH_SMDK6410 != CPU_6410 and
            MACH_SMDK6410 != PLAT_64XX.

The common peripheral support needs to be factored out so that "thin" MACH configs can set some per-MACH GPIOs/chipsets (LCD, power,etc.)

Thanks

David F. Carlson    Chronolytics, Inc.  Rochester, NY
mailto:dave at chronolytics.com            http://www.chronolytics.com

"The faster I go, the behinder I get." --Lewis Carroll
> So that, we are considering the following platform structure to manage our new SoCs.
> (All names are tentative)
> 
> linux
>   |
>   +-- arch
>         |
>         +-- arm
>               |
>               +-- plat-samsung2
>               |
>               +-- mach-samsung2
>               |         |
>               |         +-- mach-smdk6440.c
>               |         +-- mach-smdkc100.c
>               |         +-- ...
>               |
>               +-- plat-samsung3
>               |
>               +-- mach-samsung3
>               |         |
>               |         +-- mach-smdk6442.c
>               |         +-- mach-smdkc110.c
>               |         +-- ...
> 
> This layout is based on the time of products, not what the core is in.
> (The names like plat-samsung2 are not decided, just be used to explain our layout)
> 
> The plat-samsung2 and plat-samsung3 directories include common implementations for those groups, as you guess, mach-samsung2 and mach-samsung3 directories support board specific files.
> 
> Anyone has better idea?
> 
> We hope and need to discuss our ideas more and more, continuously, so tell us your opinions and something like this freely about this and, because s3c6410 supports is already in the mainline, we should handle this SoC specially.
> 
> Also we are considering the single binary compilation/operation for the same arm architecture.
> Finally, we should talk with Ben Dooks who is a maintainer of s3c24xx series, so hope Ben's reply especially :)
> 
> Thank you,
> --
> Jinsung, Yang <jsgood@samsung.com>
> Samsung Electronics, Co., Ltd.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
