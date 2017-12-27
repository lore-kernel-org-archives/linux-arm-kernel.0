From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 26 Dec 2017 18:01:42 -0800
Subject: [PATCH 0/3] [v11] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <CACRpkdYtMbACG0D2zjgw-kN_3pb_VDGH_3DDhyMQD92eE5P0Gw@mail.gmail.com>
References: <1513797033-9494-1-git-send-email-timur@codeaurora.org>
 <CACRpkdYtMbACG0D2zjgw-kN_3pb_VDGH_3DDhyMQD92eE5P0Gw@mail.gmail.com>
Message-ID: <20171227020142.GZ7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21, Linus Walleij wrote:
> Hi Timur,
> 
> thank you for your perseverance. I am sorry that I am sometimes not
> fast to respond :(
> 
> On Wed, Dec 20, 2017 at 8:10 PM, Timur Tabi <timur@codeaurora.org> wrote:
> 
> > Patch 1 reverts an old patch that triggers a get_direction of every
> > pin upon init, without attempting to request the pins first.  The
> > direction is already being queried when the pin is requested.
> >
> > Patch 2 adds support to pinctrl-msm for "unavailable" GPIOs.
> 
> I have applied both of these to the pinctrl "devel" branch so we
> can see if all is fine.
> 
> They have Stephen's ACK so I am happy with them, I am just
> still slightly worried about possible regressions because of
> patch 1.
> 
> > Patch 3 extends that support to pinctrl-qdf2xxx.  A recent ACPI change
> > on QDF2400 platforms blocks access to most pins, so the driver can only
> > register a subset.
> 
> I see this one is still under discussion.
> 
> If nothing drastic happens with patch 1/2 in linux-next
> it should be fine if you just resend this single patch in subsequent
> submissions.
> 

If we go with my suggestion, patch 2 is not necessary and should
be dropped. The different approaches come down to expressing
which pins are available through the gpio valid mask, or through
the npins field of the msm pinctrl driver. Also, my approach
covers more than just GPIOs, it covers irqs and adjusts the
pinctrl pin request function so that pinctrl can't request
unavailable pins.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
