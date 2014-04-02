From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 2 Apr 2014 14:26:53 +0300
Subject: [patch] clk: vt8500: several forever loops
In-Reply-To: <CAKv+Gu9R7Y5OKy+P62FAyE2_zf7f=reiLQy-++XziXahbSM15A@mail.gmail.com>
References: <20130826154908.GD12428@elgon.mountain>
 <20140402110429.GJ18506@mwanda>
 <CAKv+Gu9R7Y5OKy+P62FAyE2_zf7f=reiLQy-++XziXahbSM15A@mail.gmail.com>
Message-ID: <20140402112653.GK18506@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 01:19:19PM +0200, Ard Biesheuvel wrote:
> On 2 April 2014 13:04, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > This patch is still needed in linux-next.  It was Acked by Tony Prisk in
> > a private email.
> >
> > Acked-by: Tony Prisk <linux@prisktech.co.nz>
> >
> > regards,
> > dan carpenter
> >
> > On Mon, Aug 26, 2013 at 07:02:33PM +0300, Dan Carpenter wrote:
> >> This does a bunch of looping like this:
> >>
> >>       for (div2 = 7; div2 >= 0; div2--)
> >>
> >> But unsigned values are always greater than or equal to zero so it just
> >> loops and loops.  Really "mul", "div1" and "div2" should all be declared
> >> as int for cleanliness sake.
> >>
> 
> Apologies if this is a silly question from someone who is utterly
> uninformed, but are values == 0 even legal for divisors?
> It seems that, at least in some cases, 'div - 1' is or'ed into a
> register value (WM8850_BITS_TO_VAL), and I don't think you are
> expecting negative values there.
> So perhaps instead, change the test to '> 0' ??

Those seem like totally valid points.  The truth is that I almost am
"utterly uninformed" about this code.  Perhaps someone who knows more
than the both of us could take a look?

Please give Ard and me reported by tags when you fix this.

regards,
dan carpenter
