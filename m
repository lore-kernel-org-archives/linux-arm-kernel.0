From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 31 May 2012 10:51:25 +0300
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <4FC5DFCF.1020606@codeaurora.org>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
Message-ID: <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 10:52:31AM +0200, Stephen Boyd wrote:
> On 5/29/2012 2:58 AM, Peter De Schrijver wrote:
> > Add an extension API for clocks. This allows clocktypes to provide extensions
> > for features which are uncommon and cannot be easily mapped onto normal clock
> > framework concecpts. eg: resetting blocks, configuring clock phase etc.
> 
> This seems rather generic. Why not add more specific APIs/concepts like
> clk_reset(), clk_set_phase(), etc.? If they don't map, maybe we should
> make them map.
> 

Some of those might be very SoC specific. Eg OMAP doesn't need software
controlled modulereset. I don't think we should add a new function to the
clock framework for clock related features which only exist in a single
SoC or family. Ideally we could use inheritance to add methods to derived
clocktypes, but that's not really possible in C unfortunately.

Cheers,

Peter.
