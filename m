From: joseph@codesourcery.com (Joseph Myers)
Date: Tue, 17 May 2016 15:45:11 +0000
Subject: [RFC6 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <4173531.IRSphtVpg9@wuerfel>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <573B0A4D.4090704@arm.com> <4173531.IRSphtVpg9@wuerfel>
Message-ID: <alpine.DEB.2.20.1605171542340.24255@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 May 2016, Arnd Bergmann wrote:

> I think it has become easier to override now and we just need to
> update sysdeps/unix/sysv/linux/generic/bits/typesizes.h to set
> 
> #define __INO64_T_TYPE          __UQUAD_TYPE
> #define __OFF64_T_TYPE          __UQUAD_TYPE
> #define __OFF_T_MATCHES_OFF64_T        1
> #define __INO_T_MATCHES_INO64_T        1
> 
> for new architectures (obviously not the ones that already use the
> 32-bit types). I haven't tries this, so there may be other things
> that are required.

I think more than that would be needed to get struct stat to match and get 
things aliased for that (which is presumably desirable).

-- 
Joseph S. Myers
joseph at codesourcery.com
