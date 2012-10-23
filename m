From: wmb@firmworks.com (Mitch Bradley)
Date: Tue, 23 Oct 2012 07:02:09 -1000
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121023100333.GA24418@arwen.pp.htv.fi>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
 <CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com>
 <508664CA.7000601@ti.com>
 <CACRpkdbhCS-Vb0DtbTZQ_Zw_8SOh3Bqutme3Y2-QrxNqvMiNNw@mail.gmail.com>
 <20121023100333.GA24418@arwen.pp.htv.fi>
Message-ID: <5086CD91.9070101@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2012 12:03 AM, Felipe Balbi wrote:
> Hi,
> 
> I much prefer having drivers explicitly manage all their resources,
> which would mean that pinctrl calls need to be done on probe() and, if
> necessary, during suspend()/resume().


Per-driver resource management is certainly convenient when you are
dealing with a single system, but it becomes difficult to maintain for
drivers that are shared among many platforms.

The industry trend for many years has been consolidation around a single
programming model per class of device.  For example, SDHCI, EHCI, ATA.
This trend will only accelerate, as the cost of developing controller IP
and associated drivers increases.  Such drivers need to be as
platform-agnostic as possible.
