From: bp@alien8.de (Borislav Petkov)
Date: Thu, 30 Jul 2015 09:43:16 +0200
Subject: [PATCH v2 2/3] edac: Add L3/SoC support to the APM X-Gene SoC
 EDAC driver
In-Reply-To: <CAPw-ZTnipyRLnRxNTvq6FJTHyt2EbhObJMOa542LYOGna3FgjA@mail.gmail.com>
References: <1437808063-17592-1-git-send-email-lho@apm.com>
 <1437808063-17592-2-git-send-email-lho@apm.com>
 <1437808063-17592-3-git-send-email-lho@apm.com>
 <20150729142941.GC17367@nazgul.tnic>
 <CAPw-ZTkZ7q8PUWydFad5TXrhcY6YBRjdVvz+SR+LV4sOLDKkEg@mail.gmail.com>
 <20150730043148.GC7209@nazgul.tnic>
 <CAPw-ZTnipyRLnRxNTvq6FJTHyt2EbhObJMOa542LYOGna3FgjA@mail.gmail.com>
Message-ID: <20150730074316.GB8984@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 10:31:49PM -0700, Loc Ho wrote:
> Let me clarify a bit. I have one top level driver node and multiple
> instance of subnodes -  4 MC, 4 L2/L1, 1 L3C, and 1 SoC EDAC for now.
> The L3C many be multiple instance in the future. Just a note,  the way
> EDAC looks up instance is by pointer of struct device. It doesn't need
> anything more than that.

That's not what I mean - I mean all those instances calling into the
EDAC core concurrently without any locking. From a quick scan, nothing
problematic sticks out but it needs careful auditing.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
