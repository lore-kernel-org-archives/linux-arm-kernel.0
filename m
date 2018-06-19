From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 19 Jun 2018 13:32:23 -0700
Subject: [PATCH 0/2] Make badr macro compatible with newer GAS versions
In-Reply-To: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
Message-ID: <20180619203223.GA28370@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 09:26:31PM +0200, Ard Biesheuvel wrote:
> Work around the mindless and backward incompatible change in GAS that
> prevents us from using a simple addition to set the Thumb bit in local
> symbol references taken using 'adr' instructions (#2)
> 
> As a preparatory step, remove badr occurrences in ARM code sequences
> contained in Thumb2 kernels.
> 
> Ard Biesheuvel (2):
>   ARM: avoid badr macro for switching to Thumb-2 mode
>   ARM: assembler: prevent ADR from setting the Thumb bit twice
> 

This doesn't work for images built with a toolchain based on gcc 7.3.0
and binutils 2.28.1. It _does_ work for images built with gcc 7.3.0/
binutils 2.30.

Guenter
