From: bp@alien8.de (Borislav Petkov)
Date: Fri, 17 Jun 2016 19:11:20 +0200
Subject: [PATCHv3 3/7] EDAC, altera: Share Arria10 check_deps & IRQ
 functions
In-Reply-To: <57642EE7.4060109@opensource.altera.com>
References: <1465852752-11018-1-git-send-email-tthayer@opensource.altera.com>
 <1465852752-11018-4-git-send-email-tthayer@opensource.altera.com>
 <20160617170050.GG3912@pd.tnic>
 <57642EE7.4060109@opensource.altera.com>
Message-ID: <20160617171120.GI3912@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 12:09:59PM -0500, Thor Thayer wrote:
> Since each peripheral's EDAC can be individually selected, the build
> generates a warning of an unused function if just L2 cache was selected.
> 
> The ifdeffery is ugly but it removes that warning in the L2 only case.

You could add __maybe_unused to the function definition but I guess you
don't want that code in there if only L2 is selected.

Ok.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
