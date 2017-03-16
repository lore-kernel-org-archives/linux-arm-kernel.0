From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Mar 2017 10:48:11 +0100
Subject: [PATCH v2] generic syscalls: Wire up statx syscall
In-Reply-To: <CAAG0J99QAwefvpnNxrGRU6XH+0+k1LO6qRW3kLBQCc3nc6QdmA@mail.gmail.com>
References: <20170313144521.28127-1-shorne@gmail.com>
 <CAAG0J99QAwefvpnNxrGRU6XH+0+k1LO6qRW3kLBQCc3nc6QdmA@mail.gmail.com>
Message-ID: <CAK8P3a3YPsa_FXvqAmt2rQqRPc+Rby6n_+5MoMR2EV85jQHyjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 11:26 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On 13 March 2017 at 14:45, Stafford Horne <shorne@gmail.com> wrote:

>>  #undef __NR_syscalls
>> -#define __NR_syscalls 291
>> +#define __NR_syscalls 292
>
> Out of interest, anybody know OTOH which other stat syscalls statx
> supersedes (such that they could at some point be disabled by default
> in asm-generic for new arches, and implemented in userspace)?

It should replace the entire stat family {old,new,}{f,}stat{at,}{64,}, but not
the {f,}statfs{64,} family, which will eventually get another replacement.

      Arnd
