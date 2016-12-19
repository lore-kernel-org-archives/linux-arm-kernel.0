From: romain.perier@free-electrons.com (Romain Perier)
Date: Mon, 19 Dec 2016 15:58:17 +0100
Subject: [PATCH 3/4] net: dsa: mv88e6xxx: Add support for ethernet switch
 88E6341/88E6141
In-Reply-To: <20161219145227.GC10048@lunn.ch>
References: <20161219141610.30934-1-romain.perier@free-electrons.com>
 <20161219141610.30934-4-romain.perier@free-electrons.com>
 <20161219145227.GC10048@lunn.ch>
Message-ID: <bc0af369-28a9-af38-723b-d4b182bb153e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Le 19/12/2016 ? 15:52, Andrew Lunn a ?crit :
> Hi Romain
>
>> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
>> index 76d944e..72ba24b 100644
>> --- a/drivers/net/dsa/mv88e6xxx/chip.c
>> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
>> @@ -4086,6 +4086,20 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>>  		.ops = &mv88e6321_ops,
>>  	},
>>
>> +	[MV88E6341] = {
>> +		.prod_num = PORT_SWITCH_ID_PROD_NUM_6341,
>> +		.family = MV88E6XXX_FAMILY_6352,
>> +		.name = "Marvell 88E6341",
>> +		.num_databases = 4096,
>> +		.num_ports = 6,
>> +		.port_base_addr = 0x10,
>> +		.global1_addr = 0x1b,
>> +		.age_time_coeff = 15000,
>> +		.tag_protocol = DSA_TAG_PROTO_EDSA,
>> +		.flags = MV88E6XXX_FLAGS_FAMILY_6352,
>> +		.ops = &mv88e6352_ops,
>
> Even if it i 100% compatible with the 6532, you should still add an
> ops structure for it. All chips have their own, even when the are
> exactly the same as other in the family.

Ack, I will fix this.

>
>> --- a/drivers/net/dsa/mv88e6xxx/mv88e6xxx.h
>> +++ b/drivers/net/dsa/mv88e6xxx/mv88e6xxx.h
>> @@ -86,6 +86,7 @@
>>  #define PORT_SWITCH_ID_PROD_NUM_6097	0x099
>>  #define PORT_SWITCH_ID_PROD_NUM_6131	0x106
>>  #define PORT_SWITCH_ID_PROD_NUM_6320	0x115
>> +#define PORT_SWITCH_ID_PROD_NUM_6341	0x340
>>  #define PORT_SWITCH_ID_PROD_NUM_6123	0x121
>>  #define PORT_SWITCH_ID_PROD_NUM_6161	0x161
>
> Ah, err..
>
> These should be in numerical order of the macro.
> PORT_SWITCH_ID_PROD_NUM_6320 is however in the wrong place.  Please
> put the 6341 after the 6321.

good catch, ok.

Thanks,
Romain
