From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 16:57:12 +0530
Subject: [PATCH v5 09/22] KVM: arm64: vgic-its: Introduce migration ABI
 infrastructure
In-Reply-To: <1492164934-988-10-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-10-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumcwKV5KVSuDCGA87maXMZ1JfCL-8tt=+ZtsNUR2r1L6ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> We plan to support different migration ABIs, ie. characterizing
> the ITS table layout format in guest RAM. Typically a new ABI will
> be needed if vLPIs get supported for nested use case.
>
> So let's introduce an array of supported ABIs (at the moment a single
> ABI is supported though). The following characteristics are foreseen
> to vary with the ABI: size of table entries, save/restore operation.
>
> By default the MAX_ABI_REV is applied on its creation. In subsequent
> patches we will introduce a way for the userspace to change the ABI
> in use.
>
> The entry sizes now are set according to the ABI version and not
> hardcoded anymore.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
