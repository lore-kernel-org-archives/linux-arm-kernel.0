From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jan 2015 09:13:10 +0100
Subject: [PATCH 1/4] rtc: armada38x: Add the device tree binding
 documentation
In-Reply-To: <87iogai8sc.fsf@natisbad.org>
References: <1420817565-28800-1-git-send-email-gregory.clement@free-electrons.com>
 <1420817565-28800-2-git-send-email-gregory.clement@free-electrons.com>
 <87iogai8sc.fsf@natisbad.org>
Message-ID: <20150114081310.GI4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 12:02:27AM +0100, Arnaud Ebalard wrote:
> Hi Gregory,
> 
> Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
> 
> > The Armada 38x SoCs come with a new RTC which differs from the one
> > used in the other mvebu SoCs until now. This patch describes the
> > binding of this RTC.
> >
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > ---
> >  .../devicetree/bindings/rtc/armada-380-rtc.txt          | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
> > new file mode 100644
> > index 000000000000..2c56bef9dd7e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
> > @@ -0,0 +1,17 @@
> > +* Real Time Clock of te Armada 38x SoCs
> > +
> > +RTC controller for the Armada 38x SoCs
> > +
> > +Required properties:
> > +- compatible : Should be "marvell,armada-380-rtc"
> > +- reg: physical base address of the controller and length of memory mapped
> > +  region. The second entires is for the IP configuration part.
>                         ^^^^^^^
>                         entry
> 
> I had to read probe function to understand precisely the purpose of each
> region, i.e. IMHO the description could be made a bit clearer.

Maybe using reg-names would make it easier to understand, both in the
documentation and the DT itself (as well as not needing to enforce a
particular ordering of the two areas in the documentation)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/2bd3c29f/attachment-0001.sig>
