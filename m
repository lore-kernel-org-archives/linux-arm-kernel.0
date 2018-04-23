From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Mon, 23 Apr 2018 10:40:53 -0700
Subject: [PATCH v3 03/10] drivers/peci: Add support for PECI bus driver
 core
In-Reply-To: <20180423105224.GA1444@kroah.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-4-jae.hyun.yoo@linux.intel.com>
 <20180423105224.GA1444@kroah.com>
Message-ID: <09b1a8af-4d47-0714-8f68-d7fe35cc7a72@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/23/2018 3:52 AM, Greg KH wrote:
> On Tue, Apr 10, 2018 at 11:32:05AM -0700, Jae Hyun Yoo wrote:
>> +static void peci_adapter_dev_release(struct device *dev)
>> +{
>> +	/* do nothing */
>> +}
> 
> As per the in-kernel documentation, I am now allowed to make fun of you.
> 
> You are trying to "out smart" the kernel by getting rid of a warning
> message that was explicitly put there for you to do something.  To think
> that by just providing an "empty" function you are somehow fulfilling
> the API requirement is quite bold, don't you think?
> 
> This has to be fixed.  I didn't put that warning in there for no good
> reason.  Please go read the documentation again...
> 
> greg k-h
> 

Hi Greg,

Thanks a lot for your review.

I think, it should contain actual device resource release code which is
being done by peci_del_adapter(), or a coupling logic should be added
between peci_adapter_dev_release() and peci_del_adapter().

As you suggested, I'll check it again after reading documentation and
understanding core.c code more deeply.

Jae
