From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 22 Sep 2011 14:45:53 +0100
Subject: DT vs ARM static mappings
In-Reply-To: <20110922131302.GO17169@n2100.arm.linux.org.uk>
References: <1316519479.4611.150.camel@hornet.cambridge.arm.com>
	<alpine.LFD.2.00.1109211320090.12663@xanadu.home>
	<1316696696.4611.844.camel@hornet.cambridge.arm.com>
	<20110922131302.GO17169@n2100.arm.linux.org.uk>
Message-ID: <1316699153.4611.858.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Ok, what I did was grepping for all .map_io-s. Then I sorted the list
> > and had a look at first 100 and about 50% of them were doing more than
> > just creating mappings.
> 
> The answer to that is: they shouldn't be now that we have the init_early
> hook.  The only remainder for .map_io is where platforms make run-time
> decisions about what to map based on some register value somewhere
> (eg, Assabet vs Assabet+Neponset).
> 
> I do have a large patch series floating around in my git tree which tries
> to clean up to all those map_io functions - the biggest stumbling block
> to them is the Samsung stuff being indirected through its own tables.

Awesome. I'll work with an assumption that future map_io-s will only
create static mappings and nothing more then.

Cheers!

Pawe?
