From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Apr 2015 18:36:24 +0100
Subject: [PATCH 0/2] Add support for PL172 memory-controller
In-Reply-To: <1430241879-30046-1-git-send-email-manabian@gmail.com>
References: <1430241879-30046-1-git-send-email-manabian@gmail.com>
Message-ID: <20150428173623.GA1573@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

On Tue, Apr 28, 2015 at 06:24:37PM +0100, Joachim Eastwood wrote:
> This patch set adds support for setting up static memory devices on
> a ARM PrimeCell MultiPort Memory Controller (PL172) from DT. Dynamic
> memory (SDRAM) is not supported in this patch set.
> 
> DT bindings for PL172 is based on the bindings for the TI AEMIF
> memory controller. PL172 can be found on a number of NXP devices
> like the LPC18xx family.
> 
> Tested on Embedded Artists' LPC4357 Developer's Kit with NOR Flash
> (SST39VF320) and 74LCV16374 (gpio-74x164) on MPMC.

Please excuse my ignorance here, but is this memory controller used to
manage the memory in use by the kernel? If so, how is it safe to reconfigure
it dynamically at runtime? If not, then it might be worth describing
some typical use-cases in the binding documentation to motivate the
existence of this driver.

Cheers,

Will
