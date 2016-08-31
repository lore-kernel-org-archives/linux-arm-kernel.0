From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 31 Aug 2016 13:58:05 +0200
Subject: Kernel warning in cpufreq_add_dev()
In-Reply-To: <20160831041137.GE5539@vireshk-i7>
References: <20160819110032.GM1041@n2100.armlinux.org.uk>
 <2310664.2BksGViL4r@vostro.rjw.lan>
 <20160824131316.GI25143@ubuntu> <1496109.Jd9MGDryNS@vostro.rjw.lan>
 <20160831041137.GE5539@vireshk-i7>
Message-ID: <CAJZ5v0hyJrVgCR+ziZokug7hoMvj-Y9AEtZUB32_UAeMvrjZrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 6:11 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 31-08-16, 03:26, Rafael J. Wysocki wrote:
>> On Wednesday, August 24, 2016 06:43:16 PM Viresh Kumar wrote:
>> > On 22-08-16, 19:32, Rafael J. Wysocki wrote:
>> > > But it will be called in that path during physical CPU hot-add, won't it?
>> >
>> > What about something like this instead (completely untested) ?
>>
>> Inline, please?
>
> I am not sure what that means. I pasted that inline in my previous mail only.

I wanted to say that I'd prefer patches to be sent in the message
proper instead of as inline attachments.  It is easier to respond to
them this way (to me at least).

>> > @Russell: Can you please try this ??
>>
>> I was thinking about something similar, but won't the WARN_ON()s in
>> cpufreq_add/remove_dev_symlink() still trigger, say if there's more
>> than one CPU in a policy and both happen to be online initially?
>
> real CPUs should already be online and their device structure should be
> available, isn't it ?

Not if the driver has already been registered when cpufreq_add_dev()
runs AFAICS (which is the case in question).

Thanks,
Rafael
