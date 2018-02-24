From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Sat, 24 Feb 2018 01:32:53 -0800
Subject: [PATCH v2 7/8] [PATCH 7/8] drivers/hwmon: Add a generic PECI
 hwmon client driver
In-Reply-To: <CANiq72mjsfJRzfFmhbL7dnih_0=2pFoJDTrmi35x0yLmKrSBFA@mail.gmail.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-8-jae.hyun.yoo@linux.intel.com>
 <20180221182608.GA11635@roeck-us.net>
 <618f34cd-ee43-d8e4-4fb0-3c23bf03835f@linux.intel.com>
 <20180221214859.GA30263@roeck-us.net>
 <576a50c6-c302-654c-ceb3-aaf820b7738a@linux.intel.com>
 <20180222003720.GA25250@lunn.ch>
 <b506b4b1-7e7d-abd6-bac2-c45e7c1e0aae@linux.intel.com>
 <CANiq72mjsfJRzfFmhbL7dnih_0=2pFoJDTrmi35x0yLmKrSBFA@mail.gmail.com>
Message-ID: <85f66284-2e18-2a74-1e7b-9378353ab43e@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/23/2018 4:00 PM, Miguel Ojeda wrote:
> On Thu, Feb 22, 2018 at 2:29 AM, Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>> On 2/21/2018 4:37 PM, Andrew Lunn wrote:
>>>>
>>>> But even with this change, it still needs to use delayed creation
>>>> because BMC side kernel doesn't know how many DIMMs are populated on
>>>> a remote server before the remote server completes its memory
>>>> training and testing in BIOS, but it needs to check the remote
>>>> server's CPU temperature as immediate as possible to make
>>>> appropriate thermal control based on the remote CPU's temperature to
>>>> avoid any critical thermal issue. What would be a better solution in
>>>> this case?
>>>
>>>
>>> You could change this driver so that it supports one DIMM.  Move the
>>> 'hotplug' part into another driver which creates and destroys
>>> instances of the hwmon DIMM device as the DIMMS come and go.
>>>
>>> Also, do you need to handle CPU hotplug? You could split the CPU
>>> temperature part into a separate hwmon driver? And again create and
>>> destroy devices as CPUs come and go?
>>>
>>>          Andrew
>>>
>>
>> That seems like a possible option. I'll rewrite the hwmon driver again like
>> that.
>>
>> Thanks for the good idea. :)
> 
> By the way, in the rewrite, please try to avoid the create*workqueue()
> functions (they are deprecated :).
> 
> Cheers,
> Miguel
> 

Hi Miguel,

Thanks for letting me know that. I'll replace that with 
alloc_workqueue(). :)

Regards,
Jae

>>
>> Jae
