From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 11 Nov 2016 09:55:54 -0800
Subject: [RFC PATCH 0/6] media: davinci: VPIF: add DT support
In-Reply-To: <6058d790-5409-01c0-1d3f-b1bb45f8f85c@xs4all.nl> (Hans Verkuil's
 message of "Fri, 11 Nov 2016 16:36:31 +0100")
References: <20161025235536.7342-1-khilman@baylibre.com>
 <6058d790-5409-01c0-1d3f-b1bb45f8f85c@xs4all.nl>
Message-ID: <m2bmxllx3p.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hans Verkuil <hverkuil@xs4all.nl> writes:

> Hi Kevin,
>
> On 10/26/2016 01:55 AM, Kevin Hilman wrote:
>> This series attempts to add DT support to the davinci VPIF capture
>> driver.
>> 
>> I'm not sure I've completely grasped the proper use of the ports and
>> endpoints stuff, so this RFC is primarily to get input on whether I'm
>> on the right track.
>> 
>> The last patch is the one where all my questions are, the rest are
>> just prep work to ge there.
>> 
>> Tested on da850-lcdk and was able to do basic frame capture from the
>> composite input.
>> 
>> Series applies on v4.9-rc1
>> 
>> Kevin Hilman (6):
>>   [media] davinci: add support for DT init
>>   ARM: davinci: da8xx: VPIF: enable DT init
>>   ARM: dts: davinci: da850: add VPIF
>>   ARM: dts: davinci: da850-lcdk: enable VPIF capture
>>   [media] davinci: vpif_capture: don't lock over s_stream
>>   [media] davinci: vpif_capture: get subdevs from DT
>
> Looks good, but wouldn't it be better to do the dts changes last when all the
> supporting code is in?

I guess it doesn't really matter in this case, because the DT nodes will
be nops until the driver changes are in.

Either way, next week I'll repost a non-RFC version and separate out the
arch and DT patches, since those will go through Sekhar's davinci tree,
and then via arm-soc.

Thanks for the review,

Kevin
