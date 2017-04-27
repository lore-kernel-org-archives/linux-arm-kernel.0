From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Apr 2017 13:11:54 +0200
Subject: [PATCH, 3.18-stable regression] ARM: psci: fix header file
In-Reply-To: <20170427100124.GE1755@kroah.com>
References: <20170421135923.2735181-1-arnd@arndb.de>
 <20170427100124.GE1755@kroah.com>
Message-ID: <CAK8P3a2C+0voNpqh=rMbRM4hcVUiYs8KgCRi6AadMn4F5jn7OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 12:01 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Apr 21, 2017 at 03:59:17PM +0200, Arnd Bergmann wrote:
>> Commit be95485a0b828 was incorrectly backported to 3.18 and
>> now causes a different build error when CONFIG_SMP is disabled:
>>
>>  arch/arm/kernel/psci.c:287:12: error: redefinition of 'psci_init'
>>
>> This version is how it should be on 3.18, with the main psci
>> code built for both SMP and UP, but the psci_smp_available()
>> function only being available for SMP builds.
>>
>> Fixes: dbcfee724255 ("ARM: 8457/1: psci-smp is built only for SMP")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/arm/include/asm/psci.h | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> This should have already been fixed in 3.18.50 as dbcfee724255 was
> reverted there.  Because of that, this patch does not apply to the
> 3.18-stable tree.

Confirmed. The report was for 3.18.49 and I already noticed the error
is gone in the 3.18.50 kernelci build report.

      Arnd
