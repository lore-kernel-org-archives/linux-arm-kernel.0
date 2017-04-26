From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 16:57:57 +0530
Subject: [PATCH v5 10/22] KVM: arm64: vgic-its: Implement
 vgic_mmio_uaccess_write_its_iidr
In-Reply-To: <1492164934-988-11-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-11-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumfjJLn=jJMhoNMQ2vg27XEya8msoOM4V1Fs__Y8ghdizg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> The GITS_IIDR revision field is used to encode the migration ABI
> revision. So we need to restore it to check the table layout is
> readable by the destination.
>
> By writing the IIDR, userspace thus force the ABI revision to be
> used and this msut be less or equal than the max revision KVM supports.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
