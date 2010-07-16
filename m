From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jul 2010 22:01:09 +0200
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
Message-ID: <201007162201.09629.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 July 2010 19:57:55 Grant Likely wrote:
> On Fri, Jul 16, 2010 at 10:03 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Wed, 2010-07-14 at 00:04 +0100, Grant Likely wrote:
> 
> sfr and I were talking about your patch the other day.  Just warning
> on incomplete dependencies is enough to make it actually workable for
> me (without my ugly post-processing step).  I was very happy to hear
> that it is in linux-next.
> 
> Last missing piece is being able to do "select FOO = n", which Stephen
> is currently working on.

Are there a lot of symbols for which this is needed? If there is only
a handful, you could work around this by selectively adding

config FOO
	bool "foo"
	default !FOO_DISABLE

config FOO_DISABLE
	def_bool "n"


		Arnd
