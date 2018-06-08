From: j-keerthy@ti.com (Keerthy)
Date: Fri, 8 Jun 2018 12:18:05 +0530
Subject: [PATCH] pinctrl: pinctrl-single: Avoid divisions in context
 save/restore
In-Reply-To: <20180608062602.GK5738@atomide.com>
References: <1528374274-26385-1-git-send-email-geert+renesas@glider.be>
 <20180608062602.GK5738@atomide.com>
Message-ID: <6f7fd157-8d49-d61d-c959-1f60c4dc5e8e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 08 June 2018 11:56 AM, Tony Lindgren wrote:
> * Geert Uytterhoeven <geert+renesas@glider.be> [180607 13:40]:
>> The divisions (and multiplications) can be avoided by changing the loops
>> to use increments of mux_bytes instead of 1.
>> While at it, remove the unneeded casts when assigning void pointers.
>>
>> This saves +100 bytes of kernel size on arm32/arm64.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Compile-tested only.
> 
> Makes sense to me:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Keerthy can you please test?

Tested on AM437x-gp-evm for Deep Sleep0.

Tested-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Keerthy <j-keerthy@ti.com>

Thanks Geert!

> 
> Regards,
> 
> Tony
> 
