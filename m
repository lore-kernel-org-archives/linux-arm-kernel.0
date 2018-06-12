From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jun 2018 22:40:49 +0100
Subject: [U-Boot] [RFC PATCH 0/2] ARM: v7: Enable basic framework for
 supporting bits for CVE-2017-5715
In-Reply-To: <CAGo_u6qyf1Z+zSG-17TYRDPzG8V_0_-nk1F15HB4tPyT9rbUYQ@mail.gmail.com>
References: <20180125214559.27570-1-nm@ti.com>
 <CAOMZO5CcEf=EhFWknKmCXXLJPOgx=65jLH+X1OAGkg5VxBGVew@mail.gmail.com>
 <CAGo_u6qyf1Z+zSG-17TYRDPzG8V_0_-nk1F15HB4tPyT9rbUYQ@mail.gmail.com>
Message-ID: <20180612214049.GA17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 02:13:38PM -0500, Nishanth Menon wrote:
> On Tue, May 22, 2018 at 9:05 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Thu, Jan 25, 2018 at 7:45 PM, Nishanth Menon <nm@ti.com> wrote:
> >> Hi Folks,
> >>
> >> This is a follow through on the discussion we have had in [1].
> >> This itself is'nt a complete solution and is based on recommendation
> >> This from Arm[2] for variant 2 CVE-2017-5715
> >>
> >> The Linux kernel discussions are spread out in [3], ATF and OPTEE
> >> status are available in [4].
> >>
> >> This is just an RFC series (build tested at this point) to check if
> >> the direction is fine and should follow the final solution once kernel
> >> patches get to upstream, IMHO.
> >>
> >> NOTE: As per ARM recommendations[2], and discussions in list[1] ARM
> >> Cortex-A9/12/17 do not need additional steps in u-boot to enable the
> >> OS level workarounds.
> >>
> >> Nishanth Menon (2):
> >>   ARM: Introduce ability to enable ACR::IBE on Cortex-A8 for
> >>     CVE-2017-5715
> >>   ARM: Introduce ability to enable invalidate of BTB on Cortex-A15 for
> >>     CVE-2017-5715
> >
> 
> I started respinning the series, while there is definitely a use of
> implementing in u-boot,
> I am starting to wonder if we should also be doing this in kernel.

How does the kernel set the bit when the kernel is running in non-secure
mode, when the ACTLR is read-only in that mode?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
