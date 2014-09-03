From: khiem.nguyen.xt@renesas.com (Khiem Nguyen)
Date: Wed, 03 Sep 2014 11:42:57 +0900
Subject: [PATCH repost] ARM: shmobile: lager: correct memory map
In-Reply-To: <20140903004901.GA3277@verge.net.au>
References: <20140903004901.GA3277@verge.net.au>
Message-ID: <54068031.5050806@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Simon-san, Shiiba-san,

Thanks for the patch.

On 9/3/2014 9:49 AM, Simon Horman wrote:
> The base address of the second memory region on the lager
> board is 0x140000000. Update the tag used in the dts file accordingly.
> 
> This is a documentation fix and should have no run-time affect.
> 
> This problem was introduced when the second memory region
> was added to the lager dts file by 62bc32a2573c4219
> ("ARM: shmobile: Include all 4 GiB of memory on Lager)"
> in v3.14.
> 
> Reported-by: NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I am reposting this as Olof originally requested a syntax change,
> which I followed up on, however that change no longer seems appropriate.
> This this patch seems to be correct.
[...]
> -	memory at 180000000 {
> +	memory at 140000000 {

Could you give more information about not using new syntax ?

I checked memblock information in both 2 ways 
(i.e memory at 140000000 and memory at 1,40000000)
and I got same result.
root at lager:~# cat /sys/kernel/debug/memblock/memory
   0: 0x0000000040000000..0x000000007fffffff
   1: 0x0000000140000000..0x00000001ffffffff

So, what does 'no longer seems appropriate" mean ?

>  		device_type = "memory";
>  		reg = <1 0x40000000 0 0xc0000000>;
>  	};
> 

Thanks.

-- 
Best regards,
KHIEM Nguyen
