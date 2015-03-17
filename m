From: appro@openssl.org (Andy Polyakov)
Date: Tue, 17 Mar 2015 16:09:40 +0100
Subject: [PATCH] arm: crypto: Add NEON optimized SHA-256
In-Reply-To: <CAKv+Gu8fmBYwfrMKRqhA5KhU1HNjMP1cLtpmgCmp78R4CUw3fg@mail.gmail.com>
References: <20150316154835.GA31336@google.com>	<CAKv+Gu8+oQ13j61X6x70baJXOpEiM2L+vK=KgK1JG12sy5KMsg@mail.gmail.com>	<20150316162304.GA35408@google.com>
 <CAKv+Gu8fmBYwfrMKRqhA5KhU1HNjMP1cLtpmgCmp78R4CUw3fg@mail.gmail.com>
Message-ID: <550843B4.8080903@openssl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>>> Have you tested this code with the tcrypt.ko module?
>>
>> I have not, but I can look into it.
>>
>>> Did you talk to Andy about the license? I don't think this is
>>> permissible for the kernel as-is.
>>
>> Unless I have misunderstood something, the license at the Cryptogams
>> website includes an option to license the code under the GNU GPL.
>>
>> However, I can certainly contact Andy to clarify his intentions.

I have no problems with reusing assembly modules in kernel context. The
whole idea behind cryptogams initiative was exactly to reuse code in
different contexts. But I'd prefer if it's more of cooperative effort,
when we help each other to improve code, test on and tune for more
platforms single developer might have access to, cross-report problems,
etc. For this reason I'd prefer if it can be arranged in way similar to
bsaes-armv7 module, i.e. we work together on shared copy of module that
generates assembly that can be then compiled for OpenSSL or kernel. Is
it sensible? BTW, why stop at SHA256? There is SHA512 and NEON SHA1...

As for practicalities. In order to spare brain capacity for list
subscribers, it would probably be appropriate to work out details such
as naming of entry points in smaller group and present result when it's
ready to go and tests. I'll start by looking at Thumb-ification...

Cheers.
