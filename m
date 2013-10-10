From: nm@ti.com (Nishanth Menon)
Date: Thu, 10 Oct 2013 14:01:16 -0500
Subject: [PATCH] ARM: dts: omap4-panda-es: Do not reset gpio1
In-Reply-To: <20131010164702.GF29913@atomide.com>
References: <1381313521-10422-1-git-send-email-rnayak@ti.com>
 <1381423481-5920-1-git-send-email-nm@ti.com>
 <20131010164702.GF29913@atomide.com>
Message-ID: <5256F97C.9080101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2013 11:47 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [131010 09:53]:
>> Do not reset GPIO1 at boot-up because GPIO 7 in GPIO1 block is used on
>> OMAP4460 PandaBoard-ES to select voltage register in TPS62361 which
>> supplies VDD_MPU.
>>
>> Without this, OMAP4460 PandaBoard-ES boards fail to boot-up because
>> MPU voltage switches over to VSET0 voltage value (boot voltage) which
>> is not sufficient to operate the device at OPP100.
> 
> Is this needs as a fix for the -rc series?

Nope, this is not a regression recently introduced, has been in since
day one of Panda-ES support. Further, we still have decision pending
on the dependent series from Rajendra[1] - will be good to see it go
in along with AM335x-EVM.


[1] http://marc.info/?t=138131368300005&r=1&w=2

-- 
Regards,
Nishanth Menon
