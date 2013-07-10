From: bp@alien8.de (Borislav Petkov)
Date: Wed, 10 Jul 2013 22:01:39 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130710182815.GA362@x4>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130506095124.GA22041@pd.tnic>
 <CAMuHMdWH9w5fj6HRXi+9QcBJym4dukAFsPVGZVqSSk3yTZJUcA@mail.gmail.com>
 <20130710093642.GC14873@pd.tnic> <20130710182815.GA362@x4>
Message-ID: <20130710200139.GC9140@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 08:28:15PM +0200, Markus Trippelsdorf wrote:
> Well, there's also no hand-holding when lzop is missing for LZO. And
> the error message is clear enough. No?

Actually, we should error out more gracefully than that. Maybe check for
the presence of the executable first and if not, exit out of the build
with an informational message that lz4c is not present on the system.
Ditto for lzop.

Currently, you wait for the whole build to complete just to see that
there's no executable at the end. Not nice.

> BTW speaking of introductory-level patches, what about the following
> one:
> 
> Now that lz4 kernel compression is available, add *.lz4 to .gitignore

Yep. That makes sense.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
