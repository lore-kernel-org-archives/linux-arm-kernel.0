From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Tue, 26 May 2015 17:22:11 +0300
Subject: [PATCH v2 5/5] arm64: add KASan support
In-Reply-To: <55647F57.8010008@samsung.com>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
 <1431698344-28054-6-git-send-email-a.ryabinin@samsung.com>
 <CACRpkda3Pe9L14_iyKEfeCx1F3XJSLbz_OVHLxX0Lzy9Gt9t9Q@mail.gmail.com>
 <55647F57.8010008@samsung.com>
Message-ID: <55648193.3030003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2015 05:12 PM, Andrey Ryabinin wrote:
> On 05/26/2015 04:35 PM, Linus Walleij wrote:
>> I wonder were the problem lies, any hints where to start looking
>> to fix this?
>>
> 
> I suspect that your compiler lack -fsantize=kernel-address support.
> It seems that GCC 4.9.2 doesn't supports -fsanitize=address/kernel-address on aarch64.
> 

In that case you should get something like this, during kernel build:
	scripts/Makefile.kasan:17: Cannot use CONFIG_KASAN: -fsanitize=kernel-address is not supported by compiler


Also you may check you gcc by compiling simple program:
$ cat test.c
void main(void) {
}

$ gcc -fsanitize=kernel-address test.c
