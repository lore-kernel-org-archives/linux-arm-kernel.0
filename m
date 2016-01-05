From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 5 Jan 2016 10:23:37 -0200
Subject: [PATCH 2/2] ARM: dts: imx6qdl-microsom-ar8035: Adjust Ethernet
 PHY reset duration
In-Reply-To: <20160104224234.GR19062@n2100.arm.linux.org.uk>
References: <1451934700-28060-1-git-send-email-festevam@gmail.com>
 <1451934700-28060-2-git-send-email-festevam@gmail.com>
 <20160104224234.GR19062@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5ByFwYk7JT=U-y-ECpDHLXwwk3XSiRWpsini2E34qmLbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 4, 2016 at 8:42 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 04, 2016 at 05:11:40PM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> As per the AR8035 datasheet:
>>
>> "For a reliable power on reset, suggest to keep asserting the reset
>> low long enough (10ms) to ensure the clock is stable and clock-to-reset
>> 1ms requirement is satisfied."
>
> This is questionable.  The quote you indicate above is "For a reliable
> POWER ON RESET".  It depends what use this DT is being put to.  Given
> that the only boot loader which is trustworthy on SoldRun hardware is
> their uboot versions, and these don't use DT, I would say that the
> only time that this is used is when the kernel is booting.
>
> That reset is not a power on reset, the phy has been powered for a
> comparitively long time by the time the kernel gets to use it.  So, I
> think on balance I'm going to NAK this change until there is a reason
> for it to be made - iow, when there _is_ a boot loader where the
> requirement for this parameter to be used at power on is required.

Ok, understood. I was working on a fix for U-boot where the 2ms reset
was not enough, so I thought about extending it to the kernel. I see
your point and agree that for the kernel we could keep the existing
2ms reset delay.
