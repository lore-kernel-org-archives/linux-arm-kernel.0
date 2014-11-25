From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 25 Nov 2014 13:38:01 +0100
Subject: [RFC PATCH v2 3/4] arm64:thunder: Add initial dts for Cavium's
 Thunder SoC in 2 Node topology.
In-Reply-To: <2750247.HT2ynjYizJ@wuerfel>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <4080571.JcHDsAZ9EV@wuerfel>
 <CAFECyb8aObzJeiL4uB+N6D83GKqJ5tgYGJJJQXRQiEqMegg3Ng@mail.gmail.com>
 <2750247.HT2ynjYizJ@wuerfel>
Message-ID: <CAKv+Gu-EEmj1cV-N9tAijotV9Wj9drwajkoTVnRijHLiCskywg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 November 2014 at 18:01, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 24 November 2014 11:32:46 Roy Franz wrote:
>> >
>> > I don't know how much history is behind this binding. Have you looked
>> > at the sPAPR way of doing this? I don't remember exactly how that is
>> > done, but we'd need a good reason to discard that and implement
>> > something else for arm64.
>> >
>> > If we create a new binding, I don't think the 'numa-map' node you
>> > have here is the best solution. We already have device nodes for each
>> > memory segment and each CPU in the system. Why not work with those
>> > nodes directly?
>>
>> The DT memory nodes don't exist in an EFI system, as the EFI memory
>> map is used instead.
>> Using EFI as the boot firmware doesn't require the use of ACPI for
>> hardware description,
>> so the EFI/DT case is one that we should support.
>
> But they /could/ exist, right? Can we just require them to be
> present in order to use NUMA features?
>

Actually, currently the memory nodes are stripped from the device tree
by the EFI stub, so the kernel will never get to see them.
This is done more or less as a fixup, under the assumption that EFI
systems should not have DT memory nodes in the first place.

We could revisit this, of course, but it needs to be taken into
account in this discussion.

-- 
Ard.
