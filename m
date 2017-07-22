From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 22 Jul 2017 11:52:37 +0800
Subject: [PATCH] irqchip/gic-v3-its: Allow GIC ITS number more than
 MAX_NUMNODES
In-Reply-To: <CAKTKpr7tmavUKyqxYabdfYOpV0V9TLySmwCwTyng5zZoxy9nqg@mail.gmail.com>
References: <1500630715-2156-1-git-send-email-guohanjun@huawei.com>
 <5971D208.3040005@huawei.com> <84d411ff-596b-c451-29fb-f506abc4fb04@arm.com>
 <CAKTKpr7tmavUKyqxYabdfYOpV0V9TLySmwCwTyng5zZoxy9nqg@mail.gmail.com>
Message-ID: <5972CC05.9010702@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/7/21 19:42, Ganapatrao Kulkarni wrote:
> Hi Hanjun,
>
>
> On Fri, Jul 21, 2017 at 4:50 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 21/07/17 11:06, Hanjun Guo wrote:
>>> On 2017/7/21 17:51, Hanjun Guo wrote:
>>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>>
>>>> When running 4.13-rc1 on top of D05, I got the boot log:
>>>>
>>>> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
>>>> [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
>>>> [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
>>>> [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
>>>> [    0.000000] SRAT: ITS affinity exceeding max count[4]
>>>>
>>>> This is wrong on D05 as we have 8 ITSes with 4 NUMA nodes.
> Used static array to keep it simple.  we can have either dynamic array
> or increase static array size (which is in init data) to a larger
> number.
> We may have to go for dynamic array to be more sane. You can refer my
> v2 patch [1], which was doing dynamic allocation and avoids
> 2 calls to acpi parser as done in this patch.
>
> [1] https://patchwork.kernel.org/patch/9798659/

Hmm, although scanning the SRAT twice is bad, it will keep the
code simple, and no need to alloc the memory every time when we
find a ITS affinity entry, you need to free that memory when
ITS probing is done.

I will post a patch later, please take a look if it's ok to you :)

Thanks
Hanjun
