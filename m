From: wmb@firmworks.com (Mitch Bradley)
Date: Tue, 23 Oct 2012 07:51:22 -1000
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121023172035.GB32167@arwen.pp.htv.fi>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
 <CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com>
 <508664CA.7000601@ti.com>
 <CACRpkdbhCS-Vb0DtbTZQ_Zw_8SOh3Bqutme3Y2-QrxNqvMiNNw@mail.gmail.com>
 <20121023100333.GA24418@arwen.pp.htv.fi> <5086CD91.9070101@firmworks.com>
 <20121023172035.GB32167@arwen.pp.htv.fi>
Message-ID: <5086D91A.5080109@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perhaps I misunderstood what you were suggesting.  I thought that, when
you said "explicitly manage all their resources", you meant that the
driver should know the platform-specific details about clocks and power
domains.  That is one possible interpretation of the word "explicit".

Now I see that you meant that the driver should explicitly call
abstracted functions.


On 10/23/2012 7:20 AM, Felipe Balbi wrote:
> HI,
> 
> On Tue, Oct 23, 2012 at 07:02:09AM -1000, Mitch Bradley wrote:
>> On 10/23/2012 12:03 AM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> I much prefer having drivers explicitly manage all their resources,
>>> which would mean that pinctrl calls need to be done on probe() and, if
>>> necessary, during suspend()/resume().
>>
>>
>> Per-driver resource management is certainly convenient when you are
>> dealing with a single system, but it becomes difficult to maintain for
>> drivers that are shared among many platforms.
> 
> why ? look at drivers/usb/dwc3/, we're using that on OMAP, exynos, PCIe
> and a couple of different FPGA implementations inside TI. Not to mention
> what other licensees of that IP core might have internally.
> 
> So far no problesm with resources at all.
> 
> We have frameworks exactly to hide the differences.
> 
>> The industry trend for many years has been consolidation around a single
>> programming model per class of device.  For example, SDHCI, EHCI, ATA.
>> This trend will only accelerate, as the cost of developing controller IP
>> and associated drivers increases.  Such drivers need to be as
>> platform-agnostic as possible.
> 
> that's why we have pinctrl framework to abstract the details about pin
> muxing.
> 
