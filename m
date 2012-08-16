From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 16 Aug 2012 20:27:03 +0200
Subject: [PATCH v3 05/10] resource: add PCI configuration space support
In-Reply-To: <502D0F3C.4010308@wwwdotorg.org>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-6-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo4qg45brVRwEbw3=R04VsbnvUowSMWcT+M6VoAxbf3Cqg@mail.gmail.com>
 <20120814055542.GB16181@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6LYpkC5wop53S1r1z3ov4+w4soqrQARzbbouVs1trzUg@mail.gmail.com>
 <20120814180142.GA9430@avionic-0098.mockup.avionic-design.de>
 <CAErSpo4Efy-Dt67rktzNiYfZfOTSu=pmYtyGd3tR-zZQ3jDGtA@mail.gmail.com>
 <20120815064902.GB15665@avionic-0098.mockup.avionic-design.de>
 <502D0F3C.4010308@wwwdotorg.org>
Message-ID: <20120816182703.GA31005@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 09:18:20AM -0600, Stephen Warren wrote:
> On 08/15/2012 12:49 AM, Thierry Reding wrote:
> ...
> > Stephen: Could you try to find out whether the regular
> > configuration space translation can just be omitted if we already
> > set up the one for the extended configuration space? In
> > tegra_pcie_setup_translations(), BAR 0 is setup for regular
> > configuration space (which requires a 16 MiB region), while BAR 1
> > is setup for the extended configuration space (requiring a full 256
> > MiB region). However, if I understand correctly, each of the
> > registers that can be accessed via the BAR 0 translation can also
> > be accessed via the BAR 1 translation. That seems like we're 
> > wasting the 16 MiB set aside for the BAR 0 mapping.
> 
> I have confirmed that in theory, the EXTCFG space can indeed be used
> to access any register, making the regular config space redundant.
> However, using the HW this way has apparently received less validation.

Okay. I wasn't expecting anything else really. I'll give this a try next
time I get my hands on some Tegra hardware. If that works maybe we
should make up for the missing validation by testing this more
thoroughly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120816/f0f90297/attachment-0001.sig>
