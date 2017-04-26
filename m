From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 17:02:32 +0530
Subject: [PATCH v5 16/22] KVM: arm64: vgic-its: Add infrastructure for
 table lookup
In-Reply-To: <1492164934-988-17-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-17-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumept3RSD9cW4i_j6ww9naLHrLhCj0wBDrNDZ=JpKwLnQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> Add a generic lookup_table() helper whose role consists in
> scanning a contiguous table located in guest RAM and applying
> a callback on each entry. Entries can be handled as linked lists
> since the callback may return an offset to the next entry and
> also tell that an entry is the last one.
>
> Helper functions also are added to compute the device/event ID
> offset to the next DTE/ITE.
>
> compute_next_devid_offset, compute_next_eventid_offset and
> lookup_table will become static in subsequent patches
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
