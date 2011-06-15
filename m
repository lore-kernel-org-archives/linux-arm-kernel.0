From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 14 Jun 2011 23:37:29 -0600
Subject: [PATCH V2] ARM: Xilinx: Adding Xilinx board support
In-Reply-To: <BANLkTi=rV0K3J4rsPVKw73KRG-E2h_CE=A@mail.gmail.com>
References: <1305657064-4531-1-git-send-email-johnlinn@comcast.net>
	<BANLkTi=rV0K3J4rsPVKw73KRG-E2h_CE=A@mail.gmail.com>
Message-ID: <BANLkTinrBw1RsP09bwbmDJC9Pd5NguMEUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 9:23 PM, Barry Song <21cnbao@gmail.com> wrote:
> 2011/5/18 ?<johnlinn@comcast.net>:
>> +static struct of_device_id zynq_of_bus_ids[] __initdata = {
>> + ? ? ? { .compatible = "simple-bus", },
>> + ? ? ? {}
>> +};
>> +
>> +/**
>> + * xilinx_init_machine() - System specific initialization, intended to be
>> + * ? ? ? ? ? ? ? ? ? ? ? ?called from board specific initialization.
>> + */
>> +void __init xilinx_init_machine(void)
>> +{
>> +#ifdef CONFIG_CACHE_L2X0
>> + ? ? ? /*
>> + ? ? ? ?* 64KB way size, 8-way associativity, parity disabled
>> + ? ? ? ?*/
>> + ? ? ? l2x0_init(PL310_L2CC_BASE, 0x02060000, 0xF0F0FFFF);
>> +#endif
>> +
>> + ? ? ? of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
>> +}
>
> it looks to me a common machine init function is calling a
> chip/board-special device probing. xilinx_init_machine ?is calling
> zynq_of_bus_ids. what will happen if we add a new different with zynq?

The bus_ids are actually pretty generic.  I've got a patch in my tree
which I'll be posting soon that creates a generic bus id table that
most platforms can use.

g.
