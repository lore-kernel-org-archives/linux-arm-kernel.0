From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 27 Nov 2018 15:41:01 -0800
Subject: [PATCH v9 00/17] Removed nested TPM operations
In-Reply-To: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20181127234101.GA3150@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2018 at 02:47:33PM +0200, Jarkko Sakkinen wrote:
> [was Detach TPM space code out of the tpm_transmit() flow but the scope
>  expanded a bit.]
> 
> Make the changes necessary to detach TPM space code and TPM activation
> code out of the tpm_transmit() flow because of both of these can cause
> nested tpm_transmit() calls. The nesteds calls make the whole flow hard
> to maintain, and thus, it is better to just fix things now before this
> turns into a bigger mess.

I will take care to address the feedback from Tomas and Jason but won't
yet try to push this into v4.21. It is a patch set, which is better to
lie in linux-next before landing to a release. Probably will push the
patches soon after my v4.21 PR to linux-next. Then they will get maximum
time of exposure.

/Jarkko
