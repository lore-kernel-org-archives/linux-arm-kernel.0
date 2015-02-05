From: j.uzycki@elproma.com.pl (=?UTF-8?B?SmFudXN6IFXFvHlja2k=?=)
Date: Thu, 05 Feb 2015 16:17:22 +0100
Subject: arm: kprobe compilation error
Message-ID: <54D38982.6000100@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I got the compilation error on next-20150204:

   CC      arch/arm/probes/kprobes/actions-arm.o
In file included from arch/arm/probes/kprobes/actions-common.c:18:
arch/arm/probes/kprobes/core.h:43: error: '[*]' not allowed in other 
than a declaration
make[2]: *** [arch/arm/probes/kprobes/actions-common.o] B??d 1
make[2]: *** Oczekiwanie na niezako?czone zadania....
In file included from arch/arm/probes/kprobes/actions-arm.c:66:
arch/arm/probes/kprobes/core.h:43: error: '[*]' not allowed in other 
than a declaration
make[2]: *** [arch/arm/probes/kprobes/actions-arm.o] B??d 1
In file included from arch/arm/probes/kprobes/core.c:37:
arch/arm/probes/kprobes/core.h:43: error: '[*]' not allowed in other 
than a declaration
make[2]: *** [arch/arm/probes/kprobes/core.o] B??d 1
make[1]: *** [arch/arm/probes/kprobes] B??d 2
make: *** [arch/arm/probes] B??d 2

reason is *[*]:
const struct decode_checker *[*]);
                                                      ^

target: mxs (arm926)
gcc version 4.2.4


best regards
Janusz
