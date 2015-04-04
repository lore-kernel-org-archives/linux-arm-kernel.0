From: ipaton0@gmail.com (Iain Paton)
Date: Sat, 04 Apr 2015 10:16:49 +0100
Subject: [PATCH 1/2] sunxi: a20-LIME2 update regulator description
In-Reply-To: <20150330231350.GA23664@lukather>
References: <55143CA1.7000606@gmail.com> <20150330231350.GA23664@lukather>
Message-ID: <551FAC01.8000404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/03/15 00:13, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Mar 26, 2015 at 05:06:41PM +0000, Iain Paton wrote:
>> configure regulators as per the manufacturers recomendations from their
>> 3.4.x fex file.
>>
>> this is necessary to prevent operating points in the dtsi selecting
>> inappropriate values and causing the board to lockup

> Could you use the axp DTSI please?
> 
> That will remove most of the chunk defined in there.

No. See my other reply. The regulators are even more board specific than 
the opp data and the interaction between the two is hard to handle at
the best of times.

Using the axp dtsi means that the board dts really has to override every 
single possible item that could ever be added to the dtsi just to ensure 
stability.  This won't remove anything, it'll just add extra unnecessary 
stuff to the mix as well as the additional burden on people taking care of 
a board watching the axp dtsi to catch any additions there casuing further 
problems.

Wishing these things were suitable for a common dtsi unfortunately doesn't 
change the reality whatsoever. 
I'm with you that exploiting commonality is generally a good thing. It's 
just not appropriate here.

It also seems that most other boards have realised that the pmic setup is 
board specific and keep it in the appropriate place in the dts. 
The only other obvious example I can find apart from sunxi is TI, everyone 
else is doing the opposite.
So why the resistance?  A repeat of the label based syntax / alphabetical 
ordering thing?

Rgds,
Iain
