From: mbrugger@suse.com (Matthias Brugger)
Date: Fri, 12 Jan 2018 13:11:30 +0100
Subject: [PATCH 0/2] tee: optee: report OP-TEE revision information
In-Reply-To: <cover.1511533457.git.jerome.forissier@linaro.org>
References: <cover.1511533457.git.jerome.forissier@linaro.org>
Message-ID: <e02ea595-946e-c94e-19a8-5ba1a57cb3df@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/24/2017 03:47 PM, Jerome Forissier wrote:
> Hi,
> 
> This patchset updates the OP-TEE driver to report the version of the
> secure OS upon initialization. To further facilitate troubleshooting,
> an optional build ID is introduced in the response to the
> OPTEE_SMC_CALL_GET_OS_REVISION request. Upstream OP-TEE uses this field
> to report its Git SHA1 since commit 29cff5cf09aa ("core: GET_OS_REVISION:
> return SHA1 of current Git commit").
> 
> Typical boot log (>> is introduced by this patchset):
> 
>     optee: probing for conduit method from DT.
>  >> optee: revision 2.6 (947cfeec)
>     optee: initialized driver
> 
> ...or, if the build ID is not set by the TEE or set to zero:
> 
>     optee: probing for conduit method from DT.
>  >> optee: revision 2.6
>     optee: initialized driver
> 
> Jerome Forissier (2):
>   tee: optee: GET_OS_REVISION: document a2 as a build identifier
>   tee: optee: report OP-TEE revision information
> 
>  drivers/tee/optee/core.c      | 23 +++++++++++++++++++++++
>  drivers/tee/optee/optee_smc.h | 10 +++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 

Reviewed-by: Matthias Brugger <mbruger@suse.com>
