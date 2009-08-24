From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 24 Aug 2009 15:39:39 +0300
Subject: [PATCH 1/2 v2] ARM: OMAP4: Fix NULL pointer dereference crash.
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BA434EC2@dbde02.ent.ti.com>
	(Santosh Shilimkar's message of "Mon\,
	24 Aug 2009 17\:56\:00 +0530")
References: <1250928012-5233-1-git-send-email-santosh.shilimkar@ti.com>
	<87hbvytich.fsf@deeprootsystems.com>
	<87pralqvnp.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BA434EC2@dbde02.ent.ti.com>
Message-ID: <87tyzxper8.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

>> >>  static inline unsigned int serial_read_reg(struct plat_serial8250_port
>> *up,
>> >>  					   int offset)
>> >>  {
>> >> @@ -550,6 +564,17 @@ static struct omap_uart_state
>> omap_uart[OMAP_MAX_NR_PORTS] = {
>> >>  			},
>> >>  		},
>> >>  	},
>> >> +#ifdef CONFIG_ARCH_OMAP4
>> >> +	{
>> >> +		.pdev = {
>> >> +			.name			= "serial8250",
>> >> +			.id			= PLAT8250_DEV_FOURPORT,
>> >
>> > This should not be FOURPORT, it should just be a number.  In this case,
>> > it should be 3 (the others start from zero.)
>> 
>> Santosh,
>> 
>> I've changed the .id field to '3' and will queue up this fix for the
>> next merge window along with my fixes queue[1].  Please let me know if you
>> want to do otherwise.
>
> This is fine Kevin. Thanks !!
>
> Bye the way I have also posted v3 version in which I changed the .id field to 3.

Yeah, saw that after I replied.  Thanks!

Kevin
