From: joe@perches.com (Joe Perches)
Date: Tue, 18 Mar 2014 06:07:31 -0700
Subject: [PATCH 00/12] scsi/NCR5380: fix debugging macros and #include
 structure
In-Reply-To: <CAMuHMdUMpdp7deL5zC4hUVTHjyNbtkZ2bNFupo5JiDyuyc345w@mail.gmail.com>
References: <20140318002822.372705594@telegraphics.com.au>
 <1395112756.20860.1.camel@joe-AO722>
 <alpine.LNX.2.00.1403182208590.2018@nippy.intranet>
 <1395146702.2812.47.camel@joe-AO722>
 <CAMuHMdUMpdp7deL5zC4hUVTHjyNbtkZ2bNFupo5JiDyuyc345w@mail.gmail.com>
Message-ID: <1395148051.2812.51.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-18 at 13:55 +0100, Geert Uytterhoeven wrote:
> On Tue, Mar 18, 2014 at 1:45 PM, Joe Perches <joe@perches.com> wrote:

Hi Geert.

> > #define dprintk(flg, fmt, ...) \
> > do { if (0) pr_debug(fmt, ##__VA_ARGS__); } while (0)
> 
> Na, no_printk():
> 
> #define dprintk(flg, fmt, ...) no_printk(fmt, ##__VA_ARGS__)

Fine, but with a correction.

no_printk keeps all side effects like
performing any function calls made by the
statement or accessing any volatiles.

Using

do { if (0) no_printk(fmt, ##__VA_ARGS__); } while (0)

does not have any side-effects.
