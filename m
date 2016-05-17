From: schwab@suse.de (Andreas Schwab)
Date: Tue, 17 May 2016 18:02:36 +0200
Subject: [RFC6 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <alpine.DEB.2.20.1605171542340.24255@digraph.polyomino.org.uk>
 (Joseph Myers's message of "Tue, 17 May 2016 15:45:11 +0000")
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <573B0A4D.4090704@arm.com> <4173531.IRSphtVpg9@wuerfel>
 <alpine.DEB.2.20.1605171542340.24255@digraph.polyomino.org.uk>
Message-ID: <mvm1t50ad0j.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joseph Myers <joseph@codesourcery.com> writes:

> On Tue, 17 May 2016, Arnd Bergmann wrote:
>
>> I think it has become easier to override now and we just need to
>> update sysdeps/unix/sysv/linux/generic/bits/typesizes.h to set
>> 
>> #define __INO64_T_TYPE          __UQUAD_TYPE
>> #define __OFF64_T_TYPE          __UQUAD_TYPE
>> #define __OFF_T_MATCHES_OFF64_T        1
>> #define __INO_T_MATCHES_INO64_T        1
>> 
>> for new architectures (obviously not the ones that already use the
>> 32-bit types). I haven't tries this, so there may be other things
>> that are required.
>
> I think more than that would be needed to get struct stat to match and get 
> things aliased for that (which is presumably desirable).

Looking at sysdeps/unix/sysv/linux/generic/bits/stat.h, there is at
least blkcnt_t that differs between stat and stat64.  And you probably
want to alias statfs and statfs64 as well, ie. fs{blk,fil}cnt_t.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
