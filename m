From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Mon, 27 Oct 2014 13:34:32 -0500
Subject: [PATCH] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <20141027135035.GA2629@leverpostej>
References: <1414153221-13104-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20141027135035.GA2629@leverpostej>
Message-ID: <544E9038.5050004@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 8:50 AM, Mark Rutland wrote:
> Hi Suravee,
>
> [...]
>
>> +	chosen {
>> +		linux,stdout-path = "console=ttyAMA0,115200 earlycon=pl011,0xe1010000";
>
> The stdout-path property should just be a path to the UART node. It's
> not a direct replacement for /chosen/bootargs.
>
> This should be (assuming you fix up the label above):
>
> 	stdout-path = &serial0;
>
> That will give us earlycon if "earlycon" (with no arguments) is provided
> on the command line, and should set up that UART as the console. There's
> no need for the "linux," prefix now either.
>
> Unfortuantely, I believe that the UART rate will get changed when the
> real PL011 driver registers, unless the rate is explicitly provided on
> the command line. It might be worth looking into retaining the
> configured rate somehow indepentent of bootargs (unless overriden).

Thanks for the explanation. I think I should be able to get rid of the 
"console=ttyAMA0,115200 earlycon=pl011,0xe1010000" altogether. I'll send 
out V2 soon.

Thanks,

Suravee

> Thanks,
> Mark.
>
