From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Mon, 8 Aug 2016 13:44:59 -0700
Subject: [PATCH v18 6/6] ARM: socfpga: fpga bridge driver support
In-Reply-To: <alpine.DEB.2.02.1608081416110.11063@linuxheads99>
References: <20160712193645.9098-1-atull@opensource.altera.com>
 <20160712193645.9098-7-atull@opensource.altera.com>
 <CAP=VYLo2jtp57kQe5671xM=4o_ZAU6XG_W1MXU8aPv4Ws7kkDA@mail.gmail.com>
 <alpine.DEB.2.02.1608081416110.11063@linuxheads99>
Message-ID: <CAAtXAHev2Dytadp-_Hs0agcSXUTyrFhJQxHcsFd7faOReHzr9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On Mon, Aug 8, 2016 at 12:18 PM, atull <atull@opensource.altera.com> wrote:

>> Please don't use module.h in drivers controlled by a bool
>> Kconfig setting.
>>
>> THanks,
>> Paul.
>>
>
> Thanks for the feedback.  Can you provide an example of what you
> would consider to be proper usage in the kernel?


I think Paul is suggesting to use

static int __init alt_fpga_bridge_init(void)
{
        platform_driver_register(&alt_fpga_bridge_driver);
}

device_initcall(alt_fpga_bridge_init);

or better:

builtin_platform_driver(&alt_fpga_bridge_driver);

Like for example in: drivers/cpuidle/cpuidle-mvebu-v7.c

Cheers,

Moritz
