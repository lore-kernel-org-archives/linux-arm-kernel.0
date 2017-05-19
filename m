From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 May 2017 18:37:13 +0100
Subject: [PATCH] arm: boot/compressed: fix decompressor header layout for
 v7-M
In-Reply-To: <67bd95eb-1f4b-d9d2-9a68-3574d03ac072@arm.com>
References: <20170519145959.26569-1-ard.biesheuvel@linaro.org>
 <20170519164603.GH3559@e103592.cambridge.arm.com>
 <CAKv+Gu-yAT+kZ_oMT_+n6_RSOKOoqkZtGYjBKq=Wwhj31BgUgQ@mail.gmail.com>
 <67bd95eb-1f4b-d9d2-9a68-3574d03ac072@arm.com>
Message-ID: <20170519173713.GY22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 06:16:36PM +0100, Robin Murphy wrote:
> On 19/05/17 17:59, Ard Biesheuvel wrote:
> > Indeed. Apart from the error in the second line, this sequence should
> > be equivalent, but the nested macro invocations don't make it clearer
> > imo.
> > 
> > I could add some more comments as well if that helps?
> 
> Hmm, couldn't it be ISA-agnostic?
> 
> 	ldr pc, 1f
> 	.ltorg
> THUMB(	.thumb	)
> 	...
> 
> given that that should be interworking on anything where THUMB() is
> valid in the first place.

Unfortunately not, this is PIC code, so we must not have anything that
contains an absolute address.  LDR to branch is out of the question.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
