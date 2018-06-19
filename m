From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 19 Jun 2018 22:34:38 +0200
Subject: [PATCH 0/2] Make badr macro compatible with newer GAS versions
In-Reply-To: <20180619203223.GA28370@roeck-us.net>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
 <20180619203223.GA28370@roeck-us.net>
Message-ID: <CAKv+Gu-RHM7HAmzWw9Ge+w21kWxKxLbJT7DD5huv-7WWOPUVWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 June 2018 at 22:32, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Jun 19, 2018 at 09:26:31PM +0200, Ard Biesheuvel wrote:
>> Work around the mindless and backward incompatible change in GAS that
>> prevents us from using a simple addition to set the Thumb bit in local
>> symbol references taken using 'adr' instructions (#2)
>>
>> As a preparatory step, remove badr occurrences in ARM code sequences
>> contained in Thumb2 kernels.
>>
>> Ard Biesheuvel (2):
>>   ARM: avoid badr macro for switching to Thumb-2 mode
>>   ARM: assembler: prevent ADR from setting the Thumb bit twice
>>
>
> This doesn't work for images built with a toolchain based on gcc 7.3.0
> and binutils 2.28.1. It _does_ work for images built with gcc 7.3.0/
> binutils 2.30.
>

Sigh.

So does it fail? Or is the resulting binary broken?
