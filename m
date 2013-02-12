From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Feb 2013 16:37:26 +0000
Subject: [PATCH] [RFC] arm: fix memset-related crashes caused by recent
 GCC (4.7.2) optimizations
In-Reply-To: <20130212163645.GI4123@mudshark.cambridge.arm.com>
References: <1359793988-6881-1-git-send-email-ivan.djelic@parrot.com>
 <20130211184114.GP9801@mudshark.cambridge.arm.com>
 <20130211194225.GK29329@parrot.com>
 <20130212140008.GB4123@mudshark.cambridge.arm.com>
 <20130212155801.GQ17833@n2100.arm.linux.org.uk>
 <20130212163645.GI4123@mudshark.cambridge.arm.com>
Message-ID: <20130212163725.GR17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 04:36:45PM +0000, Will Deacon wrote:
> That would be the ideal thing to do, because it allows the compiler to
> optimise around these functions, however it does mean we need to check/fix
> *all* of the string functions at least (if we don't pass -fno-builtin then
> any builtin function is up for optimisation, including strcpy etc).

No we don't.  memset() is the only one which I created in a non-standard
way.
