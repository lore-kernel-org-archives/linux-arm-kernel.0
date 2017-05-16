From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 May 2017 20:53:17 +0900
Subject: [PATCH 2/5] ARM: dts: use #include "..." to include DT in the
 same directory
In-Reply-To: <20170515131048.GW8471@dragon>
References: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
 <1494846888-18966-3-git-send-email-yamada.masahiro@socionext.com>
 <20170515131048.GW8471@dragon>
Message-ID: <CAK7LNARJGwPfYcEWb7O0OcazWN2i_PsSJ1+vspPAiTnnwUqjnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

2017-05-15 22:10 GMT+09:00 Shawn Guo <shawnguo@kernel.org>:
> Hi Masahiro,
>
> On Mon, May 15, 2017 at 08:14:45PM +0900, Masahiro Yamada wrote:
>> Most of DT files in ARM use #include "..." to make pre-processor
>> include DT in the same directory, but we have 3 exceptional files
>> that use #include <...> for that.
>>
>> They must be fixed to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts
>> path from dtc_cpp_flags.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  arch/arm/boot/dts/imx6q-zii-rdu2.dts  | 4 ++--
>>  arch/arm/boot/dts/imx6qp-zii-rdu2.dts | 4 ++--
>
> I see this patch depends on nothing and can be applied immediately.  But
> versatile-pb.dts is not really in my charge.  In case you want to get
> this series merged by arm-soc folks, here is my ACK:
>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
>
> Or you need to split versatile-pb.dts out, and then I can take it.
>
> Shawn


This is needed for 4/5:
https://patchwork.kernel.org/patch/9726697/

Probably, no need to rush for this series.

So, perhaps we can apply DT changes for v4.13 (by splitting per-platform),
then Makefile changes for 4.14.

I will wait for comments for a while (if any).





-- 
Best Regards
Masahiro Yamada
