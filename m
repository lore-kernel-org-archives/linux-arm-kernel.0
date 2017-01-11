From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Wed, 11 Jan 2017 11:42:50 +0100
Subject: [PATCHv3 3/8] rtc: add STM32 RTC driver
In-Reply-To: <20170111101708.ujcgo7kpyywymyzp@piout.net>
References: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
 <1483623809-29937-4-git-send-email-amelie.delaunay@st.com>
 <20170111000803.mlie6kizcsj2o7lh@piout.net>
 <1feb3a23-7450-2b5c-9c1c-c7ecacd7fa17@st.com>
 <20170111101708.ujcgo7kpyywymyzp@piout.net>
Message-ID: <ff7a532e-a2a7-920a-29d9-e8a82d6ed915@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/11/2017 11:17 AM, Alexandre Belloni wrote:
> On 11/01/2017 at 11:07:16 +0100, Amelie DELAUNAY wrote :
>>> This will never happen, tm is already checked multiple times (up to
>>> three) in the core before this function can be called.
>>>
>> You're right. I'll remove all rtc_valid_tm calls.
>
> You can keep the one in read_time
>
Even if rtc_valid_tm is called just after rtc->ops->read_time() in 
__rtc_read_time ?
