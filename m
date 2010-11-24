From: bengt.g.jonsson@stericsson.com (Bengt Jonsson)
Date: Wed, 24 Nov 2010 09:24:14 +0100
Subject: [PATCH 1/3] mfd: Added new regulator_data pointer to ab8500 board
	configuration
In-Reply-To: <20101123183037.GA19212@rakim.wolfsonmicro.main>
References: <1290536754-21775-1-git-send-email-bengt.g.jonsson@stericsson.com>
	<1290536754-21775-2-git-send-email-bengt.g.jonsson@stericsson.com>
	<20101123183037.GA19212@rakim.wolfsonmicro.main>
Message-ID: <4CECCBAE.6080707@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-11-23 19:30, Mark Brown wrote:
> On Tue, Nov 23, 2010 at 07:25:52PM +0100, Bengt Jonsson wrote:
>
>> The ab8500 regulator board configuration will be better separated
>> from the MFD board configuration. This patch adds a void pointer
>> for this purpose.
>
> Adding something completely typesafe seems like a real loss - if you
> want to point to something else at least point to a particular type -
> eg,
>
> struct foo;
>
> struct pdata {
> 	int other_stuff;
> 	struct foo *foo;
> };
>
I get your point, I'll try this out.
>>   	struct regulator_init_data *regulator[AB8500_NUM_REGULATORS];
>> +	void *regulator_data;
>
> It'd also help if you could articulate the problem you see with the
> current approach...
The problem I see is that ab8500-core defines the number of regulators 
which I can see no reason for. If someone wants to add or remove a 
regulator they have to make a change in include/linux/mfd/ab8500.c as 
well as in the regulator files.

I will add a better description in an updated patch.
