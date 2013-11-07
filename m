From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 07 Nov 2013 10:53:16 +0800
Subject: [PATCH trivial] include: uapi: standard all files' macro prefix
 and suffix, excluding "linux/" sub-directory
In-Reply-To: <5278DEF8.2030101@asianux.com>
References: <52786742.1080509@asianux.com> <51FB6216.6010008@asianux.com>
 <11907.1383602624@warthog.procyon.org.uk>
 <13981.1383649896@warthog.procyon.org.uk> <5278DEF8.2030101@asianux.com>
Message-ID: <527B009C.4060905@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2013 08:05 PM, Chen Gang wrote:
> On 11/05/2013 07:11 PM, David Howells wrote:
>> Chen Gang <gang.chen@asianux.com> wrote:
>>
>>>> Userspace sometimes depends on the name in the guard macro:-/
>>>
>>> "the guard macro" is only for prevent itself from being included by
>>> multiple times (an id used by itself -- like a handle), it is not an id
>>> to let other files know about it (it is not a normal using way).
>>
>> Whilst that *should* be true, it isn't actually true.  See:
>>
>> 	grep -r _LINUX_.*_H /usr/include/ | grep -v ^/usr/include/linux/
>>
>> for example.  Also who knows what all those autoconf scripts out there look
>> for?
>>
> 
> Oh... the real world is really not quite perfect. :-/
> 
> 
>> However, thinking about it some more, you're probably safe with respect to
>> userspace as scripts/headers_install.h strips off the _UAPI prefix on the
>> guard macros - just as long as you don't change the rest of the macro name.
>>
> 

I will preparing the patch for it, it will cover "include/uapi/*" and
"arch/*/include/uapi/*", the patch will only add "_UAPI" for the guard
macros which miss it.

Welcome any additional suggestions and completions.

Thanks.

> In honest, I really did not think more about it.
> 
> Only adding _UAPI (not touch others) can completely fix one style issue:
> separate "uapi/*" from other sub-directories in "include/*"
> 
> So for me, we can continue improve this patch: add "_UAPI" for all guard
> macro under "include/uapi/*" (also include "include/uapi/linux").
> 
> 
> Thanks.
> 


-- 
Chen Gang
