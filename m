From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 11 Jan 2014 11:12:16 +0800
Subject: DT include files
In-Reply-To: <CAOesGMhP5t=QHj7TdDY9Nq+=WHeQXv1V0n9TGmmEnqSG9SaFKg@mail.gmail.com>
References: <20140103023211.GA25079@S2101-09.ap.freescale.net>
 <CAOesGMheei8YgzfRp9pmQ0rT9zhJ2_hF56j5Y+jLSy5TadPZ-g@mail.gmail.com>
 <20140103030455.GB25079@S2101-09.ap.freescale.net>
 <CAOesGMihX-pLva-aBCHJ6TYfsN57MzRWiYFTnfKCXOKeja0uUg@mail.gmail.com>
 <20140104011056.GA3282@S2101-09.ap.freescale.net>
 <20140110024124.GA6844@S2101-09.ap.freescale.net>
 <CAOesGMh3HBCYut2hfub3svrJT5JJzoWq8mU=VU0grZbg-JqqbA@mail.gmail.com>
 <52CFF57D.8060808@samsung.com>
 <CAL_JsqKHr6v+6kNXrAdnzH0gpoFCPAjPSnX8iBDgRSMh9JgxvA@mail.gmail.com>
 <CAOesGMhP5t=QHj7TdDY9Nq+=WHeQXv1V0n9TGmmEnqSG9SaFKg@mail.gmail.com>
Message-ID: <20140111031214.GK21717@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 10:37:01AM -0800, Olof Johansson wrote:
> > On a side note, I'm not really a fan of this pattern:
> >
> > #define FOO1 1 2 3
> >
> > #define BAR FOO1 FOO2 FOO3
> >
> > While it definitely simplifies the dts files, it would never be used
> > in C and obfuscates what the actual property size is. Reading a dts
> > file, I would naturally assume the define was a single value while in
> > fact it could expand to a very large property size.
> 
> Hmm. Shawn?

What I read from Rob is that he does not like it but he does not hate it
so much either.  And that's probably why I did not get either ACK or
NACK from him when the usage was firstly introduced :)

While I agree such macro usage should be avoided or limited, it really
helps IMX pinctrl case to improve the readability and make the handwriting
of these pinctrl entries less error prone.  Isn't it the whole point of
introducing macro support for DTC?

Shawn
