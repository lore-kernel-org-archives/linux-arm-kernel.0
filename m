From: eduardo.valentin@nokia.com (Eduardo Valentin)
Date: Wed, 16 Feb 2011 13:57:29 +0200
Subject: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
In-Reply-To: <AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>
	<AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>
Message-ID: <20110216115729.GA29817@besouro.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On Tue, Feb 15, 2011 at 01:58:00PM +0100, ext Linus Walleij wrote:
> 2010/5/11 Eduardo Valentin <eduardo.valentin@nokia.com>:
> 
> > Here is the version 5 of the change to export OMAP data to userspace
> > (name, revision, id code, production id and die id).
> >
> > Basically, this version is still attempting to create a new file under /proc.
> > It is the /proc/socinfo, which should be used to export bits which are SoC specific
> > (not CPU related, nor machine related).
> >
> > So, differences between previous version are:
> > - merged patch 02/04 with 03/04 to avoid compilation breakages.
> > - simplified the seq_file usage by using the single_open and single_release functions
> > - exported a function to register a seq_operation .show callback
> > - adapted the changes accordingly
> >
> > As usual, comments are welcome.
> 
> Eduardo, what has happened to this patchset?

Got forgotten :-(. Unfortunately I didn't pushed it hard enough.

> 
> Now we need something similar for arch/arm/mach-ux500 and I was sort of
> hoping that this infrastructure would be in place already... wrong I was.

Right.

> 
> Do you want help in picking it up and try to polish it up?

Yeah, but it would need a refactoring. IIRC, result of last discussion was that
we should not mess with /proc. So, maybe moving back to something under sysfs.
Perhaps /sys/devices/soc or so?

> 
> Yours,
> Linus Walleij

-- 
Eduardo Valentin
