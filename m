From: broonie@kernel.org (Mark Brown)
Date: Thu, 3 Jul 2014 16:55:38 +0100
Subject: [PATCH 2/5] regulator: act8865: set correct number of regulators
 in pdata
In-Reply-To: <20140629094642.GA13485@gmail.com>
References: <1403451105-31929-1-git-send-email-b.galvani@gmail.com>
 <1403451105-31929-3-git-send-email-b.galvani@gmail.com>
 <20140627160725.GQ23300@sirena.org.uk>
 <20140629094642.GA13485@gmail.com>
Message-ID: <20140703155538.GG410@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 11:46:43AM +0200, Beniamino Galvani wrote:
> On Fri, Jun 27, 2014 at 05:07:25PM +0100, Mark Brown wrote:
> > On Sun, Jun 22, 2014 at 05:31:42PM +0200, Beniamino Galvani wrote:
> > > When platform data is populated from DT all the regulators are
> > > instantiated and the value of num_regulators should be the number of
> > > all available regulators rather than the number of matched ones.

> > Could you go into more detail on your logic on this one please?  The
> > platform data (and DT configuration) for regulators should be completely
> > optional.

> pdata contains an array of struct act8865_regulator_data and a
> num_regulators field which should hold the number of elements in the
> array, if I understand correctly.

> So in the current code, when populating platform data from DT, there
> is a mismatch between the number of elements that are put in the array
> (ARRAY_SIZE(act8865_matches)) and the value of num_regulators, which
> is set to the number of regulators found in the DT.

> In case of missing regulator nodes in DT, pdata->regulators will be
> populated with all the regulators but their init_data will be NULL.

OK, so that was slightly unclear but I see what you're saying now - the
issue isn't that there will be fewer valid elements in the array, it's
that the array is sparsely populated.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140703/a270ced5/attachment-0001.sig>
