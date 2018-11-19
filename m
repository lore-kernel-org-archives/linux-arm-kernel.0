From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 19 Nov 2018 17:56:10 +0200
Subject: [PATCH v9 00/17] Removed nested TPM operations
In-Reply-To: <1393743e-7c54-4a83-ba2a-779a3a8a31e3@linux.ibm.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
 <1393743e-7c54-4a83-ba2a-779a3a8a31e3@linux.ibm.com>
Message-ID: <20181119155610.GC13298@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 09:23:03AM -0500, Stefan Berger wrote:
> On 11/18/18 7:47 AM, Jarkko Sakkinen wrote:
> > [was Detach TPM space code out of the tpm_transmit() flow but the scope
> >   expanded a bit.]
> > 
> > Make the changes necessary to detach TPM space code and TPM activation
> > code out of the tpm_transmit() flow because of both of these can cause
> > nested tpm_transmit() calls. The nesteds calls make the whole flow hard
> > to maintain, and thus, it is better to just fix things now before this
> > turns into a bigger mess.
> 
> Tested this series with the vtpm proxy test cases:
> 
> 
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>

Awesome, thank you! I'll add your tags to the next revision.

/Jarkko
