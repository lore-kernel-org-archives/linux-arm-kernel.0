From: robherring2@gmail.com (Rob Herring)
Date: Wed, 26 Mar 2014 11:08:09 -0500
Subject: [PATCH v5 02/11] ARM/ARM64: KVM: Add base for PSCI v0.2 emulation
In-Reply-To: <CAJ5Y-eaiuV=TijB8cj4i8GY8CoN+qOT9C2Jsq4-kJmfCpY7Ciw@mail.gmail.com>
References: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
 <1395406414-11707-3-git-send-email-anup.patel@linaro.org>
 <20140321232704.GB25519@cbox>
 <CALrVBkvRqRWnnzgBYCLGwYbiOy-JnezgE=89nq8O3rvdv7RqFw@mail.gmail.com>
 <20140323174431.GE30885@cbox>
 <CABGGisxYq6+4ZBni8EyU_w7WzivBKjRHT2LZu_bJMnNa=jWF-w@mail.gmail.com>
 <CAJ5Y-eaiuV=TijB8cj4i8GY8CoN+qOT9C2Jsq4-kJmfCpY7Ciw@mail.gmail.com>
Message-ID: <CAL_JsqJF9wJnszmwnAkqQe_h5Jinp9jYZzRfOP2VnmjdWAHTPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 10:32 AM, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> Hello,
>
> On 24 March 2014 09:26, Rob Herring <rob.herring@linaro.org> wrote:
>
>>>>
>>>> My suggestion would be to have:
>>>> arch/arm/include/uapi/asm/psci.h
>>>> arch/arm64/include/uapi/asm/psci.h
>>>
>>> I think the suggestion was to move all this to include/uapi/linux/psci.h
>>> or something equivalent so also arm and arm64 can share these defines,
>>> but maybe I read too much into it.
>>
>> Yes. It is perfectly fine for a somewhat architecture specific header
>> to live in include/linux (or include/uapi/linux).
>>
>>
> While I'm aware that we wouldn't want to push seemingly irrelevant
> stuff into this header, I'm thinking of ways to unify the ARM and
> ARM64 PSCI code. A lot of it is reusable between the two.
> So, can this header also include all the common PSCI functions between
> ARM and ARM64? And can KVM possibly use these functions as well?

Anything under uapi should be related to the PSCI ABI. If there are
headers to be shared that are just kernel implementation specific,
then they can go in include/linux/.

> Alternately, is drivers/psci.c a more suitable place? In this case, at
> least one function will be guarded by CONFIG_ARM64.

No. For .c files, I don't think we have a good solution. Some of the
kvm stuff does ../../ type includes back to arch/arm, but that's not a
very clean solution.

Rob
