From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 21:01:45 +0100
Subject: [PATCH 03/14] ARM: suspend: extract common code from
	MULTI_CPU/!MULTI_CPU paths
In-Reply-To: <alpine.LFD.2.00.1106131522410.2142@xanadu.home>
References: <20110613171446.GF13643@n2100.arm.linux.org.uk>
	<E1QWAju-0002dr-P6@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1106131522410.2142@xanadu.home>
Message-ID: <20110613200145.GG13643@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 03:29:02PM -0400, Nicolas Pitre wrote:
> On Mon, 13 Jun 2011, Russell King - ARM Linux wrote:
> 
> > Very little code is different between these two paths now, so extract
> > the common code.
> 
> What about simply always using the MULTI_CPU path unconditionally here?  
> The struct processor pointer could be made available in all cases, and 
> non critical paths could choose to always use it to simplify the code.

For the ifdef sections I don't think its worth it.
