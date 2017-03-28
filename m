From: elena.reshetova@intel.com (Reshetova, Elena)
Date: Tue, 28 Mar 2017 14:00:01 +0000
Subject: [PATCH 06/16] drivers, net, mlx5: convert mlx5_cq.refcount from
 atomic_t to refcount_t
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFBE8AF@AcuExch.aculab.com>
References: <1490691403-4016-1-git-send-email-elena.reshetova@intel.com>
 <1490691403-4016-7-git-send-email-elena.reshetova@intel.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFBE8AF@AcuExch.aculab.com>
Message-ID: <2236FBA76BA1254E88B949DDB74E612B41C82E54@IRSMSX102.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Elena Reshetova
> > Sent: 28 March 2017 09:57
> >
> > refcount_t type and corresponding API should be
> > used instead of atomic_t when the variable is used as
> > a reference counter. This allows to avoid accidental
> > refcounter overflows that might lead to use-after-free
> > situations.
> 
> I can't help feeling that you ought to find a scheme
> that will detect extra decrements and extra increments
> before the counter wraps 32 bits.
> 
> If an extra reference is requested every 100us it takes 4.8 days
> for the counter to increment back to zero.
> Simple tests aren't doing to find that - but it can easily happen
> on a system that is running for several years.

So, you are proposing to try detecting this case instead of preventing overflows?
Not sure how this would look like in a generic form...



> 
> 	David
