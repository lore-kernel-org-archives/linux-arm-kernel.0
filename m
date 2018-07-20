From: bp@alien8.de (Borislav Petkov)
Date: Fri, 20 Jul 2018 06:10:05 +0200
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
In-Reply-To: <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
Message-ID: <20180720041005.GA25433@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 02:36:21PM -0400, Tyler Baicar wrote:
> With the current ghes_edac setup, it seems the only way this could
> work would be to have the firmware always report the module value to

My experience with firmware so far is that it is a lost cause,
considering all the bugs, snafus and incompleteness it demonstrates...

> The other obvious but more messy way would be to have notifiers
> register to be called by ghes_edac and have a custom EDAC driver for
> each CPU to properly populate their layer information.

... which is what we do on x86 and whitelist only known-good platforms
in ghes_edac, which claim that their fw info is correct.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
