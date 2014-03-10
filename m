From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 10 Mar 2014 18:01:09 +0000
Subject: [PATCH RFC v4 3/3] Documentation: arm: define DT idle states
 bindings
In-Reply-To: <20140219160449.11460.93660@capellas-linux>
References: <1392724051-11950-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392724051-11950-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140219160449.11460.93660@capellas-linux>
Message-ID: <20140310180109.GB834@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 04:04:49PM +0000, Sebastian Capella wrote:
> Quoting Lorenzo Pieralisi (2014-02-18 03:47:31)
> > +       - index
> > +               Usage: Required
> > +               Value type: <u32>
> > +               Definition: It represents the idle state index.
> > +                           An increasing index value implies less power
> > +                           consumption. Index must be given a sequential
> > +                           value = {0, 1, ....}, starting from 0.
> One minor comment.  In the example, it can be tricky to see how this is sequential
> since the states interleave.  Not sure if it merits rewording here?

- index
	Usage: Required
	Value type: <u32>
	Definition: It represents the idle state index.
		    The index must be given an increasing
		    value = {0, 1, ....}, starting from 0, with higher
		    values implying less power consumption.
		    Indices must be unique as seen from a cpu
		    perspective, ie phandles in the cpu nodes [1]
		    cpu-idle-states array property are not allowed to
		    point at idle state nodes having the same index
		    value.

Ack ?

I will post a v5, should be final.

Lorenzo
