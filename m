From: olof@lixom.net (Olof Johansson)
Date: Mon, 3 Nov 2014 22:19:13 -0800
Subject: [GIT PULL] ARM: brcmstb: SMP, Kconfig, earlyprintk and GISB fixes
In-Reply-To: <1413840408-14860-1-git-send-email-f.fainelli@gmail.com>
References: <1413840408-14860-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20141104061913.GE13562@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 02:26:48PM -0700, Florian Fainelli wrote:
> These changes were posted late during the v3.18 release cycle, and were
> eventually added to your 'late' branch, but here is an updated version
> 
> Thanks!
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/brcm/linux.git tags/brcmstb-smp-uart-for-3.19
> 
> for you to fetch changes up to 203bb85ed605e43eadca62afb3a8cd128a8ec10a:
> 
>   bus: brcmstb_gisb: save and restore GISB timeout (2014-10-20 12:44:42 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains 3 changes for the brcmstb platform and 2 changes
> to the GISB bus arbiter driver
> 
> - fist patch adds earlyprintk to brcmstb platforms using the existing 8250
>   infrastructure
> 
> - second patch re-introduces SMP support after fixing the problems we had in
>   the initial implementation, for this patch to apply cleanly, I had to advance
>   up to "ARM: brcmstb: revert SMP support"
> 
> - third patch is dropping unused Kconfig dependencies
> 
> - fourth patch registers the ARM fault code for external aborts that the GISB
>   bus arbiter driver is designed to assit
> 
> - fifth patch does save/restore the GISB arbiter timeout across S3
>   suspend/resume cycles
> 
> Thanks!
> 
> ----------------------------------------------------------------
> Brian Norris (2):
>       ARM: brcmstb: reintroduce SMP support
>       ARM: brcmstb: Kconfig: drop unneeded symbol selections
> 
> Florian Fainelli (2):
>       bus: brcmstb_gisb: register the fault code hook
>       bus: brcmstb_gisb: save and restore GISB timeout
> 
> Marc Carino (1):
>       ARM: brcmstb: add debug UART for earlyprintk support

Ok, actually looking at the pull request now, sorry for the delay.

Looks like the two patches fromy ou should have been in a drivers branch
instead. Since they were trivial I'll keep them in here though.


-Olof
