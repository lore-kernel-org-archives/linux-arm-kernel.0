From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 17 Apr 2015 21:52:27 +0200
Subject: [PATCH v4 04/10] mtd: pxa3xx_nand: rework flash detection and
 timing setup
In-Reply-To: <552FEA74.5020909@free-electrons.com> (Ezequiel Garcia's message
 of "Thu, 16 Apr 2015 13:59:32 -0300")
References: <1429118648-19416-1-git-send-email-antoine.tenart@free-electrons.com>
 <1429118648-19416-5-git-send-email-antoine.tenart@free-electrons.com>
 <552EB7F0.2090106@gmail.com> <552FB4DF.1030403@free-electrons.com>
 <552FBC0E.20004@gmail.com> <552FEA74.5020909@free-electrons.com>
Message-ID: <87r3riv8g4.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:

>> Also, as soon as Robert moves pxa3xx boards fully to DT, we'll loose
>> the pdata timings option above. *sigh*
>> 
> Well, such move would include proper timing DT properties for non-ONFI
> devices.
I will move several boards to DT, including several pxa3x boards, but not _all_
the boards.

For reference, I said in [1] this :
> Actually, this deserves another discussion alltogether. My plan was not to
> convert all pxa board files to dt support, but all internal SoC IPs drivers +
> mach/plat support.
> 
> Or put another way at the end :
>  - there will be at least one pxa25x board which is fully DT converted
>  - there will be at least one pxa27x board which is fully DT converted
>  - there will be at least one pxa3xx board which is fully DT converted
> 
>  - there will be at least one pxa25x board which is not DT converted
>  - there will be at least one pxa27x board which is not DT converted
>  - there will be at least one pxa3xx board which is not DT converted
> 
> I want to keep the support for both legacy platform_data and DT for pxa
> architecture. The idea I had was that only fully DT converted machines will
> benefit from multiplatform support.

And as you said Ezequiel, the problem will arise regardless of being DT or not,
it's a lack of conformance of the zylonite board's nand amongst others.

So the timings will have to survive somewhere, whichever place is seen fit.

Cheers.

-- 
Robert

[1] http://lists.openwall.net/linux-kernel/2015/03/24/101
