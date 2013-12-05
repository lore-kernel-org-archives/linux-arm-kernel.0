From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Dec 2013 18:00:22 +0000
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized
 using pinfunc.
In-Reply-To: <1502243.eRBlCfUhTO@amdc1227>
References: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
 <CACRpkdYrPd9tnO48bA_5n+-k=KEDyhY7czkCNhTZfpgF3ar+LQ@mail.gmail.com>
 <20131205150747.GW29268@sirena.org.uk>
 <1502243.eRBlCfUhTO@amdc1227>
Message-ID: <20131205180022.GX29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 04:11:15PM +0100, Tomasz Figa wrote:
> On Thursday 05 of December 2013 15:07:47 Mark Brown wrote:

> > Or should we be going and applying the default state to all devices on
> > init without worrying about a driver appearing?

> If a device isn't used, then it's often better to configure the pins for
> a different function, such as GPIO, to minimize leakage current.

That's true but on the other hand it's much more likely that the default
information will be there than the hog for the case when the driver
doesn't get loaded for some reason so it's more likely that the default
will kick in; perhaps we need to work down a list of states in order
instead?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131205/979ddebf/attachment.sig>
