From: olof@lixom.net (Olof Johansson)
Date: Wed, 23 Jul 2014 16:27:30 -0700
Subject: next build: 629 warnings 1 failures (next/next-20140723)
In-Reply-To: <53cf8323.e4b6440a.7d37.4f75@mx.google.com>
References: <53cf8323.e4b6440a.7d37.4f75@mx.google.com>
Message-ID: <CAOesGMhT9n7nVbCay5cU74pv2qrbqMooZLoY923Lk6SzXk5z+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin, Will,

On Wed, Jul 23, 2014 at 2:40 AM, Olof's autobuilder <build@lixom.net> wrote:

>         arm64.defconfig:
> arch/arm64/kernel/head.S:298: Error: unknown or missing system register name at operand 2 -- `mrs x0,S3_4_C12_C9_5'
> arch/arm64/kernel/head.S:301: Error: unknown or missing system register name at operand 1 -- `msr S3_4_C12_C9_5,x0'
> arch/arm64/kernel/head.S:303: Error: unknown or missing system register name at operand 1 -- `msr S3_4_C12_C11_0,xzr'
> arch/arm64/kernel/ptrace.c:1119:3: error: too many arguments to function 'audit_syscall_entry'
> /tmp/ccq7ZztI.s:21: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C12_1,x0'
> /tmp/ccq7ZztI.s:162: Error: unknown or missing system register name at operand 2 -- `mrs x19,S3_0_C12_C12_0'
> /tmp/ccq7ZztI.s:186: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C12_1,x19'
> /tmp/ccq7ZztI.s:220: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C12_1,x19'
> /tmp/ccq7ZztI.s:1110: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C11_5,x27'
> /tmp/ccq7ZztI.s:1530: Error: unknown or missing system register name at operand 2 -- `mrs x0,S3_0_C12_C12_5'
> /tmp/ccq7ZztI.s:1540: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C12_5,x0'
> /tmp/ccq7ZztI.s:1548: Error: unknown or missing system register name at operand 2 -- `mrs x0,S3_0_C12_C12_5'
> /tmp/ccq7ZztI.s:1564: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C4_C6_0,x0'
> /tmp/ccq7ZztI.s:1576: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C12_4,x0'
> /tmp/ccq7ZztI.s:1592: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C12_7,x0'


I'm building with a vanilla gcc 4.8.2 / binutils 2.23.2. That
shouldn't be broken like this, so those changes should be fixed (or
minimal toolchain expecations need to be documented -- but there
really is no good reason to require 4.9.0/2.24).


-Olof
