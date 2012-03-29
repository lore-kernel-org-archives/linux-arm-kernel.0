From: khilman@ti.com (Kevin Hilman)
Date: Thu, 29 Mar 2012 11:03:40 -0700
Subject: [PATCH-V3 0/3] ARM: OMAP2+: Add powerdomain & PRM support for
 AM33XX device
In-Reply-To: <1331809586-24652-1-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Thu, 15 Mar 2012 16:36:23 +0530")
References: <1331809586-24652-1-git-send-email-hvaibhav@ti.com>
Message-ID: <87limjl1xf.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaibhav,

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> After going round-n-round on how to add support for AM33XX family
> of device into kernel, especially for PRM and CM support, we have
> decided to handle it separately; as AM33XX-PRCM module is different
> than OMAP3 and OMAP4 architecture.
>
> The difference becomes very interesting/weird when it comes to
> the consistency for register offsets in PRM address space and
> bit-field offsets inside PRM registers,
> So along with Powerdomain data and PRM api's required for AM33XX
> device, this patch series adds,
>
>  - XXX_RSTST register offset to "struct omap_hwmod_omap4_prcm"
>  - PWRSTCTRL & PWRSTST register offsets to "struct powerdomain"
>  - Logicretstate and mem_on/ret/pwrst/retst mask to "struct powerdomain"
>
>
> Testing: This patch series has been boot tested on AM37xEVM and AM335x
>          based BeagleBone community board.
>
> THANKS TO PAUL HERE...for helping and concluding on this, soon I will
> have similar patch for CM support, then clock-tree and hwmod will follow...
>
> Changes from V1 & V2:
> 	- Rolled back to my original approach, where AM33xx device was
> 	  handled separately (RFC version).

My apologies for causing the run around.  

This approach (without the prminst layer) is indeed a better approach.

Thanks for your patience (and persistence.)

I went to give this a test on my BeagleBone, but it doesn't apply to
mainline.  What upstream commit is this supposed to apply onto.  I tried
it on v3.3, but patch 3 fails with a conflict in io.c.

Looking at your am335x-staging branch, it seems that it depends on
previous changes to io.c made in:

        arm:omap:am33xx: Add AM335XEVM machine support

That patch appears to need an update for mainline as well.

Kevin
