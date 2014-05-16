From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 16 May 2014 11:14:32 +0300
Subject: [PATCH 00/11] ARM: OMAP: OMAP5 & AM43x DSS
In-Reply-To: <20140512154850.GG31772@atomide.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
 <5370CBD5.3060107@ti.com> <20140512143604.GB31772@atomide.com>
 <5370E172.20009@ti.com> <20140512154850.GG31772@atomide.com>
Message-ID: <5375C8E8.1020209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/14 18:48, Tony Lindgren wrote:

>>> Also, I'm wondering why we still have .clk and .opt_clks entries in the
>>> hwmod data for am43xx and omap5 which are both device tree based with
>>> all the clocks coming from .dts files?
>>
>> I think they are needed for the omap_device/hwmod stuff to work. Only
>> omapdss driver knows about the clocks defined in the .dts files, and the
>> omap_device/hwmod code still needs to do the reset and maybe some other
>> tasks that require the clocks.
> 
> We're already populating the hwmod data from dts entries, that's done by
> omap_device_build_from_dt. Why aren't we doing that for dt defined clocks?
> 
> I'd rather not start adding new data that will then just be removed, that's
> what people call "pointless extra churn".

I don't know why. I have to say I'm not 100% sure if that's done or not,
but at least I can't find where it's done.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140516/8531d271/attachment.sig>
