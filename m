From: samitolvanen@google.com (Sami Tolvanen)
Date: Tue, 17 Mar 2015 15:21:20 +0000
Subject: [PATCH] arm: crypto: Add NEON optimized SHA-256
In-Reply-To: <550843B4.8080903@openssl.org>
References: <20150316154835.GA31336@google.com>
 <CAKv+Gu8+oQ13j61X6x70baJXOpEiM2L+vK=KgK1JG12sy5KMsg@mail.gmail.com>
 <20150316162304.GA35408@google.com>
 <CAKv+Gu8fmBYwfrMKRqhA5KhU1HNjMP1cLtpmgCmp78R4CUw3fg@mail.gmail.com>
 <550843B4.8080903@openssl.org>
Message-ID: <20150317152120.GA31053@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 04:09:40PM +0100, Andy Polyakov wrote:
> I have no problems with reusing assembly modules in kernel context.

Awesome, thank you for clarifying this.

> I'd prefer if it can be arranged in way similar to bsaes-armv7 module,
> i.e. we work together on shared copy of module that generates assembly
> that can be then compiled for OpenSSL or kernel. Is it sensible?

Sure, that sounds good to me.

> BTW, why stop at SHA256? There is SHA512 and NEON SHA1...

The kernel already has NEON SHA-1 and SHA-512, but for some reason is
lacking SHA-256. I have not tested how they compare to yours though.

Sami
