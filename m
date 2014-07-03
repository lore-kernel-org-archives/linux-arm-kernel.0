From: dborkman@redhat.com (Daniel Borkmann)
Date: Thu, 03 Jul 2014 11:23:14 +0200
Subject: [PATCH RFC] arm64: eBPF JIT compiler
In-Reply-To: <20140703091450.GB12958@arm.com>
References: <1404278424-31176-1-git-send-email-zlim.lnx@gmail.com>
 <20140703091450.GB12958@arm.com>
Message-ID: <53B52102.7060400@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2014 11:14 AM, Will Deacon wrote:
> On Wed, Jul 02, 2014 at 06:20:24AM +0100, Zi Shen Lim wrote:
>> The JIT compiler emits A64 instructions. It supports eBPF only.
>> Legacy BPF is supported thanks to conversion by BPF core.
>>
>> JIT is enabled in the same way as for other architectures:
>>
>>          echo 1 > /proc/sys/net/core/bpf_jit_enable
>>
>> Or for additional compiler output:
>>
>>          echo 2 > /proc/sys/net/core/bpf_jit_enable
>>
>> See Documentation/networking/filter.txt for more information.
>>
>> The implementation passes all 57 tests in lib/test_bpf.c
>> on ARMv8 Foundation Model :)
>
> First off, this is really cool. Thanks for putting in the effort to get this
> supported on arm64! I'm happy to run tests on some real hardware if you tell
> me how to run them :)

We have lib/test_bpf.c for this, see also Documentation/networking/filter.txt.

So, the procedure would be, e.g.:

  1) echo 1 > /proc/sys/net/core/bpf_jit_enable
  2) modprobe/insmod test_bpf
  3) See kernel log for passes/fails

For seccomp/BPF, there's a test suite in:

  https://github.com/redpig/seccomp
