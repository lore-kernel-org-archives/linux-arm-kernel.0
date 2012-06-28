From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jun 2012 11:17:46 +0100
Subject: [PATCH 3/3] arm: mach-mvebu: system-controller only registers
 restart if device exists
In-Reply-To: <4FEC2289.80808@codethink.co.uk>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <1340814406-26010-1-git-send-email-ben.dooks@codethink.co.uk>
 <1340814406-26010-4-git-send-email-ben.dooks@codethink.co.uk>
 <20120627191932.GE25319@n2100.arm.linux.org.uk>
 <4FEC2289.80808@codethink.co.uk>
Message-ID: <20120628101746.GI19026@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 10:23:21AM +0100, Ben Dooks wrote:
> On 27/06/12 20:19, Russell King - ARM Linux wrote:
>> On Wed, Jun 27, 2012 at 05:26:46PM +0100, Ben Dooks wrote:
>>> Change to only registering the restart hook if the device exists
>>> and can be enumerated in the device tree. Remove the header definiton
>>> and the restart entry in the machine file.
>>
>> NAK.  Please use the .restart method in the machine description rather
>> than directly using arm_pm_restart.  Thanks.
>>
>> arm_pm_restart only continues to exist because I could not work out how
>> to stop AT91 from using it.
>
> So what should you do if your board doesn't support this method of
> resetting?

Eh, what?

Set the .restart method in MACHINE_DESC or DT_MACHINE_DESC.  Try to avoid
using arm_pm_restart directly.

Simples.
