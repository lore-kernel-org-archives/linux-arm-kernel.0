From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 6 Sep 2018 13:39:43 +0200
Subject: [PATCH v3 30/30] ARM: sun8i: a83t: full range OPP tables and
 CPUfreq
In-Reply-To: <20180906072429.7qjwbbqsjlbskk6v@qschulz>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-31-embed3d@gmail.com>
 <20180906072429.7qjwbbqsjlbskk6v@qschulz>
Message-ID: <c76e71bc-6bc5-f73c-2c7a-c9315cf2da31@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.09.2018 09:24, Quentin Schulz wrote:
> Hi Philipp,
> 
> On Thu, Aug 30, 2018 at 05:45:18PM +0200, Philipp Rossak wrote:
>> Since we have now thermal trotteling enabeled we can now add the full
>> range of the OPP table.
>>
> That's not the reason why they were not added.
> 
> Please see commit 2db639d8c1663d7543c9ab5323383d94c8a76c63[1].
> 
> Basically, you only want the OPPs which can work below or at the default
> voltage of the CPU supply, because the CPU supply is specific to each
> board.
> 
> If you set your CPU to work at a given frequency and the voltage isn't
> updated (saying opp-microvolt = <x>; in DT isn't enough, you need
> cpu-supply to be provided and functional), the CPU might just crash.
> 
> Without cpu-supply property, underclocking isn't effective in term of
> thermal cooling or power saving. Overclocking is very, very, very likely
> to make the CPU crash.
> 
> It's not a very difficult thing to do to test if a given frequency work
> well but it needs a specific test environment and it's a lengthy test,
> you can have a look at those tools here[3] if you like. It's not because
> it works in a given test case that'll work on the long term under heavy
> load and constant frequency changes.
> 
> For A83T, I already did it and the outcome is the patch in [1]. Same for
> A33.
> 
> So, if you want to use these three higher OPPs, you need to define them
> in your board DTS and add the cpu-supply property. See what's done for
> the A33 and more specifically the Sinlinx SinA33[2] as an example.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2db639d8c1663d7543c9ab5323383d94c8a76c63
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
> [3]http://linux-sunxi.org/Hardware_Reliability_Tests#CPU
> 
> Quentin
> 

Hey Quentin,

thanks for your feedback!

Sounds like we will never be able to run the A83T on its maximum 
frequency in mainline.

I will do some testing, during the next weeks/months when I have time.
With the old Allwinner kernel I was able to run the A83T with its 
maximum frequency without any problems since my board is very good cooled.

For now I will drop this patch.

Philipp
