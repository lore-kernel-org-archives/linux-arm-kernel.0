From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 10 May 2013 16:03:31 -0700
Subject: [PATCH v2 1/2] clk: Disable unused clocks after deferred probing
 is done
In-Reply-To: <20130510064520.GI3041@game.jcrosoft.org>
References: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
 <1368124502-18830-1-git-send-email-skannan@codeaurora.org>
 <20130510064520.GI3041@game.jcrosoft.org>
Message-ID: <518D7CC3.6050000@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2013 11:45 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:35 Thu 09 May     , Saravana Kannan wrote:
>> With deferred probing, late_initcall() is too soon to declare a clock as
>> unused. Wait for deferred probing to finish before declaring a clock as
>> unused. Since deferred probing is done in late_initcall(), do the unused
>> check to late_initcall_sync.
>
> Nack for both regulator & clk
>
> you can not known when the clock need to be shutdown
>
> example display splash screen set by the bootloader and display as module
>
> Best Regards,
> J.

You are joking right? This is already done in the kernel. If you don't 
want that, please rip out the code and try to get that picked up. I'm 
sending out this patch for fix what's currently in the kernel for those 
who care for the current feature.

Regards,
Saravana


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
