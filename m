From: briannorris@chromium.org (Brian Norris)
Date: Fri, 13 Oct 2017 17:06:48 -0700
Subject: [PATCH 0/3] PCI: rockchip: assert PERST# in S3
In-Reply-To: <20171013062728.GA56763@google.com>
References: <20171012205220.130048-1-briannorris@chromium.org>
 <20171013031523.GB25517@bhelgaas-glaptop.roam.corp.google.com>
 <20171013062728.GA56763@google.com>
Message-ID: <CA+ASDXM2UnoGOkyVy=y3XToTvLZ1djLNaDESkB89mf-mzqGHRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

One piece of information to add:

On Thu, Oct 12, 2017 at 11:27 PM, Brian Norris <briannorris@chromium.org> wrote:
> On Thu, Oct 12, 2017 at 10:15:23PM -0500, Bjorn Helgaas wrote:
> > Is this a hole in those specs?  Is this something that needs to be
> > clarified by the PCI-SIG to improve interoperability?
>
> After re-re-reading the specifications, I'm more convinced that the
> first Wifi vendor got it wrong. I also don't trust them to get many
> things right in general, so this is pretty much par for the course.
>
> The only things I can suggest:
> * "main power" is never defined, as far as I can tell. So "main" and
>   "auxiliary" power don't have much meaning for many M.2 cards, and so
>   I end up reading much of the spec with a grain of salt

This part is where the first vendor seems to disagree. They claim that
because power is not switched off, PERST# can remain asserted or
deasserted -- whichever leads to least power consumption. (i.e., they
don't consider they need to follow the parts that describe "when
removing main power" (e.g., in S3) we must assert PERST#.

> * S3 is never defined in the PCIe Card EM spec, but it's thrown around a
>   few times
> * if possible, the PCIe base spec should mention something about the
>   fundamental reset which is expected with an L2 transition. It's not
>   clear what to do if you don't want to switch off power completely (and
>   so enter L3), but you also don't have "auxiliary" power

Brian
