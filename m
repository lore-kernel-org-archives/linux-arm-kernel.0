From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 30 Jan 2018 11:01:50 +0100
Subject: [PATCH v6 2/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <20180130095916.GA23047@ulmo>
References: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
 <CACRpkdan52UB7HOyH1gnHWg4CDke_VQxAdq8cBgwUroibE59Ow@mail.gmail.com>
 <20180129082533.6edmqgbauo6q5dgz@flea.lan>
 <CACRpkdYAGwUjr2C-w5U+WuG48pZAOUcnxFjznLbdF6Lmy1uZuQ@mail.gmail.com>
 <CAK8P3a2HmPOTHAzqBnmim388pcWOE=fG50mG5HJifT=vzKOaTg@mail.gmail.com>
 <20180130075441.rqxzkwero6sdfak6@flea.lan>
 <CAK8P3a0QxQE=GM=SGPtT82=UreiqsgY6uMThvQ_woA3rjK0zjA@mail.gmail.com>
 <20180130095916.GA23047@ulmo>
Message-ID: <20180130100150.GB23047@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 10:59:16AM +0100, Thierry Reding wrote:
> On Tue, Jan 30, 2018 at 10:24:48AM +0100, Arnd Bergmann wrote:
> > On Tue, Jan 30, 2018 at 8:54 AM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> > > On Mon, Jan 29, 2018 at 03:34:02PM +0100, Arnd Bergmann wrote:
> > >> On Mon, Jan 29, 2018 at 10:25 AM, Linus Walleij
> > >> <linus.walleij@linaro.org> wrote:
> > >> > On Mon, Jan 29, 2018 at 9:25 AM, Maxime Ripard
> > >> > <maxime.ripard@free-electrons.com> wrote:
> > >> >> On Sat, Jan 27, 2018 at 05:14:26PM +0100, Linus Walleij wrote:
> > 
> > >>
> > >> At one point we had discussed adding a 'dma-masters' property that
> > >> lists all the buses on which a device can be a dma master, and
> > >> the respective properties of those masters (iommu, coherency,
> > >> offset, ...).
> > >>
> > >> IIRC at the time we decided that we could live without that complexity,
> > >> but perhaps we cannot.
> > >
> > > Are you talking about this ?
> > > https://elixir.free-electrons.com/linux/latest/source/Documentation/devicetree/bindings/dma/dma.txt#L41
> > >
> > > It doesn't seem to be related to that issue to me. And in our
> > > particular cases, all the devices are DMA masters, the RAM is just
> > > mapped to another address.
> > 
> > No, that's not the one I was thinking of. The idea at the time was much
> > more generic, and not limited to dma engines. I don't recall the details,
> > but I think that Thierry was either involved or made the proposal at the
> > time.
> 
> Yeah, I vaguely remember discussing something like this before. A quick
> search through my inbox yielded these two threads, mostly related to
> IOMMU but I think there were some mentions about dma-ranges and so on as
> well. I'll have to dig deeper into those threads to refresh my memories,
> but I won't get around to it until later today.
> 
> If someone wants to read up on this in the meantime, here are the links:
> 
> 	https://lkml.org/lkml/2014/4/27/346
> 	http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/257200.html
> 
> From a quick glance the issue of dma-ranges was something that we hand-
> waved at the time.
> 
> Thierry

Also found this, which seems to be relevant as well:

	http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/252715.html

Adding Dave.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180130/8ae6e69f/attachment.sig>
