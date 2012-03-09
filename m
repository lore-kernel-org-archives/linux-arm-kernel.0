From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 9 Mar 2012 08:53:47 +0100
Subject: [PATCH 05/11] tps6586x: Add device-tree support
In-Reply-To: <20120309051506.761B63E090F@localhost>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-6-git-send-email-thierry.reding@avionic-design.de>
 <20120308150607.GP3638@opensource.wolfsonmicro.com>
 <20120308151545.GA23934@avionic-0098.mockup.avionic-design.de>
 <20120309051506.761B63E090F@localhost>
Message-ID: <20120309075347.GA27270@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely wrote:
> On Thu, 8 Mar 2012 16:15:46 +0100, Thierry Reding <thierry.reding@avionic-design.de> wrote:
> > * Mark Brown wrote:
> > > ...they all seem to be explicitly named in the device tree so presumably
> > > there's enough information in there for the driver to pick any set of
> > > regulators in any order.  This would be much nicer to use.
> > 
> > I don't like it much either. The only reason that requirement exists is
> > because it makes the assignment of the regulator ID (as defined in the
> > include/linux/mfd/tps6586x.h header) very trivial. Would it be better to
> > look up the ID based on the node name (sm0 --> TPS6586X_ID_SM_0, ...)?
> > 
> > Then the only requirement would be that the names match.
> 
> Yes, please look up id via name.  Alternately you can give each child node
> a 'reg' property and put #address-cells = <1>; #size-cells = <0>; in the
> parent (assuming the regulator number is a documented attribute of the
> hardware and not just a convenient linux construct).

I'll go with the lookup via name then because as far as I can tell the
datasheet doesn't list any specific ordering of the regulators.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/61b3ddc2/attachment-0001.sig>
