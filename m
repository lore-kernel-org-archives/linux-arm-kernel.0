From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Aug 2016 14:51:28 +0100
Subject: [PATCH] arm: add an option for erratum 657417
In-Reply-To: <CAKv+Gu-Ek0NEPP9f2Jp+3ZxwRAP8rqPwwwRa56b2Bz4i=7h=Jw@mail.gmail.com>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
 <20160812123314.GX1041@n2100.armlinux.org.uk>
 <20160812231503.3e2e059b@roar.ozlabs.ibm.com>
 <CAKv+Gu-Ek0NEPP9f2Jp+3ZxwRAP8rqPwwwRa56b2Bz4i=7h=Jw@mail.gmail.com>
Message-ID: <20160812135128.GY1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2016 at 03:49:15PM +0200, Ard Biesheuvel wrote:
> We could enable CONFIG_ARM_MODULE_PLTS in this case, and force a
> branch via a PLT entry if an affected instruction is encountered.
> However, this only covers branch instructions that are covered by
> relocations, so we'd still need to scan the module .text to look for
> affected instructions whose targets has been resolved at compile time.

Only if it's combined with detecting which regions of the .text section
are really instructions - just looking for something that appears to be
a branch instruction will be unreliable as the .text contains literal
data, and literal data could look like a branch instruction.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
