From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 14 Mar 2014 12:32:02 +0100
Subject: [PATCH v2 1/3] ARM: dts: berlin2q: add the Marvell Armada 1500 pro
In-Reply-To: <5322CC8B.6010905@gmail.com>
References: <1394719607-25018-1-git-send-email-antoine.tenart@free-electrons.com>
 <1394719607-25018-2-git-send-email-antoine.tenart@free-electrons.com>
 <5322CC8B.6010905@gmail.com>
Message-ID: <20140314113202.GB3106@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/2014 at 10:31:55 +0100, Sebastian Hesselbarth wrote :
> On 03/13/2014 03:06 PM, Antoine T?nart wrote:
> >+		local-timer at ad0600 {
> >+			compatible = "arm,cortex-a9-twd-timer";
> >+			reg = <0xad0600 0x20>;
> >+			clocks = <&sysclk>;
> 
> If I understand Jisheng correctly, this should be cpuclk/3. When
> removing the clocks {} container above, please also take care of
> it.
> 

You understood correctly

> You can do
> 
> cpuclk: cpu-clock {
> 	compatible = "fixed-clock";
> 	#clock-cells = <0>;
> 	clock-frequency = <1200000000>; /* <- put correct freq here */
> };
> 
> sysclk: system-clock {
> 	compatible = "fixed-factor-clock";
> 	#clock-cells = <0>;
> 	clocks = <&cpuclk>;
> 	clock-multi = <1>;
> 	clock-div = <3>;
> };
> 
> Hopefully, we'll have proper clock drivers soon so we can just replace
> referenced "fixed-*" clocks.
> 

I'm working on that, do you have some code that you can share right now ?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
