From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Dec 2013 11:22:44 +0100
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized using
 pinfunc.
In-Reply-To: <20131205150747.GW29268@sirena.org.uk>
References: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
 <528BB1F2.4080107@wwwdotorg.org>
 <CAD=FV=XS0dbE7zfgDGVdp84h4fHH6tfO8aN_HNh1LbOjYy51aQ@mail.gmail.com>
 <528BB913.6080409@wwwdotorg.org>
 <CAH9JG2UjnL5bZzNUuJhWY3GpwPD=rJvR2O4Hcpm33G+prSS=BA@mail.gmail.com>
 <CACRpkdbyjm0X9RX+8WjqQxBPyRjBOAunkqVcO-0KUd1PTdGavA@mail.gmail.com>
 <5293ACA6.7060403@bracey.fi>
 <CACRpkdYrPd9tnO48bA_5n+-k=KEDyhY7czkCNhTZfpgF3ar+LQ@mail.gmail.com>
 <20131205150747.GW29268@sirena.org.uk>
Message-ID: <CACRpkdZ7YCt7NvDDqgv6CZS07wkfVJ1NRZHFhqKxcYbdW7pXnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 4:07 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Dec 03, 2013 at 10:29:42AM +0100, Linus Walleij wrote:
>
>> So a suggested patch to support weak hogs would be interesting
>> to look at. Can you provide details on how you think this would
>> work?
>
> Or should we be going and applying the default state to all devices on
> init without worrying about a driver appearing?

That doesn't really work: if you have an unused device not in the
DT you usually mark it "disabled", and then the DT core doesn't
even create a platform_device for this node.

So doing this would involve parsing the tree and ... yuck.

Yours,
Linus Walleij
