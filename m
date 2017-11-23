From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 23 Nov 2017 06:51:09 +0000
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in userspace
 (KAISER)
In-Reply-To: <20171122233738.GA25313@amd>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
 <20171122161913.GB12684@amd>
 <CAKv+Gu9xw92F_K5XhDwpuSWCSbVJOMGSszuGBkyrhqboLhA-Mw@mail.gmail.com>
 <20171122223355.GA5877@amd> <C271F3D3-A849-43F5-AE0A-6997890A3857@linaro.org>
 <20171122233738.GA25313@amd>
Message-ID: <D3BCED36-58D1-4E30-9171-16F06A5DC65D@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 22 Nov 2017, at 23:37, Pavel Machek <pavel@ucw.cz> wrote:
> 
> Hi!
> 
>>>>> If I'm willing to do timing attacks to defeat KASLR... what prevents
>>>>> me from using CPU caches to do that?
>>>>> 
>>>> 
>>>> Because it is impossible to get a cache hit on an access to an
>>>> unmapped address?
>>> 
>>> Um, no, I don't need to be able to directly access kernel addresses. I
>>> just put some data in _same place in cache where kernel data would
>>> go_, then do syscall and look if my data are still cached. Caches
>>> don't have infinite associativity.
>>> 
>> 
>> Ah ok. Interesting.
>> 
>> But how does that leak address bits that are covered by the tag?
> 
> Same as leaking any other address bits? Caches are "virtually
> indexed",

Not on arm64, although I don?t see how that is relevant if you are trying to defeat kaslr.

> and tag does not come into play...
> 

Well, I must be missing something then, because I don?t see how knowledge about which userland address shares a cache way with a kernel address can leak anything beyond the bits that make up the index (i.e., which cache way is being shared)

> Maybe this explains it?
> 

No not really. It explains how cache timing can be used as a side channel, not how it defeats kaslr.

Thanks,
Ard.
