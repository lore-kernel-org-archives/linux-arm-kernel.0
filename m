From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Apr 2017 10:22:16 +0200
Subject: [PATCH] lib/mpi: fix build with clang
In-Reply-To: <20170420034022.24109-1-stefan@agner.ch>
References: <20170420034022.24109-1-stefan@agner.ch>
Message-ID: <CAK8P3a0cW-u-hzYX+qijMcEs=Ztar=WaDnsd4JcPvqiTR69TbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 5:40 AM, Stefan Agner <stefan@agner.ch> wrote:
> Use just @ to denote comments which works with gcc and clang.
> Otherwise clang reports an escape sequence error:
>   error: invalid % escape in inline assembly string
>
> Use %0-%3 as operand references, this avoids:
>   error: invalid operand in inline asm: 'umull ${1:r}, ${0:r}, ${2:r}, ${3:r}'
>
> Also remove superfluous casts on output operands to avoid warnings
> such as:
>   warning: invalid use of a cast in an inline asm context requiring an l-value
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> I checked the output of gcc with -S switch before and after this change,
> gcc generated the same assembly.

I've done a lot of build testing on a tree that contains a very similar patch.

Acked-by: Arnd Bergmann <arnd@arndb.de>
