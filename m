From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 6 Jun 2011 18:32:21 +0530
Subject: [PATCH 2/3] davinci: dm6467/T EVM: pass reference clock rate to
	dm646x_init()
In-Reply-To: <20110606122552.GA2729@xyzzy.org.uk>
References: <1307034677-27236-1-git-send-email-nsekhar@ti.com>
	<1307034677-27236-2-git-send-email-nsekhar@ti.com>
	<4DEB7DD4.5050706@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D38344A@dbde02.ent.ti.com>
	<20110606122552.GA2729@xyzzy.org.uk>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D383514@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bob,

On Mon, Jun 06, 2011 at 17:55:52, Bob Dunlop wrote:
> Hi,
> 
> On Mon, Jun 06 at 05:01, Nori, Sekhar wrote:
> > On Sun, Jun 05, 2011 at 18:30:04, Sergei Shtylyov wrote:
> > >     I don't think you should ascribe *your* patch to Bob. There's 
> > > Suggested-by: line if you want to credit Bob.
> > 
> > Bob, do you have an opinion on this? If not, I will go with what
> > Sergei is suggesting.
> 
> I have no problem one way or the other, we all know who we are.

Okay, I will do what Sergei is suggesting then.

> 
> Anyway I'd like to propose a simpler patch that covers both boards in one.
> Fewer files touched than the original da850 patch.
> 
> Add the ref_clk_rate parameter to the davinci_soc_info structure and
> perform the clock adjustment in davinci_common_init().  The code assumes

Lets not extend davinci_soc_info any further. We need to be looking
at ways of reducing its usage (for example by making GPIO code use
platform device).

Also, refclk is a board information not soc information so placing
it there makes it misplaced.

> that if which to tweak the ref_clk it will be the first one listed in
> cpu_clocks[] which is the case for all boards sofar.
> 
> The only downside is you need to export the davinci_soc_info_dm646x struct
> in order to tweak it.

That's not very elegant as well. SoC information structure for a given
SoC should be private to the SoC specific file. Making it public will
open it up for abuse.

Thanks,
Sekhar
