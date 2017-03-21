From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Mar 2017 11:35:16 +0100
Subject: [PATCH] [v2] arm64: define BUG() instruction without CONFIG_BUG
In-Reply-To: <20170320190939.GR17263@arm.com>
References: <20170314213939.3874497-1-arnd@arndb.de>
 <20170320190939.GR17263@arm.com>
Message-ID: <CAK8P3a2d71PL4EaJ_hCAsjg3szG=0CFrLZ8U2AZvch=k3bv2gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 8:09 PM, Will Deacon <will.deacon@arm.com> wrote:

>>
>> -#define BUG() do {                           \
>> -     _BUG_FLAGS(0);                          \
>> -     unreachable();                          \
>> +#define _BUG_FLAGS(flags) __BUG_FLAGS(flags)
>
> What is this for? I don't see _BUG_FLAGS used anywhere, but I could
> be missing some macro expansion.

I think I accidentally left this after removing the last user from an
intermediate
version of the patch. Do you want me to send an updated version, or could
you just drop this line when applying?

       Arnd
