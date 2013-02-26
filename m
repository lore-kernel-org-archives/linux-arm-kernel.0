From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 26 Feb 2013 10:50:21 +0100
Subject: [Suggestion] ARM:S5PV210: version merging compiling issue for
 'struct fimc_source_info'
In-Reply-To: <512C5877.7090805@asianux.com>
References: <511F50CF.90403@asianux.com>
 <CAH9JG2WS5q4SR8zk5=OC32PHLZ2+ZYva7csyshG7oANacqbCuA@mail.gmail.com>
 <512C5877.7090805@asianux.com>
Message-ID: <512C855D.6090109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/26/2013 07:38 AM, Chen Gang wrote:
> ? 2013?02?16? 19:39, Kyungmin Park ??:
>> You can find it at recent patch from Arnd.
> 
>   excuse me, could you please provide more information about it ?
> 
>   I have checked 2 tags:
>     the next-20130225 tag in git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
>       in Feb 1 2013, by Sylwester Nawrocki, Kyungmin Park, Mauro Carvalho Chehab
>       git number: 56bc911ac3b94c731db3a6de20258827f1a61c20
>         in include/media/s5p_fimc.h, the structure fimc_source_info is changed.
>         in arch/arm/mach-s5pv210/mach-goni.c, the structure fimc_source_info is not changed.
>           still use .bus_type (not use .fimc_bus_type like others).
> 
>       it seems, the relative members forgot to change it to .fimc_bus_type.
> 
>       did the patch from Arnd still not applied into next tree ?
> 
>     the v3.8-rc7 tag in git clone git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>       it seems no relative changes (change nothing).

No, the fix is not yet in linux-next. I has not been merged through the media
tree and it might take some time until it gets to Linus's tree now. You can use
one of following patches to fix this build break:

http://www.spinics.net/lists/linux-samsung-soc/msg16023.html
https://patchwork.kernel.org/patch/2143211
http://patchwork.linuxtv.org/patch/16892

Kgene, could you push any of these fixes upstream ?


Thanks,
Sylwester
