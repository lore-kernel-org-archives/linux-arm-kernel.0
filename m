From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Jun 2017 16:28:56 +0200
Subject: [PATCH 13/20] arm64: ilp32: share aarch32 syscall handlers
In-Reply-To: <20170608141053.66i57zhvunrj6sei@localhost>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-14-ynorov@caviumnetworks.com>
 <20170608141053.66i57zhvunrj6sei@localhost>
Message-ID: <CAK8P3a1L0YAUnMdFw5WOLNPr8eQkD4umbWN+pr50ESLon9rdZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 8, 2017 at 4:10 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Sun, Jun 04, 2017 at 03:00:02PM +0300, Yury Norov wrote:
>> off_t is  passed in register pair just like in aarch32.
>> In this patch corresponding aarch32 handlers are shared to
>> ilp32 code.
>
> Is the comment here relevant? IOW, do we have any AArch64/ILP32 syscall
> where off_t is used as an argument? AFAICT, the *64 syscalls use loff_t
> or loff_t *.

I think it should just be reworded, the 'off_t' above seems to refer to the
user space type that corresponds to the kernel's loff_t.

       Arnd
