From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Jan 2014 11:41:26 +0000
Subject: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
In-Reply-To: <20140125.101546.1134862463481697494.apm@brigitte.kvy.fi>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20140125.101546.1134862463481697494.apm@brigitte.kvy.fi>
Message-ID: <20140127114125.GD16639@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 25, 2014 at 08:15:46AM +0000, Antti P Miettinen wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Subject: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
> Date: Mon, 20 Jan 2014 17:47:59 +0000
> > +	- latency
> > +		Usage: Required
> > +		Value type: <prop-encoded-array>
> > +		Definition: List of u32 values representing worst case latency
> > +			    in microseconds required to enter and exit the
> > +			    C-state, one value per OPP [2]. The list should
> > +			    be specified in the same order as the operating
> > +			    points property list of the cpu this state is
> > +			    valid on.
> > +			    If no OPP bindings are present, the latency value
> > +			    is associated with the current OPP of CPUs in the
> > +			    system.
> 
> I'm afraid the CPU OPP is not enough to capture the variance in
> latencies. Especially memory frequency affects some of the latencies
> very stronly.

That's why I defined the worst case. How did you implemented it in your
idle drivers ? That would help generalize it, after all these bindings
are there to simplify drivers upstreaming, feedback welcome.

Thanks,
Lorenzo
