From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 9 May 2015 10:54:18 +0300
Subject: [PATCH v3 2/4] remoteproc: add a rproc ops for performing address
 translation
In-Reply-To: <1427917039-43206-3-git-send-email-d-gerlach@ti.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com>
 <1427917039-43206-3-git-send-email-d-gerlach@ti.com>
Message-ID: <CAK=WgbaSD9tGVKhUkbL3JjtW9GuAR_fbWHG6rx1m_v9TDW0Osw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Wed, Apr 1, 2015 at 10:37 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> From: Suman Anna <s-anna@ti.com>
>
> The rproc_da_to_va API is currently used to perform any device to
> kernel address translations to meet the different needs of the remoteproc
> core/drivers (eg: loading). The functionality is achieved within the
> remoteproc core, and is limited only for carveouts allocated within the
> core.
>
> A new rproc ops, da_to_va, is added to provide flexibility to platform
> implementations to perform the address translation themselves when the
> above conditions cannot be met by the implementations. The rproc_da_to_va()
> API is extended to invoke this ops if present, and fallback to regular
> processing if the platform implementation cannot provide the translation.
> This will allow any remoteproc implementations to translate addresses for
> dedicated memories like internal memories.

Can you please provide specific examples where this is needed and how
it is going to be used?

Thanks,
Ohad.
