From: keescook@chromium.org (Kees Cook)
Date: Thu, 3 Mar 2016 09:41:18 -0800
Subject: [PATCH] arm64: enable CONFIG_DEBUG_RODATA by default
In-Reply-To: <CAKv+Gu8hkFuSkAXWNCEC_qnxoZPcP3yo_Gue5fgUDVeUzoZnNw@mail.gmail.com>
References: <1457014259-32015-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAGXu5j+HzNfiiNkZb86iEtCWK4PC_MKax53hNWS7CXrpo5FE6Q@mail.gmail.com>
 <CAKv+Gu8hkFuSkAXWNCEC_qnxoZPcP3yo_Gue5fgUDVeUzoZnNw@mail.gmail.com>
Message-ID: <CAGXu5j+uP3zbLSUJ+SUJ3U9kk5GC+ndtxmdxAkGeZahYUj8VUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2016 at 8:56 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 3 March 2016 at 17:50, Kees Cook <keescook@chromium.org> wrote:
>> On Thu, Mar 3, 2016 at 6:10 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> In spite of its name, CONFIG_DEBUG_RODATA is an important hardening feature
>>> for production kernels, and distros all enable it by default in their
>>> kernel configs. However, since enabling it used to result in more granular,
>>> and thus less efficient kernel mappings, it is not enabled by default for
>>> performance reasons.
>>>
>>> However, since commit 2f39b5f91eb4 ("arm64: mm: Mark .rodata as RO"), the
>>> various kernel segments (.text, .rodata, .init and .data) are already
>>> mapped individually, and the only effect of setting CONFIG_DEBUG_RODATA is
>>> that the existing .text and .rodata mappings are updated late in the boot
>>> sequence to have their read-only attributes set, which means that any
>>> performance concerns related to enabling CONFIG_DEBUG_RODATA are no longer
>>> valid.
>>>
>>> So from now on, make CONFIG_DEBUG_RODATA default to 'y'
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>>
>> If this doesn't cause any problems, perhaps we can make it always 'y' soon?
>>
>
> You mean remove the option altogether? I would not mind, although
> arguably, being able to map .text and .rodata writable could be
> considered a useful debug option (and then it would almost, but not
> quite, live up to its name)

For x86 (and everything that implements mark_rodata_ro()) this will
soon be controlled by rodata=off on the kernel command line (i.e. it
skips mark_rodata_ro() during startup).

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
