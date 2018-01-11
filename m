From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu, 11 Jan 2018 12:33:51 -0800
Subject: [PATCH linux dev-4.10 3/6] drivers/misc: Add driver for Aspeed
 PECI and generic PECI headers
In-Reply-To: <1515661373.31850.31.camel@kernel.crashing.org>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180109223126.13093-4-jae.hyun.yoo@linux.intel.com>
 <20180110101840.GB5822@kroah.com>
 <1515661373.31850.31.camel@kernel.crashing.org>
Message-ID: <538056d0-dacc-b27e-db37-9b956dc06496@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/11/2018 1:02 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2018-01-10 at 11:18 +0100, Greg KH wrote:
>> On Tue, Jan 09, 2018 at 02:31:23PM -0800, Jae Hyun Yoo wrote:
>>> This commit adds driver implementation for Aspeed PECI. Also adds
>>> generic peci.h and peci_ioctl.h files to provide compatibility
>>> to peci drivers that can be implemented later e.g. Nuvoton's BMC
>>> SoC family.
>>
>> We don't add code that could be used "sometime in the future".  Only
>> include stuff that we use now.
>>
>> Please fix up this series based on that and resubmit.  There should not
>> be any need for any uapi file then, right?
> 
> No Greg, I think you misunderstood (unless I misread myself).
> 
> What Jae means is that since PECI is a standard and other drivers
> implementing the same ioctl interface and messages will eventually go
> upstream, instead of having the ioctl definitions in a driver specific
> locations, they go in a generic spot, as they define a generic API for
> all PECI drivers, including the one that's getting merged now.
> 
> IE. This doesn't add unused stuff, it just puts the API parts of it
> into a generic location.
> 
> At least that's my understanding from a, granted cursory, look at the
> patch.
> 
> That said, I do have a problem with the structure definitions of the
> various packet types as they use "long" which has a variable size and
> unclear alignment. It should be using __u8, __u16 and __u32...
> 
> Cheers,
> Ben.
> 

Thanks for your clear explanation. That is what I actually intended to. 
However, the structure definitions you and Greg pointed out need to be 
corrected. I will fix it.

Thanks,
Jae
