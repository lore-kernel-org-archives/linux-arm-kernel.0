From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 14 May 2014 12:46:27 +0900
Subject: [PATCH 00/03] ARM: shmobile: Use shmobile_init_delay() on r8a7791
In-Reply-To: <20140514032837.GB22813@verge.net.au>
References: <20140511232508.20177.11556.sendpatchset@w520>
 <1509906.x9u0HJ6AbJ@avalon> <20140513005936.GB30252@verge.net.au>
 <20140513071224.GC27611@verge.net.au>
 <CAMuHMdWBAkh_Jkfsok-Nws56z0ZsU0LmxV2nob_LKrMY_tFF6A@mail.gmail.com>
 <20140514032837.GB22813@verge.net.au>
Message-ID: <CANqRtoRvB9o2AwU1X2OFGpsmBoRtZDnKD+jz0SRhjSn-Ye6mug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 12:28 PM, Simon Horman <horms@verge.net.au> wrote:
> I wonder if the following is any good.
>
> From: Simon Horman <horms+renesas@verge.net.au>
>
> [PATCH] ARM: shmobile: Set clock frequency in HZ from OF nodes
>
> shmobile_init_delay() looks for OF "clock-frequency" to determine
> the delay which is set by calling shmobile_setup_delay().
>
> Unfortunately this seems to be incorrect in detail as
> "clock-frequency" node values are in HZ whereas the frequency
> argument to shmobile_setup_delay() is in MHz.
>
> Provide a variant of shmobile_setup_delay() that accepts HZ to
> correct this problem.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> v2
> * As suggested by Geert Uytterhoeven
>   - Don't ignore the potential for integer overflow.
>     To this end I have taken Geert's suggestion of dividing by
>     a large "value" in the HZ case.
>     And I have let the original function unchanged for the MHz case:
>     it should eventually be removed anyway.

Hi Simon and Geert,

Thanks for dealing with the fallout of my cosmetic changes. Nice to
see that you managed to track it down!

I think this patch looks perfect, please merge unless anyone objects.

Cheers,

/ magnus
