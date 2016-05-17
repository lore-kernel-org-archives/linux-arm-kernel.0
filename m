From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 00:45:51 +0200
Subject: [RFC6 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <mvm1t50ad0j.fsf@hawking.suse.de>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <alpine.DEB.2.20.1605171542340.24255@digraph.polyomino.org.uk>
 <mvm1t50ad0j.fsf@hawking.suse.de>
Message-ID: <4095406.jADDlVRiDg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 May 2016 18:02:36 Andreas Schwab wrote:
> Joseph Myers <joseph@codesourcery.com> writes:
> 
> > On Tue, 17 May 2016, Arnd Bergmann wrote:
> >
> >> I think it has become easier to override now and we just need to
> >> update sysdeps/unix/sysv/linux/generic/bits/typesizes.h to set
> >> 
> >> #define __INO64_T_TYPE          __UQUAD_TYPE
> >> #define __OFF64_T_TYPE          __UQUAD_TYPE
> >> #define __OFF_T_MATCHES_OFF64_T        1
> >> #define __INO_T_MATCHES_INO64_T        1
> >> 
> >> for new architectures (obviously not the ones that already use the
> >> 32-bit types). I haven't tries this, so there may be other things
> >> that are required.
> >
> > I think more than that would be needed to get struct stat to match and get 
> > things aliased for that (which is presumably desirable).
> 
> Looking at sysdeps/unix/sysv/linux/generic/bits/stat.h, there is at
> least blkcnt_t that differs between stat and stat64.  And you probably
> want to alias statfs and statfs64 as well, ie. fs{blk,fil}cnt_t.

Makes sense. Indeed that is a bit more work than I hoped, in particular
if we have to audit the uses of __WORDSIZE as well.

	Arnd
