From: cmetcalf@ezchip.com (Chris Metcalf)
Date: Fri, 22 May 2015 16:13:22 -0400
Subject: [RFC PATCH] EDAC: Cleanup atomic_scrub mess
In-Reply-To: <20150521181157.GF3689@pd.tnic>
References: <1431991481-25684-1-git-send-email-lho@apm.com>
 <1431991481-25684-2-git-send-email-lho@apm.com>
 <20150519170308.GL4641@pd.tnic>
 <CAPw-ZT=mTpt_vz+e=rM5ywK8feNKkJQrpEWg=noRCziJ0840TQ@mail.gmail.com>
 <20150519203336.GP4641@pd.tnic> <20150521180719.GE3689@pd.tnic>
 <20150521181157.GF3689@pd.tnic>
Message-ID: <555F8DE2.4060402@ezchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2015 02:11 PM, Borislav Petkov wrote:
> From: Borislav Petkov<bp@suse.de>
>
> So first of all, this atomic_scrub() function's naming is bad. It looks
> like an atomic_t helper. Change it to edac_atomic_scrub().
>
> The bigger problem is that this function is arch-specific and every new
> arch which doesn't necessarily need that functionality still needs to
> define it, otherwise EDAC doesn't compile.
>
> So instead of doing that and including arch-specific headers, have each
> arch define an EDAC_ATOMIC_SCRUB symbol which can be used in edac_mc.c
> for ifdeffery. Much cleaner.
>
> We already are doing this with another symbol - EDAC_SUPPORT. This is
> also much cleaner than having CONFIG_EDAC explicitly depend on all the
> arches which need/have EDAC support and drivers.
>
> This way I can kill the useless edac.h header in tile too.
>
> Signed-off-by: Borislav Petkov<bp@suse.de>

Acked-by: Chris Metcalf <cmetcalf@ezchip.com> [for tile]

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com
