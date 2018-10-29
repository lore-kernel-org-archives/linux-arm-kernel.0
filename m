From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 29 Oct 2018 22:16:02 +0900
Subject: [PATCH v3 4/4] kernel hacking: new config
 CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
In-Reply-To: <20181028130945.23581-5-changbin.du@gmail.com>
References: <20181028130945.23581-1-changbin.du@gmail.com>
 <20181028130945.23581-5-changbin.du@gmail.com>
Message-ID: <CAK7LNAS8UPXBbOpG9Zy_aP7an2jbq5H7uQGymUAn+hv46WQ4Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2018 at 10:11 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> This will apply GCC '-Og' optimization level which is supported
> since GCC 4.8. This optimization level offers a reasonable level
> of optimization while maintaining fast compilation and a good
> debugging experience. It is similar to '-O1' while perferring
> to keep debug ability over runtime speed.
>
> If enabling this option breaks your kernel, you should either
> disable this or find a fix (mostly in the arch code). Currently
> this option has only been tested on x86_64 and arm platform.
>
> This option can satisfy people who was searching for a method
> to disable compiler optimizations so to achieve better kernel
> debugging experience with kgdb or qemu.
>
> The main problem of '-Og' is we must not use __attribute__((error(msg))).
> The compiler will report error though the call to error function
> still can be optimize out. So we must fallback to array tricky.


I removed the sentence "So we must fallback to array tricky."

Commit 81b45683487a51b0f4d3b29d37f20d6d078544e4
killed the fallback to the negative array trick.


I also resolved a conflict.

Your series is now available in the following branch.

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild kbuild


Please double check if I did it correctly.


--
Best Regards
Masahiro Yamada
