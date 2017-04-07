From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 07 Apr 2017 10:21:27 +0100
Subject: [RFC kvm-unit-tests PATCH 4/8] Makefiles: use explicit path for
 including sub-Makefiles
In-Reply-To: <7f6fe583-a765-b8cd-d1f6-5068ee5d52e0@redhat.com>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
 <20170406190727.5624-5-alex.bennee@linaro.org>
 <7f6fe583-a765-b8cd-d1f6-5068ee5d52e0@redhat.com>
Message-ID: <87mvbsa7zc.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thomas Huth <thuth@redhat.com> writes:

> On 06.04.2017 21:07, Alex Benn?e wrote:
>> I would of thought VPATH took care of this but apparently not.
>>
>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>> ---
>>  Makefile               | 8 ++++----
>>  arm/Makefile           | 2 +-
>>  arm/Makefile.arm       | 2 +-
>>  arm/Makefile.arm64     | 2 +-
>>  powerpc/Makefile       | 2 +-
>>  powerpc/Makefile.ppc64 | 2 +-
>>  x86/Makefile           | 2 +-
>>  x86/Makefile.i386      | 2 +-
>>  x86/Makefile.x86_64    | 2 +-
>>  9 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 80bc57e..781186e 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -32,14 +32,14 @@ cflatobjs := \
>>  	lib/stack.o
>>
>>  # libfdt paths
>> -LIBFDT_objdir = lib/libfdt
>> -LIBFDT_srcdir = lib/libfdt
>> +LIBFDT_objdir = $(SRCDIR)/lib/libfdt
>
> I think this is wrong - objdir should not get a SRCDIR prefix.

Good catch - which explains why I was seeing libfdt.a in the source tree.

--
Alex Benn?e
