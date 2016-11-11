From: stefan@agner.ch (Stefan Agner)
Date: Thu, 10 Nov 2016 20:27:50 -0800
Subject: [PATCH v2 1/3] ARM: dts: imx6qdl-apalis: Do not rely on DDC I2C
 bus bitbang for HDMI
In-Reply-To: <7eb3df71-6d1a-006a-cc4c-83ff8df3c42c@mentor.com>
References: <2263d508999ada9476268138b2922702eb50131f.1474260360.git.maitysanchayan@gmail.com>
 <20161022032559.GL30578@tiger>
 <3d2b6dfd-c03c-e635-8dc1-2dc9ac454f5a@mentor.com>
 <20161108173315.GA16082@Sanchayan-Arch.localdomain>
 <57268103e8fabf344723eae99b45ec7d@agner.ch>
 <7eb3df71-6d1a-006a-cc4c-83ff8df3c42c@mentor.com>
Message-ID: <b68c1a07b6b5f027a6519c29b90217c1@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-11-10 10:29, Vladimir Zapolskiy wrote:
> Hi Stefan, Philipp,
> 
> On 11/09/2016 02:50 AM, Stefan Agner wrote:
>> On 2016-11-08 09:33, maitysanchayan at gmail.com wrote:
>>> Hello Shawn,
>>> 
>>> On 16-10-22 15:43:04, Vladimir Zapolskiy wrote:
>>>> Hi Shawn,
>>>> 
>>>> On 10/22/2016 06:25 AM, Shawn Guo wrote:
>>>>> On Mon, Sep 19, 2016 at 10:41:51AM +0530, Sanchayan Maity wrote:
>>>>>> Remove the use of DDC I2C bus bitbang to support reading of EDID
>>>>>> and rely on support from internal HDMI I2C master controller instead.
>>>>>> As a result remove the device tree property ddc-i2c-bus.
>>>>>> 
>>>>>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>>>>> 
>>>>> I think that the dw-hdmi i2c support [1] is a prerequisite of this
>>>>> patch.  I do not see it lands on v4.9-rc1.  Or am I missing something?
>>>>> 
>>>>> Shawn
>>>>> 
>>>>> [1] https://patchwork.kernel.org/patch/9296883/
>>>>> 
>>>> 
>>>> I'm adding Philipp to Cc, since he is the last one who tested the change
>>>> and helped me to push the change to the mainline:
>>>> 
>>>>   https://lists.freedesktop.org/archives/dri-devel/2016-September/118569.html
>>>> 
>>>> The problem is that there is no official DW HDMI bridge maintainer, may be
>>>> you can review the change, and if you find it satisfactory push it through
>>>> ARM/iMX tree.
>>> 
>>> Shawn, is it okay if that patch goes through your ARM/iMX tree?
>> 
>> I don't think it makes sense that the DRM bridge changes go through
>> Shawn's tree. Dave should merge Philipps pull request...
>> 
> 
> Philipp, do you mind to submit a rebased pull request one more time?
> 

You probably saw it, Dave merged it today in his drm-next branch:
https://cgit.freedesktop.org/~airlied/linux/?h=drm-next

I guess with that Shawn can go ahead and merge this patchset for next
too...?

--
Stefan
