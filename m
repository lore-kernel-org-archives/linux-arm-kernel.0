From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 5 Mar 2018 14:25:22 +0100
Subject: [PATCH] drm/bridge/synopsys: dsi: readl_poll_timeout return
 value clean up
In-Reply-To: <587f8a32-b9b3-0e81-d91d-69ea256bdc29@st.com>
References: <20180204213624.18288-1-philippe.cornu@st.com>
 <CGME20180301090106epcas2p3c47f4436b0c8a31ce71cfd3909dc77ae@epcas2p3.samsung.com>
 <172e7f68-8f4b-7e5f-3e9f-7aaf10a51dc9@st.com>
 <290c749a-70bf-2b74-1fb9-2de26708d001@samsung.com>
 <587f8a32-b9b3-0e81-d91d-69ea256bdc29@st.com>
Message-ID: <8b47bb1d-ff1d-b85a-18ca-b53b70c1a32d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.03.2018 14:15, Philippe CORNU wrote:
> Hi Andrzej,
>
>
> On 03/02/2018 11:21 AM, Andrzej Hajda wrote:
>> On 01.03.2018 10:00, Philippe CORNU wrote:
>>> Hi Archit, Andrzej & Laurent,
>>>
>>> May I ask you please your feedback on this small patch?
>>> Many thanks,
>>>
>>> Philippe :-)
>>>
>>> On 02/04/2018 10:36 PM, Philippe Cornu wrote:
>>>> The readl_poll_timeout() return value is 0 in case of success
>>>> so it is better to detect errors without taking care of the
>>>> return value sign.
>>>>
>>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> The patch is of course correct. However I am not sure if necessary. For
>> sure functionally it does not change anything.
>> AFAIK kernel CodingStyle says nothing about it, so I suppose it is
>> matter of personal taste.
> I sent this tiny patch in order to homogenize the dw mipi driver because 
> there were both cases "if (ret)" & "if (ret < 0)" in the source code.
>
> I did not really find a preferred way in the kernel source code so I 
> selected what sounds the best to me ie "if (ret)" but it is not a 
> problem to make another patch for "if (ret < 0)" everywhere :-)
>
> In any case, the most important from my pov is to have a homogeneous 
> source code :-)

OK

Queued to drm-misc-next.

Regards
Andrzej
