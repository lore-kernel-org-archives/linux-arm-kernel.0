From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 1 Oct 2018 17:06:06 +0200
Subject: [PATCH v3 1/4] DYNAMIC_FTRACE configurable with and without REGS
In-Reply-To: <20181001150353.GA2634@lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141643.331EE68BC7@newverein.lst.de>
 <CAKv+Gu-ZtJ-BpfPWU=soDCb2+dAd81p8OtaarWhmTe+Fk6A8ig@mail.gmail.com>
 <20181001150353.GA2634@lst.de>
Message-ID: <CAKv+Gu9tvbM=tb-LJVJtGaq5wD0woX2gtdST+22xJnjZmc_SxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 October 2018 at 17:03, Torsten Duwe <duwe@lst.de> wrote:
> On Mon, Oct 01, 2018 at 04:52:27PM +0200, Ard Biesheuvel wrote:
>>
>> I guess we now have Kbuild/Kconfig support for this, no? I mean, we
>> can now show/hide options depending on the capabilities of the
>> toolchain.
>
> Config options depending on flags availability?
>

Yes. Note that 'make menuconfig' now prints the compiler version at
the top, and kconfig options can now 'depend' on compiler features,
although I must admit I don't know how it works.

>> I am not saying it would be a better approach, though - I'd rather
>> have a warning than have things silently disabled, but other people
>> may think differently.
>
> Even then this switch has to be enabled, no matter who or what sets it.
> Note that this patch leaves everything as-is. Only arm64 users with
> "old" compilers would need to take action.
>
>         Torsten
>
