From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 9 Apr 2018 14:20:02 +0100
Subject: [PATCH V2 1/2] cpufreq: scmi: Don't validate the frequency table
 twice
In-Reply-To: <CAJZ5v0hGgLAK2MRx0tEpTt5Hh9i_9zwhFJPsOsxQ+fOSiLBr_w@mail.gmail.com>
References: <cover.1522749887.git.viresh.kumar@linaro.org>
 <442ecfd0a5bddf32c912c449b072d8a0139318fc.1522749887.git.viresh.kumar@linaro.org>
 <5ce48bce-4fcf-1e0a-6b78-f588fbf7e4a5@arm.com>
 <CAJZ5v0hGgLAK2MRx0tEpTt5Hh9i_9zwhFJPsOsxQ+fOSiLBr_w@mail.gmail.com>
Message-ID: <d86012d8-f98f-b9e9-aa0b-032ef0ee9c9c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/04/18 12:39, Rafael J. Wysocki wrote:
> On Wed, Apr 4, 2018 at 11:48 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> (I have exact patches ready :), was on vacation)
> 
> What am I expected to do with this one?
> 

Sorry for not being explicit. I assumed you can pick up this patch along
with 2/2 removing the function, that's why I just acked the patch. The
SCMI code is now merged.

>> On 03/04/18 11:07, Viresh Kumar wrote:
>>> The cpufreq core is already validating the CPU frequency table after
>>> calling the ->init() callback of the cpufreq drivers and the drivers
>>> don't need to do the same anymore. Though they need to set the
>>> policy->freq_table field directly from the ->init() callback now.
>>>
>>> Stop validating the frequency table from scmi driver.
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
