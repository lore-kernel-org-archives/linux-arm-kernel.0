From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Nov 2013 15:41:37 +0000
Subject: [PATCH 02/10] mtd: st_spi_fsm: Supply all register address and
 bit logic defines
In-Reply-To: <20131118153110.GN13640@lee--X1>
References: <1384438956-31153-1-git-send-email-lee.jones@linaro.org>
 <1384438956-31153-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdaccxcTfKc-y7rPEH1H3yua3ubLvuvTzWnMs1rOwjiVNw@mail.gmail.com>
 <20131118093229.GB13640@lee--X1>
 <20131118133940.GC14306@sirena.org.uk>
 <20131118142447.GJ13640@lee--X1>
 <20131118144512.GB24408@sirena.org.uk>
 <20131118145614.GM13640@lee--X1>
 <20131118151651.GE24408@sirena.org.uk>
 <20131118153110.GN13640@lee--X1>
Message-ID: <20131118154137.GA28334@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 03:31:10PM +0000, Lee Jones wrote:
> On Mon, 18 Nov 2013, Mark Brown wrote:

> > This doesn't seem realistic, you're assuming that system integrators
> > won't go and use chips you've not heard of and at least in the case of
> > things like quad read my understanding is that the commands aren't
> > standardised so the host just has to know what to write.

> I'm not following? What are you suggesting?

Like I say I'm suggesting that the bit of the code that understands the
flash chip is separate to the bit of code that knows the mechanics of
sending commands and data to the chip.

> After some analysis we have come to the conclusion that using m25p80
> is not feasible. It makes more sense for this to be an
> orthogonal/stand-alone driver.

That seems plausible for the controller side but it seems surprising for
the flash chip side.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/d4aaa61c/attachment-0001.sig>
