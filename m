From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 14 Sep 2015 11:36:32 +0200
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <55F693F5.8030203@huawei.com>
References: <20150910112418.GC29293@leverpostej>
 <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
 <20150910121514.GE29293@leverpostej>
 <alpine.DEB.2.02.1509101429480.2672@kaball.uk.xensource.com>
 <20150910144938.GI29293@leverpostej>
 <alpine.DEB.2.02.1509101655020.2672@kaball.uk.xensource.com>
 <20150910162302.GN29293@leverpostej>
 <20150911124643.GB4530@olila.local.net-space.pl>
 <alpine.DEB.2.02.1509111410180.2672@kaball.uk.xensource.com>
 <CAKv+Gu9rN7_mxk0huX+34HSCC_aTWVTkUZKQMB1+9U56fRnwsA@mail.gmail.com>
 <20150911154534.GD4530@olila.local.net-space.pl>
 <55F6886D.1090900@huawei.com>
 <CAKv+Gu-xAAd=xTOh+qZvPDthgbRPLy=YwT4xfi4dS53EgJRh1Q@mail.gmail.com>
 <55F693F5.8030203@huawei.com>
Message-ID: <CAKv+Gu-2kyd3Gf3ceSa1jdgCjqJ8zBCesa4xehLiZ+VzergS3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(snip some cc's)

On 14 September 2015 at 11:31, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>
>
> On 2015/9/14 17:09, Ard Biesheuvel wrote:
>> On 14 September 2015 at 10:42, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>> [..]
>>
>>>
>>> It only needs to apply following patch to fix a bug in Linux kernel when
>>> mapping EFI_MEMORY_RUNTIME memory.
>>>
>>
>> Could you explain why you think efi_virtmap_init() should fail if
>> there are no EFI_MEMORY_RUNTIME regions?
>>
>
> My understanding is that if there are no EFI_MEMORY_RUNTIME regions, it
> means we can't use runtime services and should not set the bit
> EFI_RUNTIME_SERVICES of efi.flags. But if efi_virtmap_init() return
> true, the bit will be set.
>

As I said, if you don't want the EFI_RUNTIME_SERVICES bit to be set
for other reasons, don't rig efi_virtmap_init() to return false when
it shouldn't.

>> The absence of such regions is allowed by the spec, so
>> efi_virtmap_init() is correct imo to return success.
>>
> Sorry, not well know about the spec. Could you point out where the spec
> says this?
>

Well, I think it doesn't work that way. You are claiming that a memory
map without at least one EFI_MEMORY_RUNTIME constitutes an error
condition, so the burden is on you to provide a reference to the spec
that says you must have at least one such region.

-- 
Ard.
