From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Jan 2014 20:34:46 +0100
Subject: [PATCH 2/4] arm: qcom: Split Qualcomm support into legacy and
 multiplatform
In-Reply-To: <2B2190A4-6689-40D8-A3D7-BD2D882A2CF6@codeaurora.org>
References: <1391107002-21470-1-git-send-email-galak@codeaurora.org>
 <201401312020.16984.arnd@arndb.de>
 <2B2190A4-6689-40D8-A3D7-BD2D882A2CF6@codeaurora.org>
Message-ID: <3511712.H3ChLoqCm7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 January 2014 13:25:25 Kumar Gala wrote:
> > The hotplug.c change sticks out as something that isn't just a move
> > of code to another place, but deletion of unused code. It would
> > be nice to split that out into a separate change, possibly together
> > with the trivial board.c and smp.c changes.
> 
> That?s not 100% true, the hotplug.c code implemented msm_cpu_die, which moved into smp.c
> 
> I can split out scm*/smp* into a patch to enable smp if that is really desired, but not exactly sure what it gets us.
> 

It's not extremely important, I just prefer splitting patches
that have any kind of functional change from trivial moves.

If something happens to break for an unforseen reason, it's
easier to bisect to the patch that does the change.

	Arnd
