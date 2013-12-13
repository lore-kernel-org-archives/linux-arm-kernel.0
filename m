From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Dec 2013 09:59:22 -0700
Subject: [PATCH V2] ARM: tegra: fix pinctrl misconfiguration on Venic2
In-Reply-To: <52AAA870.4090609@nvidia.com>
References: <1386886322-2700-1-git-send-email-swarren@wwwdotorg.org>
 <52AAA870.4090609@nvidia.com>
Message-ID: <52AB3CEA.70405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 11:25 PM, Laxman Dewangan wrote:
> On Friday 13 December 2013 03:42 AM, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Other boards use PULL_NONE for their debug UART pins, and without this
>> change, the board doesn't accept any serial input.
>>
>> Don't set the I2S port pins to tristate mode, or no audio signal will
>> be sent out.
>>
>> Fixes: 605ae5804385 ("ARM: tegra: add default pinctrl nodes for Venice2")
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> v2: Added fix for I2S port.
>>
>> Laxman, can you please go through the whole pinctrl configuration for
>> Venice2 and make sure it's correct. Perhaps the best approach would be
>> to compare it against our downstream kernels for this board.
>
> The patch is generated based on downstream ref platforms setting,
> Let me again check with very similar board in dowsntream.

Oh, you mean this isn't a pinctrl configuration for Venice2 then? As you
know, we do have a separate downstream kernel with full Venice2 support;
you should use that as a reference.
