From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 27 Aug 2015 11:33:09 -0400
Subject: [PATCH 2/5] coresight-etm4x: Change the name of the
 ctxid_val to ctxid_pid
In-Reply-To: <CANLsYkyA_C=PUDEUSbcA_Sa6Abqnxk1TP9ye6F9i0bWW_OxqiA@mail.gmail.com>
References: <1436258518-9339-1-git-send-email-zhang.chunyan@linaro.org>	<1436258518-9339-3-git-send-email-zhang.chunyan@linaro.org>	<55DDFE01.50201@codeaurora.org>
 <CANLsYkyA_C=PUDEUSbcA_Sa6Abqnxk1TP9ye6F9i0bWW_OxqiA@mail.gmail.com>
Message-ID: <55DF2DB5.7000909@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2015 11:12 AM, Mathieu Poirier wrote:
> On 26 August 2015 at 11:57, Christopher Covington <cov@codeaurora.org> wrote:
>> On 07/07/2015 04:41 AM, Chunyan Zhang wrote:
>>> 'ctxid_val' array was used to store the value of ETM context ID comparator
>>> which actually stores the process ID to be traced, so using 'ctxid_pid' as
>>> its name instead make it easier to understand.
>>
>> Previous discussion with some ARM folks has led me to believe there isn't a
>> guarantee that the Context ID Register will always have a PID. Why not allow
>> filtering on thread group ID, session ID, cgroup related identifiers, etc.?
> 
> Coresight tracers only support contextID tracing.  The HW
> automatically does the match between the contextID comparator register
> in the tracer with the contextID register of the core.  Tracing is
> enabled if both values match (and the tracer is configured to do so).

Is there a reason to only ever allow Process IDs to be written into the
Coresight and CPU Context ID registers? Is there anything in the hardware that
would prevent writing, for example, Thread Group IDs into the Coresight and
CPU Context ID registers? If there's no hardware limitation, why should there
be kernel or device tree architecture that states or implies that patches to
support such a use case are unacceptable?

Thanks,
Christopher Covington

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
