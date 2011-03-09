From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 09 Mar 2011 09:41:23 +0200
Subject: [PATCH 2/3] ARM: tegra: harmony: initialize the TPS65862 PMIC
In-Reply-To: <20110308131541.GB5892@sirena.org.uk>
References: <cover.1299588456.git.mike@compulab.co.il>
	<4ade6d195fff78271085eafb0a99de3be8beb426.1299588456.git.mike@compulab.co.il>
	<20110308131541.GB5892@sirena.org.uk>
Message-ID: <4D772F23.70304@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/11 15:15, Mark Brown wrote:
> On Tue, Mar 08, 2011 at 02:58:58PM +0200, Mike Rapoport wrote:
> 
>> +static struct regulator_consumer_supply tps658621_ldo2_supply[] = {
>> +	REGULATOR_SUPPLY("vdd_rtc", NULL),
>> +};
> 
> I feel sure that some of these could be using a struct device, though
> since they're probably all going to be required to be always on I'd
> expect it's not useful to have them mapped as supplies at all and the
> drivers could just assume they were there.

I'd prefer to keep it as is for now and update the supplies when merging the
drivers that actually use them.

>> +#define REGULATOR_INIT(_id, _minmv, _maxmv)				\
>> +	{								\
> 
> This should be namespaced, someone might add a generic macro with that
> name.

Ok, will fix.

-- 
Sincerely yours,
Mike.
