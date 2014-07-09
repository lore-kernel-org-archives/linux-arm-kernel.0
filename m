From: dave.hansen@intel.com (Dave Hansen)
Date: Wed, 09 Jul 2014 16:33:09 -0700
Subject: [RFC/PATCH RESEND -next 00/21] Address sanitizer for kernel
 (kasan) - dynamic memory error detector.
In-Reply-To: <CAOMGZ=Fmqg6MWyx3NygqVmYiqw=npkPQrO9ifhF489bq5Gxz4A@mail.gmail.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>	<53BDB1D6.1090605@intel.com>	<8761j6nr53.fsf@tassilo.jf.intel.com>
 <CAOMGZ=Fmqg6MWyx3NygqVmYiqw=npkPQrO9ifhF489bq5Gxz4A@mail.gmail.com>
Message-ID: <53BDD135.1000105@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2014 02:59 PM, Vegard Nossum wrote:
>> > But I could see KASAN eventually deprecating kmemcheck, which
>> > is just incredible slow.
> FWIW, I definitely agree with this -- if KASAN can do everything that
> kmemcheck can, it is no doubt the right way forward.

That's very cool.  For what it's worth, the per-arch work does appear to
be pretty minimal and the things like the string function replacements
_should_ be able to be made generic.  Aren't the x86_32/x86_64 and arm
hooks pretty much copied-and-pasted?
