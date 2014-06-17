From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jun 2014 10:57:29 +0100
Subject: ARM diagnostic register across suspend/resume
In-Reply-To: <20140617083117.GD8860@dragon>
References: <20140617083117.GD8860@dragon>
Message-ID: <20140617095729.GF13020@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 09:31:18AM +0100, Shawn Guo wrote:
> Hi Will, Catalin,
> 
> The CP15 diagnostic register holds some bits for ARM errata workaround.
> Since core gets power gated across suspend/resume cycle, these bits will
> get lost along the way.  Is it okay for errata workaround to continue
> working after suspend, or do we have to save/restore diagnostic register
> to keep workaround effective?

I'm not sure that saving/restoring the diagnostic register on A9 actually
works at all (I seem to remember some bits always read as zero?).

Anyway, I'd expect the state could be lost, so you'd need to reprogram
the diagnostic register rather than save/restore its value.

Will
