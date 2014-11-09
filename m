From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 9 Nov 2014 20:28:20 +0100
Subject: [PATCH 1/2] of: Make const the device node pointers in
 of_clk_get and of_node_put
In-Reply-To: <20141109185019.GU4042@n2100.arm.linux.org.uk>
References: <cover.1415557680.git.moinejf@free.fr>
 <375a82230accf26dfbbb74e6f928243ea8e38b50.1415557680.git.moinejf@free.fr>
 <20141109185019.GU4042@n2100.arm.linux.org.uk>
Message-ID: <20141109202820.026252bf@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 9 Nov 2014 18:50:19 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> What this then means is that it fundamentally undermines the idea of
> storing the pointer to a device_node as a const pointer, as the device
> node must always be modified when you're done with it (because it's a
> ref-counted structure.)  So, having it const in your code is a bug.
> 
> What this also means is that every other place that you've added const
> below is also very dubious.

Thanks for the explanation.

The correct patch will be simpler: in the ASoC structures, I found only
three places where the device_node pointer is const.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
