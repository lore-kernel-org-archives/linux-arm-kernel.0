From: pmladek@suse.com (Petr Mladek)
Date: Fri, 1 Jun 2018 13:47:38 +0200
Subject: [PATCH 0/4] lib/vsprintf: Remove atomic-unsafe support for
 printk format %pCr
In-Reply-To: <CA+55aFxHHSRnDbbNGq6SwNAwEt0EhX15n_pNqon3MzGYJgMJmA@mail.gmail.com>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
 <CA+55aFxHHSRnDbbNGq6SwNAwEt0EhX15n_pNqon3MzGYJgMJmA@mail.gmail.com>
Message-ID: <20180601114738.kdoggkha2yosjgbv@pathway.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2018-06-01 06:00:47, Linus Torvalds wrote:
> On Fri, Jun 1, 2018 at 4:29 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >
> > This patch series:
> >   - Changes all existing users of "%pCr" to print the result of
> >     clk_get_rate() directly, which is safe as they all do this in task
> >     context only,
> >   - Removes support for the "%pCr" printk format.
> 
> Looks good to me.
> 
> What tree will this go through? The normal printk one? Just checking
> that this doesn't end up falling through the cracks because nobody
> knows who would take it...

I will take it via printk.git. There already is bunch of vsprintf
changes for-4.18.

Best Regards,
Petr
