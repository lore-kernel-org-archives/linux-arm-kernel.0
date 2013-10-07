From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 7 Oct 2013 18:03:01 -0400 (EDT)
Subject: [RFC PATCH 1/5] ARM64: allow limited use of some NEON registers
 in exceptions
In-Reply-To: <1381147951-7609-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1381147951-7609-1-git-send-email-ard.biesheuvel@linaro.org>
 <1381147951-7609-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.03.1310071759190.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Oct 2013, Ard Biesheuvel wrote:

> Stack/unstack the bottom 4 NEON registers on exception entry/exit
> so we can use them in places where we are not allowed to sleep.

If you want to use Neon in places where you're not allowed to sleep, 
this also means you are not going to be scheduled away unexpectedly.  
Why not simply save/restore those Neon regs locally instead?  Same goes 
for interrupt context.


Nicolas
