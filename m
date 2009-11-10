From: papalagi.pakeha@gmail.com (Papalagi Pakeha)
Date: Wed, 11 Nov 2009 12:56:31 +1300
Subject: Runtime code modification fails on arm
In-Reply-To: <20091110191740.GA20317@n2100.arm.linux.org.uk>
References: <343d1bca0911100508w1b5b62d8n8242abd7eb97a0c@mail.gmail.com>
	<20091110191740.GA20317@n2100.arm.linux.org.uk>
Message-ID: <343d1bca0911101556x61fead12jb4113d1680228b8a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2009 at 8:17 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 11, 2009 at 02:08:27AM +1300, Papalagi Pakeha wrote:
>> Why is this happening? What is so different between x86 and ARM in
>> that field? I'm aware that my problem exhibits in userspace, not in
>> the kernel. I'm sorry if it's way off topic here.
>
> As others in this thread have pointed out, the
> kernel provides a call to deal with the I/D cache coherency problem
> which must be called _after_ _any_ modification of instructions
> whether they have been executed previously or not.

Thank you guys for the hint. However I can't find a ready to use
cacheflush() implemented in glibc (2.3.3) or dietlibc. Am I left on my
own implementing the userspace part of the syscall? I tried to figure
out how syscalls are implemented in dietlibc but there seems to be a
lot of preprocessor voodoo involved making it hard to understand...

Thanks!

PaPa
