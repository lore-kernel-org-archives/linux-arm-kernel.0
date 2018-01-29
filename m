From: slash.tmp@free.fr (Mason)
Date: Mon, 29 Jan 2018 12:59:46 +0100
Subject: [RFC 09/10] x86/enter: Create macros to restrict/unrestrict
 Indirect Branch Speculation
In-Reply-To: <20180125171616.GA25130@kroah.com>
References: <CA+55aFxUEPHc7JRQG3zmxEsfmfJOiJa1QqFBKCBNb5Tt5vfiSg@mail.gmail.com>
 <1516566497.9814.78.camel@infradead.org>
 <CA+55aFwOkH8RH12Dzs=hT3e7eS3Ckz9Ed6x_-9a0zs1cw9zbKA@mail.gmail.com>
 <1516572013.9814.109.camel@infradead.org>
 <CA+55aFwoxXmY0u84iPT-RP8DoG+Qb8t-mh2r8RLhKVAH3jm6qg@mail.gmail.com>
 <1516638426.9521.20.camel@infradead.org>
 <20180123072930.soz25cyky3u4hpgv@gmail.com>
 <20180123075358.nztpyxympwfkyi2a@gmail.com>
 <1516699832.9521.123.camel@infradead.org>
 <d77abfaf-077a-0ae6-8ed7-3b5354938a52@free.fr>
 <20180125171616.GA25130@kroah.com>
Message-ID: <1b430c16-2090-41e3-82d7-ef3d9b63fe2b@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Dropping large CC list ]

On 25/01/2018 18:16, Greg Kroah-Hartman wrote:

> On Thu, Jan 25, 2018 at 05:19:04PM +0100, Mason wrote:
> 
>> On 23/01/2018 10:30, David Woodhouse wrote:
>>
>>> Skylake takes predictions from the generic branch target buffer when
>>> the RSB underflows.
>>
>> Adding LAKML.
>>
>> AFAIU, some ARM Cortex cores have the same optimization.
>> (A9 maybe, A17 probably, some recent 64-bit cores)
>>
>> Are there software work-arounds for Spectre planned for arm32 and arm64?
> 
> Yes, I think they are currently buried in one of the arm64 trees, and
> they have been posted to the mailing list a few times in the past.

Found the burial ground, thanks Greg.

  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti

Via https://developer.arm.com/support/security-update

"For Cortex-R8, Cortex-A8, Cortex-A9, and Cortex-A17, invalidate
the branch predictor using a BPIALL instruction."

The latest arm32 patch series was submitted recently:

  https://www.spinics.net/lists/arm-kernel/msg630892.html

Regards.
