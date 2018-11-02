From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Fri, 2 Nov 2018 11:18:25 +0200
Subject: [PATCH v2 3/8] clk: clk-s3c2410-dclk: clean up clkdev lookup leak
In-Reply-To: <CAJKOXPeM18c3a2nWeGGGw+Fn-GQ2C0ridwE3eqRsd1gVQ6zB5w@mail.gmail.com>
References: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
 <8e396e22b328f35538a01193797fbd0d001f885d.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
 <CAJKOXPeM18c3a2nWeGGGw+Fn-GQ2C0ridwE3eqRsd1gVQ6zB5w@mail.gmail.com>
Message-ID: <20181102091825.GB29664@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Krzysztof!

On Fri, Nov 02, 2018 at 09:19:10AM +0100, Krzysztof Kozlowski wrote:
> On Thu, 1 Nov 2018 at 08:19, Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> >
> > Use devm variant of clkdev lookup registration in order to avoid
> > clkdev lookup leak at device remove.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/clk/samsung/clk-s3c2410-dclk.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Driver has suppress_bind_attrs and it cannot be built as module so
> device removal should not be possible. There is no need to use devm.

This is exactly what I wanted to hear =) I will drop this patch from
series.

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
