From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 1 Sep 2015 07:57:45 -0700
Subject: arm64: how to check endianness of Image file?
In-Reply-To: <20150901141746.GA19729@leverpostej>
References: <CAMAWPa8EW92OAAVn7FOkBzPbtsQLQDpU1F0TM3uuTFa9P6bYOA@mail.gmail.com>
 <20150901141746.GA19729@leverpostej>
Message-ID: <CAMAWPa_q-AHXkGUN0S+0Ozd3DAjag71v8_sujY=2+9gq30GzGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 1, 2015 at 7:17 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Kevin,
>
> On Fri, Aug 28, 2015 at 11:23:20PM +0100, Kevin Hilman wrote:
>> Will, Catalin,
>>
>> Any suggestions on a quick way to check if an arm64 kernel Image file
>> is big-endian?
>>
>> We're adding more boot support for arm64 defconfig +
>> CONFIG_CPU_BIG_ENDIAN=y to kernelci.org, and are looking for a
>> reliable way to check the endianness of the kernel Image file, we
>> don't have the vmlinux around to check the ELF headers.
>>
>> On arm32, the zImage has some magic fields set from
>> arch/arm/boot/compressed/head.S, but arm64 doesn't have the
>> equivalent.
>
> We have an endianness flag in the arm64 Image header, added per your
> request in v3.17 [1,2].

Doh, I completely forgot about that. :/   Thanks for the reminder!

Kevin
