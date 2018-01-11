From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu, 11 Jan 2018 12:42:57 -0800
Subject: [PATCH linux dev-4.10 3/6] drivers/misc: Add driver for Aspeed
 PECI and generic PECI headers
In-Reply-To: <1515661583.31850.34.camel@kernel.crashing.org>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180109223126.13093-4-jae.hyun.yoo@linux.intel.com>
 <1515661583.31850.34.camel@kernel.crashing.org>
Message-ID: <7a038bd0-b2e0-2261-deea-f37a3e1810ba@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/11/2018 1:06 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2018-01-09 at 14:31 -0800, Jae Hyun Yoo wrote:
>> +struct peci_rd_ia_msr_msg {
>> +       unsigned char target;
>> +       unsigned char thread_id;
>> +       unsigned short address;
>> +       unsigned long value;
>> +};
> 
> Those types are representing messages on the wire ?
> 
> In that case those types aren't suitable. For example "long" will have
> a different size and alignment for 32 and 64-bit userspace. There are
> size-explicit userspace types available.
> 
> Also I didn't see any endianness annotations in there. Is that expected
> ? IE are those wire format packets ?
> 
> Cheers,
> Ben.
> 

Only the 'peci_xfer_msg' struct is representing messages on the wire. 
All userspace messages which is using other struct definitions will be 
copied into the 'peci_xfer_msg' for each member variable in driver, but 
anyway, type definitions of each member variable should be fixed as you 
said. Will fix it.

Thanks,
Jae
