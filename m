From: bp@alien8.de (Borislav Petkov)
Date: Mon, 19 Feb 2018 22:05:23 +0100
Subject: [PATCH 00/11] APEI in_nmi() rework and arm64 SDEI wire-up
In-Reply-To: <20180215185606.26736-1-james.morse@arm.com>
References: <20180215185606.26736-1-james.morse@arm.com>
Message-ID: <20180219210523.GA17922@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 06:55:55PM +0000, James Morse wrote:
> Hello!
> 
> The aim of this series is to wire arm64's SDEI into APEI.
> 
> What's SDEI? Its ARM's "Software Delegated Exception Interface" [0]. It's
> used by firmware to tell the OS about firmware-first RAS events.
> 
> These Software exceptions can interrupt anything, so I describe them as
> NMI-like. They aren't the only NMI-like way to notify the OS about
> firmware-first RAS events, the ACPI spec also defines 'NOTFIY_SEA' and
> 'NOTIFY_SEI'.
> 
> (Acronyms: SEA, Synchronous External Abort. The CPU requested some memory,
> but the owner of that memory said no. These are always synchronous with the
> instruction that caused them. SEI, System-Error Interrupt, commonly called
> SError. This is an asynchronous external abort, the memory-owner didn't say no
> at the right point. Collectively these things are called external-aborts
> How is firmware involved? It traps these and re-injects them into the kernel
> once its written the CPER records).

Thank you about those! This is how people should write 0/N introductory
messages with fancy new abbreviations.

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
