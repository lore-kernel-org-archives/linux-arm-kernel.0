From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 May 2013 18:59:07 +0530
Subject: [RFC V7 PATCH 0/3] USB: OHCI: Start splitting up the driver
In-Reply-To: <1369657550-24101-1-git-send-email-manjunath.goudar@linaro.org>
References: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
 <1369657550-24101-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <CAKohpom1jofi9bBrJ54OmeP8M83FfHALN=khDx7iADPF3PvZwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 May 2013 17:55, Manjunath Goudar <manjunath.goudar@linaro.org> wrote:
> This series of patches begins the process of splitting ohci-hcd up into
> a core library module and independent pci driver modules.
>
> Patch 1/3 prepares the way by exporting a few functions from ohci-hcd
> and adding a new mechanism for platform-specific drivers to initialize
> their hc_driver structures.  This deserves to be done in the core
> because almost all of the entries in these structures are pure
> boilerplate -- practically none of the drivers need to override more
> than three of the standard core values.
>
> Patch 2/3 is part of separating the ohci pci host controller
> driver from ohci-hcd host code.
> Moved sb800_prefetch() function from ohci-pci.c to pci-quirks.c file
> and EXPORTed, this is part of the effort to move the ohci pci related
> code to generic pci code.
>
> Patch 3/3  separate out ohci-pci into independent driver modules.

You need to tell everybody what has changed from V6 to V7..
