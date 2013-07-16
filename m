From: bp@alien8.de (Borislav Petkov)
Date: Tue, 16 Jul 2013 11:22:42 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <201307161112.17901.yann.morin.1998@free.fr>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <20130716012756.31936d8d.akpm@linux-foundation.org>
 <20130716090546.GB4402@pd.tnic>
 <201307161112.17901.yann.morin.1998@free.fr>
Message-ID: <20130716092242.GD4402@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 11:12:17AM +0200, Yann E. MORIN wrote:
> The goal is to avoid generating a non-buildable kernel in the first place.

I know, that's why I'm proposing to fail the build with the script run
as one of the first things by make.

> > I.e., those steps:
> > 1. make <whatever>config
> > 2. make => A prereq. target runs the shell script.
> 
> This is too late, since this will bail out, and will give a false-positive
> failure.

Huh? This will tell you: "you've selected X, but I don't have toolX
needed for the build".

You install the tool and run make again. Checks pass, the build
continues.

> While if we were to check for _known_ needed tools before calling into
> Kconfig,

How would you do that? How do you know what the user is going to select
*before* she even selects it?

You need to have a prepared .config to act upon.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
