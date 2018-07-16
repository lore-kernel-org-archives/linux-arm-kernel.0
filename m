From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 16 Jul 2018 10:41:45 +0200
Subject: [PATCH 1/3] soc: amlogic: Add Meson GX Clock Measure driver
In-Reply-To: <CAFBinCDCbOrX8BaJcDpeiR=r6eSxj=OQ1voj-Lug=P7hyvu=hA@mail.gmail.com>
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
 <1530624110-4687-2-git-send-email-narmstrong@baylibre.com>
 <CAFBinCDBEbVSEzhM2WOhxNX1DZLiSrkeo7GWdxGzBpOUH3PKQw@mail.gmail.com>
 <7d83a0a4-5cde-7e4f-78a8-372ae8cb03d0@baylibre.com>
 <CAFBinCA5B87TkfOtQd==PxDK74kJ+XWMgY-36QK2TT9p-vAEUA@mail.gmail.com>
 <7hy3eknl3l.fsf@baylibre.com>
 <fb73556d-cf18-266c-e638-9dd92224b939@baylibre.com>
 <CAFBinCDCbOrX8BaJcDpeiR=r6eSxj=OQ1voj-Lug=P7hyvu=hA@mail.gmail.com>
Message-ID: <1531730505.12853.16.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-07-14 at 16:41 +0200, Martin Blumenstingl wrote:
> > > 
> > > Even futther, Couldn't this measure IP be used by the current CCF code
> > > (as an additonal, optional property) such the the debugfs clk_summary
> > > uses it directly?
> > 
> > It will need hacking the CCF core, but as Jerome and I said, this can be done later on !
> > We can push a debugfs version and migrate it to CCF when we figure out how to integrate it
> > correctly.
> 
> Jerome already raised concerns (on IRC) that measuring the clock takes
> too much time and using a CCF clock provider would mean that "cat
> /sys/kernel/debug/clk/clk_summary" would be slow
> if that's the case then I'm happy with a debugfs solution which can be
> migrated wo whatever framework suits best in the future

Actually I'm not concerned by clk_summary much, it is debug. Slow is not
desirable but not critical either. I'm more concerned by tree recalc while
changing the tree topology and rate change if clock measure implement
get_rate(). It is worth trying ... just keep an eye ton this.
