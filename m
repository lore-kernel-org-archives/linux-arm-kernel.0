From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 07 Aug 2013 09:48:16 -0400
Subject: angel_SWI_ARM
In-Reply-To: <CANEcUBW2OsQqN_Cm_9ThJmcmNB5oQfNvqNi_MU+DsCNAPJtaFQ@mail.gmail.com>
References: <CANEcUBW2OsQqN_Cm_9ThJmcmNB5oQfNvqNi_MU+DsCNAPJtaFQ@mail.gmail.com>
Message-ID: <52025020.1020506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 06:57 AM, zhaobin xv wrote:
> Hello
> when I read linux/arch/arm/boot/compressed/head.S
> I can't understand :
>  mrs    r2, cpsr        @ get current mode
>         tst    r2, #3            @ not user?
>         bne    not_angel
>         mov    r0, #0x17        @ angel_SWIreason_EnterSVC
>         swi    0x123456        @ angel_SWI_ARM
> I want to know :
> a) what is angel_SWI_ARM
> b) what is angel debuger
> c)Do the code " swi    0x123456 " make interrupt what make program
> jump to addr 0x0000 0008
> ,but addr 0x0000 0008 doesn't initialize.

Angel is ARM's semihosting interface.

http://infocenter.arm.com/help/topic/com.arm.doc.dui0471c/CHDJHHDI.html

HTH,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
