From: kasimling@gmail.com (Alex Ling)
Date: Sun, 15 Dec 2013 22:14:53 +0800
Subject: [PATCH v2 1/1] ARM: dts: Add missing clocks for exynos4412 dwmmc
 node
In-Reply-To: <6057819.pWzq25qpVf@flatron>
References: <1386998490-19456-1-git-send-email-kasimling@gmail.com>
 <6057819.pWzq25qpVf@flatron>
Message-ID: <CAHaF_kimHy38cL79uZDRy-OWCDs2m0TRAQyT=JaHVfWgHLz2JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for pointing out this, Tomasz. I'll use those patches instead.


Regards,
Alex

On Sat, Dec 14, 2013 at 9:24 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Alex,
>
> On Saturday 14 of December 2013 13:21:30 Alex Ling wrote:
>> This patch adds "biu" and "ciu" clocks for exynos4412 dwmmc
>> node. Without this patch, dwmmc host driver will skip enabling the
>> two clocks and it will break dwmmc host function on exynos4412.
>> Tested on FriendlyARM TINY4412 board.
>>
>> Signed-off-by: Alex Ling <kasimling@gmail.com>
>> ---
>> Changes for v2:
>>    - Fix patch description as Mark Rutland suggested
>>
>>  arch/arm/boot/dts/exynos4412.dtsi |    2 ++
>>  1 file changed, 2 insertions(+)
>
> The patch is correct, but unfortunately it's not the only thing that
> is wrong with MSHC device tree node for Exynos4x12.
>
> Please refer to my series fixing DW-MSHC support on Exynos4x12 (and
> enabling it on TRATS2 board):
> http://www.spinics.net/lists/arm-kernel/msg293652.html
>
> Best regards,
> Tomasz
>
