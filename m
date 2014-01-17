From: robherring2@gmail.com (Rob Herring)
Date: Fri, 17 Jan 2014 09:14:47 -0600
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
Message-ID: <CAL_JsqKX2RT2E6uk3d35m+TWW7iuPFFiuZzOwd0xA9zMgqAZRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 9:08 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 16 Jan 2014, Olof Johansson wrote:
>
>> "for SDIO slots" is somewhat misleading; nearly all controllers only
>> do one slot/device per controller. The designware controller can do
>> multiple slots, and that adds a bit of driver and binding complexity
>> for something that seemingly not a single vendor has actually
>> implemented.
>
> The Marvell 8688, just to name one, does both WIFI and BlueTooth over
> the same SDIO controller using separate functions/slots.

But that is logical functions within a chip, not multiple discrete
chips (i.e. slots) with their own reset, regulators, etc. There would
still be a single set of external controls per host controller I
think.

Rob
