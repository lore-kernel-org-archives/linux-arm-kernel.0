From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 18 Feb 2014 12:56:24 -0500
Subject: [RFC/PATCH 0/3] Add devicetree scanning for randomness
In-Reply-To: <CAMuHMdW7S=o4oHVsNtYo0i_giB5cgWhygo-GgSaA1Kur6m3vng@mail.gmail.com>
References: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org>
 <201402121251.06280.arnd@arndb.de>
 <20140217155419.682F7C401D4@trevor.secretlab.ca>
 <1418981.0py7JxXCp8@wuerfel>
 <20140217182312.GV7862@titan.lakedaemon.net>
 <CAMuHMdW7S=o4oHVsNtYo0i_giB5cgWhygo-GgSaA1Kur6m3vng@mail.gmail.com>
Message-ID: <20140218175624.GY7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 10:07:50PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 17, 2014 at 7:23 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> >> Could we use a faster hash function that scans the entire device tree and
> >> then just feed the output of that into add_device_randomness? We probably
> >> can't expect that there is a lot of entropy in the DT blob, so the
> >> result wouldn't be all that different in terms of quality of the random
> >> seed.
> >
> > I think it would be easier to identify the few attributes that differ
> > from board to board (mac address, serial number, etc), and differ from
> > boot to boot (random-seed, timestamp) and just extract and feed those
> > in.
> 
> Isn't identifying those (mostly) a manual process?
> Calculating a fast hash is fully automatic.

The list would be pretty short, and once created wouldn't likely change
too often.  But it really depends on the 'fast hash'.  if the two
methods have comparable speed, I'd definitely prefer the hash.  Easier
to maintain.

thx,

Jason.
