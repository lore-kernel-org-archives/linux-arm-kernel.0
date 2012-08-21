From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Aug 2012 19:27:31 +0100
Subject: [PATCH v2 16/31] arm64: ELF definitions
In-Reply-To: <CAMuHMdVEX0egzFETMJ=LA_PB+7Qc=Ph-7uxofVr__wOE-0cvLQ@mail.gmail.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208151415.39570.arnd@arndb.de>
 <20120816102300.GG31784@mudshark.cambridge.arm.com>
 <201208161237.53594.arnd@arndb.de> <20120821160653.GH12708@arm.com>
 <CAMuHMdVEX0egzFETMJ=LA_PB+7Qc=Ph-7uxofVr__wOE-0cvLQ@mail.gmail.com>
Message-ID: <20120821182731.GJ12708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 07:17:19PM +0100, Geert Uytterhoeven wrote:
> On Tue, Aug 21, 2012 at 6:06 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > But I can see on x86 that it always reports x86_64 even if the task is
> > x86_32.
> 
> Really?
> 
> $ uname -m
> x86_64
> $ linux32 uname -m
> i686
> $

Well, you set the personality explicitly with linux32. What I tested was
with an x86_32 uname called directly (without linux32) and even though
the ELF was a 32-bit one, it was reporting x86_64. In this AArch64
patch, a compat task was automatically setting the linux32 personality
(which x86 does not do).

Arnd's point is that the ELF file should not affect the personality and
hence the uname value. This should only be done by an explicit call to
sys_personality().

-- 
Catalin
