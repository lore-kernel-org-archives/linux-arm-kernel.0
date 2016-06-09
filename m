From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 9 Jun 2016 09:09:34 +0100
Subject: [RFC PATCH 00/15] Exynos big-endian fixes
In-Reply-To: <20160608183110.13851-1-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
Message-ID: <2bd53bbc-b8de-e616-b4ee-412330910a34@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/16 19:30, Matthew Leach wrote:
> Hi all,
> 
> I've been working with Ben Dooks to get a big-endian kernel working on
> my Exynos 4412 board.  Primarily this series consists of:
> 
>   - Replacing the __raw_{read,write}l accessors, which aren't
>     endian-clean, with their respective {read,write}l_relaxed versions
>     across various drivers.
> 
>   - Adding endian-aware {set,clear}_bit functions to the Exynos serial
>     driver as the __{set,clear}_bit() functions aren't endian-clean.
> 
>   - Make the low-level Exynos debug printing macros endian-clean.
> 
> There may well be other things that are broken under BE that we've not
> tested but this series should be enough to allow a board to boot
> user-space to a login prompt.

The only nit is the use of "be", it would be nicer to either use
BE8 consistently, or go for "big endian".

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
