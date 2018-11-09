From: nm@ti.com (Nishanth Menon)
Date: Fri, 9 Nov 2018 03:00:33 -0600
Subject: [PATCH 1/2] dt-bindings: pinctrl: k3-am6: Introduce pinmux
 definitions
In-Reply-To: <1c400ca6-9257-0831-6909-fb00b00c4698@ti.com>
References: <20181108112647.7205-1-vigneshr@ti.com>
 <20181108112647.7205-2-vigneshr@ti.com>
 <20181108134533.3dcy3f53oxze5nlz@kahuna>
 <1c400ca6-9257-0831-6909-fb00b00c4698@ti.com>
Message-ID: <20181109090033.jx4buin3xuogdgfo@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:20-20181109, Vignesh R wrote:
> >> +++ b/include/dt-bindings/pinctrl/k3-am6.h
> > 
> > Are we thinking of creating headers for every single SoC?
> 
> We would need one file per SoC family (i.e atleast one for K3 family as
> a whole) as pinctrl register layout is significantly different than

Yes, I am aware of the same.

> other TI SoCs. I can rename the file to include/dt-bindings/pinctrl/k3.h
> to indicate its intended to be common for all K3 SoCs, if you prefer.

Yes, that would be the preference. There are two types of IO muxing IPs
(the equivalent of padconf from omap days) that I
am aware of. However these are all within the same 32bit definitions and
I know there has been significant effort spend by designers based on
software team feedbacks to maintain consistency as much as possible
within technological constraints.

So macros could be used to differentiate within the same header. The
deltas do exist, however they can be differentiated easily.

You should have access to the alternative solution, and even if you
cannot publish it, you should plan the header to scale easily when the
time is appropriate as a trivial additional patch.

For the rest.. Will wait for v2.

-- 
Regards,
Nishanth Menon
