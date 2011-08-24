From: santosh.shilimkar@ti.com (Santosh)
Date: Wed, 24 Aug 2011 11:49:12 +0530
Subject: [PATCH v5 18/22] gpio/omap: use pm-runtime framework
In-Reply-To: <4E5477D0.9090301@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-19-git-send-email-tarun.kanti@ti.com>
	<4E53BA80.7030200@ti.com> <4E5477D0.9090301@ti.com>
Message-ID: <4E5497E0.4090004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 August 2011 09:32 AM, Rajendra Nayak wrote:
> On 8/23/2011 8:04 PM, Santosh wrote:
>> + Rajendra and Benoit to comment on optional clock
>> handling.
>>
>> On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:

[....]

>>>
>>> + if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev)< 0))
>>> + dev_err(bank->dev, "%s: GPIO bank %d "
>>> + "pm_runtime_get_sync failed\n",
>>> + __func__, bank->id);
>>> +
>>> for (j = 0; j< hweight_long(bank->dbck_enable_mask); j++)
>>> clk_enable(bank->dbck);
>> Optional clock handling also should been addressed using runtime hooks,
>> isn't it ?
>
> Whats handled by runtime hooks is the device;s *main* clocks, which are
> needed for the device to become accessible.
> Anything else *optional* which the device would need optionally based on
> the various modes it can operate etc are still controlled by the driver
> by enabling/disabling them as and when needed using the clock framework.
>
Thanks Rajendra for clarification. In summary, we continue to use clock
framework for the optional clock handling from the drivers.

Regards
Santosh
