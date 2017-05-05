From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 5 May 2017 16:04:15 +0100
Subject: [PATCH v8 5/7] coresight: add support for CPU debug module
In-Reply-To: <20170505144832.GA4507@linaro.org>
References: <1493719717-27698-1-git-send-email-leo.yan@linaro.org>
 <1493719717-27698-6-git-send-email-leo.yan@linaro.org>
 <4cd0e395-c177-0b72-9cab-7a95aac9cca4@arm.com>
 <20170505144832.GA4507@linaro.org>
Message-ID: <d683a786-b6f2-2d95-2a42-c82b38200bfa@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/05/17 15:48, Mathieu Poirier wrote:
> On Fri, May 05, 2017 at 02:55:17PM +0100, Sudeep Holla wrote:

[...]

>>
>> Just curious as why this is not registered under coresight bus using
>> coresight_register ? It would be good to group all the coresight devices
>> under that bus if possible.
> 
> The only thing this driver has in common with the coresight framework is the
> name, everything else is completely different.  Coupling them together (because
> of the name) would introduce a lot of hacks and make the code unintelligible. 
> 

I guessed so from the quick glance at it as it needs descriptors with
notion of source, sink and links to register. However I felt odd to not
group under the same "coresight" bus. As someone with least knowledge
on coresight, I would check under "sys/bus/coresight" to check available
devices on the system.

Anyways that's just my thoughts though I agree with you. It may need
more refactoring to support that and it will look hackish if we try to
do that with the code as it stands.

-- 
Regards,
Sudeep
