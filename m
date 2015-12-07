From: keescook@chromium.org (Kees Cook)
Date: Mon, 7 Dec 2015 13:56:02 -0800
Subject: [PATCH] ARM: mm: mark section-aligned portion of rodata NX
In-Reply-To: <CAKv+Gu-q4ziskce+KneLTKZWi+sB_-4ZG4tyYssK7HNyqxAn4A@mail.gmail.com>
References: <20151207205432.GA5271@www.outflux.net>
 <CAKv+Gu-q4ziskce+KneLTKZWi+sB_-4ZG4tyYssK7HNyqxAn4A@mail.gmail.com>
Message-ID: <CAGXu5jKOn7S-GVu4bZU+B3QbrJZxen4mPzK7-TyzcFf7YiKDNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 7, 2015 at 1:52 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 7 December 2015 at 21:54, Kees Cook <keescook@chromium.org> wrote:
>> When rodata is large enough that it crosses a section boundary after the
>> kernel text, mark the rest NX. This is as close to full NX of rodata as
>> we can get without splitting page tables or doing section alignment via
>> CONFIG_DEBUG_ALIGN_RODATA.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> I am baffled why I can't put the ALIGN in the ".start = " initializer.
>> GCC seems to think it's non-static, but only because of the "&" operator.
>> Does anyone see a way to do this that doesn't require the runtime ALIGN?
>
> Yes, but you need to move the ALIGN() expression to the linker script
> as the value of a new symbol

I didn't see a way to do this without actually bumping the alignment
(CONFIG_DEBUG_ALIGN_RODATA already does that, I want the other case).
Do you have an example anywhere I could look at?

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
