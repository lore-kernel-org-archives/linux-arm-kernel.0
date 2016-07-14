From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 14 Jul 2016 13:07:30 -0500
Subject: [PATCH] arm64: Add config to limit user space to 47bits
In-Reply-To: <e24481b9-fb6a-aead-a72b-43b7d561b940@suse.de>
References: <1468424567-15925-1-git-send-email-agraf@suse.de>
 <CAKv+Gu_QH=sZi--FVqHebd1P+6UMzEqWQQ1u3Y170B7cND8Kgw@mail.gmail.com>
 <578668D3.6010406@suse.de> <20160714010812.GA17138@e103986-lin>
 <837E6456-4718-45D7-8EE7-E28E11DB8BD3@suse.de>
 <VI1PR0801MB1423AC2E8EDEE7EA33A6233196320@VI1PR0801MB1423.eurprd08.prod.outlook.com>
 <e24481b9-fb6a-aead-a72b-43b7d561b940@suse.de>
Message-ID: <e48483fc-8dda-3fe2-c3fe-46b93aa41973@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2016 02:14 AM, Alexander Graf wrote:
>
> On 14.07.16 09:03, Zheng Xu wrote:
>> LuaJIT also fix the 48VA issue by allocating heap memory below 47 bits.
>>
>> For mozjs issue, if there are pointers to .rodata, it can be a problem. Does it happen on master and do we have any case to reproduce the issue so that I can take a look?
>
> mozjs is fixed with your patch. I backported it to all of the ancient
> versions of mozjs, so we're probably good there. Though every distro
> will have to redo that work in their own trees, because older versions
> of mozjs are no longer maintained upstream. If you want to be a hero,
> you can try to port polkitd and gnome to use more recent versions of
> mozjs ;). Or maybe they can already and we just messed up packaging.


I have a polkit built against mozjs45, getting it to work on the other 
hand is the yak of the day...
