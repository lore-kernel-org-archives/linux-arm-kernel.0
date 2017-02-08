From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 8 Feb 2017 11:23:47 +0000
Subject: [PATCH 1/2] clk: scpi: RfC - Allow to ignore invalid SCPI DVFS
 clock rates
In-Reply-To: <d7b8f9db-7512-646c-bb96-ef74e7266661@gmail.com>
References: <3b60654a-88b6-6262-396e-a058ade1c586@gmail.com>
 <d7b8f9db-7512-646c-bb96-ef74e7266661@gmail.com>
Message-ID: <209248b8-2a1c-e00f-d8a8-b82759772b5d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/02/17 21:03, Heiner Kallweit wrote:
> Introduce an optional property "clock-max-frequency" for SCPI DVFS
> clocks. All frequencies for the respective clock exceeding this
> threshold will be ignored.
> 
> This is useful on systems where the firmware offers too optimistic
> clock rates causing instabilities and crashes.
> 

It clearly means the firmware/hardware(IOW platform) was not tested
correctly before firmware advertised the OPPs. It needs to fixed in the
firmware. The approach should be advertise the known minimal set working
rather than the set for which hardware was designed.

That's the whole reason while these are kept in firmware so the OS need
not worry about such details.

So NACK, go fix the firmware or disable it completely and be happy with
the boot frequency.

-- 
Regards,
Sudeep
