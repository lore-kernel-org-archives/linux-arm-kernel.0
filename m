From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Mar 2015 13:44:03 -0700
Subject: [PATCH 01/12] ARM: Remove mach-msm and associated ARM architecture
 code
In-Reply-To: <1426275371.7778.10.camel@x220>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>	
 <1426270185-19510-2-git-send-email-sboyd@codeaurora.org>
 <1426275371.7778.10.camel@x220>
Message-ID: <55034C13.9060808@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/15 12:36, Paul Bolle wrote:
> I've checked this series with my local Kconfig checker (for no other
> reason than that it removes board-sapphire.c and I had promised to do so
> too a week ago).
>
> On Fri, 2015-03-13 at 11:09 -0700, Stephen Boyd wrote:
>> --- a/arch/arm/mach-msm/Kconfig
>> +++ /dev/null
>> -config MSM_SMD
>> -	bool
> After this series MSM_SMD is still referenced in drivers/char/Kconfig
> (sin the entry for MSM_SMD_PKT) and drivers/tty/serial/Kconfig (in the
> entry for SERIAL_MSM_SMD).
>
> So I think those two Kconfing entries, drivers/char/msm_smd_pkt.c,
> drivers/tty/serial/msm_smd_tty.c, and the related lines in the two
> Makefiles involved, can be removed too. (A quick glance at those tow
> entries and those two files suggests there are no second order effects
> from removing all that.)
>

Oh yeah I missed those. We can delete them now and reintroduce them when
they're needed.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
