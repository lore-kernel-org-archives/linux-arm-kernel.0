From: keescook@chromium.org (Kees Cook)
Date: Wed, 12 Feb 2014 13:35:54 -0800
Subject: [RFC/PATCH 0/3] Add devicetree scanning for randomness
In-Reply-To: <20140212174554.GM27395@titan.lakedaemon.net>
References: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org>
 <201402121251.06280.arnd@arndb.de>
 <20140212174554.GM27395@titan.lakedaemon.net>
Message-ID: <CAGXu5j+BQzrgoAN-TiCaaoQaEjB+JQOCZLKq+_rFoWdFR-UpqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 9:45 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> I brought this up at last weeks devicetree irc meeting.  My goal is to
> provide early randomness for kaslr on ARM.  Currently, my idea is modify
> the init script to save an additional random seed from /dev/urandom to
> /boot/random-seed.

I'm all for a good entropy source for early boot. :)

I need to figure out what's needed for relocation support first
though, before we can really tackle kernel base-address randomization
on ARM. I haven't had a chance to look around too closely yet, but it
seems like only x86 and ppc do this currently? Has anyone looked in
detail and what would be needed on ARM for CONFIG_RELOCATABLE
behavior?

-Kees

-- 
Kees Cook
Chrome OS Security
