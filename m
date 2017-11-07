From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 7 Nov 2017 10:37:22 +0000
Subject: [PATCH 13/17] coresight etr: Do not clean ETR trace buffer
In-Reply-To: <CANLsYkyEVqZ+Nc-RwWpNJ7TpxTdDFHF05-JsSSG65JYZhnoc6Q@mail.gmail.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-14-suzuki.poulose@arm.com>
 <20171102203623.GE23320@xps15> <c7a89f16-3974-69aa-505f-a3395d0579e6@arm.com>
 <CANLsYkyEVqZ+Nc-RwWpNJ7TpxTdDFHF05-JsSSG65JYZhnoc6Q@mail.gmail.com>
Message-ID: <6897a1ae-eede-6f78-1d2f-4dfb26679162@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/17 20:17, Mathieu Poirier wrote:
> On 3 November 2017 at 04:10, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 02/11/17 20:36, Mathieu Poirier wrote:
>>>
>>> On Thu, Oct 19, 2017 at 06:15:49PM +0100, Suzuki K Poulose wrote:
>>>>
>>>> We zero out the entire trace buffer used for ETR before it
>>>> is enabled, for helping with debugging. Since we could be
>>>> restoring a session in perf mode, this could destroy the data.
>>>
>>>
>>> I'm not sure to follow you with "... restoring a session in perf mode
>>> ...".
>>> When operating from the perf interface all the memory allocated for a
>>> session is
>>> cleanup after, there is no re-using of memory as in sysFS.
>>
>>
>> We could directly use the perf ring buffer for the ETR. In that case, the
>> perf
>> ring buffer could contain trace data collected from the previous "schedule"
>> which the userspace hasn't collected yet. So, doing a memset here would
>> destroy that data.
> 
> I originally thought your comment was about re-using the memory from a
> previous trace session, hence the confusion.  Please rework your
> changelog to include this clarification as I am sure other people can
> be mislead.

Sure, will do.

Thanks
Suzuki
