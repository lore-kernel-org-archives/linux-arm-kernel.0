From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue, 17 Apr 2018 11:21:13 -0700
Subject: [PATCH v3 06/10] drivers/peci: Add a PECI adapter driver for
 Aspeed AST24xx/AST25xx
In-Reply-To: <93e7f93c-a2e4-1e16-be4c-b908f88b9897@arm.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-7-jae.hyun.yoo@linux.intel.com>
 <93e7f93c-a2e4-1e16-be4c-b908f88b9897@arm.com>
Message-ID: <684d1e9e-b07d-ef79-4333-e47d11326e7f@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 4/17/2018 6:37 AM, Robin Murphy wrote:
> Just a drive-by nit:
> 
> On 10/04/18 19:32, Jae Hyun Yoo wrote:
> [...]
>> +#define PECI_CTRL_SAMPLING_MASK???? GENMASK(19, 16)
>> +#define PECI_CTRL_SAMPLING(x)?????? (((x) << 16) & 
>> PECI_CTRL_SAMPLING_MASK)
>> +#define PECI_CTRL_SAMPLING_GET(x)?? (((x) & PECI_CTRL_SAMPLING_MASK) 
>> >> 16)
> 
> FWIW, <linux/bitfield.h> already provides functionality like this, so it 
> might be worth taking a look at FIELD_{GET,PREP}() to save all these 
> local definitions.
> 
> Robin.

Yes, that looks better. Thanks a lot for your pointing it out.

Jae
