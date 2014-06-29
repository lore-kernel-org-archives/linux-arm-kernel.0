From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun, 29 Jun 2014 11:46:43 +0200
Subject: [PATCH 2/5] regulator: act8865: set correct number of regulators
 in pdata
In-Reply-To: <20140627160725.GQ23300@sirena.org.uk>
References: <1403451105-31929-1-git-send-email-b.galvani@gmail.com>
 <1403451105-31929-3-git-send-email-b.galvani@gmail.com>
 <20140627160725.GQ23300@sirena.org.uk>
Message-ID: <20140629094642.GA13485@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 05:07:25PM +0100, Mark Brown wrote:
> On Sun, Jun 22, 2014 at 05:31:42PM +0200, Beniamino Galvani wrote:
> > When platform data is populated from DT all the regulators are
> > instantiated and the value of num_regulators should be the number of
> > all available regulators rather than the number of matched ones.
> 
> Could you go into more detail on your logic on this one please?  The
> platform data (and DT configuration) for regulators should be completely
> optional.

pdata contains an array of struct act8865_regulator_data and a
num_regulators field which should hold the number of elements in the
array, if I understand correctly.

So in the current code, when populating platform data from DT, there
is a mismatch between the number of elements that are put in the array
(ARRAY_SIZE(act8865_matches)) and the value of num_regulators, which
is set to the number of regulators found in the DT.

In case of missing regulator nodes in DT, pdata->regulators will be
populated with all the regulators but their init_data will be NULL.

Beniamino
