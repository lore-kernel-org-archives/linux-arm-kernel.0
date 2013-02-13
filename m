From: robherring2@gmail.com (Rob Herring)
Date: Wed, 13 Feb 2013 10:33:07 -0600
Subject: [PATCH 1/4] clocksource: pass DT node pointer to init functions
In-Reply-To: <CAHTX3dKLCbfhBaHKBE=fVTcRReVL6yotA9e_8S70bH+_gajL5Q@mail.gmail.com>
References: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
 <1360264144-20714-2-git-send-email-robherring2@gmail.com>
 <CAHTX3dKLCbfhBaHKBE=fVTcRReVL6yotA9e_8S70bH+_gajL5Q@mail.gmail.com>
Message-ID: <511BC043.4030506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2013 10:21 AM, Michal Simek wrote:
> 2013/2/7 Rob Herring <robherring2@gmail.com>:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> In cases where we have multiple nodes of the same type, we may need the
>> node pointer to know which node was matched. Passing the node pointer
>> also keeps the init function from having to match the node a 2nd time.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: John Stultz <johnstul@us.ibm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  drivers/clocksource/clksrc-of.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Tested-by: Michal Simek <michal.simek@xilinx.com>
> 
> The rest is just the same as I have done. Any option to add these
> patches to v3.9?

I would like to before we have more users to fix, but it will have to be
post rc1. If not, Arnd/Olof should be be able to provide a stable branch
for 3.10.

> Because I need these patches for zynq timer because we have two in the soc.
> Is it OK to register several clock source and clockevent devices?

If it is 1 DT node, then that should be fine.

> btw: there is still one issue because you can just setup only one
> compatibility string.

You can have multiple CLOCKSOURCE_OF_DECLARE statements. The gic code
does this for irqchips.

Rob
