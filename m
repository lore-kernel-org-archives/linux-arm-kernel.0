From: robherring2@gmail.com (Rob Herring)
Date: Thu, 30 Aug 2012 10:27:15 -0500
Subject: [PATCH 00/10] Make mach/gpio.h optional
In-Reply-To: <20120829234030.GV18957@n2100.arm.linux.org.uk>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <20120829234030.GV18957@n2100.arm.linux.org.uk>
Message-ID: <503F8653.40908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2012 06:40 PM, Russell King - ARM Linux wrote:
> On Wed, Aug 29, 2012 at 05:31:26PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This series makes mach/gpio.h optional like we have done for other mach
>> headers in preparation for multi-platform kernel images. Unfortunately,
>> it adds more mach includes to drivers/, but really they are just now
>> explicitly included and easily found.
> 
> This in general looks like a complete backwards step rather than a forwards
> step for multi-platform kernels.  All these drivers are not going to be
> usable in multi-platform kernel images, because with mach/ includes they're
> not going to be picking up the correct set of headers.

These drivers are already not usable. I'm just making that obvious.

> So all these SoC types might as well not be part of the multi-platform
> project until they get their act together with their headers.

Precisely the point. It is pushing the problem to the sub-arches so they
can clean-up their stuff if they want to get into a multi-plat image. I
expect we will see some clean starting in parallel with this. The omap
folks are working omap headers and there were some clean-ups for Marvell
parts posted. Arnd has platform_data header series he is working on.

Rob
