From: john.garry@huawei.com (John Garry)
Date: Wed, 6 Dec 2017 08:34:59 +0000
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <20171205172748.GI3070@tassilo.jf.intel.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
 <20171205172748.GI3070@tassilo.jf.intel.com>
Message-ID: <7e209e42-362e-7767-2b94-62239c62e70d@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2017 17:27, Andi Kleen wrote:
> On Wed, Dec 06, 2017 at 12:13:16AM +0800, John Garry wrote:
>> For some architectures (like arm64), there are architecture-
>> defined recommended events. Vendors may not be obliged to
>> follow the recommendation and may implement their own pmu
>> event for a specific event cod
>
> I would just duplicate the architected events into the different
> vendor files.  Then you wouldn't need all this mess.
>

This is what we were originally doing:
https://patchwork.kernel.org/patch/10010859/

But then we thought that we could avoid duplicating all these events for 
every platform from every vendor. Most, if not all, vendors will 
implement the events as recommended for any platform, so much 
unnecessary duplication.

cheers,
John


> -Andi
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>
