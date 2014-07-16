From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Jul 2014 14:53:56 +0200
Subject: [PATCH 11/19] ARM: S5PV210: Remove support for board files
In-Reply-To: <1405505072.4408.17.camel@x220>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-12-git-send-email-t.figa@samsung.com>
 <1405505072.4408.17.camel@x220>
Message-ID: <53C675E4.4020502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.07.2014 12:04, Paul Bolle wrote:
> On Fri, 2014-07-04 at 19:48 +0200, Tomasz Figa wrote:

[snip]

>> -
>> -config MACH_AQUILA
>> -	bool "Aquila"
>> -	select CPU_S5PV210
>> -	select S3C_DEV_FB
>> -	select S3C_DEV_HSMMC
>> -	select S3C_DEV_HSMMC1
>> -	select S3C_DEV_HSMMC2
>> -	select S5PV210_SETUP_FB_24BPP
>> -	select S5PV210_SETUP_SDHCI
>> -	select S5PV210_SETUP_USB_PHY
>> -	select S5P_DEV_FIMC0
>> -	select S5P_DEV_FIMC1
>> -	select S5P_DEV_FIMC2
>> -	select S5P_DEV_ONENAND
>> -	help
>> -	  Machine support for the Samsung Aquila target based on S5PC110 SoC
>> -
> 
> This symbol is still referenced in sound/soc/samsung/Kconfig.

More code that I missed.

I believe that both sound card drivers for Goni and Aquilla could be
replaced with simple cards in DT, so I'll send a follow-up patch for this.

Most likely the same is the case for SMDK boards, but they don't seem to
have any active users (see cover letter for more details), which means
that probably they could be simply dropped from
sound/soc/samsung/Kconfig in another follow-up patch.

Best regards,
Tomasz
