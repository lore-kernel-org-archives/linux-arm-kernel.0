From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 18 Oct 2016 13:51:39 -0700
Subject: [PATCH v5 00/23] Support qcom's HSIC USB and rewrite USB2 HS
 support
In-Reply-To: <20161018093139.GB6294@b29397-desktop>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018093139.GB6294@b29397-desktop>
Message-ID: <147682389932.20076.4186408979552866325@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-10-18 02:31:40)
> On Mon, Oct 17, 2016 at 06:56:13PM -0700, Stephen Boyd wrote:
> > I've also sent separate patches for other minor pieces to make this
> > all work. The full tree can be found here[2], hacks and all to get
> > things working. I've tested this on the db410c, apq8074 dragonboard,
> > and ifc6410 with configfs gadgets and otg cables.
> > 
> > Patches based on v4.8-rc1

Oops should be v4.9-rc1 here.

> > 
> > Changes from v4:
> >  * Picked up Acks from Rob
> >  * Updated HS phy init sequence DT property to restrict it to offsets
> 
> I remembered that you got all my acks for chipidea patches, right? I did
> not check for this series.

Sorry I've added in one more patch

   usb: chipidea: Emulate OTGSC interrupt enable path

to fix extcon interrupt emulation even further.

> 
> Besides, the patch "gpu: Remove depends on RESET_CONTROLLER when not a
> provider" [1]  still not be accepted, I need this patch to be merged
> first, then apply your chipidea part, otherwise, there is a building
> warning.
> 
> [1] https://patchwork.kernel.org/patch/9322583/

Yes, I'm going to resend that patch now. I hope that David will apply it
for -rc2.
