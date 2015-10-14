From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 14 Oct 2015 07:42:59 -0600
Subject: [PATCH v2 1/2] ARM: cpuidle: remove cpu parameter from the
 cpuidle_ops suspend hook
In-Reply-To: <20151012154054.GA23364@red-moon>
References: <1444648628-24790-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1444648628-24790-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20151012145640.GF921@linaro.org> <20151012154054.GA23364@red-moon>
Message-ID: <20151014134259.GG921@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12 2015 at 09:40 -0600, Lorenzo Pieralisi wrote:
>Hi Lina,
>
>On Mon, Oct 12, 2015 at 08:56:40AM -0600, Lina Iyer wrote:
>> On Mon, Oct 12 2015 at 05:16 -0600, Lorenzo Pieralisi wrote:
>> >The suspend() hook in the cpuidle_ops struct is always called on
>> >the cpu entering idle, which means that the cpu parameter passed
>> >to the suspend hook always corresponds to the local cpu, making
>> >it somewhat redundant.
>> >
>> >This patch removes the logical cpu parameter from the ARM
>> >cpuidle_ops.suspend hook and updates all the existing kernel
>> >implementations to reflect this change.
>> >
>> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> >Cc: Lina Iyer <lina.iyer@linaro.org>
>> >Cc: Russell King <linux@arm.linux.org.uk>
>> >Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Reviewed-by: Lina Iyer <lina.iyer@linaro.org>
>
>Thank you very much. May I also ask you to test it please, a Tested-by
>is needed since it affects QCOM platforms I can't test on at present.
>
Tested-by: Lina Iyer <lina.iyer@linaro.org>

Thanks,
Lina
