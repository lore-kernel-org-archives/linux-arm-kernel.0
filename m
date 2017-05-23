From: robh@kernel.org (Rob Herring)
Date: Tue, 23 May 2017 10:19:09 -0500
Subject: [PATCH 3/7] clk: mvebu: cp110: do not depend anymore of the
 *-clock-output-names
In-Reply-To: <e47d288af5d42d4cc145eb7fa708f984a0fc0d9d.1495208533.git-series.gregory.clement@free-electrons.com>
References: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
 <e47d288af5d42d4cc145eb7fa708f984a0fc0d9d.1495208533.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170523151909.3n37igjjsfx6ojun@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 05:55:21PM +0200, Gregory CLEMENT wrote:
> Using the *-clock-output-names property was a convenient way to have a
> unique name for each clock even when there are multiple cp110 blocks
> as we can find on Armada 8K.
> 
> However it has some drawbacks: the main one being a stronger link than
> necessary between the driver and the device tree. For example the clock
> name can't be changed, removed or moved. It is still the early stage of
> introduction of the Armada 7K/8K and the hardware is still not totally
> documented, especially for the clock part. By removing the use of
> *-clock-output-names it will be easier to add new clocks without breaking
> the compatibility.
> 
> The name of each clock is now created by using its physical address as a
> prefix (as it was done for the platform device names). Thanks to this we
> have an automatic way to compute a unique name.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt |  14 +----------
>  drivers/clk/mvebu/cp110-system-controller.c                                | 106 ++++++++++++++++++++++++++++++++++++++++++++----------------------------
>  2 files changed, 65 insertions(+), 55 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
