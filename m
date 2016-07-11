From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 Jul 2016 18:12:22 +0200
Subject: [PATCH v2 1/6] dt-bindings: clock: add DT binding for the Xtal
 clock on Armada 3700
In-Reply-To: <20160708093156.4f235b85@free-electrons.com> (Thomas Petazzoni's
 message of "Fri, 8 Jul 2016 09:31:56 +0200")
References: <1467931071-31004-1-git-send-email-gregory.clement@free-electrons.com>
 <1467931071-31004-2-git-send-email-gregory.clement@free-electrons.com>
 <20160708093156.4f235b85@free-electrons.com>
Message-ID: <87a8hotaqh.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On ven., juil. 08 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Fri,  8 Jul 2016 00:37:46 +0200, Gregory CLEMENT wrote:
>
>> +gpio1: gpio at 13800 {
>> +	compatible = "marvell,mvebu-gpio-3700",	"syscon", "simple-mfd";
>
> I find this compatible string not very consistent with what we do for
> other drivers, it should have been:
>
> 	marvell,armada-3700-gpio

Thanks for pointing this. We missed it during the last review. I agree
that using marvell,armada-3700-gpio is more appropriate, especially
because the gpio controller on Armada 37xx seems to be different that
the ones used on the other mvebu SoCs.

Gregory

>
> or something like that.
>
>
>> +	xtalclk: xtal-clk {
>> +		compatible = "marvell,armada-3700-xtal-clock";
>
> See here for example.
>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
