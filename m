From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 23 Feb 2018 08:54:55 -0800
Subject: [PATCH v2 0/3] Support qcom pinctrl protected pins
In-Reply-To: <CACRpkdbgz9PnyLgsn_grsGHbVnak54aOKhetsqfvag5wJNm7=g@mail.gmail.com>
References: <20180126011400.2191-1-sboyd@codeaurora.org>
 <94a7bd07-8ad5-7ab1-20ab-a02fe2476efd@codeaurora.org>
 <CACRpkdbgz9PnyLgsn_grsGHbVnak54aOKhetsqfvag5wJNm7=g@mail.gmail.com>
Message-ID: <20180223165455.GN93895@bjorns-mbp-2.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23 Feb 06:22 PST 2018, Linus Walleij wrote:

> On Tue, Feb 20, 2018 at 5:45 PM, Timur Tabi <timur@codeaurora.org> wrote:
> > On 01/25/2018 07:13 PM, Stephen Boyd wrote:
> >>
> >> This patchset proposes a solution to describing the valid
> >> pins for a pin controller in a semi-generic way so that qcom
> >> platforms can expose the pins that are really available.
> >>
> >> Typically, this has been done by having drivers and firmware
> >> descriptions only use pins they know they have access to, and that
> >> still works now because we no longer read the pin direction at
> >> boot. But there are still some userspace drivers and debugfs facilities
> >> that don't know what pins are available and attempt to read everything
> >> they can. On qcom platforms, this may lead to a system hang, which isn't
> >> very nice behavior, even if root is the only user that can trigger it.
> >
> > Any progress on this patch set?  Stephen no longer works for Qualcomm, so I
> > don't know what the next step is, and I really want this feature in 4.17
> > (we've missed so many merge windows already).
> 
> I depend on Bjorn as maintainer of the pin control driver to ACK
> the solution he likes.
> 

I haven't found the time to review the reuse of the irq valid mask or
the effort needed to replace this, other than that I think the series
looks good.

Regards,
Bjorn
