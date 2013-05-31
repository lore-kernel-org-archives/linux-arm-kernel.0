From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 31 May 2013 07:33:10 +0200
Subject: Kirkwood CPU Freq driver
In-Reply-To: <51A7DE65.4090108@baker-net.org.uk>
References: <51A12DD4.9010907@baker-net.org.uk>
 <20130526083614.GB26249@lunn.ch>
 <20130526180513.GF31290@titan.lakedaemon.net>
 <51A5234D.9030100@baker-net.org.uk> <20130528215126.GF7678@lunn.ch>
 <51A7DE65.4090108@baker-net.org.uk>
Message-ID: <20130531053310.GJ7678@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 12:19:01AM +0100, Adam Baker wrote:
> On 28/05/13 22:51, Andrew Lunn wrote:
> >>I've now tested with the first of these patches applied and the
> >>>changes from the second added to my .config
> >>>
> >>>To get it to work I had to follow the instructions in the
> >>>Documentation to add the cpus entry to kirkwood.dtsi so I'll post
> >>>that as a patch in a day or two but after doing that I have a
> >>>working cpufreq driver.
> >Great that you got it working. Something must of changed in the
> >generic code, since originally a cpu node was not required.
> >
> >The clocks are not needed in node, so please don't list them.
> >
> Andrew, I just tried testing without the clocks line in the .dtsi
> and I get the messages below in dmesg
> 
> [   18.554990] ERROR: could not get clock /cpus/cpu at 0:cpu_clk(0)
> [   18.560840] kirkwood-cpufreq kirkwood-cpufreq: Unable to get cpuclk
> [   18.567154] kirkwood-cpufreq: probe of kirkwood-cpufreq failed
> with error -2

Duh! I have forgotten how my driver works! Yes, it needs the node,
with clocks. I even documented it!

Strange thing is, i cannot find a patch adding such a node.

I suggest you add the node to the kirkwood.dtsi. I've never seen any
products using the 88F632X, we have no support for it, and very likely
its much more work needed than just moving a few DT nodes around.

Please submit your patch to Jason.

       Thanks
	Andrew
