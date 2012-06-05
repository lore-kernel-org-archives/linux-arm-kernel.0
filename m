From: sfking@fdwdc.com (Steven King)
Date: Tue, 5 Jun 2012 07:35:00 -0700
Subject: Freescale fec.c driver breakage
In-Reply-To: <20120605134116.GY23408@opensource.wolfsonmicro.com>
References: <4FCC3CB4.5030107@snapgear.com> <4FCE088D.1060604@snapgear.com>
 <20120605134116.GY23408@opensource.wolfsonmicro.com>
Message-ID: <201206050735.00458.sfking@fdwdc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 June 2012 6:41:16 am Mark Brown wrote:
> On Tue, Jun 05, 2012 at 11:24:29PM +1000, Greg Ungerer wrote:
> > Well, yeah, of course there are clocks involved. But you pretty much
> > hit the point here. 'ipg' and 'ahb' here are platform specific.
>
> What should be happening for that is that the driver requests with some
> generic name which is referenced to the IP (unfortunately these are
> usually not documented for the public...) and then clkdev or some
> platform specific code is used to map the names onto the underlying
> clocks.
>
> If 'ahb' isn't suitable how about 'bus', and for 'ipg' how about 'mclk'
> or something?

Some of the newer Coldfire parts such as the m54455/m5441x do have software 
controllable clocks; but they keep it simple with one clock per fec, and 
names in the documentation like 'fec0, fec1' for the m54455 
and 'macnet0,macnet1' for the m5441x. 
