From: roy.franz@linaro.org (Roy Franz)
Date: Fri, 14 Feb 2014 11:02:49 -0800
Subject: [PATCH 06/22] Add helper functions used by arm/arm64
In-Reply-To: <20140213112606.GF20717@console-pimps.org>
References: <1391619853-10601-1-git-send-email-leif.lindholm@linaro.org>
 <1391619853-10601-7-git-send-email-leif.lindholm@linaro.org>
 <20140213112606.GF20717@console-pimps.org>
Message-ID: <CAFECyb_wUphr4XOyW9tC-Rw5Py3m39e6GQorCtFGtSXTUTBnFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 3:26 AM, Matt Fleming <matt@console-pimps.org> wrote:
> On Wed, 05 Feb, at 05:03:57PM, Leif Lindholm wrote:
>> From: Roy Franz <roy.franz@linaro.org>
>>
>> Add the get_dram_base() function and efi_call_physN() macros
>> that are shared by arm/arm64.
>>
>> Signed-off-by: Roy Franz <roy.franz@linaro.org>
>> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
>> ---
>>  drivers/firmware/efi/efi-stub-helper.c |   63 +++++++++++++++++++++++++-------
>>  1 file changed, 50 insertions(+), 13 deletions(-)
>
> These changes should be in drivers/firmware/efi/arm-stub.c -
> efi-stub-helper.c is not a dumping ground for random
> architecture-specific code.

Hi Matt,

  I will move those functions/macros to the arm-stub.c file.  I agree
that the macros should go there, as they are the arm specific versions
and conflict with the x86 versions defined elsewhere.  These were
there before the arm-stub.c file was added and didn't get moved when
it was.  The get_dram_base() function is only used by arm/arm64, but
there is nothing architecture specific about it, which is why I put it
here to begin with.  I don't feel strongly about this either way.

Thanks,
Roy


>
> --
> Matt Fleming, Intel Open Source Technology Center
