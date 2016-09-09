From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 9 Sep 2016 17:28:51 +0800
Subject: [PATCH v10 3/4] ARM64: ACPI: enable ACPI_SPCR_TABLE
In-Reply-To: <1473352456.21193.8.camel@redhat.com>
References: <20160905123617.18775-1-aleksey.makarov@linaro.org>
 <20160905123617.18775-4-aleksey.makarov@linaro.org>
 <7e5486cc-4080-2d1e-8f6d-98874379887d@gmail.com>
 <20160908111654.GH1493@arm.com> <1473352456.21193.8.camel@redhat.com>
Message-ID: <706e4bc9-1010-ba2d-55ec-dc6f24611bd3@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/9/9 0:34, Mark Salter wrote:
> On Thu, 2016-09-08 at 12:16 +0100, Will Deacon wrote:
>> On Wed, Sep 07, 2016 at 12:30:19PM +0300, Aleksey Makarov wrote:
>>>
>>>
>>> On 09/05/2016 03:36 PM, Aleksey Makarov wrote:
>>>>
>>>> SBBR mentions SPCR as a mandatory ACPI table.  So enable it for ARM64
>>>>
>>>> Earlycon should be set up as early as possible.  ACPI boot tables are
>>>> mapped in arch/arm64/kernel/acpi.c:acpi_boot_table_init() that
>>>> is called from setup_arch() and that's where we parse SPCR.
>>>> So it has to be opted-in per-arch.
>>>>
>>>> When ACPI_SPCR_TABLE is defined initialization of DT earlycon is
>>>> deferred until the DT/ACPI decision is done.  Initialize DT earlycon
>>>> if ACPI is disabled.
>>> Hi Will, Catalin,
>>>
>>> Can you review this patch and consider ACKing it please?
>> Hanjun, Al, Mark, Graeme -- any comments on this?
>>
>> Will
>
> I think there is a problem still with systems using 32-bit access to 8250
> UARTs (i.e. Mustang) but that will need a DBG2 table spec change and
> followup patch to resolve.

Hmm, I think you mean we can add patches later with the spec updated,
and this patch works with SBSA pl011 can go for now?

Thanks
Hanjun
