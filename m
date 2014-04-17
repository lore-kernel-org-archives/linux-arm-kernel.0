From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Thu, 17 Apr 2014 16:35:00 +0200
Subject: dma_alloc_coherent and cache?
In-Reply-To: <20140415081004.GJ22546@lunn.ch>
References: <45E047AA-4C3B-4645-A590-5B75A1729ADA@nowonline.co.uk>
 <20140415081004.GJ22546@lunn.ch>
Message-ID: <534FE694.8090102@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 10:10 AM, Andrew Lunn wrote:
> On Tue, Apr 15, 2014 at 09:43:38AM +0400, Lee Essen wrote:
>> Hi,
>>
>> I'm working on a driver for a Marvell switch device (98dx4122) where the basic interface closely resembles the mv643xx_eth device.
> 
> There is basic support for this SoC in the kernel. See
> arch/arm/boot/dts/kirkwood-98dx4122.dtsi and
> arch/arm/boot/dts/kirkwood-km_kirkwood.dts which is keymile's
> reference design.
> 
> Keymile are the experts for this device within the kernel community,
> so maybe they can comment?
> 

Hi Lee and Andrew,

Sorry for the quite late answer. At Keymile we rely on the driver (CPSS) Marvell
provides to manage the switch but personally I am not very happy about this
situation and I think your effort is great.

As you know, there are several ways to access the Switch from the CPU, one of
them is through the "internal" RGMII that you use, and another one is through
the CPU internal bus that we use at Keymile (thus we have to reserve a Mbus
window for the switch that then can be ioremapped). Since I have never used the
RGMII device, I cannot really give you some interesting hints here.

If we are talking about feroceon and caches, we have experienced a lot of
problems with the L2 cache that was sometimes not coherent with the CPU, but
with the latest versions of u-boot and Linux we do not see that anymore, so I
don't think you problem is this one.

That's unfortunately all the information I can provide to this thread.

Valentin
