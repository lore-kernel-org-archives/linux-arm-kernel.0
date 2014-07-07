From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 7 Jul 2014 07:52:12 +0200
Subject: [GIT PULL 1/3] ARM: tegra: rework PCIe regulators
In-Reply-To: <20140707003854.GD8469@quad.lixom.net>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
 <20140707003854.GD8469@quad.lixom.net>
Message-ID: <20140707055211.GA15216@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 06, 2014 at 05:38:54PM -0700, Olof Johansson wrote:
> On Mon, Jun 23, 2014 at 03:23:44PM -0600, Stephen Warren wrote:
> > This branch reworks the set of regulators that the Tegra PCIe driver
> > uses, so that the driver and DT bindings more correctly model what's
> > really going on in HW.
> > 
> > I've made this a separate branch in case it needs to be pulled into the
> > PCIe tree to resolve any conflicts. Any branch that adds Tegra124
> > support to the PCIe driver will need to be based on this branch, and
> > such patches might show up for 3.17, and be taken through the ARM tree
> > so we can manage our own dependencies.
> 
> Isn't PCI broken if you boot with an older device tree now?

Yes.

> I would like to see this as two branches: One to the PCI driver, and one
> modifying DT contents. The PCI driver should remain working for old DTs,
> so the last couple of commits on this branch can't be there.

This is one of my main gripes with device tree these days. We have many
situations where device tree bindings got rushed with the result that
many of them describe hardware in a *completely* wrong way.

The Tegra PCIe binding was designed with an incomplete understanding of
the hardware (I wonder how many other cases there are like this in
mainline) and it just happens to work by accident on existing platforms.

So this really boils down to one question: how do we fix bugs in device
tree bindings?

I suppose we could keep some sort of backwards-compatible shim inside
the driver to cope with the existing, wrong device tree binding. However
that means an additional maintenance burden and I'm not convinced that
there's a need in this particular case.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140707/e2beab94/attachment.sig>
