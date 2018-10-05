From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 5 Oct 2018 16:03:53 +0200
Subject: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
In-Reply-To: <20181005135728.GR19272@hirez.programming.kicks-ass.net>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
 <20181005135728.GR19272@hirez.programming.kicks-ass.net>
Message-ID: <CAKv+Gu_GpeqvTHC0E341ehvbYVyEiXMxirijhFTJrwo0OMrdAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2018 at 15:57, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>> Add a function pointer abstraction that can be implemented by the arch
>> in a manner that avoids the downsides of function pointers, i.e., the
>> fact that they are typically located in a writable data section, and
>> their vulnerability to Spectre like defects.
>>
>> The FFP (or fast function pointer) is callable as a function, since
>> the generic incarnation is simply that. However, due to the fact that
>> C does not distinguish between functions and function pointers at the
>> call site, the architecture can instead emit it as a patchable sequence
>> of instructions consisting of ordinary branches.
>
> This is basically a static_key, except for indirection function calls?

Yes, that is why I put you on cc :-)

> So why not call the thing static_func or static_call or something like
> that?

Yep that sounds better.
