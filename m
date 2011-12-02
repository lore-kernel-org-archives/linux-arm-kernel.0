From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Dec 2011 18:57:43 +0000
Subject: [PATCH 3/3] ARM: S3C64XX: Implement basic power domain support
In-Reply-To: <4008DCBCB90E409AA8C5E085EB54D2DB@Flatron>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1322765339-29879-3-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAH9JG2WLO-wFT_QEv4qBeCcz-pE2CNoMqV8f8u3BKF8r+GSBvA@mail.gmail.com>
 <20111202005604.GA31948@opensource.wolfsonmicro.com>
 <4008DCBCB90E409AA8C5E085EB54D2DB@Flatron>
Message-ID: <20111202185743.GA27227@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 07:25:01PM +0100, Tomasz Figa wrote:

> Please do not forget that there might be some drivers not yet submited
> to mainline and mainline should not break them with an assumption that
> there are no such drivers.

> For example, there is an on-going work on an open source OpenGL
> implementation for the GPU in S3C6410, known as OpenFIMG. Currently it
> uses a little kernel module for low level hardware management
> (interrupts, contexts, locking, power management), involving clock
> gating and runtime power management, but a DRM driver is planned.

As I said in the commit message for the patch you're following up on
I don't think that's a problem as it's pretty straightforward to add the
requisite hooks as part of adding the actual drivers.  The power domain
framework is really easy to use so it's not like it should cause real
effort, if you can figure out how to drive a 3D graphics engine adding a
device to a power domain shouldn't be too hard.

There will need to be arch/arm changes to add the platform devices and
hook up the clocks anyway so it's not like this is creating a need for
modifications.  Indeed I'd suggest adding the arch/arm stuff as it gets
written anyway, even if the actual drivers are still a work in progress.
It's one less thing to carry out of tree and it means that updates like
this or like the clk API reworks that I'd expect to start appearing soon
will happen for free.
