From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2018 13:49:47 +0200
Subject: linux-next: manual merge of the regulator tree with the arm-soc
 tree
In-Reply-To: <20180604104642.GC7536@sirena.org.uk>
References: <20180530150711.2c7c1fe9@canb.auug.org.au>
 <CACRpkdaotBXbA4pPFHRH0S1SF7-XX_T6yAOwZcbsR3RBcj+-=Q@mail.gmail.com>
 <2564792.sYBGPVz9u3@z50> <20180604104642.GC7536@sirena.org.uk>
Message-ID: <CACRpkdaUQkjM3nFWn2aO-Jxy=tWEKWkEUmCA11Xuji2p2x82gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 4, 2018 at 12:46 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jun 01, 2018 at 12:49:53AM +0200, Janusz Krzysztofik wrote:
>
>> I confirm the fix by Stephen works for me, however, the conflicting patch by
>> Linus breaks things a bit.
>
>> Lookup tables added to board files use function name "enable" while the
>> regulator uses NULL. As a result, GPIO descriptor is not matched and not
>> assigned to the regulator which ends up running with no control over GPIO pin.
>
>> Either the regulator driver should use the function name "enable" or that name
>> should be removed from lookup tables.
>
> I'll revert this one as well :(

I see this is a generic problem, no idea why I didn't pass these
unnamed as NULL in the first place, probably my ignorance as usual.

I fixed it up in my patch making them all anonymous and rebasing
the rest as well. Let's see how it looks after the merge window.

I will also need to rebase on top of Janusz changes and then it
will look even better.

Janusz: would be super if you could test my patches after that!

Yours,
Linus Walleij
