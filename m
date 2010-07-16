From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Jul 2010 19:07:01 +0100
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
Message-ID: <20100716180701.GA26854@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 11:57:55AM -0600, Grant Likely wrote:
> Last missing piece is being able to do "select FOO = n", which Stephen
> is currently working on.

I thought Linus' idea was to use:

KBUILD_KCONFIG=file make allnoconfig

in which case any option which would be presented to the user which hasn't
been selected by 'file' ends up being set to n.  That means there's no
need for a special "select FOO=n" construct.

See one of Linus' replies on June 3:
Message-ID: <alpine.LFD.2.00.1006031317410.8175@i5.linux-foundation.org>
