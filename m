From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Wed, 04 Apr 2018 19:10:20 +0800
Subject: [PATCH v8 11/14] iommu/rockchip: Use OF_IOMMU to attach devices
 automatically
In-Reply-To: <CAGS+omCN7cXY0APvFuL_wmZeXihivu4hF0+ZfLFffvdZyK9f6A@mail.gmail.com>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
 <20180323073814.5802-12-jeffy.chen@rock-chips.com>
 <CAGS+omDUve9DTMJY8FdWBBxQgCOACLYLsRuzmQzd3Fh7TeekDw@mail.gmail.com>
 <5AB8A7F0.1090305@rock-chips.com>
 <CAGS+omCN7cXY0APvFuL_wmZeXihivu4hF0+ZfLFffvdZyK9f6A@mail.gmail.com>
Message-ID: <5AC4B29C.8090002@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Thanks for your reply.

On 04/04/2018 12:11 AM, Daniel Kurtz wrote:
> Hi Jeffy,
>
> Sorry for delayed response.
>
> On Mon, Mar 26, 2018 at 1:58 AM JeffyChen <jeffy.chen@rock-chips.com> wrote:
>
>> Hi Daniel,
>
>> Thanks for your reply.
>
>> On 03/26/2018 02:31 PM, Daniel Kurtz wrote:
>>>>> +struct rk_iommudata {
>>>>> +       struct rk_iommu *iommu;
>>>>> +};
>>> Why do we need this struct?  Can't we just assign a pointer to struct
>>> rk_iommu directly to dev->archdata.iommu?
>>>
>> hmmm, i was trying to add more device related data in patch[13]:
>
>>     struct rk_iommudata {
>> +       struct device_link *link; /* runtime PM link from IOMMU to master
> */
>>           struct rk_iommu *iommu;
>>     };
>>>
>
> Can't you just add link to rk_iommu directly?

adding link to rk_iommu would be fine if we only have one master device 
per rk_iommu.

but now we are supporting multiple master devices sharing a iommu device :)

>
>
>
