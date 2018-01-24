From: noloader@gmail.com (Jeffrey Walton)
Date: Wed, 24 Jan 2018 11:38:42 -0500
Subject: [PATCH RFC 0/3] API for 128-bit IO access
In-Reply-To: <20180124090519.6680-1-ynorov@caviumnetworks.com>
References: <20180124090519.6680-1-ynorov@caviumnetworks.com>
Message-ID: <CAH8yC8nvD-CWt9eZ_CumwtVB0xAKKD1uosftAKGvxrhJhcneNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 4:05 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
>
> ...
> With all that, this example code:
>
> static int __init 128bit_test(void)
> {
>         __uint128_t v;
>         __uint128_t addr;
>         __uint128_t val = (__uint128_t) 0x1234567890abc;
> ...

In case it matters, you can check for GCC support of the 128-bit types
in userland with:

#if (__SIZEOF_INT128__ >= 16)
   ...
#endif

Also see https://gcc.gnu.org/ml/gcc-help/2015-08/msg00185.html .

Jeff
