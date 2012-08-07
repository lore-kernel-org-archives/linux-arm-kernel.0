From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Aug 2012 18:38:10 +0100
Subject: RFC: mutex: hung tasks on SMP platforms with
 asm-generic/mutex-xchg.h
In-Reply-To: <20120807173344.GD16877@mudshark.cambridge.arm.com>
References: <20120807115647.GA12828@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1208071259270.5231@xanadu.home>
 <20120807173344.GD16877@mudshark.cambridge.arm.com>
Message-ID: <20120807173810.GE16877@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 06:33:44PM +0100, Will Deacon wrote:
> What I think is happening is that B writes the -1 in __mutex_lock_common
> and, after seeing a NULL owner (C may not have set that yet), drops through
> to the:
> 
> 	if (atomic_xchg(&lock->count, -1) == 1)
> 		goto done;

Sorry, should have proofread that. I meant to say:

 What I think is happening is that B writes the -1 in __mutex_lock_common
 after seeing a NULL owner (C may not have set that yet) and dropping through
 to the:
 
 	if (atomic_xchg(&lock->count, -1) == 1)
 		goto done;
 

Will
