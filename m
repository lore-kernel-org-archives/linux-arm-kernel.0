From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 28 Jun 2012 10:23:21 +0100
Subject: [PATCH 3/3] arm: mach-mvebu: system-controller only registers
 restart if device exists
In-Reply-To: <20120627191932.GE25319@n2100.arm.linux.org.uk>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <1340814406-26010-1-git-send-email-ben.dooks@codethink.co.uk>
 <1340814406-26010-4-git-send-email-ben.dooks@codethink.co.uk>
 <20120627191932.GE25319@n2100.arm.linux.org.uk>
Message-ID: <4FEC2289.80808@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/06/12 20:19, Russell King - ARM Linux wrote:
> On Wed, Jun 27, 2012 at 05:26:46PM +0100, Ben Dooks wrote:
>> Change to only registering the restart hook if the device exists
>> and can be enumerated in the device tree. Remove the header definiton
>> and the restart entry in the machine file.
>
> NAK.  Please use the .restart method in the machine description rather
> than directly using arm_pm_restart.  Thanks.
>
> arm_pm_restart only continues to exist because I could not work out how
> to stop AT91 from using it.

So what should you do if your board doesn't support this method of
resetting?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
