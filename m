From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 May 2017 19:33:49 +0100
Subject: [PATCH] arm: boot/compressed: fix decompressor header layout for
 v7-M
In-Reply-To: <29254cb6-ded4-6707-1d75-d0eac53e2f65@arm.com>
References: <20170519145959.26569-1-ard.biesheuvel@linaro.org>
 <20170519164603.GH3559@e103592.cambridge.arm.com>
 <CAKv+Gu-yAT+kZ_oMT_+n6_RSOKOoqkZtGYjBKq=Wwhj31BgUgQ@mail.gmail.com>
 <67bd95eb-1f4b-d9d2-9a68-3574d03ac072@arm.com>
 <2E764C85-57F3-4DC2-ADEB-B6B75A70B898@linaro.org>
 <29254cb6-ded4-6707-1d75-d0eac53e2f65@arm.com>
Message-ID: <20170519183349.GZ22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 06:58:16PM +0100, Robin Murphy wrote:
> Ah, I knew I'd have overlooked something - that makes sense.
> 
> FWIW, my final thought is this:
> 
> 	add	r12, pc, #5
> 	mov	r0, r0
> 	mov	pc, r12
> 
> Which I think should leave you in Thumb regardless of which ISA it's
> assembled in, thanks to the wackiness of ALUWritePC().

You only have four bytes to fit whatever code in here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
