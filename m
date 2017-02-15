From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Wed, 15 Feb 2017 10:06:23 -0700
Subject: [PATCH V8 08/10] ras: acpi / apei: generate trace event for
 unrecognized CPER section
In-Reply-To: <20170215120342.48eff95d@gandalf.local.home>
References: <1485969413-23577-1-git-send-email-tbaicar@codeaurora.org>
 <1485969413-23577-9-git-send-email-tbaicar@codeaurora.org>
 <20170215105234.4921db1f@gandalf.local.home>
 <e50b7673-a441-3a6b-cf75-c267881c1a92@codeaurora.org>
 <20170215120342.48eff95d@gandalf.local.home>
Message-ID: <b1e44c1f-ff88-e43b-6bd3-96ac5e6a31bd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/15/2017 10:03 AM, Steven Rostedt wrote:
> On Wed, 15 Feb 2017 09:54:09 -0700
> "Baicar, Tyler" <tbaicar@codeaurora.org> wrote:
> \
>> In v9 I currently have this and the ARM trace event from this series
>> both wrapped in an
>> ifdef verifying that CONFIG_RAS is enabled. This resolves the kbuild
>> failures and
>> will have this code compiled out when that config isn't enabled. Do you
>> think I
>> should use the ifdef or use these *_enabled() functions?
>>
> I believe you need both. The *_enabled() functions wont prevent build
> errors. But since tracing is seldom enabled (usually only when you want
> to see what's happening), the *_enabled() functions optimize the code
> to not perform tasks that are only needed when tracing is enabled. When
> I say "enabled" I mean actively tracing, as supposed to being just
> enabled in the kernel.
>
> -- Steve
Got it, I will add both!

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
