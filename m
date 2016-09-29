From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 29 Sep 2016 10:15:19 +0100
Subject: Crash seen on ARM Juno r1 with 4.8-rc8 when Coresight is enabled
In-Reply-To: <CANLsYkypz383Smuqv3B5K3i9mzGxMdc1OJdc_tWQZ5qHWQCeJw@mail.gmail.com>
References: <CAGhh56EPK0BYbjV_v7cehT+yuB=L3O-AkFR2mLQMDAS66zDgDg@mail.gmail.com>
 <CANLsYkypz383Smuqv3B5K3i9mzGxMdc1OJdc_tWQZ5qHWQCeJw@mail.gmail.com>
Message-ID: <941e74f1-a00c-e618-cf20-065b89d16191@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On 28/09/16 18:41, Mathieu Poirier wrote:
> On 28 September 2016 at 10:35, Venkatesh Vivekanandan
> <venkatesh.vivekanandan@broadcom.com> wrote:
>> Hi All,
>>
>> I am trying to boot 4.8-rc8 in ARM Juno r1 board with coresight
>> enabled and could see crash. When coresight is disabled at kernel
>> config, then it boots to the linux prompt with rootfs in USB.
>>
>> I am using UEFI binary that came along with Juno-r1 board.
>>
>> Used following Image and dtb,
>>

[...]

>
> Thanks you for reporting this Vankatesh,
>
> Sudeep and Suzuki, can you guys help me with this - I don't have an R1
> to test with.
>

R1 and R2 are almost same except A57 is replaced by A72.
Anyways I reported the exact crash along with the fix sometime in June.
It got missed in v4.8, but is already queued in linux-next(in-fact twice
;), from your tree as well as greg's).

e05b386c878d coresight: access conn->child_name only if it's initialised
b8392153721c coresight: access conn->child_name only if it's initialised

-- 
Regards,
Sudeep
