From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Aug 2016 09:40:50 +0200
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l,
 ldr_l and str_l macros
In-Reply-To: <20160803180934.GK1041@n2100.armlinux.org.uk>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160803180934.GK1041@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu9Wyiu38J=K00WKXSeFoDF2vS-3TJAvbz9Yo616GBXSwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 August 2016 at 20:09, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Aug 03, 2016 at 05:38:43PM +0200, Ard Biesheuvel wrote:
>> +     add     \dst, pc, #:pc_g0_nc:(\sym) - 8
>> +     add     \dst, \dst, #:pc_g1_nc:(\sym) - 4
>> +     add     \dst, \dst, #:pc_g2:(\sym)
>
> What's this :pc_g0_nc: stuff?  What binutils versions is it supported
> in?  It doesn't appear documented in gas 2.23.91, so I don't think we
> can use it.
>

binutils 2.18 and up
