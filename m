From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 22 Oct 2018 12:20:08 +0530
Subject: [PATCH 6/6] arm64: dts: xilinx: ultra96: Standardize LED labels
 and triggers
In-Reply-To: <20181015185147.GA29649@amd>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
 <20181009140522.6492-7-manivannan.sadhasivam@linaro.org>
 <7b94c09d-ecbd-e48e-6583-127566715a76@xilinx.com>
 <20181015185147.GA29649@amd>
Message-ID: <20181022065008.GA10999@mani>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

Sorry for the late reply! Not sure why your resonse was filtered by the
Spam filter :\

On Mon, Oct 15, 2018 at 09:56:01PM +0200, Pavel Machek wrote:
> On Wed 2018-10-10 09:25:24, Michal Simek wrote:
> > On 9.10.2018 16:05, Manivannan Sadhasivam wrote:
> > > For all 96Boards, the following standard is used for onboard LEDs.
> > > 
> > > device-name:green:user1  default-trigger: heartbeat
> > > device-name:green:user2  default-trigger: mmc0/disk-activity
> > >                                           (onboard-storage)
> > > device-name:green:user3  default-trigger: mmc1 (SD-card)
> > > device-name:green:user4  default-trigger: none, panic-indicator
> 
> Actually, having one LED as heartbeat and second as panic indicator
> only... Could those be merged and remaining LED used to something
> useful?
>

No. Our intention is to leave one LED as a panic indicator and a dedicated
LED for heartbeat. If user wants to override the defaults, he can always do
with any LEDs.
 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> 
> > > index eb5e8bddb610..565ceb390f99 100644
> > > --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> > > +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> > > @@ -57,29 +57,30 @@
> > >  	leds {
> > >  		compatible = "gpio-leds";
> > >  		ds2 {
> > > -			label = "ds2";
> > > +			label = "zynqmp-zcu100-revC:green:user1";
> > 
> > The purpose of this series should be standardize Led labels that's why I
> > would expect that leds will be called in the same way on all these
> > boards that's why I am not getting why there is board name.
> > 
> > green:user1 or just user1 should be enough.
> 
> green:user1 is better. Also... I guess this should go to the LEDs
> list... and if you want to make names standard, maybe there's better
> naming than user1..user4?
> 

These are user LEDs and that's why the `userN` naming convention comes into
place. Here I agree to move with "green:user1" format and sending it to the
LEDs list.

Thanks,
Mani

> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
