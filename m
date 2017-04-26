From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 16:58:29 +0530
Subject: [PATCH v5 11/22] KVM: arm64: vgic-its: Interpret MAPD Size field
 and check related errors
In-Reply-To: <1492164934-988-12-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-12-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumcEseZp44TaxsycAyVRZ-zFJPFETCXCZdNRNO=1WjTzqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> Up to now the MAPD's ITT size field has been ignored. It encodes
> the number of eventid bit minus 1. It should be used to check
> the eventid when a MAPTI command is issued on a device. Let's
> store the number of eventid bits in the its_device and do the
> check on MAPTI. Also make sure the ITT size field does
> not exceed the GITS_TYPER IDBITS field.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
