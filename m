From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 30 May 2010 05:51:51 +0100
Subject: [PATCH v2 1/5] ARM: SAMSUNG: Add keypad device support
In-Reply-To: <AANLkTilt_-UAZGZepwtIYM7HRuPsX7gsW_ppLZD1_bZq@mail.gmail.com>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
	<201005300542.37715.marek.vasut@gmail.com>
	<AANLkTilt_-UAZGZepwtIYM7HRuPsX7gsW_ppLZD1_bZq@mail.gmail.com>
Message-ID: <20100530045151.GE4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 30, 2010 at 01:46:03PM +0900, Jassi Brar wrote:
> On Sun, May 30, 2010 at 12:42 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Dne Ne 30. kv??tna 2010 05:06:20 Joonyoung Shim napsal(a):
> >> +struct samsung_kp_platdata {
> >> + ? ? const struct matrix_keymap_data *keymap_data;
> >> + ? ? unsigned int ? ? ? ? ? ?rows;
> >> + ? ? unsigned int ? ? ? ? ? ?cols;
> >> + ? ? unsigned int ? ? ? ? ? ?rep;
> >
> > I don't know, maybe using uint32_t here? On ARM, it doesn't matter so far as int
> > will be always 32bit, but maybe we should just type the variables well ?
> 
> I thought int was 32bits on all archs

No, the C standard doesn't make any guarantees about the size of types,
it is up to the implementation of the compiler. If I rember correctly
the only guarantee in the lanugage definition is that char->short->int->long
be that the next up the line be at-least as a  big as the one before.

For this, unsigned int should be fine. unsigned short would probably be
fine too. I'm not going to worry too much about this.
 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
