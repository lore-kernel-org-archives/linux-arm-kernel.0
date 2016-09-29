From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 29 Sep 2016 10:17:39 +0100
Subject: Crash seen on ARM Juno r1 with 4.8-rc8 when Coresight is enabled
In-Reply-To: <20160929084953.GA24154@lnxartpec.se.axis.com>
References: <CAGhh56EPK0BYbjV_v7cehT+yuB=L3O-AkFR2mLQMDAS66zDgDg@mail.gmail.com>
 <CANLsYkypz383Smuqv3B5K3i9mzGxMdc1OJdc_tWQZ5qHWQCeJw@mail.gmail.com>
 <20160929084953.GA24154@lnxartpec.se.axis.com>
Message-ID: <5dc4d096-d580-900c-5750-38e0db1ccbce@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/09/16 09:49, Rabin Vincent wrote:
> On Wed, Sep 28, 2016 at 11:41:41AM -0600, Mathieu Poirier wrote:
[...]

>> Thanks you for reporting this Vankatesh,
>>
>> Sudeep and Suzuki, can you guys help me with this - I don't have an R1
>> to test with.
>
> I've seen this too, on other platforms.  This should fix it:
>
> 8<-----------
> From a9da7d7b47e67dd6ffcafddadb50e6f97503f296 Mon Sep 17 00:00:00 2001
> From: Rabin Vincent <rabinv@axis.com>
> Date: Tue, 30 Aug 2016 08:54:21 +0200
> Subject: [PATCH] coresight: check for NULL child_name
>
> Connection child names associated to ports can sometimes be NULL, which
> is the case when booting a system on QEMU or when the Coresight power
> domain isn't switched on.  fadf3a44e974 ("coresight: checking for NULL
> string in coresight_name_match()") fixed one place to handle this but
> the same check is needed in coresight_orphan_match() to prevent a crash
> there.
>

Thanks Rabin, we have exact same fix in linux-next already.

-- 
Regards,
Sudeep
