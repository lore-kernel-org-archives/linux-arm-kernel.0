From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Oct 2011 13:21:07 +0100
Subject: [PATCH/RFT 0/12] step towards removal of mach/system.h
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <20111025122107.GA6892@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

On Mon, Oct 24, 2011 at 10:49:49AM +0100, Nicolas Pitre wrote:
> In the spirit of eventually being able to boot a single zImage on multiple
> SOCs, we need to get rid of mach/system.h.  This file mainly contains two
> inline functions that should be out-of-line and assigned to the existing global
> hooks at run time.  Those functions are arch_idle() and arch_reset().  The
> following series only address the former.

I'm looking at the latter, but I'm losing the will to live in the process.

> [PATCH 01/12] ARM: clean up idle handlers
> [PATCH 02/12] ARM: mach-at91: move special idle code to a
> [PATCH 03/12] ARM: mach-clps711x: move special idle code to a
> [PATCH 04/12] ARM: mach-ebsa110: move special idle code to a
> [PATCH 05/12] ARM: mach-gemini: move special idle code to a
> [PATCH 06/12] ARM: mach-h720x: move special idle code to a
> [PATCH 07/12] ARM: mach-ixp23xx: properly disable CPU idle call
> [PATCH 08/12] ARM: mach-ixp4xx: properly disable CPU idle call
> [PATCH 09/12] ARM: s3c24xx: move special idle code to a proper
> [PATCH 10/12] ARM: mach-shark: properly disable CPU idle call
> [PATCH 11/12] ARM: mach-w90x900: properly disable CPU idle call
> [PATCH 12/12] ARM: imx: move special idle code to proper out-of-line

I think you might need to hack on mach-msm too as they have an
implementation of arch_idle which is written in assembly (for reasons which
aren't obvious to me).

Will
