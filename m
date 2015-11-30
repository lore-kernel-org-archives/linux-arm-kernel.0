From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 30 Nov 2015 11:13:17 +0200
Subject: [PATCH 0/4] gpio: lpc32xx: add new LPC32xx GPIO controller driver
In-Reply-To: <CACRpkdYN+_2qrP3tDDj2SxDAEJr05FnPLKyFPEF9BGdVyQdTuQ@mail.gmail.com>
References: <1447982995-30231-1-git-send-email-vz@mleia.com>
 <CACRpkdYN+_2qrP3tDDj2SxDAEJr05FnPLKyFPEF9BGdVyQdTuQ@mail.gmail.com>
Message-ID: <565C132D.4040609@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 30.11.2015 10:54, Linus Walleij wrote:
> On Fri, Nov 20, 2015 at 2:29 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> 
>> Unfortunately the old driver has too many hacks inherited from the
>> ancient legacy NXP BSP and I find it can not be maintained, the new
>> driver has compatible interface to device tree clients, so moving
>> to the new driver should not impact any GPIO consumers.
> 
> Has it been tested on the old hardware too?

the hardware here is the same, the driver is different.

With the existing LPC32xx DTS files I tested that the DTS GPIO client's
interface is unchanged and that GPIO client drivers correctly work with
the new GPIO controller driver.

As a summary about the change,
* DT binding of GPIO controller in lpc32xx.dtsi is extended (no removed
properties),
* client's DT binding to the GPIO controller are untouched,
* GPIO controller code is completely replaced,
* GPIO client's side is untouched.

As a reminder about the necessity of the change, the legacy driver
operates with hardware IRQs, this prevents switching of the platfrom to
SPARSE_IRQ model.

It is important that the change depends on IRQ chip driver, which is
also under review.

I would appreciate, if review of this change can be started, so that
both IRQ chip driver and GPIO controller driver are accepted in one
merge window.

--
With best wishes,
Vladimir
