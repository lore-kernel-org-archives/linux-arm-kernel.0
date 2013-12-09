From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Dec 2013 17:04:22 +0000
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized
 using pinfunc.
In-Reply-To: <CACRpkdZ7YCt7NvDDqgv6CZS07wkfVJ1NRZHFhqKxcYbdW7pXnQ@mail.gmail.com>
References: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
 <528BB1F2.4080107@wwwdotorg.org>
 <CAD=FV=XS0dbE7zfgDGVdp84h4fHH6tfO8aN_HNh1LbOjYy51aQ@mail.gmail.com>
 <528BB913.6080409@wwwdotorg.org>
 <CAH9JG2UjnL5bZzNUuJhWY3GpwPD=rJvR2O4Hcpm33G+prSS=BA@mail.gmail.com>
 <CACRpkdbyjm0X9RX+8WjqQxBPyRjBOAunkqVcO-0KUd1PTdGavA@mail.gmail.com>
 <5293ACA6.7060403@bracey.fi>
 <CACRpkdYrPd9tnO48bA_5n+-k=KEDyhY7czkCNhTZfpgF3ar+LQ@mail.gmail.com>
 <20131205150747.GW29268@sirena.org.uk>
 <CACRpkdZ7YCt7NvDDqgv6CZS07wkfVJ1NRZHFhqKxcYbdW7pXnQ@mail.gmail.com>
Message-ID: <20131209170422.GT29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 11:22:44AM +0100, Linus Walleij wrote:
> On Thu, Dec 5, 2013 at 4:07 PM, Mark Brown <broonie@kernel.org> wrote:

> > Or should we be going and applying the default state to all devices on
> > init without worrying about a driver appearing?

> That doesn't really work: if you have an unused device not in the
> DT you usually mark it "disabled", and then the DT core doesn't
> even create a platform_device for this node.

> So doing this would involve parsing the tree and ... yuck.

Hrm, yeah, good point.  That's got a low awesomeness factor even though
it should work.  Boo.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/075f08bc/attachment.sig>
