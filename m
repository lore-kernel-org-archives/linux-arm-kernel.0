From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Feb 2016 23:24:02 +0100
Subject: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
In-Reply-To: <20160220211659.GG18327@sirena.org.uk> (Mark Brown's message of
 "Sun, 21 Feb 2016 06:16:59 +0900")
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk> <871t87z1gz.fsf@belgarion.home>
 <20160220195925.GF18327@sirena.org.uk> <87twl3xgud.fsf@belgarion.home>
 <20160220211659.GG18327@sirena.org.uk>
Message-ID: <878u2fxbp9.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Sat, Feb 20, 2016 at 09:32:58PM +0100, Robert Jarzmik wrote:
>> Mark Brown <broonie@kernel.org> writes:
>> > On Sat, Feb 20, 2016 at 07:22:04PM +0100, Robert Jarzmik wrote:
>> I will. By now I fail to see how this will help in the wm9713 probing and
>> detection ...
>
> It will eumerate the AC'97 bus by itself and does not need the CODEC to
> be described.
I think I still don't get it.

So let's rephrase it another way : how will the function wm9713_probe() be
called, ie. what is the possible function backtrace leading to that call ?

>> Until I make the try, here is what I have as a device-tree extract in [1],
>> which is my candidate for sound/soc/pxa/zylonite.c replacement.. If we
>> conclude that wm9713 shouldn't be in device-tree, then I'm curious how the
>> DAI bindings (simple-audio-card,dai-link*) should be handled.
>
> They should be created as a function of enumerating the CODEC.  If you
> use the genric AC'97 stuff it doesn't use ASoC at all and this happens
> as a side effect.
I don't get that either. For me sound/soc/pci/ac97/ac97_codec.c is PCI specific,
not generic, so what is "generic AC'97 stuff" ? I will never be able to use it
as on my platforms CONFIG_PCI=n.

Do you have a devicetree example somewhere, with (ac97 host, audio codec) pair I
can have a look at to understand ?

Cheers.

-- 
Robert
