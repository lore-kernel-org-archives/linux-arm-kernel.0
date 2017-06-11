From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Sun, 11 Jun 2017 21:54:14 +0000
Subject: [PATCH v2] gpio: mvebu: fix regmap_update_bits usage
References: <20170609100917.26660-1-gregory.clement@free-electrons.com>
 <20170609142144.5f6c916b@gmail.com>
Message-ID: <192e8364fed24e91a12b5dec78fa06f0@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/17 00:22, Ralph Sennhauser wrote:
> On Fri,  9 Jun 2017 12:09:17 +0200
> Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> 
>> In some place in the driver regmap_update_bits was misused. Indeed the
>> last argument is not the value of the bit (or group of bits) itself
>> but the mask value inside the register.
>>
>> So when setting the bit N, then the value must be BIT(N) and not 1.
>>
>> CC: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
>> CC: Ralph Sennhauser <ralph.sennhauser@gmail.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
> 
> Hi Gregory,
> 
> Tested-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> 
> Thanks for the prompt fix
> Ralph

Also works for me

Tested-by: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
