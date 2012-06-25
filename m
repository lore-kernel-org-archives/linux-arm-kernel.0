From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 25 Jun 2012 08:34:56 +0200
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <4FE4AB2F.8090402@wwwdotorg.org>
References: <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de>
 <4FDA40A0.4030206@wwwdotorg.org>
 <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
 <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
 <4FE0EFBB.6090206@firmworks.com>
 <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com>
 <20120622110038.GA15212@avionic-0098.mockup.avionic-design.de>
 <4FE4A4B3.9010200@wwwdotorg.org> <4FE4AB2F.8090402@wwwdotorg.org>
Message-ID: <20120625063456.GB11469@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 11:28:15AM -0600, Stephen Warren wrote:
> On 06/22/2012 11:00 AM, Stephen Warren wrote:
> > On 06/22/2012 05:00 AM, Thierry Reding wrote:
> > ...
> >> Stephen: can you try to find out whether the Tegra PCIe controller 
> >> indeed implements ECAM, or if this scheme is actually just a
> >> proprietary variant?
> > 
> > Sure. I have added this request to the bug I filed requesting more
> > complete PCIe host documentation.
> 
> I've received unofficial confirmation that we do indeed implement a
> non-standard/non-ECAM mapping, and what's in our driver matches our HW.

What I don't quite see yet is how the extended configuration space is
supposed to work with the current driver. The PCIE_CONF_* macros don't
provide for registers >= 256. Passing a value higher than that will mess
with the device function field.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/62af3efd/attachment.sig>
