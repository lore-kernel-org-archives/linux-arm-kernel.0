From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 3 Feb 2012 12:45:09 +0530
Subject: [PATCH 1/2] ARM: OMAP: Get rid of reset for system timer
In-Reply-To: <87obthcc57.fsf@ti.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
 <87obthcc57.fsf@ti.com>
Message-ID: <CAMQu2gy2jDWszUAMDCfgyXsLNWUAb6phWpOP=7geFXTkc30S_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 3, 2012 at 12:10 AM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> hwmod setup already does a reset and sets the OCP sysconfig
>> registers appropriately. Avoid doing a reset again and overriding
>> the OCP sysconfig settings in the system timer init code.
>
> That is true for OMAP4, but have you verified if this is indeed a
> duplicate reset on ?OMAP2/3?
>
Yes. It is duplicate for OMAP2 and OMAP3 devices as well.
Actually this should have been fixed when the driver was
hwmod converted but some how got missed. We noticed
an issue on OMAP5, when timer interrupts stopped firing when
always on clock domain was allowed to idle. This was because
this reset was clearing the correctly set sysc value by hwmod.

The patch is also tested on ZOOM3 ( OMAP3630)
and OMAP2430SDP.

Regards
Santosh
