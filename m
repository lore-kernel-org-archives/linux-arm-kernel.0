From: gxt@mprc.pku.edu.cn (Guan Xuetao)
Date: Wed, 23 Mar 2011 09:29:46 +0800
Subject: [PATCH] ARM: Use asm-generic/sizes.h
In-Reply-To: <4D88ECE3.1070209@codeaurora.org>
References: <1300751462-1494-1-git-send-email-sboyd@codeaurora.org>
	<201103220934.50435.arnd@arndb.de>
	<20110322092113.GB17264@n2100.arm.linux.org.uk>
	<201103221110.20861.arnd@arndb.de>
	<00ec01cbe897$2eed7210$8cc85630$@mprc.pku.edu.cn>
	<4D88ECE3.1070209@codeaurora.org>
Message-ID: <00fc01cbe8f9$cd807640$688162c0$@mprc.pku.edu.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at codeaurora.org]
> Sent: Wednesday, March 23, 2011 2:40 AM
> To: Guan Xuetao
> Cc: 'Arnd Bergmann'; linux-arm-kernel at lists.infradead.org; 'Russell King - ARM Linux'; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH] ARM: Use asm-generic/sizes.h
> 
> On 03/22/2011 06:43 AM, Guan Xuetao wrote:
> > And I just complete the SZ_* definitions for 32-bit architecture,
> > and remove SZ_48M for not being power-of-2 size.
> 
> Ah, I didn't notice this part. SZ_48M is actually used by ARM code so
> that would need to be added to the generic header should we go with this
> patch.

IMO, the content of asm-generic/sizes.h should only include power-of-2 sizes definitions.
And SZ_48M could be replaced by (SZ_32M | SZ_16M) or (SZ_32M + SZ_16M), or added to arch-specific headers.

Guan Xuetao
