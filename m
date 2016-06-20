From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 20 Jun 2016 19:27:37 +0800
Subject: [PATCH 00/12] power: add generic power sequence framework
In-Reply-To: <576487C1.5050807@maciej.szmigiero.name>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
 <576487C1.5050807@maciej.szmigiero.name>
Message-ID: <20160620112737.GB26936@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 18, 2016 at 01:29:05AM +0200, Maciej S. Szmigiero wrote:
> Hi Peter,
> 
> On 17.06.2016 12:09, Peter Chen wrote:
> > Hi all,
> > 
> > We have an well-known problem that the device needs to do some power
> > sequence before it can be recognized by related host, the typical
> > example like hard-wired mmc devices and usb devices. This power
> > sequence is hard to be described at device tree and handled by
> > related host driver, so we have created a common power sequence
> > framework to handle this requirement. The generic code is supplied
> > some common helpers from host driver, and individual power sequence
> > driver handles kinds of power sequence for devices.
> > 
> > Since the MMC has already done the similar things, and this power
> > sequence handling can be generic, we use mmc power sequence code
> > as base to create this framework.
> > 
> > This patch set is based on Krzysztof Kozlowski's RFC patch set (v4.7-rc1)
> > [1], and making some changes which can let it be generic. After that,
> > we create a generic power sequence driver for USB devices which handles
> > below things, it includes all input signals for devices I can consider.
> > 
> > - Clock and its frequencies
> > - GPIO for reset and the duration time
> > - GPIO for enable
> > - Regulator for power
> > 
> > This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> > two hot-plug devices to simulate this use case. The udoo board changes
> > were tested using my last power sequence patch set. [2]
> > 
> > @Maciej S. Szmigiero, Oscar, would you please test them on imx6qdl udoo
> > boards?
> 
> Thanks for the patch set, just tested them on my UDOO Quad board and can
> confirm that USB and on-board hub work fine.
> 
> Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> 
> Maciej
> 

Many thanks, Maciej.

-- 

Best Regards,
Peter Chen
