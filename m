From: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 05 Sep 2014 13:43:44 -0700
Subject: Post-merge-window ping (Re: [PATCH v4 0/5] x86: two-phase syscall
 tracing and seccomp fastpath)
In-Reply-To: <540A1800.3000005@zytor.com>
References: <CALCETrUaZ8w92g96SmFEZDE0Jr+0Moeo+S24-TyW8crrK5reSg@mail.gmail.com>
 <540A1800.3000005@zytor.com>
Message-ID: <540A2080.8050404@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2014 01:07 PM, H. Peter Anvin wrote:
> On 08/26/2014 06:32 PM, Andy Lutomirski wrote:
>> On Mon, Jul 28, 2014 at 8:38 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> This applies to:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp-fastpath
>>>
>>> Gitweb:
>>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>>
>> Hi all-
>>
>> AFAIK the only thing that's changed since I submitted it is that the
>> 3.17 merge window is closed.  Kees rebased the tree this applies to,
>> but I think the patches all still apply.  What, if anything, do I need
>> to do to help this along for 3.18?
>>
> 
> Just put this stuff in a branch and running through my personal test
> battery now.
> 

... and they fail build testing.  Specifically, both i386 and x86-64
allnoconfig fail with:

arch/x86/kernel/ptrace.c: In function ?syscall_trace_enter_phase2?:
  LD      fs/quota/built-in.o
../arch/x86/kernel/ptrace.c:1579:2: error: implicit declaration of
function ?seccomp_phase2? [-Werror=implicit-function-declaration]
  if (phase1_result > 1 && seccomp_phase2(phase1_result)) {
  ^
cc1: some warnings being treated as errors
  CC      arch/x86/kernel/step.o
make[4]: *** [arch/x86/kernel/ptrace.o] Error 1

	-hpa
