From: david-b@pacbell.net (David Brownell)
Date: Tue, 7 Sep 2010 16:44:55 -0700 (PDT)
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <20100907222230.4a3594be@lxorguk.ukuu.org.uk>
Message-ID: <616992.75276.qm@web180302.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Tue, 9/7/10, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > 
> > ?????device->output_pin = -EINVAL;
> 
> gpio numbers are unsigned in the rest of the API

Minor goof; should have been "int" everywhere,
as implied by the references to negative numbers
in the docs... negatives not used internally, but
preserved for external use (as above).


> 
> It's unfortunate that 0 was used for a GPIO

Intentional:  board schematics and chip docs can
easily match up to Linux this way.  What would be
unfortunate is needing to map hardware docs into
software ones all the time -- error prone.

When the API is used correctly, it's not an issue.
