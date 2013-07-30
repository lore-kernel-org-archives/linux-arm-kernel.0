From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jul 2013 21:57:16 +0100
Subject: Defining schemas for Device Tree
In-Reply-To: <CAKON4OykPqYA8+ZGxjiX00Ut+iM9hqiXr5D9KEZF3PVxoqiM1g@mail.gmail.com>
References: <2469263.vMN09Q7Tzi@flatron> <51F6E30B.7060106@wwwdotorg.org>
 <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
 <1706112.Xn49tiCSKF@thinkpad>
 <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
 <20130730102511.GM9858@sirena.org.uk>
 <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
 <51F7F596.6020503@wwwdotorg.org>
 <CAKON4OykPqYA8+ZGxjiX00Ut+iM9hqiXr5D9KEZF3PVxoqiM1g@mail.gmail.com>
Message-ID: <20130730205716.GZ9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 01:29:56PM -0400, jonsmirl at gmail.com wrote:
> On Tue, Jul 30, 2013 at 1:19 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > On 07/30/2013 07:14 AM, jonsmirl at gmail.com wrote:

> > > Is something similar to this possible in device tree syntax?
> > > dmas =  <"tx" &pdma0 7>,  <"rx"  &pdma0 6>;

> > I /think/ you can physically write that in *.dts, or something very
> > similar; with the strings outside the <>:

> > dmas = "tx", <&pdma0 7>, "rx", <&pdma0 6>;

> Can we turn the strings into string phandles? Then they'd be fixed sized.

> That might provide a way to internationalize the strings too.

I don't know how viable or sane this actually is but one suggestion I
just made elsewhere which might help is to fix this at the dtc level by
having syntatic sugar which will do the parallel arrays trick that
people are currently using to write things out.  The user writes one
array with multiple types of data in it and the actual output is two or
more matched arrays each with a single type of data.

It would help legibility and wouldn't impact the parsers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/a8e63708/attachment.sig>
