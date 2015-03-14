From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 13 Mar 2015 21:02:33 -0600
Subject: [PATCH v4 0/3] firmware: qcom: scm: Add cpu power on/off support
In-Reply-To: <FF397312-A395-40ED-8FCF-E893E2849208@codeaurora.org>
References: <1425339030-45828-1-git-send-email-lina.iyer@linaro.org>
 <20150313171656.GI497@linaro.org>
 <FF397312-A395-40ED-8FCF-E893E2849208@codeaurora.org>
Message-ID: <20150314030233.GK497@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13 2015 at 18:52 -0600, Kumar Gala wrote:
>I?ve applied these to my ?soc? branch.
>
Great. Thank you.

-Lina.

>- k
>
>On Mar 13, 2015, at 12:16 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>
>> Kumar, Stephen, Andy,
>>
>> Any comments on this patchset?
>>
>> Thanks,
>> Lina
>>
>> On Mon, Mar 02 2015 at 16:30 -0700, Lina Iyer wrote:
>>> Hi,
>>>
>>> This series of patches adds SCM cold boot clean up and support for warm boot
>>> for QCOM quad core (and dual core) cpus.
>>>
>>> v4 Changes:
>>> - Added QCOM_SCM_CPU_DOWN_ prefix for L2 on/off enums, relocated them to be close
>>> to the function declaration.
>>>
>>> v3 Changes:
>>> - Addressed review comments from Kumar.
>>> 	+ Cleaned up the cold boot api and the warm boot api to match
>>> 	+ Uniform qcom_scm_ prefix
>>> - Add support for cpu power down using scm_call_atomic1() from [1].
>>> 	+ No longer dependent on the series from sboyd.
>>>
>>> v2 Changes:
>>> - Merge the warm boot patches into a single patch.
>>>
>>> [1]. https://lkml.org/lkml/2014/8/4/765
>>>
>>> Thanks,
>>> Lina
>>>
>>> Lina Iyer (3):
>>> firmware: qcom: scm: Clean cold boot entry to export only the API
>>> firmware: qcom: scm: Add qcom_scm_set_warm_boot_addr function
>>> firmware: qcom: scm: Support cpu power down through SCM
>>>
>>> arch/arm/mach-qcom/platsmp.c |  21 +-----
>>> drivers/firmware/qcom_scm.c  | 154 ++++++++++++++++++++++++++++++++++++++++++-
>>> include/linux/qcom_scm.h     |  17 +++--
>>> 3 files changed, 163 insertions(+), 29 deletions(-)
>>>
>>> --
>>> 2.1.0
>>>
>
>-- 
>Qualcomm Innovation Center, Inc.
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
