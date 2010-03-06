From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 6 Mar 2010 11:41:31 +0100
Subject: weirdness with compiling a 2.6.33 kernel on arm debian
In-Reply-To: <25ae2d691003060224x67ab1c9au5102c8a22518aff@mail.gmail.com>
References: <25ae2d691003051958x72040b47g29d842f1d389a6cf@mail.gmail.com>
	<19346.6765.457769.167118@pilspetsen.it.uu.se>
	<25ae2d691003060224x67ab1c9au5102c8a22518aff@mail.gmail.com>
Message-ID: <20100306104131.GV28972@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 06, 2010 at 09:24:49PM +1100, dave b wrote:
> On 6 March 2010 20:03, Mikael Pettersson <mikpe@it.uu.se> wrote:
> > dave b writes:
> > ?> Hi have now successfully built a 2.6.33 kernel on a linkstation pro
> > ?> v2. This is an arm device. It is currently running debian?? lenny
> > ?> armel.
> > ?>
> > ?>
> > ?> I compiled?? (make) zImage, then did a make modules which failed on the
> > ?> first two rounds of compiling the modules -
> > ?>
> > ?> "fs/afs/super.c: In function ???afs_test_super???:
> > ?> fs/afs/super.c:278: internal compiler error: Segmentation fault
> > ?> Please submit a full bug report,
> > ?> with preprocessed source if appropriate.
> > ?> See <file:///usr/share/doc/gcc-4.3/README.Bugs> for instructions."
> > ?> This was the error encountered on the attempt at compiling the
> > ?> modules.
> > ?>
> > ?> "crypto/gcm.c: In function ???crypto_gcm_setauthsize???:
> > ?> crypto/gcm.c:152: internal compiler error: Segmentation fault
> > ?> Please submit a full bug report,
> > ?> with preprocessed source if appropriate.
> > ?> See <file:///usr/share/doc/gcc-4.3/README.Bugs> for instructions.
> > ?> make[1]: *** [crypto/gcm.o] Error 1"
> > ?> This was the error the on the second attempt at compiling the modules.
> > ?>
> > ?> The 3rd attempt at building the modules was successful...

Whenever I had comparable problems, it was _always_ faulty RAM on my
local machine, and I'm very sure you're seeing a similar. _If_ gcc
crashes, it will always do that for the same input.

Daniel
