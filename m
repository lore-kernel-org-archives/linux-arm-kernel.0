From: benh@au1.ibm.com (Benjamin Herrenschmidt)
Date: Mon, 10 Apr 2017 07:55:37 +1000
Subject: [PATCH v4 19/23] drivers/fsi: Add GPIO based FSI master
In-Reply-To: <1491774835.4166.197.camel@au1.ibm.com>
References: <20170329174340.89109-1-cbostic@linux.vnet.ibm.com>
 <20170329174340.89109-20-cbostic@linux.vnet.ibm.com>
 <CACPK8XfOSYPidHF6=psC4mP-tkRyWTu0psdcK6EwA2E6FF53Uw@mail.gmail.com>
 <0e1bcf3a-e8d7-9f50-bdf7-2a1e7466665b@linux.vnet.ibm.com>
 <1490907014.3177.207.camel@kernel.crashing.org>
 <93b21624-11fc-b71b-aa78-6cb4371c87ae@linux.vnet.ibm.com>
 <1491344360.4166.68.camel@kernel.crashing.org>
 <5344146a-f450-7959-4688-a83ee022574b@linux.vnet.ibm.com>
 <1491774092.4166.195.camel@kernel.crashing.org>
 <1491774835.4166.197.camel@au1.ibm.com>
Message-ID: <1491774937.4166.198.camel@au1.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-04-10 at 07:53 +1000, Benjamin Herrenschmidt wrote:
> FYI. pdbg in userspace operates without any??delays in practice, the
> overhead between the various load/store instructions seems
> sufficient.
> 
> The only delay that's needed is when going through the FSI2PIB (to do
> SCOMs) where it seems like back-2-back accesses can be problematic.

Note: This isn't an objection to merging the patches. We can look at
doing an improved backend later.

Cheers,
Ben.
