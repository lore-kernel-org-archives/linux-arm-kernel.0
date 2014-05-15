From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 16 May 2014 00:17:34 +0200
Subject: [PATCH RFC 03/11] sound: ASoC: kirkwood: Remove ARCH_KIRKWOOD
 dependency
In-Reply-To: <5375392A.60905@baker-net.org.uk>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <1400163836-9831-7-git-send-email-andrew@lunn.ch>
 <5375392A.60905@baker-net.org.uk>
Message-ID: <20140515221734.GE10407@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 11:01:14PM +0100, Adam Baker wrote:
> On 15/05/14 15:23, Andrew Lunn wrote:
> >mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
> 
> Most of the descriptions in the series say remove mach-kirkwood and
> most of the actual patches remove ARCH_KIRKWOOD and leave
> MACH_KIRKWOOD untouched. Patch 01/11 hasn't turned up here so I'm
> not certain which you meant but consistency would be good.

01/11 is big, since it is an rm -fr arch/arm/mach-kirkwood. It is
bigger than the list message size limit and so has been put to one
side for the list moderator to approve.

The comment is consistent with the code, the code is however somewhat
confusing. arch/arm/mach-kirkwood uses ARCH_KIRKWOOD. kirkwood in its
new home inside arch/arm/mach-mvebu uses MACH_KIRKWOOD.

    Andrew
