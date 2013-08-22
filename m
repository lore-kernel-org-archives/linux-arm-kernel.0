From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 22 Aug 2013 10:00:08 +0200
Subject: [PATCH] of: reduce the number of PROBE_DEFERs
In-Reply-To: <CACxGe6vNKoi47-R3H2sYUhGuX5Lh0nokWaj6Bzw2zv2U0_Wgsg@mail.gmail.com>
References: <20130820120105.55a4c0ce@armhf>
 <CACxGe6vNKoi47-R3H2sYUhGuX5Lh0nokWaj6Bzw2zv2U0_Wgsg@mail.gmail.com>
Message-ID: <20130822100008.2669b0d9@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Aug 2013 11:13:24 +0100
Grant Likely <grant.likely@linaro.org> wrote:

> On Tue, Aug 20, 2013 at 11:01 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > This patch populates the platform from the device tree into two steps:
> > the first step creates the nodes that are referenced by a phandle,
> > the second step creates the other nodes.
> >
> > This permits to reduce the number of PROBE_DEFERs.
> >
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> > A better way to reduce probe deferral could be sorting the nodes
> > according to their phandle level in the DT blob at compilation time ...  
> 
> Have you got measurements or statistics that show this making a
> difference? I suspect you'll find for boot time it will have little to
> no affect since the device driver probe order is more closely related
> to the kernel link order than the order that devices were registered.

With the device tree and most drivers as modules, the kernel link order
does not matter.

I admit that the gain may be small: I just get none or just one probe
deferral instead of 3 on my cubox with this patch.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
