From: yankejian@huawei.com (Yankejian (Hackim Yim))
Date: Wed, 9 Dec 2015 18:23:48 +0800
Subject: arRe: [PATCH net-next 2/2] net: hns: enet specisies a reference
 to dsaf (config and documents)
In-Reply-To: <4902591.DhWVhdI4KP@wuerfel>
References: <1449295856-31068-1-git-send-email-yankejian@huawei.com>
 <1503684.BNZUVaD74W@wuerfel> <5667F379.2010108@huawei.com>
 <4902591.DhWVhdI4KP@wuerfel>
Message-ID: <56680134.90504@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/9 18:00, Arnd Bergmann wrote:
> On Wednesday 09 December 2015 17:25:13 Yankejian wrote:
>>  thanks a lot for pointing it out.
>>
>>  It is great regret that this change breaks compatibility with old dtbs.
>>  this is a new driver which is run on developing boards, and all the
>>  clients' boards are developing boards. So we provide them a method to
>>  update the firmware on the board, once we update the dtsi and kernel,
>>  we require our clients to update the existed firmware and kernel.
>>  Therefore, these changes is actually under control. Shall we treat this
>>  by this way?
> Ok, if you can show that the incompatible change is safe to do, that's
> fine. Just put the explanation above into the patch description to
> document that you have considered the effects of the change, and
> to ensure that it gets done atomically.
>
> Also, you have to merge the two patches into one to allow bisection,
> or do a series of three patches that need to be applied in order:
>
> 1. add ae-handle property
> 2. change driver to use that property
> 3. remove ae-name property
>
> 	Arnd
>
> .
>
Ok, thanks for your good advices.
i will change it in V2 PATCH.

Bset Regards
yankejian
