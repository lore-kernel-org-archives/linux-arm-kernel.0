From: s-anna@ti.com (Suman Anna)
Date: Fri, 12 Aug 2016 11:37:06 -0500
Subject: [PATCH 1/2] remoteproc: core: Add rproc OF look-up functions
In-Reply-To: <b1b2a510-e0cb-5d8f-9f44-48c9dd747d4d@ti.com>
References: <20160719154905.23344-1-lee.jones@linaro.org>
 <20160810174049.GO26240@tuxbot> <7650e5fa-f52c-1ab5-e197-8630fd7d0322@ti.com>
 <20160810204049.GV26240@tuxbot> <f9641050-0a3f-11de-fa69-e587034e0527@ti.com>
 <20160810211947.GW26240@tuxbot> <b1a01567-7a5d-20de-a2b5-b673b9ce67ec@ti.com>
 <20160811073122.GA1715@dell> <05d4c9c1-79ea-bde3-e5e5-d26e6b07c916@ti.com>
 <b1b2a510-e0cb-5d8f-9f44-48c9dd747d4d@ti.com>
Message-ID: <06f795ef-e71c-2cda-5306-5b75e0f15125@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

>> On 08/11/2016 02:31 AM, Lee Jones wrote:
>>> On Wed, 10 Aug 2016, Suman Anna wrote:
>>>
>>>> On 08/10/2016 04:19 PM, Bjorn Andersson wrote:
>>>>> On Wed 10 Aug 14:04 PDT 2016, Suman Anna wrote:
>>>>>
>>>>>> On 08/10/2016 03:40 PM, Bjorn Andersson wrote:
>>>>>>> On Wed 10 Aug 12:37 PDT 2016, Suman Anna wrote:
>>>>>>>
>>>>>>>> Hi Lee, Bjorn,
>>>>>>>>
>>>>>>>> On 08/10/2016 12:40 PM, Bjorn Andersson wrote:
>>>>>>>>> On Tue 19 Jul 08:49 PDT 2016, Lee Jones wrote:
>>>>>>>>>
>>>>>>>>>> - of_rproc_by_index(): look-up and obtain a reference to a rproc
>>>>>>>>>>                        using the DT phandle "rprocs" and a index.
>>>>>>>>>>
>>>>>>>>>> - of_rproc_by_name():  lookup and obtain a reference to a rproc
>>>>>>>>>>                        using the DT phandle "rprocs" and "rproc-names".
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>>>>>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> I'm happy with this, so I whipped up a binding document describing our
>>>>>>>>> two new properties. Waiting for an opinion on that before I merge this.

One last comment on this is the return code convention change on these
rproc_get APIs. I am fine in general with returning ERR_PTRs, but most
of the remoteproc code is using NULL checking for rproc. If you remember
the discussion back during the hwspinlock DT conversion [1], Ohad
preferred to return NULL, and that's why even the rproc_get_by_phandle
was returning NULL. We ought to make this consistent across the board if
we want to make this switch.

regards
Suman

[1] http://marc.info/?t=138965891200008
