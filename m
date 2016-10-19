From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Oct 2016 09:50:31 -0700
Subject: [PATCH v2] arm64: defconfig: enable EEPROM_AT25 config option
In-Reply-To: <5740014.mZjAIri61F@wuerfel>
References: <1476298306-9138-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMjLOhCBX1K_A_BB8TcMr3Ki5jagvPvxiihdJVXZ1LLmpw@mail.gmail.com>
 <c1f5e1f8-b661-9559-ca67-29386d2e992b@broadcom.com>
 <5740014.mZjAIri61F@wuerfel>
Message-ID: <CAOesGMgoWUG+=61OzxdCCX5oujHC4XOJ-MFGfEyRkrJGq_4fAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 1:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday, October 18, 2016 3:23:26 PM CEST Scott Branden wrote:
>> I have be.config and le.config that allow you to switch the defconfig
>> between big and little endian.  Does this make sense to upstream to
>> arm/configs if you have accepted dram_0x00000000.config?
>
> Yes, they clearly fall into the same category, let's merge those as well.
>
>> Would you also accept this to arm64/configs?  We actually use
>> big and little endian on the same SoC more on arm64 platforms.  But, in
>> order to boot big endian we need to maintain this outside the kernel
>> right now.
>
> I'm in favor of that, but let's see what the arm64 maintainers think.

Single-line fragments aren't really all that valuable, IMHO. Flipping
just one option is trivial to do without fragments, or when they're
not simple Y/N flips (i.e. like the ram base).

Fragments are mostly useful when you need to flip several options
together to enable some set of functionality.


-Olof
