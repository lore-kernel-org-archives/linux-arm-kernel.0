From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Feb 2016 14:27:18 +0100
Subject: [PATCH 1/5] clk: sunxi: Make clocks setup functions return their
 clock
In-Reply-To: <CAGb2v66CyhkM0vabbede43eAaf7WVg0Lm8w_OUKwqHnFO182uw@mail.gmail.com>
References: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454402834-6385-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66CyhkM0vabbede43eAaf7WVg0Lm8w_OUKwqHnFO182uw@mail.gmail.com>
Message-ID: <20160202132718.GU4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 02, 2016 at 06:35:29PM +0800, Chen-Yu Tsai wrote:
> On Tue, Feb 2, 2016 at 4:47 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The clocks registration code in clk-sunxi was most of the time not
> > returning the struct clk (or struct clk array) that was registered,
> > preventing the users of such functions to manipulate it, for example to
> > protect it.
> >
> > Make them return it so that we can start using it.
> 
> Should they return error codes as well? So the CLK_OF_DECLARE setup functions
> can report errors. Or make these helper functions report errors directly?

CLK_OF_DECLARE doesn't handle any kind of error, as the setup function
must return void, and the error printing should rather be in the
common functions in order to avoid duplicating it everywhere, so I'm
not sure. Or did you had something else in mind?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/9af172d6/attachment.sig>
