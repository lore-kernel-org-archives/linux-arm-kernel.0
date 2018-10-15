From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 15 Oct 2018 21:56:01 +0200
Subject: [PATCH 6/6] arm64: dts: xilinx: ultra96: Standardize LED labels
 and triggers
In-Reply-To: <7b94c09d-ecbd-e48e-6583-127566715a76@xilinx.com>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
 <20181009140522.6492-7-manivannan.sadhasivam@linaro.org>
 <7b94c09d-ecbd-e48e-6583-127566715a76@xilinx.com>
Message-ID: <20181015185147.GA29649@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 09:25:24, Michal Simek wrote:
> On 9.10.2018 16:05, Manivannan Sadhasivam wrote:
> > For all 96Boards, the following standard is used for onboard LEDs.
> > 
> > device-name:green:user1  default-trigger: heartbeat
> > device-name:green:user2  default-trigger: mmc0/disk-activity
> >                                           (onboard-storage)
> > device-name:green:user3  default-trigger: mmc1 (SD-card)
> > device-name:green:user4  default-trigger: none, panic-indicator

Actually, having one LED as heartbeat and second as panic indicator
only... Could those be merged and remaining LED used to something
useful?

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---

> > index eb5e8bddb610..565ceb390f99 100644
> > --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> > +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> > @@ -57,29 +57,30 @@
> >  	leds {
> >  		compatible = "gpio-leds";
> >  		ds2 {
> > -			label = "ds2";
> > +			label = "zynqmp-zcu100-revC:green:user1";
> 
> The purpose of this series should be standardize Led labels that's why I
> would expect that leds will be called in the same way on all these
> boards that's why I am not getting why there is board name.
> 
> green:user1 or just user1 should be enough.

green:user1 is better. Also... I guess this should go to the LEDs
list... and if you want to make names standard, maybe there's better
naming than user1..user4?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181015/9fc335bc/attachment.sig>
