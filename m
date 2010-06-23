From: david-b@pacbell.net (David Brownell)
Date: Wed, 23 Jun 2010 06:39:09 -0700 (PDT)
Subject: gpiolib and sleeping gpios
In-Reply-To: <alpine.DEB.2.00.1006231601310.7850@wnav-qrfxgbc>
Message-ID: <294115.59939.qm@web180308.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Wed, 6/23/10, Jani Nikula <ext-jani.1.nikula@nokia.com> wrote:

> -??? WARN_ON(extra_checks &&
> chip->can_sleep);
> +??? might_sleep_if(chip->can_sleep);

 That looks like the right track.  For
those cases the "extra_checks" should
not be optional ... thanks.

- Dave
