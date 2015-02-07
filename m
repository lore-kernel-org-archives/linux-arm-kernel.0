From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Sat, 07 Feb 2015 16:22:47 +0900
Subject: arm: kprobe compilation error
In-Reply-To: <54D38982.6000100@elproma.com.pl>
References: <54D38982.6000100@elproma.com.pl>
Message-ID: <54D5BD47.4040107@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2015/02/06 0:17), Janusz U?ycki wrote:
> Hi,
> 
> I got the compilation error on next-20150204:
> 
>    CC      arch/arm/probes/kprobes/actions-arm.o
> In file included from arch/arm/probes/kprobes/actions-common.c:18:
> arch/arm/probes/kprobes/core.h:43: error: '[*]' not allowed in other 
> than a declaration
> make[2]: *** [arch/arm/probes/kprobes/actions-common.o] B??d 1
> make[2]: *** Oczekiwanie na niezako?czone zadania....
> In file included from arch/arm/probes/kprobes/actions-arm.c:66:
> arch/arm/probes/kprobes/core.h:43: error: '[*]' not allowed in other 
> than a declaration
> make[2]: *** [arch/arm/probes/kprobes/actions-arm.o] B??d 1
> In file included from arch/arm/probes/kprobes/core.c:37:
> arch/arm/probes/kprobes/core.h:43: error: '[*]' not allowed in other 
> than a declaration
> make[2]: *** [arch/arm/probes/kprobes/core.o] B??d 1
> make[1]: *** [arch/arm/probes/kprobes] B??d 2
> make: *** [arch/arm/probes] B??d 2
> 
> reason is *[*]:
> const struct decode_checker *[*]);

Thank you for reporting!

I think there is a typo, it should be "const struct decode_checker *[]".


Thank you,


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
