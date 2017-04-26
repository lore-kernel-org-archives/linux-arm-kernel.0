From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 17:03:06 +0530
Subject: [PATCH v5 17/22] KVM: arm64: vgic-its: Collection table
 save/restore
In-Reply-To: <1492164934-988-18-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-18-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumdGJ4Y1SzEQDVNGRrp=NCQ1gX_ptfDTnUKhJ8WDhgw2_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> The save path copies the collection entries into guest RAM
> at the GPA specified in the BASER register. This obviously
> requires the BASER to be set. The last written element is a
> dummy collection table entry.
>
> We do not index by collection ID as the collection entry
> can fit into 8 bytes while containing the collection ID.
>
> On restore path we re-allocate the collection objects.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
