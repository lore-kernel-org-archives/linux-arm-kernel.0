From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 09 Mar 2011 15:23:11 +0200
Subject: [PATCH 2/3] ARM: tegra: harmony: initialize the TPS65862 PMIC
In-Reply-To: <20110309131511.GB30257@opensource.wolfsonmicro.com>
References: <cover.1299588456.git.mike@compulab.co.il>
	<4ade6d195fff78271085eafb0a99de3be8beb426.1299588456.git.mike@compulab.co.il>
	<20110308131541.GB5892@sirena.org.uk>
	<4D772F23.70304@compulab.co.il>
	<20110309101508.GD6923@opensource.wolfsonmicro.com>
	<4D776A42.9030107@compulab.co.il>
	<20110309122222.GG6923@opensource.wolfsonmicro.com>
	<4D777E6C.5040000@compulab.co.il>
	<20110309131511.GB30257@opensource.wolfsonmicro.com>
Message-ID: <4D777F3F.40208@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/11 15:15, Mark Brown wrote:
> On Wed, Mar 09, 2011 at 03:19:40PM +0200, Mike Rapoport wrote:
>> On 03/09/11 14:22, Mark Brown wrote:
> 
>>> Note that there's no issue with having no supplies set for a regulator
>>> so no reason not to register the supplies themselves, it's just the
>>> supply map that I was flagging.
> 
>> I.e. having something like
> 
>> static struct regulator_consumer_supply tps658621_ldo7_supply[] = {
>> };
> 
> Well, I'd just omit the array entirely if it's empty but yes.

This would break nice un-namespaced REGULATOR_INIT macros :)

> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.
