From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 6 Jun 2012 15:07:54 +0300
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <20120531191916.GA19475@gmail.com>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5E837.30702@ti.com> <20120531191916.GA19475@gmail.com>
Message-ID: <20120606120754.GU8026@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 09:19:16PM +0200, Mike Turquette wrote:
> On 20120530-14:58, Rajendra Nayak wrote:
> > Hi Peter,
> > 
> > On Tuesday 29 May 2012 03:28 PM, Peter De Schrijver wrote:
> > >Add an extension API for clocks. This allows clocktypes to provide extensions
> > >for features which are uncommon and cannot be easily mapped onto normal clock
> > >framework concecpts. eg: resetting blocks, configuring clock phase etc.
> > 
> > I was thinking on similar lines for OMAP wherein I need to control
> > 'hardware-auto-gating' bits on clocks which are otherwise just normal
> > gates or dividers. We just disable all of them early at boot and
> > re-enable them late in the boot process once PM kicks in.
> > 
> 
> It would be helpful to get an idea of what these different functions
> actually do.  This patch exposes a sort of poor man's ioctl/syscall
> interface (which may indeed be necessary), but I would first prefer to
> pool together everybody's needs and see if some new high-level APIs
> should be added to clk.h.
> 
> Already a clk_reset/module reset call has been discussed in this thread.
> The changelog discusses setting clock phase and Rajendra mentioned
> controlling auto-gating behavior.
> 
> Do other folks have these same needs?  What about other needs that are
> unlisted?  Please add them to the thread so we can get an idea of what
> we're up against.

* clock phase (invert or programmable delay)
* external request line configuration

Cheers,

Peter.
