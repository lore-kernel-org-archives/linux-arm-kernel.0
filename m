From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 4 Apr 2013 19:29:09 +0530
Subject: [PATCH v2 16/18] ARM: OMAP4+: CPUidle: Deprecate use of
 omap4_mpuss_read_prev_context_state()
In-Reply-To: <876203qos1.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-17-git-send-email-santosh.shilimkar@ti.com>
 <876203qos1.fsf@linaro.org>
Message-ID: <515D872D.9070404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013 03:07 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> Current OMAP4 CPUIdle driver is using omap4_mpuss_read_prev_context_state()
>> function to check whether the MPU cluster lost context or not. Thanks to
>> couple CPUIdle, cluster low power entry is almost guaranteed and hence
>> the programmed cluster check is enough in idle exit path. The API was
>> more of an optimization for corner cases, where if the cluster low power
>> entry fails for some reason, the cluster context restore gets skipped.
>>
>> Moving forward, OMAP CPUidle drivers needs to be moved to drivers/idle/*
>> once the PRM/CM code gets moved to drivers. This patch also reduces one
>> dependency with platform code for idle driver movement.
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Looks good, but I find the changelog a bit confusing.
> 
> Below is a slightly modified patch (I only modified the changelog).  If
> those changes are OK with you, I'll add it to my cpuidle branch as well.
> 
Looks good to me Kevin. Thanks for the change-log update.

Regards,
Santosh
