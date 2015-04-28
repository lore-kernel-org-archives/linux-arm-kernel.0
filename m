From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 28 Apr 2015 19:57:51 +0200
Subject: [PATCH 0/2] Add support for PL172 memory-controller
In-Reply-To: <20150428173623.GA1573@arm.com>
References: <1430241879-30046-1-git-send-email-manabian@gmail.com>
 <20150428173623.GA1573@arm.com>
Message-ID: <CAGhQ9VxZFxFOhMD2K6SoOtkiCURZh102ZXG8fw1zixuvqocCKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 April 2015 at 19:36, Will Deacon <will.deacon@arm.com> wrote:
> Hi Joachim,
>
> On Tue, Apr 28, 2015 at 06:24:37PM +0100, Joachim Eastwood wrote:
>> This patch set adds support for setting up static memory devices on
>> a ARM PrimeCell MultiPort Memory Controller (PL172) from DT. Dynamic
>> memory (SDRAM) is not supported in this patch set.
>>
>> DT bindings for PL172 is based on the bindings for the TI AEMIF
>> memory controller. PL172 can be found on a number of NXP devices
>> like the LPC18xx family.
>>
>> Tested on Embedded Artists' LPC4357 Developer's Kit with NOR Flash
>> (SST39VF320) and 74LCV16374 (gpio-74x164) on MPMC.
>
> Please excuse my ignorance here, but is this memory controller used to
> manage the memory in use by the kernel? If so, how is it safe to reconfigure
> it dynamically at runtime?

The driver is used to do a one-time configuration of static chip selects on
driver probe using the parameters specified in DT. The device nodes under the
MPMC node is only populated and then driver probed after the parameters has
been setup. This how most of drivers under drivers/memory operates.

>If not, then it might be worth describing
> some typical use-cases in the binding documentation to motivate the
> existence of this driver.

The typical use case is Flash memory (NAND and NOR) configuration and
timing setup but you could configure any kind of static memory devices on
the bus. But as described above this only happens at driver probe time.

Hope this answer your question.

regards,
Joachim Eastwood
