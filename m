From: james.morse@arm.com (James Morse)
Date: Thu, 28 Jun 2018 17:13:42 +0100
Subject: question about arm64 exception handling
In-Reply-To: <5B34CD7D.5090002@broadcom.com>
References: <5B34CD7D.5090002@broadcom.com>
Message-ID: <e54b3d4c-dbd0-b39d-28a2-063f34068dfd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arend,

On 28/06/18 12:58, Arend van Spriel wrote:
> I am looking at some issues we are seeing on a custom arm platform and I had
> some questions regarding exception handling and hope you can help me with that.
> 
> The platform has 4 cortex a53 cores running 4.1.51 kernel.

v4.1 is circa 2015, and chance you could try v4.17?


> On the platform upon
> accessing our wifi devices over PCIe, we observe two issue intermittently.
> 
> 1) synchronous external abort
> 2) NMI watchdog
> 
> With the latter I notice el1_irq in the exception stack trace. Is that due to
> the NMI watchdog or is this caused by another issue like our crappy hardware ;-) ?


> Regarding the SEA I noticed stuff has been added for that in 4.13. Is is worth
> backporting that to obtain more info about that?

Unlikely. Those changes are related to firmware-first RAS. You would see this on
server platforms booting with ACPI and have a 'HEST' table.

Can you share the backtrace for the Synchronous External Abort? It should point
at the instruction in the (probably) driver that causes the abort.


Thanks,

James
