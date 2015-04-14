From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 14 Apr 2015 14:40:57 -0500
Subject: [RFC PATCH 4/5] arm64: smp: move the pen to a header file
In-Reply-To: <20150414155941.GK28709@leverpostej>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <1428601031-5366-5-git-send-email-galak@codeaurora.org>
 <20150414155941.GK28709@leverpostej>
Message-ID: <C129C778-135D-4B3C-86E0-A345BE75EDE7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Apr 14, 2015, at 10:59 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> On Thu, Apr 09, 2015 at 06:37:10PM +0100, Kumar Gala wrote:
>> From: Abhimanyu Kapur <abhimany@codeaurora.org>
>> 
>> Move the secondary_pen_release variable and the secondary_holding_pen
>> entry function to asm/smp_plat.h so that the other cpu ops implementations
>> can share them.
> 
> If anything, this should all be moved into smp_spin_table.c, and made
> static.
> 
> We made a mistake with the pen (and allowing multiple CPUs to enter the
> kernel at once). That mistake shouldn't be spread further.
> 
> Mark.

Yeah, it appears I can drop this and just set the secondary cores to enter secondary_entry.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
