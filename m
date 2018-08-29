From: bp@alien8.de (Borislav Petkov)
Date: Wed, 29 Aug 2018 09:38:04 +0200
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
In-Reply-To: <0a94db2a-2569-ac46-1a79-a05f46a4ea6f@arm.com>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
 <20180824120102.GB29751@nazgul.tnic>
 <0a94db2a-2569-ac46-1a79-a05f46a4ea6f@arm.com>
Message-ID: <20180829073804.GA6843@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 06:09:24PM +0100, James Morse wrote:
> Does x86 have another source of memory-topology information it needs to
> correlate smbios with?

Bah, pinpointing the DIMM on x86 is a mess. There's no reliable way to
say which DIMM it is in certain cases (interleaving, mirrorring, ...)
and it is all platform-dependent. So we do the layers to dump a memory
location (node, memory controller, ....) so that we can at least limit
the number of DIMMs the user needs to replace/try.

In an ideal world, I'd like to be able to query the SPD chips on the
DIMMs and build the topology and then when an error happens to say,
"error in DIMM <silkscreen>" where silkscreen is what is written on the
motherboard under the DIMM socket.

But I don't see that happening any time soon...

> For arm there is nothing else describing the memory-topology, so as long as we
> can correlate the smbios table and ghes:cper records through the handles, we can
> get this working for all systems.

And then make sure vendors fill in the proper info in smbios. Because that's
also a mess on x86.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
