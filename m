From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 08 Jan 2014 11:15:05 +0100
Subject: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
In-Reply-To: <20140107230610.GB2592@katana>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
 <1389112504-9931-3-git-send-email-gregory.clement@free-electrons.com>
 <20140107183853.GE4227@obsidianresearch.com> <20140107230610.GB2592@katana>
Message-ID: <52CD2529.6090206@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On 08/01/2014 00:06, Wolfram Sang wrote:
> On Tue, Jan 07, 2014 at 11:38:53AM -0700, Jason Gunthorpe wrote:
>> On Tue, Jan 07, 2014 at 05:35:03PM +0100, Gregory CLEMENT wrote:
>>> +static struct property i2c_offload_broken = {
>>> +	.name = "offload-broken",
>>> +};
>>> +
>>> +static void __init i2c_quirk(void)
>>> +{
>>> +	struct device_node *np;
>>> +	u32 dev, rev;
>>> +
>>> +	/*
>>> +	 * Only revisons more recent than A0 support the offload
>>> +	 * mechanism. We can exit only if we are sure that we can
>>> +	 * get the SoC revision and it is more recent than A0.
>>> +	 */
>>> +	if (mvebu_get_soc_id(&rev, &dev) == 0 && dev > MV78XX0_A0_REV)
>>> +		return;
>>> +
>>> +	for_each_compatible_node(np, NULL, "marvell,mv78230-i2c")
>>> +		of_add_property(np, &i2c_offload_broken);
>>
>> I like this approach.
> 
> Sorry, but I don't.
> 
>> However, when I first read this I thought it should be a -a0 specific
>> compatible string, not a 'offload-broken' property - any idea what the
>> DT consensus is here? I've seen both approach in use ..
> 
> I prefer the replacement of the compatible string. If it should really
> be a seperate property, then it should be a vendor specific property. It
> is not generic, at all.

Something like "marvell,offload-broken" would be acceptable?

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
